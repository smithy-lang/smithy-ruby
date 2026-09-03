# frozen_string_literal: true

module Smithy
  module Client
    # The +:send+ step handler for {Smithy::Client}. Sends the request using the
    # configured transport (+config.transport+) and drives the resulting stream
    # into the context's {Http::Response}.
    #
    # This handler is adapter-independent but contract-shaping: it depends on no
    # concrete transport, but requires the stream from +#transmit+ to fit a
    # staged, pull-based model:
    #
    # * +#transmit+ returns before the body is consumed,
    # * status/headers are a distinct phase via +#response_headers+,
    # * the body is pulled in order via +#each_chunk+, and
    # * +#abort+ cancels during the exchange.
    #
    # A push/event-style transport must adapt itself to this lifecycle.
    # Protocol-specific concerns (blocking, pooling, truncation detection) live
    # in the transport. This handler decides only *when* to block and bridges
    # the pulled bytes onto the push-based {Http::Response}.
    # @api private
    class SendHandler < Handler
      # @param [HandlerContext] context
      # @return [Response]
      def call(context)
        transmit(context.config.transport, context.http_request, context.http_response, context)
        Response.new(context: context)
      end

      private

      # @param [#transmit] transport
      # @param [Http::Request] req
      # @param [Http::Response] resp
      # @param [HandlerContext] context
      # @return [void]
      def transmit(transport, req, resp, context)
        stream = nil
        stream = transport.transmit(req)
        context[:stream] = stream

        # Blocking is a handler-stack decision, not a transport concern. A
        # duplex event stream would deadlock if blocked here (the server waits
        # for input events), so the event stream layer drives it instead. All
        # other operations resolve here so retry/error/parse handlers can run.
        resolve_response(stream, resp) unless context[:duplex_stream]
      rescue ArgumentError => e
        # Invalid verb, ArgumentError is a StandardError. Not retryable.
        resp.signal_error(e)
      rescue StandardError => e
        resp.signal_error(e.is_a?(NetworkingError) ? e : NetworkingError.new(e))
      ensure
        # Guarantee the connection is released. On the normal path #abort is a
        # no-op; if an error escaped before the body was consumed, #abort
        # finishes the socket so it is not leaked. Duplex streams are owned and
        # closed by the event stream layer.
        stream.abort unless stream.nil? || context[:duplex_stream]
      end

      # Resolves the response by reading headers and draining the body into the
      # push-based {Http::Response}.
      # @param [#response_headers, #each_chunk] stream
      # @param [Http::Response] resp
      # @return [void]
      def resolve_response(stream, resp)
        status, headers = stream.response_headers
        resp.signal_headers(status, headers)
        stream.each_chunk { |chunk| resp.signal_data(chunk) }
        resp.signal_done
      end
    end
  end
end
