# frozen_string_literal: true

module Smithy
  module Client
    # The +:send+ step handler for {Smithy::Client}. Sends the request using the
    # configured transport (+config.transport+) and drives the resulting stream
    # into the context's {Http::Response}.
    #
    # This handler is transport-agnostic: it depends only on the stream contract
    # (+#response_headers+, +#each_chunk+, +#abort+) and never on a concrete
    # transport.
    # Protocol-specific concerns - how blocking is implemented, connection
    # pooling, HTTP/1.1 body-truncation detection - live in the transport and
    # its stream. This handler only decides *when* to block (immediately, for
    # plain request/response operations) and bridges the pulled bytes onto the
    # push-based {Http::Response} the rest of the stack consumes.
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

        # Blocking for the response is a handler-stack decision, not a transport
        # concern. For a bidirectional (duplex) event stream, the server may not
        # respond until it receives input events, so blocking here would
        # deadlock; the event stream layer drives that stream instead. For all
        # other operations (plain request/response and output-only streams) we
        # resolve the response so retry/error/parse handlers can run.
        resolve_response(stream, resp) unless context[:duplex_stream]
      rescue ArgumentError => e
        # Invalid verb, ArgumentError is a StandardError. Not retryable.
        resp.signal_error(e)
      rescue StandardError => e
        resp.signal_error(e.is_a?(NetworkingError) ? e : NetworkingError.new(e))
      ensure
        # Guarantee the checked-out connection is released. On the normal path
        # the stream has already completed and #abort is a no-op; if an error
        # escaped before the body was fully consumed (e.g. #signal_headers
        # raised, or a consumer error left the fiber suspended), #abort finishes
        # the socket so it is not leaked. Duplex streams are owned by the event
        # stream layer, which is responsible for closing them.
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
