# frozen_string_literal: true

require 'net/http'

require_relative '../stream'

module Smithy
  module Client
    module NetHTTP
      # An HTTP/1.1 stream backed by +Net::HTTP+, implementing the stream
      # contract consumed by {SendHandler}: +#response_headers+, +#each_chunk+,
      # +#write+, +#close_write+, and +#abort+.
      #
      # Body delivery is pull-based on the caller's thread: a +Fiber+ keeps
      # +Net::HTTP+'s +read_body+ block alive across separate {#response_headers}
      # and {#each_chunk} calls, so there is no background reader thread. (On
      # JRuby/TruffleRuby a +Fiber+ is thread-backed, so each stream uses one
      # background thread; the pull model is unchanged.)
      #
      # The fiber is created and must be resumed on the same thread. A different
      # thread may call {#abort} to cancel; state transitions are mutex-guarded
      # so an abort cannot race normal completion.
      #
      # HTTP/1.1 cannot write to a request after transmit, so {#write} and
      # {#close_write} raise {NotSupportedError}.
      # @api private
      class Stream < Client::Stream
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

        # Internal sentinel used on the abort path: raised inside the driving
        # fiber when an {#abort} was recorded before session checkout completed,
        # so that {ConnectionPool#session_for} finishes the checked-out socket
        # instead of returning it to the pool. Caught explicitly (not via the
        # broad StandardError rescue) so it is never mistaken for a real
        # networking failure, and never surfaced to the caller. Not a separate
        # kind of cancellation from {#abort} - it is how an abort unwinds the
        # fiber. Not part of the stream contract.
        # @api private
        class InternalAbortSignal < StandardError; end

        # @param [ConnectionPool] pool The connection pool to check a session
        #   out of.
        # @param [Http::Request] request
        def initialize(pool, request)
          super()
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
        # @api private
        def send_request
          # Build (and validate) the Net::HTTP request before touching the
          # network so an invalid verb raises ArgumentError without opening a
          # connection or wrapping the error.
          net_request = build_net_request(@request)
          @fiber = Fiber.new { run(net_request) }
          @fiber.resume
          raise @error if @error

          self
        end

        # @return [Array(Integer, Hash<String,String>)] The response status code
        #   and headers. Available immediately after {#send_request} for HTTP/1.1.
        def response_headers
          [@status, @headers]
        end

        # Yields raw response body chunks on the caller's thread until EOF or
        # abort. If a fixed-length body ends before the advertised
        # +Content-Length+, surfaces a {NetworkingError} after iteration.
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

        # Net::HTTP HTTP/1.1 does not support post-transmit request writes.
        # @raise [NotSupportedError]
        def write(_bytes)
          raise NotSupportedError, 'HTTP/1.1 does not support writing to a stream after transmit'
        end

        # Net::HTTP HTTP/1.1 does not support post-transmit request writes.
        # @raise [NotSupportedError]
        def close_write
          raise NotSupportedError, 'HTTP/1.1 does not support writing to a stream after transmit'
        end

        # Aborts the stream and discards the underlying session rather than
        # returning it to the pool. Safe to call from another thread,
        # idempotent, and never raises.
        # @param [StandardError, nil] error
        # @return [void]
        def abort(error = nil)
          session = nil
          @mutex.synchronize do
            return if @done || @aborted

            @aborted = true
            @error ||= error
            session = @session
            @session = nil
          end
          # Discard the session through the pool so this finish is serialized
          # against a concurrent check-in: the pool removes it if it was already
          # returned, closing the window where abort could finish a session that
          # normal completion had just handed back. The fiber is left suspended
          # and collected. Errors are swallowed by the pool's finish; abort runs
          # on teardown paths where it must not raise and mask the triggering
          # error.
          @pool.finish_session(session)
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
            # (unable to finish it). Raise the internal abort sentinel so
            # #session_for finishes this session and does not return it to the
            # pool, preventing a leak of the checked-out connection. The abort is
            # already recorded in @aborted.
            raise InternalAbortSignal if aborted?

            perform_exchange(session, net_request)
            # Relinquish the session before control returns to #session_for,
            # which re-adds it to the pool. Setting @done and clearing @session
            # here (still before check-in) closes the window where a cross-thread
            # #abort could finish a session that had just been returned to the
            # pool: any abort after this no-ops, and check-in owns the session.
            release_session
          end
          nil
        rescue InternalAbortSignal
          # Intentional abort path; session_for already discarded the session.
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

        # Sends the request and reads the response within the pool's session
        # block, suspending after headers and after each body chunk so the caller
        # drives reads. Runs inside the driving fiber.
        # @param [Net::HTTPSession] session
        # @param [Net::HTTPRequest] net_request
        def perform_exchange(session, net_request)
          # On net-http < 0.7.0 (bundled with supported Ruby versions), Net::HTTP
          # applies a default Content-Type while sending a request with a body;
          # {Patches} suppresses that via this flag. It must be set here, inside
          # the driving fiber, because Thread#[] is fiber-local: the request is
          # sent from within this fiber, so a flag set on the calling fiber would
          # not be visible to the patch. net-http >= 0.7.0 removed the behavior,
          # so the flag is a no-op there.
          Thread.current[:net_http_skip_default_content_type] = true
          session.request(net_request) do |net_response|
            # The request has been sent by the time the response block runs, so
            # the skip flag is no longer needed.
            Thread.current[:net_http_skip_default_content_type] = nil
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

        # Marks the stream done and relinquishes ownership of the session so a
        # concurrent #abort will no-op instead of finishing a session that is
        # about to be (or has just been) returned to the pool.
        def release_session
          @mutex.synchronize do
            @session = nil
            @done = true
          end
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
          # On net-http < 0.7.0, Net::HTTP adds a default Content-Type when a
          # body is present; {Patches} suppresses that during send (see
          # #send_request). Set the body stream when its size is unknown or
          # greater than 0.
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
          # When Accept-Encoding is left unset, Net::HTTP injects a default
          # value and enables decode_content, transparently decompressing the
          # response. Setting it explicitly (to 'identity') opts out of that
          # path so the raw body is delivered.
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

        # Detects short fixed-length bodies that Net::HTTP may otherwise tolerate
        # because +ignore_eof+ defaults to +true+. Runs inside the pool session
        # block so a truncated connection is finished rather than returned to the
        # pool.
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
          @request.http_method != 'HEAD' && !@headers.nil? && @headers.key?('content-length')
        end
      end
    end
  end
end
