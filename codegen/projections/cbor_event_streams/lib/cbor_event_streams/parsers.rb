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

    class ExplicitPayloadEvent
      def self.parse(map)
        data = Types::ExplicitPayloadEvent.new
        data.header_a = map['headerA']
        data.payload = (NestedStructure.parse(map['payload']) unless map['payload'].nil?)
        return data
      end
    end

    class InitialStructure
      def self.parse(map)
        data = Types::InitialStructure.new
        data.message = map['message']
        data.nested = (NestedStructure.parse(map['nested']) unless map['nested'].nil?)
        return data
      end
    end

    class NestedEvent
      def self.parse(map)
        data = Types::NestedEvent.new
        data.nested = (NestedStructure.parse(map['nested']) unless map['nested'].nil?)
        return data
      end
    end

    class NestedStructure
      def self.parse(map)
        data = Types::NestedStructure.new
        data.values = (Values.parse(map['values']) unless map['values'].nil?)
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

    class SimpleEvent
      def self.parse(map)
        data = Types::SimpleEvent.new
        data.message = map['message']
        return data
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

    class Values
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    module EventStream

      class ExplicitPayloadEvent
        def self.parse(message)
          data = Types::ExplicitPayloadEvent.new
          data.header_a = message.headers['headerA']&.value
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
          data.payload = (NestedStructure.parse(map) unless map.nil?)
          data
        end
      end

      class NestedEvent
        def self.parse(message)
          data = Types::NestedEvent.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
          data.nested = (NestedStructure.parse(map['nested']) unless map['nested'].nil?)
          data
        end
      end

      class SimpleEvent
        def self.parse(message)
          data = Types::SimpleEvent.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::CBOR.decode(payload.force_encoding(Encoding::BINARY))
          data.message = map['message']
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
