# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module EventStream

    class StartEventStream < Hearth::EventStream::HandlerBase

      def signal_event_a(params = {})
        input = Params::EventA.build(params, context: 'params')
        message = Builders::EventStream::EventA.build(input: input)
        encoder.send_event(:event, message)
      end

      def signal_event_b(params = {})
        input = Params::EventB.build(params, context: 'params')
        message = Builders::EventStream::EventB.build(input: input)
        encoder.send_event(:event, message)
      end

      def on_event_a(&block)
        on('EventA', block)
      end

      def on_event_b(&block)
        on('EventB', block)
      end

      def parse_event(type, message)
        case type
        when 'EventA' then Parsers::EventStream::EventA.parse(message)
        when 'EventB' then Parsers::EventStream::EventB.parse(message)
        end
      end
    end
  end
end
