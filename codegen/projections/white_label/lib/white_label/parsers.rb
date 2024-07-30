# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @api private
  module Parsers

    # Error Parser for ClientError
    class ClientError
      def self.parse(http_resp)
        data = Types::ClientError.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.message = map['Message']
        data
      end
    end

    class CustomAuth
      def self.parse(http_resp)
        data = Types::CustomAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class DataplaneEndpoint
      def self.parse(http_resp)
        data = Types::DataplaneEndpointOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class DefaultsTest
      def self.parse(http_resp)
        data = Types::DefaultsTestOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.string = map['String']
        data.struct = (Struct.parse(map['struct']) unless map['struct'].nil?)
        data.un_required_number = map['unRequiredNumber']
        data.un_required_bool = map['unRequiredBool']
        data.number = map['Number']
        data.bool = map['Bool']
        data.hello = map['hello']
        data.simple_enum = map['simpleEnum']
        data.valued_enum = map['valuedEnum']
        data.int_enum = map['IntEnum']
        data.null_document = map['nullDocument']
        data.string_document = map['stringDocument']
        data.boolean_document = map['booleanDocument']
        data.numbers_document = map['numbersDocument']
        data.list_document = map['listDocument']
        data.map_document = map['mapDocument']
        data.list_of_strings = (ListOfStrings.parse(map['ListOfStrings']) unless map['ListOfStrings'].nil?)
        data.map_of_strings = (MapOfStrings.parse(map['MapOfStrings']) unless map['MapOfStrings'].nil?)
        data.iso8601_timestamp = Time.parse(map['Iso8601Timestamp']) if map['Iso8601Timestamp']
        data.epoch_timestamp = Time.at(map['EpochTimestamp'].to_i) if map['EpochTimestamp']
        data
      end
    end

    class EndpointOperation
      def self.parse(http_resp)
        data = Types::EndpointOperationOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class EndpointWithHostLabelOperation
      def self.parse(http_resp)
        data = Types::EndpointWithHostLabelOperationOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class ExplicitPayloadEvent
      def self.parse(map)
        data = Types::ExplicitPayloadEvent.new
        data.header_a = map['headerA']
        data.payload = (NestedStructure.parse(map['payload']) unless map['payload'].nil?)
        return data
      end
    end

    class HttpApiKeyAuth
      def self.parse(http_resp)
        data = Types::HttpApiKeyAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class HttpBasicAuth
      def self.parse(http_resp)
        data = Types::HttpBasicAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class HttpBearerAuth
      def self.parse(http_resp)
        data = Types::HttpBearerAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class HttpDigestAuth
      def self.parse(http_resp)
        data = Types::HttpDigestAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
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

    class Items
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class KitchenSink
      def self.parse(http_resp)
        data = Types::KitchenSinkOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.string = map['String']
        data.simple_enum = map['SimpleEnum']
        data.valued_enum = map['ValuedEnum']
        data.struct = (Struct.parse(map['Struct']) unless map['Struct'].nil?)
        data.document = map['Document']
        data.list_of_strings = (ListOfStrings.parse(map['ListOfStrings']) unless map['ListOfStrings'].nil?)
        data.list_of_structs = (ListOfStructs.parse(map['ListOfStructs']) unless map['ListOfStructs'].nil?)
        data.map_of_strings = (MapOfStrings.parse(map['MapOfStrings']) unless map['MapOfStrings'].nil?)
        data.map_of_structs = (MapOfStructs.parse(map['MapOfStructs']) unless map['MapOfStructs'].nil?)
        data.union = (Union.parse(map['Union']) unless map['Union'].nil?)
        data
      end
    end

    class ListOfStrings
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class ListOfStructs
      def self.parse(list)
        list.map do |value|
          Struct.parse(value) unless value.nil?
        end
      end
    end

    class MapOfStrings
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class MapOfStructs
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Struct.parse(value) unless value.nil?
        end
        data
      end
    end

    class MixinTest
      def self.parse(http_resp)
        data = Types::MixinTestOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.username = map['username']
        data.user_id = map['userId']
        data
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

    class NoAuth
      def self.parse(http_resp)
        data = Types::NoAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class OptionalAuth
      def self.parse(http_resp)
        data = Types::OptionalAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class OrderedAuth
      def self.parse(http_resp)
        data = Types::OrderedAuthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class PaginatorsTest
      def self.parse(http_resp)
        data = Types::PaginatorsTestOperationOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.next_token = map['nextToken']
        data.items = (Items.parse(map['items']) unless map['items'].nil?)
        data
      end
    end

    class PaginatorsTestWithItems
      def self.parse(http_resp)
        data = Types::PaginatorsTestWithItemsOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.next_token = map['nextToken']
        data.items = (Items.parse(map['items']) unless map['items'].nil?)
        data
      end
    end

    class RelativeMiddleware
      def self.parse(http_resp)
        data = Types::RelativeMiddlewareOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class RequestCompression
      def self.parse(http_resp)
        data = Types::RequestCompressionOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class RequestCompressionStreaming
      def self.parse(http_resp)
        data = Types::RequestCompressionStreamingOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class ResourceEndpoint
      def self.parse(http_resp)
        data = Types::ResourceEndpointOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class ResultWrapper
      def self.parse(map)
        data = Types::ResultWrapper.new
        data.member___123next_token = map['__123nextToken']
        return data
      end
    end

    # Error Parser for ServerError
    class ServerError
      def self.parse(http_resp)
        data = Types::ServerError.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
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
        map = Hearth::JSON.parse(body)
        data.event = (Events.parse(map['event']) unless map['event'].nil?)
        data.initial_structure = (InitialStructure.parse(map['initialStructure']) unless map['initialStructure'].nil?)
        data
      end
    end

    class Streaming
      def self.parse(http_resp)
        data = Types::StreamingOutput.new
        data.stream = http_resp.body
        data
      end
    end

    class StreamingWithLength
      def self.parse(http_resp)
        data = Types::StreamingWithLengthOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data
      end
    end

    class Struct
      def self.parse(map)
        data = Types::Struct.new
        data.value = map['value']
        return data
      end
    end

    class Union
      def self.parse(map)
        return nil if map.nil?

        map.delete('__type')
        key, value = map.compact.flatten
        case key
        when 'String'
          value = value
          Types::Union::String.new(value) if value
        when 'Struct'
          value = (Struct.parse(value) unless value.nil?)
          Types::Union::Struct.new(value) if value
        else
          Types::Union::Unknown.new(name: key, value: value)
        end
      end
    end

    class Values
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class WaitersTest
      def self.parse(http_resp)
        data = Types::WaitersTestOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.status = map['Status']
        data
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.parse(http_resp)
        data = Types::Struct____PaginatorsTestWithBadNamesOutput.new
        body = http_resp.body.read
        return data if body.empty?
        map = Hearth::JSON.parse(body)
        data.member___wrapper = (ResultWrapper.parse(map['__wrapper']) unless map['__wrapper'].nil?)
        data.member___items = (Items.parse(map['__items']) unless map['__items'].nil?)
        data
      end
    end

    module EventStream

      class ExplicitPayloadEvent
        def self.parse(message)
          data = Types::ExplicitPayloadEvent.new
          data.header_a = message.headers['headerA']&.value
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::JSON.parse(payload)
          data.payload = (NestedStructure.parse(map) unless map.nil?)
          data
        end
      end

      class NestedEvent
        def self.parse(message)
          data = Types::NestedEvent.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::JSON.parse(payload)
          data.nested = (NestedStructure.parse(map['nested']) unless map['nested'].nil?)
          data
        end
      end

      class SimpleEvent
        def self.parse(message)
          data = Types::SimpleEvent.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::JSON.parse(payload)
          data.message = map['message']
          data
        end
      end

      class StartEventStreamInitialResponse
        def self.parse(message)
          data = Types::StartEventStreamOutput.new
          payload = message.payload.read
          return data if payload.empty?
          map = Hearth::JSON.parse(payload)
          data.event = (Events.parse(map['event']) unless map['event'].nil?)
          data.initial_structure = (InitialStructure.parse(map['initialStructure']) unless map['initialStructure'].nil?)
          data
        end
      end
    end
  end
end
