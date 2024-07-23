# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  module EventStream

    # EventStreamHandler for the the {Client#start_event_stream} operation.
    # Register event handlers using the +#on_<event_name>+ methods
    # and set the handler using the +event_stream_handler+ option
    # on the {Client#start_event_stream} method.
    # @example Basic Usage
    #   handler = StartEventStream.new
    #   # register handlers for the events you are interested in
    #   handler.on_initial_response { |initial_response| process(initial_response) }
    #   client.start_event_stream(params, event_stream_handler: handler)
    class StartEventStreamHandler < Hearth::EventStream::HandlerBase

      # Register an event handler for simple_event events
      # @yield [event] Called when simple_event events are received.
      # @yieldparam event [Types::SimpleEvent] the event.
      # @example Event structure
      #   event #=> Types::SimpleEvent
      #   event.message #=> String
      def on_simple_event(&block)
        on('SimpleEvent', block)
      end

      # Register an event handler for nested_event events
      # @yield [event] Called when nested_event events are received.
      # @yieldparam event [Types::NestedEvent] the event.
      # @example Event structure
      #   event #=> Types::NestedEvent
      #   event.nested #=> Types::NestedStructure
      #   event.nested.values #=> Array<String>
      #   event.nested.values[0] #=> String
      def on_nested_event(&block)
        on('NestedEvent', block)
      end

      # Register an event handler for explicit_payload_event events
      # @yield [event] Called when explicit_payload_event events are received.
      # @yieldparam event [Types::ExplicitPayloadEvent] the event.
      # @example Event structure
      #   event #=> Types::ExplicitPayloadEvent
      #   event.header_a #=> String
      #   event.payload #=> Types::NestedStructure
      #   event.payload.values #=> Array<String>
      #   event.payload.values[0] #=> String
      def on_explicit_payload_event(&block)
        on('ExplicitPayloadEvent', block)
      end

      private

      def parse_event(type, message)
        case type
        when 'initial-response' then Parsers::EventStream::StartEventStreamInitialResponse.parse(message)
        when 'SimpleEvent' then Parsers::EventStream::SimpleEvent.parse(message)
        when 'NestedEvent' then Parsers::EventStream::NestedEvent.parse(message)
        when 'ExplicitPayloadEvent' then Parsers::EventStream::ExplicitPayloadEvent.parse(message)
        end
      end
    end

    # Output class returned from {Client#start_event_stream}
    # and allowing async sending (signaling) of input events.
    # @example Basic Usage
    #   stream = client.simple_event(initial_request)
    #   stream.signal_start_event_stream(event_params) # send an event
    #   stream.join # close the input stream and wait for the server
    class StartEventStreamOutput < Hearth::EventStream::AsyncOutput

      # Signal (send) an Events::SimpleEvent input event
      # @param [Hash | Types::SimpleEvent] params
      #   Request parameters for this operation.
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
      #   Request parameters for this operation.
      #   See {Types::NestedEvent#initialize} for available parameters.
      # @example Request syntax with placeholder values
      #   stream.signal_nested_event(
      #     nested: {
      #       values: [
      #         'member'
      #       ]
      #     }
      #   )
      def signal_nested_event(params = {})
        input = Params::NestedEvent.build(params, context: 'params')
        message = Builders::EventStream::NestedEvent.build(input: input)
        send_event(message)
      end

      # Signal (send) an Events::ExplicitPayloadEvent input event
      # @param [Hash | Types::ExplicitPayloadEvent] params
      #   Request parameters for this operation.
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
    end
  end
end
