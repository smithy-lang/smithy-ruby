# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

module WhiteLabel
  # @api private
  module Builders

    class CustomAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.CustomAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class DataplaneEndpoint
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.DataplaneEndpoint'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class Defaults
      def self.build(input)
        data = {}
        data['String'] = input.string unless input.string.nil?
        data['struct'] = Struct.build(input.struct) unless input.struct.nil?
        data['unRequiredNumber'] = input.un_required_number unless input.un_required_number.nil?
        data['unRequiredBool'] = input.un_required_bool unless input.un_required_bool.nil?
        data['Number'] = input.number unless input.number.nil?
        data['Bool'] = input.bool unless input.bool.nil?
        data['hello'] = input.hello unless input.hello.nil?
        data['simpleEnum'] = input.simple_enum unless input.simple_enum.nil?
        data['valuedEnum'] = input.valued_enum unless input.valued_enum.nil?
        data['IntEnum'] = input.int_enum unless input.int_enum.nil?
        data['nullDocument'] = input.null_document unless input.null_document.nil?
        data['stringDocument'] = input.string_document unless input.string_document.nil?
        data['booleanDocument'] = input.boolean_document unless input.boolean_document.nil?
        data['numbersDocument'] = input.numbers_document unless input.numbers_document.nil?
        data['listDocument'] = input.list_document unless input.list_document.nil?
        data['mapDocument'] = input.map_document unless input.map_document.nil?
        data['ListOfStrings'] = ListOfStrings.build(input.list_of_strings) unless input.list_of_strings.nil?
        data['MapOfStrings'] = MapOfStrings.build(input.map_of_strings) unless input.map_of_strings.nil?
        data['Iso8601Timestamp'] = Hearth::TimeHelper.to_date_time(input.iso8601_timestamp) unless input.iso8601_timestamp.nil?
        data['EpochTimestamp'] = Hearth::TimeHelper.to_epoch_seconds(input.epoch_timestamp).to_i unless input.epoch_timestamp.nil?
        data
      end
    end

    class DefaultsTest
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.DefaultsTest'
        data = {}
        data['defaults'] = Defaults.build(input.defaults) unless input.defaults.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class EndpointOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.EndpointOperation'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.EndpointWithHostLabelOperation'
        data = {}
        data['labelMember'] = input.label_member unless input.label_member.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class ExplicitPayloadEvent
      def self.build(input)
        data = {}
        data['payload'] = NestedStructure.build(input.payload) unless input.payload.nil?
        data
      end
    end

    class HttpApiKeyAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.HttpApiKeyAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class HttpBasicAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.HttpBasicAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class HttpBearerAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.HttpBearerAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class HttpDigestAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.HttpDigestAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class InitialStructure
      def self.build(input)
        data = {}
        data['message'] = input.message unless input.message.nil?
        data['nested'] = NestedStructure.build(input.nested) unless input.nested.nil?
        data
      end
    end

    class KitchenSink
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.KitchenSink'
        data = {}
        data['String'] = input.string unless input.string.nil?
        data['SimpleEnum'] = input.simple_enum unless input.simple_enum.nil?
        data['ValuedEnum'] = input.valued_enum unless input.valued_enum.nil?
        data['Struct'] = Struct.build(input.struct) unless input.struct.nil?
        data['Document'] = input.document unless input.document.nil?
        data['ListOfStrings'] = ListOfStrings.build(input.list_of_strings) unless input.list_of_strings.nil?
        data['ListOfStructs'] = ListOfStructs.build(input.list_of_structs) unless input.list_of_structs.nil?
        data['MapOfStrings'] = MapOfStrings.build(input.map_of_strings) unless input.map_of_strings.nil?
        data['MapOfStructs'] = MapOfStructs.build(input.map_of_structs) unless input.map_of_structs.nil?
        data['Union'] = Union.build(input.union) unless input.union.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class ListOfStrings
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ListOfStructs
      def self.build(input)
        data = []
        input.each do |element|
          data << Struct.build(element) unless element.nil?
        end
        data
      end
    end

    class MapOfStrings
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class MapOfStructs
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Struct.build(value) unless value.nil?
        end
        data
      end
    end

    class MixinTest
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.MixinTest'
        data = {}
        data['userId'] = input.user_id unless input.user_id.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class NestedEvent
      def self.build(input)
        data = {}
        data['nested'] = NestedStructure.build(input.nested) unless input.nested.nil?
        data
      end
    end

    class NestedStructure
      def self.build(input)
        data = {}
        data['values'] = Values.build(input.values) unless input.values.nil?
        data
      end
    end

    class NoAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.NoAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class OptionalAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.OptionalAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class OrderedAuth
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.OrderedAuth'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class PaginatorsTest
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.PaginatorsTest'
        data = {}
        data['nextToken'] = input.next_token unless input.next_token.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class PaginatorsTestWithItems
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.PaginatorsTestWithItems'
        data = {}
        data['nextToken'] = input.next_token unless input.next_token.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class RelativeMiddleware
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.RelativeMiddleware'
        data = {}
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class RequestCompression
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.RequestCompression'
        http_req.body = StringIO.new(input.body || '')
      end
    end

    class RequestCompressionStreaming
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.RequestCompressionStreaming'
        http_req.body = input.body
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['Content-Type'] = 'application/octet-stream'
      end
    end

    class ResourceEndpoint
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.ResourceEndpoint'
        data = {}
        data['resourceUrl'] = input.resource_url unless input.resource_url.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class SimpleEvent
      def self.build(input)
        data = {}
        data['message'] = input.message unless input.message.nil?
        data
      end
    end

    class StartEventStream
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.StartEventStream'
        http_req.headers['Accept'] = 'application/vnd.amazon.eventstream'
        data = {}
        data['initialStructure'] = InitialStructure.build(input.initial_structure) unless input.initial_structure.nil?
        message = Hearth::EventStream::Message.new
        message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
        message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'initial-request', type: 'string')
        message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
        message.payload = ::StringIO.new(Hearth::JSON.dump(data))
        http_req.body = message
      end
    end

    class Streaming
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.Streaming'
        http_req.body = input.stream
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['Content-Type'] = 'application/octet-stream'
      end
    end

    class StreamingWithLength
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.StreamingWithLength'
        http_req.body = input.stream
        http_req.headers['Content-Type'] = 'application/octet-stream'
      end
    end

    class Struct
      def self.build(input)
        data = {}
        data['value'] = input.value unless input.value.nil?
        data
      end
    end

    class Union
      def self.build(input)
        data = {}
        case input
        when Types::Union::String
          data['String'] = input
        when Types::Union::Struct
          data['Struct'] = (Struct.build(input) unless input.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::Union"
        end

        data
      end
    end

    class Values
      def self.build(input)
        data = []
        input.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class WaitersTest
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.WaitersTest'
        data = {}
        data['Status'] = input.status unless input.status.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/')
        http_req.headers['Content-Type'] = 'application/json'
        http_req.headers['X-Rpc-Target'] = 'WhiteLabel.__PaginatorsTestWithBadNames'
        data = {}
        data['__nextToken'] = input.member___next_token unless input.member___next_token.nil?
        http_req.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    module EventStream

      class ExplicitPayloadEvent
        def self.build(input:)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'ExplicitPayloadEvent', type: 'string')
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
          message.headers['headerA'] = Hearth::EventStream::HeaderValue.new(value: input.header_a, type: 'string')
          payload_input = input.payload
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
          data = {}
          data['values'] = Values.build(payload_input.values) unless payload_input.values.nil?
          message.payload = ::StringIO.new(Hearth::JSON.dump(data))
          message
        end
      end

      class NestedEvent
        def self.build(input:)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'NestedEvent', type: 'string')
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
          payload_input = input
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
          data = {}
          data['nested'] = NestedStructure.build(payload_input.nested) unless payload_input.nested.nil?
          message.payload = ::StringIO.new(Hearth::JSON.dump(data))
          message
        end
      end

      class SimpleEvent
        def self.build(input:)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'SimpleEvent', type: 'string')
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/cbor', type: 'string')
          payload_input = input
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
          data = {}
          data['message'] = payload_input.message unless payload_input.message.nil?
          message.payload = ::StringIO.new(Hearth::JSON.dump(data))
          message
        end
      end
    end
  end
end
