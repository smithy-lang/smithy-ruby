# frozen_string_literal: true

module Smithy
  module Client
    # The +:send+ step handler for {Smithy::Client}. It supplies a
    # {ResponseSink} over the context's {Http::Response} and hands it to the
    # configured transport (+config.transport+), which pushes the response into
    # it - response shaping lives in the {Transport}, not here.
    #
    # The handler only picks WHICH transport method to call, by operation mode:
    # {Transport#transmit} for a non-event-stream operation (drives to completion
    # synchronously; nothing to store), or {Transport#transmit_background} for an
    # event stream (+context[:event_stream]+; returns a {Stream} handle stored on
    # the context for the event stream layer). See the methods below for the
    # per-mode error/teardown handling.
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
        # The sink is the inbound destination in all modes (an event stream feeds
        # inbound events into it too).
        sink = ResponseSink.new(resp)
        # TODO: nothing sets context[:event_stream] yet; the event stream layer will.
        if context[:event_stream]
          # Deliberately outside drive_non_event_stream's rescues: the exchange runs
          # on a background thread, so failures surface via sink.error there, and
          # teardown belongs to the event stream layer.
          context[:stream] = transport.transmit_background(req, sink)
          return
        end

        drive_non_event_stream(transport, req, resp, sink)
      end

      # Non-event-stream send: transmit drives the response into the sink to its
      # terminal synchronously and returns nothing (the transport owns teardown,
      # so there is no handle to store or abort). Errors are caught and signaled
      # onto the response so the error/retry handlers can run.
      # @return [void]
      def drive_non_event_stream(transport, req, resp, sink)
        transport.transmit(req, sink)
      rescue ArgumentError, NotSupportedError => e
        # Not retryable, and must be rescued ahead of the clause below:
        # - ArgumentError (invalid verb) is raised before any network I/O;
        # - NotSupportedError (a single-mode transport served only event streams
        #   and raised from #transmit) is a StandardError, so the clause below
        #   would otherwise wrap it into a transient NetworkingError and retry it
        #   with backoff. A mode mismatch is a caller/config error, not a
        #   networking failure. Signal both as-is.
        resp.signal_error(e)
      rescue StandardError => e
        # Defensive: the transport should surface networking failures via
        # sink.error while driving, so reaching here means something escaped.
        resp.signal_error(e.is_a?(NetworkingError) ? e : NetworkingError.new(e))
      end
    end
  end
end
