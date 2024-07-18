# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  # @api private
  module Parsers

    class EventA
      def self.parse(map)
        data = Types::EventA.new
        data.message = map['message']
        return data
      end
    end

    class EventB
      def self.parse(map)
        data = Types::EventB.new
        data.nested = (NestedEvent.parse(map['nested']) unless map['nested'].nil?)
        return data
      end
    end

    class EventValues
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class InitialStructure
      def self.parse(map)
        data = Types::InitialStructure.new
        data.message = map['message']
        return data
      end
    end

    class NestedEvent
      def self.parse(map)
        data = Types::NestedEvent.new
        data.member_values = (EventValues.parse(map['values']) unless map['values'].nil?)
        return data
      end
    end

    class NonStreamingOperation
      def self.parse(http_resp)
        data = Types::NonStreamingOperationOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.output_value = map['outputValue']
        data
      end
    end

    class StartEventStream
      def self.parse(http_resp)
        data = Types::StartEventStreamOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::CBOR.decode(body.force_encoding(Encoding::BINARY))
        data.initial_structure = (InitialStructure.parse(map['initialStructure']) unless map['initialStructure'].nil?)
        data
      end
    end

    module EventStream

      class EventA
        def self.parse(message)
          data = Types::EventA.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
          data.message = map['message']
          data
        end
      end

      class EventB
        def self.parse(message)
          data = Types::EventB.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
          data.nested = (NestedEvent.parse(map['nested']) unless map['nested'].nil?)
          data
        end
      end

      class StartEventStreamInitialResponse
        def self.parse(message)
          data = Types::StartEventStreamOutput.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
          data.initial_structure = (InitialStructure.parse(map['initialStructure']) unless map['initialStructure'].nil?)
          data
        end
      end
    end
  end
end
