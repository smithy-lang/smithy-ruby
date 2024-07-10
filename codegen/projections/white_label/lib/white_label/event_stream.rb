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
        event = Params::EventA.build(params, context: 'params')
        message = Builders::EventStream::Events.build(input)
        encoder.send_event(:event, message)
      end
      def signal_event_b(params = {})
        event = Params::EventB.build(params, context: 'params')
        message = Builders::EventStream::Events.build(input)
        encoder.send_event(:event, message)
      end
      def on_event_a(&block)
        on(:event_a, block)
      end
      def on_event_b(&block)
        on(:event_b, block)
      end
    end
  end
end
