# frozen_string_literal: true

require 'net/http'

module Smithy
  module Client
    module NetHTTP
      # An HTTP/1.1 stream backed by +Net::HTTP+, implementing the stream
      # contract consumed by {SendHandler}: +#response_headers+, +#each_chunk+,
      # +#write+, +#close_write+, and +#abort+.
      #
      # The stream is driven cooperatively by the caller's thread: a +Fiber+
      # keeps +Net::HTTP+'s +read_body+ block context alive across separate
      # {#response_headers} and {#each_chunk} calls. +transmit+ sends the request
      # and reads the response headers (suspending the fiber), and {#each_chunk}
      # resumes the fiber to read body chunks directly off the socket. There is
      # no background reader thread pushing data; the caller pulls it.
      #
      # On CRuby a +Fiber+ is a same-thread coroutine, so no OS thread is created
      # per stream. On JRuby and TruffleRuby +Fiber+ is backed by a JVM/native
      # thread, so each stream does use one background thread; the pull-based
      # concurrency model is unchanged, but the "zero threads" property is
      # CRuby-only.
      #
      # Thread model: the fiber is created in {#send_request} and *must* be
      # resumed on that same thread ({#each_chunk} enforces this implicitly, as
      # a fiber cannot be resumed across threads). A different thread may call
      # {#abort} to request cancellation; state transitions are guarded by a
      # mutex so the abort is observed and cannot race the stream's normal
      # completion.
      #
      # HTTP/1.1 cannot write to a request after it has been transmitted, so
      # {#write} and {#close_write} raise {NotSupportedError}.
      # @api private
      class Stream
        # Raised when the received response body is shorter than the advertised
        # +Content-Length+. This is an HTTP/1.1 wire concern: HTTP/2 detects
        # truncation via frame accounting / END_STREAM, not Content-Length.
        # @api private
        class TruncatedBodyError < IOError
          def initialize(bytes_expected, bytes_received)
            msg = "http response body truncated, expected #{bytes_expected} " \
                  "bytes, received #{bytes_received} bytes"
            super(msg)
          end
        end

        # Internal signal raised inside the driving fiber when a cross-thread
        # {#abort} raced ahead of session checkout. It is caught explicitly (not
        # via the broad StandardError rescue) so it is never confused with a real
        # networking failure. Not part of the stream contract.
        # @api private
        class Aborted < StandardError; end

        # @param [ConnectionPool] pool The connection pool to check a session
        #   out of.
        # @param [Http::Request] request
        def initialize(pool, request)
          @pool = pool
          @request = request
          @status = nil
          @headers = nil
          @session = nil
          @error = nil
          @bytes_received = 0
          @done = false
          @aborted = false
          # Guards the @done/@aborted/@error/@session transitions so a cross-thread
          # {#abort} is observed by the driving thread and cannot race normal
          # completion.
          @mutex = Mutex.new
        end

        # Sends the request and reads the response status and headers, leaving
        # the response body ready to be consumed via {#each_chunk}. Called by
        # {Transport#transmit}; not part of the public +Stream+ contract.
        #
        # @raise [ArgumentError] If the request has an invalid HTTP method.
        # @raise [NetworkingError] If a networking error occurs while sending
        #   the request or reading the response headers.
        # @return [self]
        def send_request
          # Build (and validate) the Net::HTTP request before touching the
          # network so an invalid verb raises ArgumentError without opening a
          # connection or wrapping the error.
          net_request = build_net_request(@request)
          @fiber = Fiber.new { run(net_request) }

          # Net::HTTP applies its default Content-Type while sending the
          # request, which happens during this first resume.
          Thread.current[:net_http_skip_default_content_type] = true
          @fiber.resume
          raise @error if @error

          self
        ensure
          Thread.current[:net_http_skip_default_content_type] = nil
        end

        # @return [Array(Integer, Hash<String,String>)] The response status code
        #   and headers. Available immediately after {#send_request} for HTTP/1.1.
        def response_headers
          [@status, @headers]
        end

        # Yields raw response body chunks as they are read off the socket on the
        # caller's thread. Blocks until the response body has been fully read.
        # A body shorter than the advertised +Content-Length+ (HTTP/1.1
        # truncation) is detected as the body is read and surfaced here.
        # @yieldparam [String] chunk
        # @raise [NetworkingError] If a networking error occurs while reading, or
        #   if the body is shorter than the advertised +Content-Length+.
        # @return [void]
        def each_chunk(&)
          return if finished?

          begin
            stream_body(&)
          rescue StandardError
            # The consumer block (or the fiber resume) raised. Tear the
            # connection down so the suspended fiber does not leak the
            # checked-out socket, then re-raise the original error.
            abort
            raise
          end

          # A cooperative abort stopped iteration early; skip surfacing a
          # partial-read result as an error.
          return if aborted?

          raise @error if @error

          nil
        end

        # Part of the stream contract for transports that support writing to a
        # request after transmit (e.g. HTTP/2 bidirectional event streams).
        # HTTP/1.1 cannot write after transmit, so this always raises.
        # @raise [NotSupportedError]
        def write(_bytes)
          raise NotSupportedError, 'HTTP/1.1 does not support writing to a stream after transmit'
        end

        # Part of the stream contract for transports that support writing to a
        # request after transmit (e.g. HTTP/2 bidirectional event streams).
        # HTTP/1.1 cannot write after transmit, so this always raises.
        # @raise [NotSupportedError]
        def close_write
          raise NotSupportedError, 'HTTP/1.1 does not support writing to a stream after transmit'
        end

        # Aborts the stream, closing the underlying socket. The session is not
        # returned to the connection pool (a partially-read or aborted
        # connection is discarded). Safe to call from a thread other than the
        # one driving {#each_chunk}: the state transition is guarded by a mutex
        # so it cannot race normal completion, and closing the socket interrupts
        # a blocked read on the driving thread (surfaced as a networking error),
        # which is the desired cancellation behavior. Idempotent, and never
        # raises (teardown errors are swallowed).
        # @param [StandardError, nil] error
        # @return [void]
        def abort(error = nil)
          session = nil
          @mutex.synchronize do
            return if @done || @aborted

            @aborted = true
            @error ||= error
            session = @session
          end
          # Finish outside the lock to release the checked-out connection. The
          # fiber is left suspended and will be collected; the session is
          # intentionally not checked back into the pool. Any error from finishing
          # is swallowed: abort runs on teardown/cleanup paths (e.g. #each_chunk's
          # rescue, the SendHandler ensure), where it must never raise and mask
          # the error that triggered the teardown.
          begin
            session&.finish
          rescue StandardError
            nil
          end
          nil
        end

        private

        # Body of the driving fiber. Runs the full request within the pool's
        # session block, suspending (via Fiber.yield) after headers and after
        # each body chunk so the caller drives reads.
        # @param [Net::HTTPRequest] net_request
        def run(net_request)
          @pool.session_for(@request.endpoint) do |session|
            store_session(session)
            # #abort may have raced ahead of checkout and captured a nil session
            # (unable to finish it). Raise the Aborted sentinel so #session_for
            # finishes this session and does not return it to the pool, preventing
            # a leak of the checked-out connection. The abort is already recorded
            # in @aborted.
            raise Aborted if aborted?

            read_response(session, net_request)
          end
          mark_done
          nil
        rescue Aborted
          # Intentional abort signal (raised above). #session_for has already
          # finished the socket; nothing to surface - #each_chunk returns early
          # when aborted.
          mark_done
          nil
        rescue StandardError => e
          # A networking failure. The invalid-verb ArgumentError is validated in
          # #send_request before the fiber exists, so any error here is a
          # networking failure. It is recorded even if an abort is concurrently
          # in progress; #each_chunk decides whether to surface it (it returns
          # early when aborted, so an aborted stream stays quiet).
          mark_error(NetworkingError.new(e))
          nil
        end

        # Issues the request within the pool's session block, suspending after
        # headers and after each body chunk so the caller drives reads.
        # @param [Net::HTTPSession] session
        # @param [Net::HTTPRequest] net_request
        def read_response(session, net_request)
          session.request(net_request) do |net_response|
            @status = net_response.code.to_i
            @headers = extract_headers(net_response)
            Fiber.yield # headers are ready; hand control back to #send_request
            net_response.read_body do |chunk|
              @bytes_received += chunk.bytesize
              Fiber.yield(chunk)
            end
            # Verify while still inside the pool session block: a truncated
            # (peer-closed) body raises here, so #session_for finishes the
            # socket instead of returning it to the pool.
            verify_content_length!
          end
        end

        # Drives the fiber, yielding non-empty body chunks. Stops promptly if
        # another thread requested cancellation between chunks (cooperative
        # abort).
        # @yieldparam [String] chunk
        def stream_body
          while @fiber.alive?
            break if aborted?

            chunk = @fiber.resume
            break if chunk.nil?
            next if chunk.empty?

            yield(chunk)
          end
        end

        # @return [Boolean] Whether the stream has completed or been aborted.
        def finished?
          @mutex.synchronize { @done || @aborted }
        end

        # @return [Boolean]
        def aborted?
          @mutex.synchronize { @aborted }
        end

        def store_session(session)
          @mutex.synchronize { @session = session }
        end

        def mark_done
          @mutex.synchronize { @done = true }
        end

        def mark_error(error)
          @mutex.synchronize do
            @error ||= error
            @done = true
          end
        end

        # Constructs a +Net::HTTP+ request object from an {Http::Request}.
        # @param [Http::Request] request
        # @return [Net::HTTPRequest]
        def build_net_request(request)
          request_class = net_http_request_class(request)
          req = request_class.new(request.endpoint.request_uri, net_headers_for(request))
          # Net::HTTP adds a default Content-Type when a body is present.
          # Set the body stream when its size is unknown or greater than 0.
          req.body_stream = request.body if !request.body.respond_to?(:size) || request.body.size.positive?
          req
        end

        # @param [Http::Request] request
        # @raise [ArgumentError] If the HTTP method is not a valid verb.
        # @return [Class<Net::HTTPRequest>]
        def net_http_request_class(request)
          ::Net::HTTP.const_get(request.http_method.capitalize)
        rescue NameError
          raise ArgumentError, "`#{request.http_method}` is not a valid http verb"
        end

        # @param [Http::Request] request
        # @return [Hash<String, String>]
        def net_headers_for(request)
          # Net::HTTP defaults decode_content=true and adds Accept-Encoding: gzip.
          # Setting 'identity' prevents automatic decompression.
          headers = { 'accept-encoding' => 'identity' }
          request.headers.each_pair do |key, value|
            headers[key] = value
          end
          headers
        end

        # @param [Net::HTTPResponse] response
        # @return [Hash<String, String>]
        def extract_headers(response)
          response.to_hash.transform_values(&:first)
        end

        # Verifies the number of bytes received against the advertised
        # +Content-Length+ and raises {TruncatedBodyError} on a mismatch. Net::HTTP
        # defaults +ignore_eof+ to +true+, so a short fixed-length body read
        # returns normally rather than raising; this is the only place such a
        # truncation is detected. Called from inside the pool session block so a
        # truncated connection is finished rather than pooled.
        # @raise [TruncatedBodyError]
        # @return [void]
        def verify_content_length!
          return unless should_verify_bytes?

          bytes_expected = @headers['content-length'].to_i
          return if bytes_expected == @bytes_received

          raise TruncatedBodyError.new(bytes_expected, @bytes_received)
        end

        # @return [Boolean]
        def should_verify_bytes?
          @request.http_method != 'HEAD' && @headers && @headers['content-length']
        end
      end
    end
  end
end
