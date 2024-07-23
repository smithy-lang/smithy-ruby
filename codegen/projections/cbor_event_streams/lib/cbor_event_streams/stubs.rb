# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

module CborEventStreams
  # @api private
  module Stubs

    class Events
      def self.default(visited = [])
        return nil if visited.include?('Events')
        visited = visited + ['Events']
        {
          simple_event: SimpleEvent.default(visited),
        }
      end

      def self.stub(stub)
        data = {}
        case stub
        when Types::Events::SimpleEvent
          data['simpleEvent'] = (SimpleEvent.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        when Types::Events::NestedEvent
          data['nestedEvent'] = (NestedEvent.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        when Types::Events::ExplicitPayloadEvent
          data['explicitPayloadEvent'] = (ExplicitPayloadEvent.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::Events"
        end

        data
      end
    end

    class ExplicitPayloadEvent
      def self.default(visited = [])
        return nil if visited.include?('ExplicitPayloadEvent')
        visited = visited + ['ExplicitPayloadEvent']
        {
          header_a: 'header_a',
          payload: NestedStructure.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::ExplicitPayloadEvent.new
        data = {}
        data['headerA'] = stub.header_a unless stub.header_a.nil?
        data['payload'] = NestedStructure.stub(stub.payload) unless stub.payload.nil?
        data
      end
    end

    class InitialStructure
      def self.default(visited = [])
        return nil if visited.include?('InitialStructure')
        visited = visited + ['InitialStructure']
        {
          message: 'message',
          nested: NestedStructure.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::InitialStructure.new
        data = {}
        data['message'] = stub.message unless stub.message.nil?
        data['nested'] = NestedStructure.stub(stub.nested) unless stub.nested.nil?
        data
      end
    end

    class NestedEvent
      def self.default(visited = [])
        return nil if visited.include?('NestedEvent')
        visited = visited + ['NestedEvent']
        {
          nested: NestedStructure.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::NestedEvent.new
        data = {}
        data['nested'] = NestedStructure.stub(stub.nested) unless stub.nested.nil?
        data
      end
    end

    class NestedStructure
      def self.default(visited = [])
        return nil if visited.include?('NestedStructure')
        visited = visited + ['NestedStructure']
        {
          values: Values.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::NestedStructure.new
        data = {}
        data['values'] = Values.stub(stub.values) unless stub.values.nil?
        data
      end
    end

    class NonStreamingOperation
      def self.build(params, context:)
        Params::NonStreamingOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NonStreamingOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          output_value: 'output_value',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['outputValue'] = stub.output_value unless stub.output_value.nil?
        http_resp.body = ::StringIO.new(Hearth::CBOR.encode(data))
        http_resp.status = 200
      end
    end

    class SimpleEvent
      def self.default(visited = [])
        return nil if visited.include?('SimpleEvent')
        visited = visited + ['SimpleEvent']
        {
          message: 'message',
        }
      end

      def self.stub(stub)
        stub ||= Types::SimpleEvent.new
        data = {}
        data['message'] = stub.message unless stub.message.nil?
        data
      end
    end

    class StartEventStream
      def self.build(params, context:)
        Params::StartEventStreamOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StartEventStreamOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          event: Events.default(visited),
          initial_structure: InitialStructure.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['event'] = Events.stub(stub.event) unless stub.event.nil?
        data['initialStructure'] = InitialStructure.stub(stub.initial_structure) unless stub.initial_structure.nil?
        http_resp.body = ::StringIO.new(Hearth::CBOR.encode(data))
        http_resp.status = 200
      end
    end

    class Values
      def self.default(visited = [])
        return nil if visited.include?('Values')
        visited = visited + ['Values']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end
  end
end
