# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that configures the EventStream handlers
    # on the request and response
    # @api private
    class EventStreams
      include Hearth::Middleware::Logging

      # @param [Class] app The next middleware in the stack.
      # @param [Boolean] request_events true if the operation supports
      #   request (input) event streams.
      # @param [Boolean] response_events true if the operation supports
      #   response (output) event streams.
      # @param [Class] async_output_class class to use for output.
      #   Set only when the output is async.
      # @param [Hearth::EventStream::HandlerBase] event_handler EventStream
      #   handler for the operation to be used with request/response.
      # @param [Module] message_encoding_module Module with protocol specific
      #   message encoders/decoders.
      #  arguments.
      #
      def initialize(
        app,
        request_events:, response_events:, async_output_class:,
        event_handler:, message_encoding_module:
      )
        @app = app
        @request_events = request_events
        @response_events = response_events
        @async_output_class = async_output_class
        @event_handler = event_handler
        @message_encoding_module = message_encoding_module
      end

      # @param input
      # @param context
      # @return [Output | EventStream::AsyncOutput]
      def call(input, context)
        encoder = setup_request_events(context) if @request_events

        setup_response_events(context) if @response_events

        output = @app.call(input, context)

        if @async_output_class && !output.error
          log_debug(context, "
          Initial connection succeeded, replacing " \
            "output with #{@async_output_class}")

          output = @async_output_class.new(
            response: context.response,
            encoder: encoder,
            metadata: output.metadata
          )
        end

        output
      end

      private

      def setup_request_events(context)
        log_debug(context, 'Setting up request events.')
        context.request.keep_open = true
        message_encoder = @message_encoding_module
                          .const_get(:MessageEncoder).new
        initial_event_body = context.request.body

        encoder =
          if initial_event_body.is_a?(EventStream::Message)
            EventStream::EncoderWithInitialMessage.new(
              message_encoder: message_encoder,
              initial_event: initial_event_body
            )
          else
            EventStream::Encoder.new(
              message_encoder: message_encoder
            )
          end

        context.request.body = encoder
        encoder
      end

      def setup_response_events(context)
        log_debug(context, 'Setting up response events.')
        decoder = EventStream::Decoder.new(
          message_decoder: @message_encoding_module
                             .const_get(:MessageDecoder).new,
          event_handler: @event_handler
        )
        context.response.body = decoder
        context.metadata[:event_handler] = @event_handler
      end
    end
  end
end
