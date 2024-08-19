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
  module Stubs

    class ClientError
      def self.build(params, context:)
        Params::ClientError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ClientError.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          message: 'message',
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 400
        data = {}
        data['__type'] = 'smithy.ruby.tests#ClientError'
        data['Message'] = stub.message unless stub.message.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class CustomAuth
      def self.build(params, context:)
        Params::CustomAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::CustomAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class DataplaneEndpoint
      def self.build(params, context:)
        Params::DataplaneEndpointOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DataplaneEndpointOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class DefaultsTest
      def self.build(params, context:)
        Params::DefaultsTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DefaultsTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string: 'string',
          struct: Struct.default(visited),
          un_required_number: 1,
          un_required_bool: false,
          number: 1,
          bool: false,
          hello: 'hello',
          simple_enum: 'simple_enum',
          valued_enum: 'valued_enum',
          int_enum: 1,
          null_document: nil,
          string_document: nil,
          boolean_document: nil,
          numbers_document: nil,
          list_document: nil,
          map_document: nil,
          list_of_strings: ListOfStrings.default(visited),
          map_of_strings: MapOfStrings.default(visited),
          iso8601_timestamp: Time.now,
          epoch_timestamp: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['String'] = stub.string unless stub.string.nil?
        data['struct'] = Struct.stub(stub.struct) unless stub.struct.nil?
        data['unRequiredNumber'] = stub.un_required_number unless stub.un_required_number.nil?
        data['unRequiredBool'] = stub.un_required_bool unless stub.un_required_bool.nil?
        data['Number'] = stub.number unless stub.number.nil?
        data['Bool'] = stub.bool unless stub.bool.nil?
        data['hello'] = stub.hello unless stub.hello.nil?
        data['simpleEnum'] = stub.simple_enum unless stub.simple_enum.nil?
        data['valuedEnum'] = stub.valued_enum unless stub.valued_enum.nil?
        data['IntEnum'] = stub.int_enum unless stub.int_enum.nil?
        data['nullDocument'] = stub.null_document unless stub.null_document.nil?
        data['stringDocument'] = stub.string_document unless stub.string_document.nil?
        data['booleanDocument'] = stub.boolean_document unless stub.boolean_document.nil?
        data['numbersDocument'] = stub.numbers_document unless stub.numbers_document.nil?
        data['listDocument'] = stub.list_document unless stub.list_document.nil?
        data['mapDocument'] = stub.map_document unless stub.map_document.nil?
        data['ListOfStrings'] = ListOfStrings.stub(stub.list_of_strings) unless stub.list_of_strings.nil?
        data['MapOfStrings'] = MapOfStrings.stub(stub.map_of_strings) unless stub.map_of_strings.nil?
        data['Iso8601Timestamp'] = Hearth::TimeHelper.to_date_time(stub.iso8601_timestamp) unless stub.iso8601_timestamp.nil?
        data['EpochTimestamp'] = Hearth::TimeHelper.to_epoch_seconds(stub.epoch_timestamp).to_i unless stub.epoch_timestamp.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class Document
      def self.default(visited = [])
        return nil if visited.include?('Document')
        visited = visited + ['Document']
        { 'Document' => [0, 1, 2] }
      end

      def self.stub(stub = {})
        stub
      end
    end

    class EndpointOperation
      def self.build(params, context:)
        Params::EndpointOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::EndpointOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(params, context:)
        Params::EndpointWithHostLabelOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::EndpointWithHostLabelOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
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
        data['payload'] = NestedStructure.stub(stub.payload) unless stub.payload.nil?
        data
      end
    end

    class HttpApiKeyAuth
      def self.build(params, context:)
        Params::HttpApiKeyAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpApiKeyAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class HttpBasicAuth
      def self.build(params, context:)
        Params::HttpBasicAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpBasicAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class HttpBearerAuth
      def self.build(params, context:)
        Params::HttpBearerAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpBearerAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class HttpDigestAuth
      def self.build(params, context:)
        Params::HttpDigestAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpDigestAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
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

    class Items
      def self.default(visited = [])
        return nil if visited.include?('Items')
        visited = visited + ['Items']
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

    class KitchenSink
      def self.build(params, context:)
        Params::KitchenSinkOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::KitchenSinkOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string: 'string',
          simple_enum: 'simple_enum',
          valued_enum: 'valued_enum',
          struct: Struct.default(visited),
          document: nil,
          list_of_strings: ListOfStrings.default(visited),
          list_of_structs: ListOfStructs.default(visited),
          map_of_strings: MapOfStrings.default(visited),
          map_of_structs: MapOfStructs.default(visited),
          union: Union.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['String'] = stub.string unless stub.string.nil?
        data['SimpleEnum'] = stub.simple_enum unless stub.simple_enum.nil?
        data['ValuedEnum'] = stub.valued_enum unless stub.valued_enum.nil?
        data['Struct'] = Struct.stub(stub.struct) unless stub.struct.nil?
        data['Document'] = stub.document unless stub.document.nil?
        data['ListOfStrings'] = ListOfStrings.stub(stub.list_of_strings) unless stub.list_of_strings.nil?
        data['ListOfStructs'] = ListOfStructs.stub(stub.list_of_structs) unless stub.list_of_structs.nil?
        data['MapOfStrings'] = MapOfStrings.stub(stub.map_of_strings) unless stub.map_of_strings.nil?
        data['MapOfStructs'] = MapOfStructs.stub(stub.map_of_structs) unless stub.map_of_structs.nil?
        data['Union'] = Union.stub(stub.union) unless stub.union.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class ListOfStrings
      def self.default(visited = [])
        return nil if visited.include?('ListOfStrings')
        visited = visited + ['ListOfStrings']
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

    class ListOfStructs
      def self.default(visited = [])
        return nil if visited.include?('ListOfStructs')
        visited = visited + ['ListOfStructs']
        [
          Struct.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Struct.stub(element) unless element.nil?
        end
        data
      end
    end

    class MapOfStrings
      def self.default(visited = [])
        return nil if visited.include?('MapOfStrings')
        visited = visited + ['MapOfStrings']
        {
          'key' => 'value'
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class MapOfStructs
      def self.default(visited = [])
        return nil if visited.include?('MapOfStructs')
        visited = visited + ['MapOfStructs']
        {
          'key' => Struct.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Struct.stub(value) unless value.nil?
        end
        data
      end
    end

    class MixinTest
      def self.build(params, context:)
        Params::MixinTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::MixinTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          username: 'username',
          user_id: 'user_id',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['username'] = stub.username unless stub.username.nil?
        data['userId'] = stub.user_id unless stub.user_id.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class NestedEvent
      def self.default(visited = [])
        return nil if visited.include?('NestedEvent')
        visited = visited + ['NestedEvent']
        {
          nested: NestedStructure.default(visited),
          message: 'message',
          header_a: 'header_a',
        }
      end

      def self.stub(stub)
        stub ||= Types::NestedEvent.new
        data = {}
        data['nested'] = NestedStructure.stub(stub.nested) unless stub.nested.nil?
        data['message'] = stub.message unless stub.message.nil?
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

    class NoAuth
      def self.build(params, context:)
        Params::NoAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NoAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class OptionalAuth
      def self.build(params, context:)
        Params::OptionalAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OptionalAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class OrderedAuth
      def self.build(params, context:)
        Params::OrderedAuthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OrderedAuthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class PaginatorsTest
      def self.build(params, context:)
        Params::PaginatorsTestOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::PaginatorsTestOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          next_token: 'next_token',
          items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['nextToken'] = stub.next_token unless stub.next_token.nil?
        data['items'] = Items.stub(stub.items) unless stub.items.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class PaginatorsTestWithItems
      def self.build(params, context:)
        Params::PaginatorsTestWithItemsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::PaginatorsTestWithItemsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          next_token: 'next_token',
          items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['nextToken'] = stub.next_token unless stub.next_token.nil?
        data['items'] = Items.stub(stub.items) unless stub.items.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class RelativeMiddleware
      def self.build(params, context:)
        Params::RelativeMiddlewareOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RelativeMiddlewareOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class RequestCompression
      def self.build(params, context:)
        Params::RequestCompressionOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RequestCompressionOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class RequestCompressionStreaming
      def self.build(params, context:)
        Params::RequestCompressionStreamingOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RequestCompressionStreamingOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class ResourceEndpoint
      def self.build(params, context:)
        Params::ResourceEndpointOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ResourceEndpointOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class ResultWrapper
      def self.default(visited = [])
        return nil if visited.include?('ResultWrapper')
        visited = visited + ['ResultWrapper']
        {
          member___123next_token: 'member___123next_token',
        }
      end

      def self.stub(stub)
        stub ||= Types::ResultWrapper.new
        data = {}
        data['__123nextToken'] = stub.member___123next_token unless stub.member___123next_token.nil?
        data
      end
    end

    class ServerError
      def self.build(params, context:)
        Params::ServerError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ServerError.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 500
        data = {}
        data['__type'] = 'smithy.ruby.tests#ServerError'
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
      end
    end

    class ServerErrorEvent
      def self.build(params, context:)
        Params::ServerErrorEvent.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ServerErrorEvent.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          nested: NestedStructure.default(visited),
          message: 'message',
          header_a: 'header_a',
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 500
        data = {}
        data['__type'] = 'smithy.ruby.tests#ServerErrorEvent'
        data['nested'] = NestedStructure.stub(stub.nested) unless stub.nested.nil?
        data['message'] = stub.message unless stub.message.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
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
          initial_structure: InitialStructure.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['initialStructure'] = InitialStructure.stub(stub.initial_structure) unless stub.initial_structure.nil?
        message = Hearth::EventStream::Message.new
        message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
        message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'initial-response', type: 'string')
        message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
        message.payload = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.body = message
        http_resp.status = 200
      end

      def self.default_event(visited = [])
        return nil if visited.include?('Events')
        visited = visited + ['Events']
        Params::SimpleEvent.build(
          SimpleEvent.default(visited),
          context: 'default_event'
        )
      end

      def self.validate_event!(event, context:)
        case event
        when Types::Events::SimpleEvent
          Validators::SimpleEvent.validate!(event, context: context)
        when Types::Events::NestedEvent
          Validators::NestedEvent.validate!(event, context: context)
        when Types::Events::ExplicitPayloadEvent
          Validators::ExplicitPayloadEvent.validate!(event, context: context)
        when Types::Events::ServerErrorEvent
          Validators::ServerErrorEvent.validate!(event, context: context)
        end
      end

      def self.stub_event(stub)
        case stub
        when Types::SimpleEvent
          EventStream::SimpleEvent.stub(stub)
        when Types::NestedEvent
          EventStream::NestedEvent.stub(stub)
        when Types::ExplicitPayloadEvent
          EventStream::ExplicitPayloadEvent.stub(stub)
        when Types::ServerErrorEvent
          EventStream::ServerErrorEvent.stub(stub)
        end
      end
    end

    class Streaming
      def self.build(params, context:)
        Params::StreamingOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          stream: 'stream',
        }
      end

      def self.stub(http_resp, stub:)
        IO.copy_stream(stub.stream, http_resp.body)
        http_resp.status = 200
      end
    end

    class StreamingWithLength
      def self.build(params, context:)
        Params::StreamingWithLengthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingWithLengthOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class Struct
      def self.default(visited = [])
        return nil if visited.include?('Struct')
        visited = visited + ['Struct']
        {
          value: 'value',
        }
      end

      def self.stub(stub)
        stub ||= Types::Struct.new
        data = {}
        data['value'] = stub.value unless stub.value.nil?
        data
      end
    end

    class TelemetryTest
      def self.build(params, context:)
        Params::TelemetryTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::TelemetryTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          body: 'body',
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.body.write(stub.body || '')
        http_resp.status = 200
      end
    end

    class Union
      def self.default(visited = [])
        return nil if visited.include?('Union')
        visited = visited + ['Union']
        {
          string: 'string',
        }
      end

      def self.stub(stub)
        data = {}
        case stub
        when Types::Union::String
          data['String'] = stub.__getobj__
        when Types::Union::Struct
          data['Struct'] = (Struct.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::Union"
        end

        data
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

    class WaitersTest
      def self.build(params, context:)
        Params::WaitersTestOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::WaitersTestOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          status: 'status',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['Status'] = stub.status unless stub.status.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.build(params, context:)
        Params::Struct____PaginatorsTestWithBadNamesOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::Struct____PaginatorsTestWithBadNamesOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          member___wrapper: ResultWrapper.default(visited),
          member___items: Items.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        data['__wrapper'] = ResultWrapper.stub(stub.member___wrapper) unless stub.member___wrapper.nil?
        data['__items'] = Items.stub(stub.member___items) unless stub.member___items.nil?
        http_resp.body = ::StringIO.new(Hearth::JSON.dump(data))
        http_resp.status = 200
      end
    end

    module EventStream

      class ExplicitPayloadEvent
        def self.stub(stub)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'ExplicitPayloadEvent', type: 'string')
          message.headers['headerA'] = Hearth::EventStream::HeaderValue.new(value: stub.header_a, type: 'string') if stub.header_a
          payload_stub = stub.payload
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
          data = {}
          data['values'] = Values.stub(payload_stub.values) unless payload_stub.values.nil?
          message.payload = ::StringIO.new(Hearth::JSON.dump(data))
          message
        end
      end

      class NestedEvent
        def self.stub(stub)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'NestedEvent', type: 'string')
          message.headers['headerA'] = Hearth::EventStream::HeaderValue.new(value: stub.header_a, type: 'string') if stub.header_a
          payload_stub = stub
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
          data = {}
          data['nested'] = NestedStructure.stub(payload_stub.nested) unless payload_stub.nested.nil?
          data['message'] = payload_stub.message unless payload_stub.message.nil?
          message.payload = ::StringIO.new(Hearth::JSON.dump(data))
          message
        end
      end

      class ServerErrorEvent
        def self.stub(stub)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'ServerErrorEvent', type: 'string')
          message.headers['headerA'] = Hearth::EventStream::HeaderValue.new(value: stub.header_a, type: 'string') if stub.header_a
          payload_stub = stub
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
          data = {}
          data['nested'] = NestedStructure.stub(payload_stub.nested) unless payload_stub.nested.nil?
          data['message'] = payload_stub.message unless payload_stub.message.nil?
          message.payload = ::StringIO.new(Hearth::JSON.dump(data))
          message
        end
      end

      class SimpleEvent
        def self.stub(stub)
          message = Hearth::EventStream::Message.new
          message.headers[':message-type'] = Hearth::EventStream::HeaderValue.new(value: 'event', type: 'string')
          message.headers[':event-type'] = Hearth::EventStream::HeaderValue.new(value: 'SimpleEvent', type: 'string')
          payload_stub = stub
          message.headers[':content-type'] = Hearth::EventStream::HeaderValue.new(value: 'application/json', type: 'string')
          data = {}
          data['message'] = payload_stub.message unless payload_stub.message.nil?
          message.payload = ::StringIO.new(Hearth::JSON.dump(data))
          message
        end
      end
    end
  end
end
