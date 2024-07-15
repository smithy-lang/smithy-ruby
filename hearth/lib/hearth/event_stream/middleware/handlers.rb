# frozen_string_literal: true

module Hearth
  module EventStream
    module Middleware
      # A middleware that configures the EventStream handlers
      # on the request and response
      class Handlers
        include Hearth::Middleware::Logging

        # @param [Class] app The next middleware in the stack.
        # @param [Boolean] request_events true if there are input events
        # @param [Boolean] response_events true if there are output events
        # @param [Hearth::EventStream::HandlerBase] event_handler EventStream
        #   handler for the operation to be used with request/response.
        # @param [Module] message_encoding_module Module with protocol specific
        #   message encoders/decoders and content_type method.
        #  arguments.
        def initialize(app, request_events:, response_events:, event_handler:, message_encoding_module:)
          @app = app
          @request_events = request_events
          @response_events = response_events
          @event_handler = event_handler
          @message_encoding_module = message_encoding_module
        end

        # @param input
        # @param context
        # @return [Output]
        def call(input, context)
          setup_request_events(context) if @request_events

          setup_response_events(context) if @response_events

          @app.call(input, context)
        end
        
        private
        
        def setup_request_events(context)
          encoder = Hearth::EventStream::Encoder.new(
            message_encoder: @message_encoding_module
                               .const_get(:MessageEncoder).new
          )
          # TODO: Handle initial event body
          _initial_event_body = context.request.body
          context.request.body = encoder
          @event_handler.encoder = encoder
        end
        
        def setup_response_events(context)
          decoder = Hearth::EventStream::Decoder.new(
            message_decoder: @message_encoding_module
                               .const_get(:MessageDecoder).new,
            event_handler: @event_handler
          )
          context.response.body = decoder
        end
      end
    end
  end
end
