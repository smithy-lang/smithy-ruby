# frozen_string_literal: true

module Smithy
  module Client
    module NetHTTP
      # The HTTP/1.1 {Client::Stream} control handle, returned by
      # {Transport#transmit_background} for an event-stream operation. It is a
      # thin OUTBOUND + CONTROL wrapper around a backgrounded {Exchange}; it holds
      # no driving logic of its own (the {Exchange} owns the request/response
      # engine and pushes the response into the sink on a background thread).
      #
      # The handle exposes:
      #
      # * {#abort} - cancels the in-flight exchange (delegates to the {Exchange}),
      #   cross-thread-safe, idempotent, never raises;
      # * {#write}/{#close_write} - the bidirectional outbound surface, which
      #   HTTP/1.1 does not support, so they raise {NotSupportedError}. (HTTP/1.1
      #   can serve OUTPUT-ONLY event streams, which never call these; it cannot
      #   serve bidirectional streams.)
      # @api private
      class Stream
        # @param [Exchange] exchange The backgrounded request/response engine
        #   this handle controls.
        def initialize(exchange)
          @exchange = exchange
        end

        # Cancels the in-progress exchange, discarding the underlying session
        # rather than returning it to the pool. Delegates to the {Exchange}; safe
        # to call from another thread, idempotent, and never raises.
        # @param [StandardError, nil] error
        # @return [void]
        def abort(error = nil)
          @exchange.abort(error)
        end

        # Net::HTTP HTTP/1.1 does not support post-transmit request writes
        # (bidirectional streaming). Output-only event streams never call this.
        # @raise [NotSupportedError]
        def write(_bytes)
          raise NotSupportedError, 'HTTP/1.1 does not support writing to a stream after transmit'
        end

        # Net::HTTP HTTP/1.1 does not support post-transmit request writes
        # (bidirectional streaming). Output-only event streams never call this.
        # @raise [NotSupportedError]
        def close_write
          raise NotSupportedError, 'HTTP/1.1 does not support writing to a stream after transmit'
        end
      end
    end
  end
end
