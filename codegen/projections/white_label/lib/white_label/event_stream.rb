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
    # Register event handlers using the +#on_<event_name>+ methods
    # and set the handler using the +event_stream_handler+ option
    # on the {Client#start_event_stream} method.
    # @example Basic Usage
    #   handler = StartEventStream.new
    #   # register handlers for the events you are interested in
    #   handler.on_initial_response { |initial_response| process(initial_response) }
    #   client.start_event_stream(params, event_stream_handler: handler)
    class StartEventStreamHandler < Hearth::EventStream::HandlerBase

      # Register an event handler for event_a events
      # @yield [event] Called when event_a events are received.
      # @yieldparam event [Types::EventA] the event.
      # @example Event structure
      #   event #=> Types::EventA
      #   event.message #=> String
      def on_event_a(&block)
        on('EventA', block)
      end

      # Register an event handler for event_b events
      # @yield [event] Called when event_b events are received.
      # @yieldparam event [Types::EventB] the event.
      # @example Event structure
      #   event #=> Types::EventB
      #   event.nested #=> Types::NestedEvent
      #   event.nested.values #=> Array<String>
      #   event.nested.values[0] #=> String
      def on_event_b(&block)
        on('EventB', block)
      end

      private

      def parse_event(type, message)
        case type
        when 'initial-response' then Parsers::EventStream::StartEventStreamInitialResponse.parse(message)
        when 'EventA' then Parsers::EventStream::EventA.parse(message)
        when 'EventB' then Parsers::EventStream::EventB.parse(message)
        end
      end
    end

    # Output class returned from {Client#start_event_stream}
    # and allowing async sending (signaling) of input events.
    # @example Basic Usage
    #   stream = client.event_a(initial_request)
    #   stream.signal_start_event_stream(event_params) # send an event
    #   stream.join # close the input stream and wait for the server
    class StartEventStreamOutput < Hearth::EventStream::AsyncOutput

      # Signal (send) an Events::EventA input event
      # @param [Hash | Types::EventA] params
      #   Request parameters for this operation.
      #   See {Types::EventA#initialize} for available parameters.
      # @example Request syntax with placeholder values
      #   stream.signal_event_a(
      #     message: 'message'
      #   )
      def signal_event_a(params = {})
        input = Params::EventA.build(params, context: 'params')
        message = Builders::EventStream::EventA.build(input: input)
        send_event(message)
      end

      # Signal (send) an Events::EventB input event
      # @param [Hash | Types::EventB] params
      #   Request parameters for this operation.
      #   See {Types::EventB#initialize} for available parameters.
      # @example Request syntax with placeholder values
      #   stream.signal_event_b(
      #     nested: {
      #       values: [
      #         'member'
      #       ]
      #     }
      #   )
      def signal_event_b(params = {})
        input = Params::EventB.build(params, context: 'params')
        message = Builders::EventStream::EventB.build(input: input)
        send_event(message)
      end
    end
  end
end
