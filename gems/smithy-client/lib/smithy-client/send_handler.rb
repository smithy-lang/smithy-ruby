# frozen_string_literal: true

module Smithy
  module Client
    # Sends the request through the configured transport at the +:send+ step.
    # Wraps the context's {Http::Response} in a {ResponseSink} to receive
    # response events.
    #
    # Chooses the transport method using +context[:event_stream]+:
    #
    # * {Transport#transmit} runs the request synchronously.
    # * {Transport#transmit_background} starts the request in the background
    #   and stores the returned {Stream} in +context[:stream]+.
    #
    # For synchronous calls, records escaped {StandardError} exceptions on
    # the HTTP response so the SDK's error and retry handlers can inspect them.
    # @api private
    class SendHandler < Handler
      # @param [HandlerContext] context
      # @return [Response]
      def call(context)
        transmit(context)
        Response.new(context: context)
      end

      private

      # @param [HandlerContext] context
      def transmit(context)
        transport = context.config.transport
        req = context.http_request
        resp = context.http_response
        sink = ResponseSink.new(resp)

        # TODO: Update when event stream is supported.
        if context[:event_stream]
          # Failures while sending the request are reported through the sink.
          # Errors starting the background exchange are raised to the caller.
          # The event-stream layer is responsible for closing or aborting the stream.
          context[:stream] = transport.transmit_background(req, sink)
          return
        end

        drive_non_event_stream(transport, req, resp, sink)
      end

      # Sends the request synchronously.
      # Records raised errors on the HTTP response so the SDK can handle them.
      # @param [#transmit] transport
      # @param [Http::Request] req
      # @param [Http::Response] resp
      # @param [ResponseSink] sink
      def drive_non_event_stream(transport, req, resp, sink)
        transport.transmit(req, sink)
      rescue StandardError => e
        # Classify recognized network errors and preserve other exceptions.
        resp.signal_error(NetworkingError.wrap(e))
      end
    end
  end
end
