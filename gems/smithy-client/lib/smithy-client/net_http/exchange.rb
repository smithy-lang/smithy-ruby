# frozen_string_literal: true

require 'net/http'

module Smithy
  module Client
    module NetHTTP
      # Runs one HTTP/1.1 request using +Net::HTTP+ and delivers the response
      # to the supplied sink:
      #
      # * +sink.headers+ delivers the response status and headers.
      # * +sink.data+ delivers each body chunk.
      # * +sink.done+ signals completion.
      # * +sink.error+ signals failure, even if no headers were received.
      #
      # Completion and failure are terminal events. An aborted exchange
      # delivers no terminal event.
      #
      # {Transport} controls how the exchange runs:
      #
      # * {Transport#transmit} runs it on the caller's thread.
      # * {Transport#transmit_background} starts a background thread and
      #   returns a {Stream} handle for controlling the exchange.
      #
      # Invalid HTTP methods raise {ArgumentError} during construction,
      # before any network I/O.
      #
      # {#abort} may be called from another thread. A mutex coordinates
      # abort, completion, and headers/body delivery (see {#deliver}).
      # Once abort is recorded, headers/body delivery stops and any active
      # session is closed to interrupt blocking network I/O.
      # @api private
      class Exchange
        # Signals cancellation internally so {ConnectionPool#session_for}
        # closes the session instead of returning it to the pool.
        # Rescued separately from +StandardError+ so cancellation is not
        # reported to the sink as a failure.
        # @api private
        class InternalAbortSignal < StandardError; end

        # Classify recognized network failures without wrapping unrelated exceptions.
        NETWORK_ERRORS = [
          SocketError, EOFError, IOError, Timeout::Error,
          Errno::ECONNABORTED, Errno::ECONNRESET, Errno::EPIPE, Errno::EINVAL,
          Errno::ETIMEDOUT, Errno::EHOSTUNREACH, Errno::ECONNREFUSED,
          OpenSSL::SSL::SSLError, Net::HTTPFatalError
        ].freeze

        # @param [ConnectionPool] pool The pool supplying the connection.
        # @param [Http::Request] request
        # @param [#headers, #data, #done, #error] sink Receives response events (see {ResponseSink}).
        # @raise [ArgumentError] For an unsupported HTTP method, before any network I/O.
        def initialize(pool, request, sink)
          @pool = pool
          @request = request
          @sink = sink
          @net_request = build_net_request(request)
          @session = nil
          @bytes_received = 0
          @status = nil
          @headers = nil
          @done = false
          @aborted = false
          # Coordinates abort, completion, and session ownership across threads.
          # Also guards headers/body delivery so it stops once abort is recorded.
          @mutex = Mutex.new
        end

        # Runs the exchange on the caller's thread.
        # Calls +sink.done+ on completion or +sink.error+ on failure.
        # An aborted exchange calls neither.
        # Recognized networking failures are wrapped in {NetworkingError}.
        def drive
          run(@net_request)
          nil
        end

        # Runs {#drive} on a background thread so the caller can continue
        # without waiting for the exchange to finish.
        # @return [Thread] The thread running the exchange.
        def drive_background
          Thread.new { drive }
        end

        # Cancels the exchange and closes its connection so the pool cannot reuse it.
        # Does nothing if the exchange has already finished or been aborted.
        # May be called from another thread.
        # @param [StandardError, nil] _error Accepted for the stream abort interface; unused.
        def abort(_error = nil)
          session = nil
          @mutex.synchronize do
            return if @done || @aborted

            @aborted = true
            session = @session
            @session = nil
          end
          # Remove and close the session under the pool's lock so another request
          # cannot reuse it while abort is closing it.
          @pool.finish_session(session, @request.endpoint)
          nil
        end

        private

        # Runs the request and signals completion unless it failed or was aborted.
        # @param [Net::HTTPRequest] net_request
        def run(net_request)
          # Call sink.done outside drive_exchange's rescue so callback errors
          # are not handled as request failures or followed by sink.error.
          @sink.done if drive_exchange(net_request)
          nil
        end

        # Sends the request using a pooled connection.
        # Reports failures to the sink; aborts do not notify the sink.
        # @param [Net::HTTPRequest] net_request
        # @return [Boolean] Whether {#run} should call +sink.done+.
        def drive_exchange(net_request)
          @pool.session_for(@request.endpoint) do |session|
            store_session(session)
            # If abort happened before checkout, raise so the pool closes this session.
            raise InternalAbortSignal if aborted?

            perform_exchange(session, net_request)
            # Abort can stop body delivery without raising. Check again before
            # returning the connection to the pool.
            raise InternalAbortSignal unless release_unless_aborted
          end
          true
        rescue InternalAbortSignal
          # The pool has already closed the session. Do not report cancellation.
          mark_done
          false
        rescue StandardError => e
          signal_failure(e)
          false
        end

        # Reports a failure to the sink unless the exchange was aborted.
        # @param [StandardError] error
        def signal_failure(error)
          mark_done
          error = NetworkingError.new(error) if NETWORK_ERRORS.any? { |type| error.is_a?(type) }
          @sink.error(error) unless aborted?
          nil
        end

        # Sends the request and delivers response headers and body to the sink.
        # @param [ConnectionPool::ExtendedSession] session
        # @param [Net::HTTPRequest] net_request
        def perform_exchange(session, net_request)
          # {Patches} uses this flag to suppress Net::HTTP's default Content-Type.
          Thread.current[:net_http_skip_default_content_type] = true
          session.request(net_request) do |net_response|
            # Clear before response callbacks can make another HTTP request.
            Thread.current[:net_http_skip_default_content_type] = nil
            push_response(net_response)
          end
        ensure
          # Clear even if the request fails before the response block runs.
          Thread.current[:net_http_skip_default_content_type] = nil
        end

        # Delivers response headers, then each nonempty body chunk to the sink.
        # {#deliver} prevents further delivery once abort is recorded.
        # @param [Net::HTTPResponse] net_response
        def push_response(net_response)
          @status = net_response.code.to_i
          @headers = extract_headers(net_response)
          return unless deliver { @sink.headers(@status, @headers) }

          net_response.read_body do |chunk|
            @bytes_received += chunk.bytesize
            next if chunk.empty?

            break unless deliver { @sink.data(chunk) }
          end
          verify_content_length!
        end

        # Runs a sink call unless the exchange was aborted.
        # Holds the mutex while checking and calling the sink, preventing
        # abort from being recorded between those steps.
        #
        # Do not call this exchange's abort method from inside the block:
        # it needs the same mutex, which is already held.
        # @return [Boolean] true if the block ran; false if already aborted.
        def deliver
          @mutex.synchronize do
            return false if @aborted

            yield
            true
          end
        end

        # @return [Boolean]
        def aborted?
          @mutex.synchronize { @aborted }
        end

        # @param [ConnectionPool::ExtendedSession] session
        def store_session(session)
          @mutex.synchronize { @session = session }
        end

        # Marks the exchange complete unless abort was already recorded.
        # Uses the same mutex as abort so only one can take effect.
        # Once complete, later abort calls do nothing.
        # @return [Boolean] true if the connection can return to the pool;
        #   false if aborted.
        def release_unless_aborted
          @mutex.synchronize do
            return false if @aborted

            @session = nil
            @done = true
            true
          end
        end

        # Marks the exchange complete under the mutex so later abort calls do nothing.
        # Clears the session reference because the exchange no longer owns it.
        def mark_done
          @mutex.synchronize do
            @done = true
            @session = nil
          end
        end

        # Constructs a +Net::HTTP+ request object from an {Http::Request}.
        # @param [Http::Request] request
        # @return [Net::HTTPRequest]
        def build_net_request(request)
          request_class = net_http_request_class(request)
          req = request_class.new(request.endpoint.request_uri, net_headers_for(request))
          req.body_stream = request.body if !request.body.respond_to?(:size) || request.body.size.positive?
          req
        end

        # @param [Http::Request] request
        # @raise [ArgumentError] If the HTTP method is not a valid verb.
        # @return [Class<Net::HTTPRequest>]
        def net_http_request_class(request)
          request_class =
            begin
              ::Net::HTTP.const_get(request.http_method.capitalize, false)
            rescue NameError
              nil
            end
          return request_class if request_class.is_a?(Class) && request_class < ::Net::HTTPRequest

          raise ArgumentError, "`#{request.http_method}` is not a valid http verb"
        end

        # @param [Http::Request] request
        # @return [Hash<String, String>]
        def net_headers_for(request)
          # Request an uncompressed response and disable Net::HTTP's automatic decompression.
          # Otherwise, the decoded body's size could differ from Content-Length,
          # making a complete response look truncated.
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

        # Net::HTTP can accept incomplete bodies, so verify Content-Length ourselves.
        # Raising here makes the pool close the connection instead of reusing it.
        # @raise [IOError] When the received byte count differs from +Content-Length+.
        def verify_content_length!
          return unless should_verify_bytes?

          bytes_expected = @headers['content-length'].to_i
          return if bytes_expected == @bytes_received

          raise IOError, "http response body truncated, expected #{bytes_expected} " \
                         "bytes, received #{@bytes_received} bytes"
        end

        # @return [Boolean]
        def should_verify_bytes?
          @request.http_method != 'HEAD' && !@headers.nil? && @headers.key?('content-length')
        end
      end
    end
  end
end
