# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  module EventStream

    class StartEventStreamHandler < Hearth::EventStream::HandlerBase

      def on_simple_event(&block)
        on('SimpleEvent', block)
      end

      def on_nested_event(&block)
        on('NestedEvent', block)
      end

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

    class StartEventStreamOutput < Hearth::EventStream::AsyncOutput

      def signal_simple_event(params = {})
        input = Params::SimpleEvent.build(params, context: 'params')
        message = Builders::EventStream::SimpleEvent.build(input: input)
        send_event(message)
      end

      def signal_nested_event(params = {})
        input = Params::NestedEvent.build(params, context: 'params')
        message = Builders::EventStream::NestedEvent.build(input: input)
        send_event(message)
      end

      def signal_explicit_payload_event(params = {})
        input = Params::ExplicitPayloadEvent.build(params, context: 'params')
        message = Builders::EventStream::ExplicitPayloadEvent.build(input: input)
        send_event(message)
      end
    end
  end
end
