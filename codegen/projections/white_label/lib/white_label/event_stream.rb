# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module EventStream

    # EventStreamHandler for the the {Client#start_event_stream} operation.
    # Register event handlers using the `#on_<event_name>` methods
    # and set the handler using the `event_stream_handler` option
    # on the {Client#start_event_stream} method.
    # @example Basic Usage
    #   handler = StartEventStream.new
    #   # register handlers for the events you are interested in
    #   handler.on_initial_response { |initial_response| process(initial_response) }
    #   client.start_event_stream(params, event_stream_handler: handler)
    class StartEventStreamHandler < Hearth::EventStream::HandlerBase
      # Register an event handler for the initial response.
      # @yield [event] Called when the initial response is received.
      # @yieldparam event [Types::StartEventStreamOutput] the initial response
      # @example Event structure
      #   event #=> Types::StartEventStreamOutput
      #   event.initial_structure #=> Types::InitialStructure
      #   event.initial_structure.message #=> String
      #   event.initial_structure.nested #=> Types::NestedStructure
      #   event.initial_structure.nested.values #=> Array<String>
      #   event.initial_structure.nested.values[0] #=> String
      def on_initial_response(&block)
        on(Types::StartEventStreamOutput, block)
      end

      # Register an event handler for simple_event events
      # @yield [event] Called when simple_event events are received.
      # @yieldparam event [Types::Events::SimpleEvent] the event.
      # @example Event structure
      #   event #=> Types::SimpleEvent
      #   event.message #=> String
      def on_simple_event(&block)
        on(Types::Events::SimpleEvent, block)
      end

      # Register an event handler for nested_event events
      # @yield [event] Called when nested_event events are received.
      # @yieldparam event [Types::Events::NestedEvent] the event.
      # @example Event structure
      #   event #=> Types::NestedEvent
      #   event.nested #=> Types::NestedStructure
      #   event.nested.values #=> Array<String>
      #   event.nested.values[0] #=> String
      #   event.message #=> String
      #   event.header_a #=> String
      def on_nested_event(&block)
        on(Types::Events::NestedEvent, block)
      end

      # Register an event handler for explicit_payload_event events
      # @yield [event] Called when explicit_payload_event events are received.
      # @yieldparam event [Types::Events::ExplicitPayloadEvent] the event.
      # @example Event structure
      #   event #=> Types::ExplicitPayloadEvent
      #   event.header_a #=> String
      #   event.payload #=> Types::NestedStructure
      #   event.payload.values #=> Array<String>
      #   event.payload.values[0] #=> String
      def on_explicit_payload_event(&block)
        on(Types::Events::ExplicitPayloadEvent, block)
      end

      # Register an event handler for any unknown events.
      # @yield [event] Called when unknown events are received.
      # @yieldparam event [Types::Events::Unknown] the event with value set to the Message
      def on_unknown_event(&block)
        on(Types::Events::Unknown, block)
      end

      private

      def parse_event(type, message)
        case type
        when 'initial-response'
          Parsers::EventStream::StartEventStreamInitialResponse.parse(message)
        when 'SimpleEvent'
          Types::Events::SimpleEvent.new(Parsers::EventStream::SimpleEvent.parse(message))
        when 'NestedEvent'
          Types::Events::NestedEvent.new(Parsers::EventStream::NestedEvent.parse(message))
        when 'ExplicitPayloadEvent'
          Types::Events::ExplicitPayloadEvent.new(Parsers::EventStream::ExplicitPayloadEvent.parse(message))
        when 'ServerErrorEvent'
          Types::Events::ServerErrorEvent.new(Parsers::EventStream::ServerErrorEvent.parse(message))
        else
          Types::Events::Unknown.new(name: type || 'unknown', value: message)
        end
      end

      def parse_exception_event(type, message)
        case type
        when 'ServerErrorEvent'
          data = Parsers::EventStream::ServerErrorEvent.parse(message)
          Errors::ServerErrorEvent.new(data: data, error_code: 'WhiteLabel::Types::Events::ServerErrorEvent', metadata: {message: message})
        else
          data = Types::Events::Unknown.new(name: type || 'unknown', value: message)
          Errors::ApiError.new(error_code: type || 'unknown', metadata: {data: data, message: message})
        end
      end

      def parse_error_event(message)
        error_code = message.headers.delete(':error-code')&.value
        error_message = message.headers.delete(':error-message')&.value
        metadata = {message: message}
        Errors::ApiError.new(error_code: error_code, metadata: metadata, message: error_message)
      end
    end

    # Output returned from {Client#start_event_stream}
    # and used to signal (send) async input events.
    # @example Basic Usage
    #   stream = client.simple_event(initial_request)
    #   stream.signal_start_event_stream(event_params) # send an event
    #   stream.join # close the input stream and wait for the server
    class StartEventStreamOutput < Hearth::EventStream::AsyncOutput

      # Signal (send) an Events::SimpleEvent input event
      # @param [Hash | Types::SimpleEvent] params
      #   Request parameters for signaling this event.
      #   See {Types::SimpleEvent#initialize} for available parameters.
      # @example Request syntax with placeholder values
      #   stream.signal_simple_event(
      #     message: 'message'
      #   )
      def signal_simple_event(params = {})
        input = Params::SimpleEvent.build(params, context: 'params')
        message = Builders::EventStream::SimpleEvent.build(input: input)
        send_event(message)
      end

      # Signal (send) an Events::NestedEvent input event
      # @param [Hash | Types::NestedEvent] params
      #   Request parameters for signaling this event.
      #   See {Types::NestedEvent#initialize} for available parameters.
      # @example Request syntax with placeholder values
      #   stream.signal_nested_event(
      #     nested: {
      #       values: [
      #         'member'
      #       ]
      #     },
      #     message: 'message',
      #     header_a: 'headerA'
      #   )
      def signal_nested_event(params = {})
        input = Params::NestedEvent.build(params, context: 'params')
        message = Builders::EventStream::NestedEvent.build(input: input)
        send_event(message)
      end

      # Signal (send) an Events::ExplicitPayloadEvent input event
      # @param [Hash | Types::ExplicitPayloadEvent] params
      #   Request parameters for signaling this event.
      #   See {Types::ExplicitPayloadEvent#initialize} for available parameters.
      # @example Request syntax with placeholder values
      #   stream.signal_explicit_payload_event(
      #     header_a: 'headerA',
      #     payload: {
      #       values: [
      #         'member'
      #       ]
      #     }
      #   )
      def signal_explicit_payload_event(params = {})
        input = Params::ExplicitPayloadEvent.build(params, context: 'params')
        message = Builders::EventStream::ExplicitPayloadEvent.build(input: input)
        send_event(message)
      end

      # Signal (send) an Events::ServerErrorEvent input event
      # @param [Hash | Types::ServerErrorEvent] params
      #   Request parameters for signaling this event.
      #   See {Types::ServerErrorEvent#initialize} for available parameters.
      # @example Request syntax with placeholder values
      #   stream.signal_server_error_event(
      #     nested: {
      #       values: [
      #         'member'
      #       ]
      #     },
      #     message: 'message',
      #     header_a: 'headerA'
      #   )
      def signal_server_error_event(params = {})
        input = Params::ServerErrorEvent.build(params, context: 'params')
        message = Builders::EventStream::ServerErrorEvent.build(input: input)
        send_event(message)
      end
    end
  end
end
