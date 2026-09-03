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
        # TODO: context[:event_stream] is not set anywhere yet - no production
        # code assigns it (rpc_v2_cbor only uses event_stream? for the
        # Content-Type/Accept headers). The event stream layer will set it (and
        # distinguish output-only vs bidirectional) once wired in; until then
        # this branch is reachable only from tests and every operation takes the
        # non-event path below.
        if context[:event_stream]
          # transmit_background returns immediately; the event stream layer pumps
          # the sink and owns the handle's lifetime, so we only store it. NOT
          # wrapped by drive_non_event_stream's rescues: the exchange runs on a
          # background thread (failures surface via sink.error there, not by
          # raising here) and teardown is the event stream layer's, not
          # signal_error's. Only a synchronous invalid-verb ArgumentError can
          # escape, which that layer surfaces.
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
      rescue ArgumentError => e
        # Invalid verb; raised before any network I/O. Not retryable.
        resp.signal_error(e)
      rescue StandardError => e
        # Defensive: the transport should surface networking failures via
        # sink.error while driving, so reaching here means something escaped.
        resp.signal_error(e.is_a?(NetworkingError) ? e : NetworkingError.new(e))
      end
    end
  end
end
