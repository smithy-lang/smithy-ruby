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

    class EventA
      def self.default(visited = [])
        return nil if visited.include?('EventA')
        visited = visited + ['EventA']
        {
          message: 'message',
        }
      end

      def self.stub(stub)
        stub ||= Types::EventA.new
        data = {}
        data['message'] = stub[:message] unless stub[:message].nil?
        data
      end
    end

    class EventB
      def self.default(visited = [])
        return nil if visited.include?('EventB')
        visited = visited + ['EventB']
        {
          nested: NestedEvent.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::EventB.new
        data = {}
        data['nested'] = NestedEvent.stub(stub[:nested]) unless stub[:nested].nil?
        data
      end
    end

    class EventValues
      def self.default(visited = [])
        return nil if visited.include?('EventValues')
        visited = visited + ['EventValues']
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

    class Events
      def self.default(visited = [])
        return nil if visited.include?('Events')
        visited = visited + ['Events']
        {
          event_a: EventA.default(visited),
        }
      end

      def self.stub(stub)
        data = {}
        case stub
        when Types::Events::EventA
          data['eventA'] = (EventA.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        when Types::Events::EventB
          data['eventB'] = (EventB.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::Events"
        end

        data
      end
    end

    class InitialStructure
      def self.default(visited = [])
        return nil if visited.include?('InitialStructure')
        visited = visited + ['InitialStructure']
        {
          message: 'message',
        }
      end

      def self.stub(stub)
        stub ||= Types::InitialStructure.new
        data = {}
        data['message'] = stub[:message] unless stub[:message].nil?
        data
      end
    end

    class NestedEvent
      def self.default(visited = [])
        return nil if visited.include?('NestedEvent')
        visited = visited + ['NestedEvent']
        {
          member_values: EventValues.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::NestedEvent.new
        data = {}
        data['values'] = EventValues.stub(stub[:member_values]) unless stub[:member_values].nil?
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
        data['outputValue'] = stub[:output_value] unless stub[:output_value].nil?
        http_resp.body = ::StringIO.new(Hearth::CBOR.encode(data))
        http_resp.status = 200
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
        data['event'] = Events.stub(stub[:event]) unless stub[:event].nil?
        data['initialStructure'] = InitialStructure.stub(stub[:initial_structure]) unless stub[:initial_structure].nil?
        http_resp.body = ::StringIO.new(Hearth::CBOR.encode(data))
        http_resp.status = 200
      end
    end
  end
end
