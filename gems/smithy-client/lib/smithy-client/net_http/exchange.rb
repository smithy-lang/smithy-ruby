# frozen_string_literal: true

require 'net/http'

module Smithy
  module Client
    module NetHTTP
      # The HTTP/1.1 request/response driving engine, backed by +Net::HTTP+. An
      # +Exchange+ runs a single request/response and PUSHES the response into
      # the sink supplied at construction (+sink.headers+, then +sink.data+ per
      # body chunk, then one terminal). There is no Fiber: +Net::HTTP+'s own
      # +read_body+ callback maps directly onto +sink.data+.
      #
      # {Transport} owns it: {Transport#transmit} calls {#drive}, and
      # {Transport#transmit_background} calls {#drive_background} and hands the
      # +Exchange+ to a {Stream} handle. The verb is validated at construction, so
      # an invalid verb raises {ArgumentError} before {#drive} touches the
      # network.
      #
      # {#abort} may be called from another thread (the norm for an event stream
      # driven in the background). State transitions are mutex-guarded so an abort
      # cannot race completion or deliver to the sink after the abort (see
      # {#deliver}), and closing the socket interrupts a blocked read on the
      # driving thread.
      # @api private
      class Exchange
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
        # exchange when an {#abort} was recorded before session checkout
        # completed, so that {ConnectionPool#session_for} finishes the
        # checked-out socket instead of returning it to the pool. Caught
        # explicitly (not via the broad StandardError rescue) so it is never
        # mistaken for a real networking failure, and never surfaced to the sink.
        # Not a separate kind of cancellation from {#abort} - it is how an abort
        # unwinds the driver.
        # @api private
        class InternalAbortSignal < StandardError; end

        # @param [ConnectionPool] pool The connection pool to check a session
        #   out of.
        # @param [Http::Request] request
        # @param [#headers, #data, #done, #error] sink The response sink this
        #   exchange pushes into when driven (see {ResponseSink}).
        # @raise [ArgumentError] If the request has an invalid HTTP method
        #   (validated here, before any network I/O).
        def initialize(pool, request, sink)
          @pool = pool
          @request = request
          @sink = sink
          # Build (and validate) the Net::HTTP request up front so an invalid
          # verb raises ArgumentError at construction time, without opening a
          # connection or driving the exchange.
          @net_request = build_net_request(request)
          @session = nil
          @bytes_received = 0
          @status = nil
          @headers = nil
          @done = false
          @aborted = false
          # Guards the @done/@aborted/@session transitions so a cross-thread
          # {#abort} is observed by the driving thread and cannot race normal
          # completion.
          @mutex = Mutex.new
        end

        # Runs the exchange synchronously on the caller's thread, pushing the
        # response into the sink to a single terminal. Networking failures are
        # surfaced as +sink.error(NetworkingError)+, not raised.
        # @return [self]
        def drive
          run(@net_request)
          self
        end

        # Runs {#drive} on a background thread and returns immediately. Net::HTTP
        # is blocking, so an OS thread is the concurrency mechanism (a reactor
        # transport would use an async task).
        # @return [Thread]
        def drive_background
          Thread.new { drive }
        end

        # Aborts the exchange, discarding the underlying session rather than
        # returning it to the pool. Idempotent and never raises (it runs on
        # teardown paths); safe to call from another thread (see the class-level
        # Concurrency note).
        # @param [StandardError, nil] _error
        # @return [void]
        def abort(_error = nil)
          session = nil
          @mutex.synchronize do
            return if @done || @aborted

            @aborted = true
            session = @session
            @session = nil
          end
          # Discard through the pool so this finish is serialized against a
          # concurrent check-in: the pool removes the session if it was already
          # returned, closing the window where abort could finish a just-pooled
          # session. Passing the endpoint keeps the pool's removal targeted to
          # that endpoint's list rather than scanning the whole pool. Errors are
          # swallowed; abort runs on teardown paths and must not raise.
          @pool.finish_session(session, @request.endpoint)
          nil
        end

        private

        # Runs the full request within the pool's session block, pushing the
        # response into the sink. Terminates the sink exactly once.
        # @param [Net::HTTPRequest] net_request
        def run(net_request)
          @pool.session_for(@request.endpoint) do |session|
            store_session(session)
            # #abort may have raced ahead of checkout with a nil session (nothing
            # to finish yet). Raise so #session_for finishes this session instead
            # of pooling it, avoiding a leak. The abort is already recorded.
            raise InternalAbortSignal if aborted?

            perform_exchange(session, net_request)
            # If an abort landed during the body (delivery stops in #deliver
            # without the socket-close necessarily having raised yet),
            # perform_exchange can return NORMALLY. Do not let #session_for re-pool
            # this session: abort already finished the socket, so pooling it would
            # hand out a closed connection. Raise so #session_for takes its finish
            # path instead (the redundant finish is swallowed).
            raise InternalAbortSignal if aborted?

            # Relinquish the session before #session_for re-pools it: any abort
            # after this no-ops, so check-in owns the session and abort cannot
            # finish a pooled connection.
            release_session
          end
          # Success terminal, unless a cooperative abort stopped us first.
          @sink.done unless aborted?
          nil
        rescue InternalAbortSignal
          # Intentional abort path; session_for already discarded the session.
          # Nothing to surface - an aborted exchange stays quiet.
          mark_done
          nil
        rescue StandardError => e
          # A networking failure (the invalid-verb ArgumentError is validated at
          # construction, before run). If an abort is concurrently in progress
          # the socket close surfaces here as a read error; stay quiet in that
          # case since the caller intentionally cancelled.
          mark_done
          @sink.error(NetworkingError.new(e)) unless aborted?
          nil
        end

        # Issues the request within the pool's session block and pushes the
        # response into the sink. Runs on the driving thread.
        # @param [Net::HTTPSession] session
        # @param [Net::HTTPRequest] net_request
        def perform_exchange(session, net_request)
          # On net-http < 0.7.0, Net::HTTP applies a default Content-Type when a
          # request has a body; {Patches} suppresses that via this flag. No-op on
          # net-http >= 0.7.0, which removed the behavior.
          # TODO: remove with {Patches} once min Ruby ships net-http >= 0.7.0.
          Thread.current[:net_http_skip_default_content_type] = true
          session.request(net_request) { |net_response| push_response(net_response) }
        ensure
          Thread.current[:net_http_skip_default_content_type] = nil
        end

        # Pushes a single response into the sink: headers, then non-empty body
        # chunks, then verifies the advertised length. Every sink call goes
        # through {#deliver}, so nothing is delivered after an abort. Runs inside
        # the pool session block so a truncated (peer-closed) body raises here and
        # #session_for finishes the socket instead of returning it to the pool.
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

        # Runs +block+ (a single sink call) iff not aborted, atomically with
        # respect to {#abort}: the check and the call happen under @mutex, so an
        # abort cannot slip between observing "not aborted" and delivering, and no
        # headers/data reach the sink after an abort is recorded. Returns whether
        # it delivered, so callers stop pushing once aborted.
        #
        # The sink call runs while @mutex is held, so a sink MUST NOT call back
        # into this exchange's #abort (it would deadlock). #abort is driven by the
        # consumer thread, not from inside the sink, so this holds.
        # @return [Boolean] true if the sink call ran; false if aborted.
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

        def store_session(session)
          @mutex.synchronize { @session = session }
        end

        # Marks the exchange done and relinquishes ownership of the session so a
        # concurrent #abort will no-op instead of finishing a session that is
        # about to be (or has just been) returned to the pool.
        def release_session
          @mutex.synchronize do
            @session = nil
            @done = true
          end
        end

        # Marks the exchange done and relinquishes ownership of the session so a
        # concurrent #abort no-ops (on @done) and, even if it had already read a
        # stale @session, finds none to finish. On the error/abort paths that
        # call this, #session_for has already finished the socket; nil-ing
        # @session here makes "done => nothing left to finish" a hard invariant
        # rather than relying on that ordering.
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
          # On net-http < 0.7.0, Net::HTTP adds a default Content-Type when a
          # body is present; {Patches} suppresses that during send (see
          # #perform_exchange). Set the body stream when its size is unknown or
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
