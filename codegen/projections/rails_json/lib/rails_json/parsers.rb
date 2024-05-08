# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module RailsJson
  # @api private
  module Parsers

    class AllQueryStringTypes
      def self.parse(http_resp)
        data = Types::AllQueryStringTypesOutput.new
        data
      end
    end

    class BooleanList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    # Error Parser for ComplexError
    class ComplexError
      def self.parse(http_resp)
        data = Types::ComplexError.new
        data.header = http_resp.headers['X-Header']
        map = Hearth::JSON.parse(http_resp.body.read)
        data.top_level = map['top_level'] unless map['top_level'].nil?
        data.nested = Parsers::ComplexNestedErrorData.parse(map['nested']) unless map['nested'].nil?
        data
      end
    end

    class ComplexNestedErrorData
      def self.parse(map)
        data = Types::ComplexNestedErrorData.new
        data.foo = map['Fooooo'] unless map['Fooooo'].nil?
        data
      end
    end

    class ConstantAndVariableQueryString
      def self.parse(http_resp)
        data = Types::ConstantAndVariableQueryStringOutput.new
        data
      end
    end

    class ConstantQueryString
      def self.parse(http_resp)
        data = Types::ConstantQueryStringOutput.new
        data
      end
    end

    class DatetimeOffsets
      def self.parse(http_resp)
        data = Types::DatetimeOffsetsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.datetime = Time.parse(map['datetime']) if map['datetime']
        data
      end
    end

    class DenseBooleanMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseNumberMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseSetMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::StringSet.parse(value) unless value.nil?
        end
        data
      end
    end

    class DenseStringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseStructMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::GreetingStruct.parse(value) unless value.nil?
        end
        data
      end
    end

    class DocumentType
      def self.parse(http_resp)
        data = Types::DocumentTypeOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.string_value = map['string_value'] unless map['string_value'].nil?
        data.document_value = map['document_value'] unless map['document_value'].nil?
        data
      end
    end

    class DocumentTypeAsMapValue
      def self.parse(http_resp)
        data = Types::DocumentTypeAsMapValueOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.doc_valued_map = Parsers::DocumentValuedMap.parse(map['doc_valued_map']) unless map['doc_valued_map'].nil?
        data
      end
    end

    class DocumentTypeAsPayload
      def self.parse(http_resp)
        data = Types::DocumentTypeAsPayloadOutput.new
        payload = Hearth::JSON.parse(http_resp.body.read)
        data.document_value = payload
        data
      end
    end

    class DocumentValuedMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class EmptyInputAndEmptyOutput
      def self.parse(http_resp)
        data = Types::EmptyInputAndEmptyOutputOutput.new
        data
      end
    end

    class EndpointOperation
      def self.parse(http_resp)
        data = Types::EndpointOperationOutput.new
        data
      end
    end

    class EndpointWithHostLabelOperation
      def self.parse(http_resp)
        data = Types::EndpointWithHostLabelOperationOutput.new
        data
      end
    end

    class FooEnumList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class FooEnumMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class FooEnumSet
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class FractionalSeconds
      def self.parse(http_resp)
        data = Types::FractionalSecondsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.datetime = Time.parse(map['datetime']) if map['datetime']
        data
      end
    end

    class GreetingStruct
      def self.parse(map)
        data = Types::GreetingStruct.new
        data.hi = map['hi'] unless map['hi'].nil?
        data
      end
    end

    class RenamedGreeting
      def self.parse(map)
        data = Types::RenamedGreeting.new
        data.salutation = map['salutation'] unless map['salutation'].nil?
        data
      end
    end

    class GreetingWithErrors
      def self.parse(http_resp)
        data = Types::GreetingWithErrorsOutput.new
        data.greeting = http_resp.headers['X-Greeting']
        data
      end
    end

    class HostWithPathOperation
      def self.parse(http_resp)
        data = Types::HostWithPathOperationOutput.new
        data
      end
    end

    class HttpChecksumRequired
      def self.parse(http_resp)
        data = Types::HttpChecksumRequiredOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.foo = map['foo'] unless map['foo'].nil?
        data
      end
    end

    class HttpEnumPayload
      def self.parse(http_resp)
        data = Types::HttpEnumPayloadOutput.new
        payload = http_resp.body.read
        data.payload = payload unless payload.empty?
        data
      end
    end

    class HttpPayloadTraits
      def self.parse(http_resp)
        data = Types::HttpPayloadTraitsOutput.new
        data.foo = http_resp.headers['X-Foo']
        payload = http_resp.body.read
        data.blob = payload unless payload.empty?
        data
      end
    end

    class HttpPayloadTraitsWithMediaType
      def self.parse(http_resp)
        data = Types::HttpPayloadTraitsWithMediaTypeOutput.new
        data.foo = http_resp.headers['X-Foo']
        payload = http_resp.body.read
        data.blob = payload unless payload.empty?
        data
      end
    end

    class HttpPayloadWithStructure
      def self.parse(http_resp)
        data = Types::HttpPayloadWithStructureOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.nested = Parsers::NestedPayload.parse(map)
        data
      end
    end

    class HttpPayloadWithUnion
      def self.parse(http_resp)
        data = Types::HttpPayloadWithUnionOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.nested = Parsers::UnionPayload.parse(map)
        data
      end
    end

    class HttpPrefixHeaders
      def self.parse(http_resp)
        data = Types::HttpPrefixHeadersOutput.new
        data.foo = http_resp.headers['X-Foo']
        data.foo_map = {}
        http_resp.headers.each do |key, value|
          if key.start_with?('X-Foo-')
            data.foo_map[key.delete_prefix('X-Foo-')] = value
          end
        end
        data
      end
    end

    class HttpPrefixHeadersInResponse
      def self.parse(http_resp)
        data = Types::HttpPrefixHeadersInResponseOutput.new
        data.prefix_headers = {}
        http_resp.headers.each do |key, value|
          if key.start_with?('')
            data.prefix_headers[key.delete_prefix('')] = value
          end
        end
        data
      end
    end

    class HttpRequestWithFloatLabels
      def self.parse(http_resp)
        data = Types::HttpRequestWithFloatLabelsOutput.new
        data
      end
    end

    class HttpRequestWithGreedyLabelInPath
      def self.parse(http_resp)
        data = Types::HttpRequestWithGreedyLabelInPathOutput.new
        data
      end
    end

    class HttpRequestWithLabels
      def self.parse(http_resp)
        data = Types::HttpRequestWithLabelsOutput.new
        data
      end
    end

    class HttpRequestWithLabelsAndTimestampFormat
      def self.parse(http_resp)
        data = Types::HttpRequestWithLabelsAndTimestampFormatOutput.new
        data
      end
    end

    class HttpRequestWithRegexLiteral
      def self.parse(http_resp)
        data = Types::HttpRequestWithRegexLiteralOutput.new
        data
      end
    end

    class HttpResponseCode
      def self.parse(http_resp)
        data = Types::HttpResponseCodeOutput.new
        data.status = http_resp.status
        data
      end
    end

    class HttpStringPayload
      def self.parse(http_resp)
        data = Types::HttpStringPayloadOutput.new
        payload = http_resp.body.read
        data.payload = payload unless payload.empty?
        data
      end
    end

    class IgnoreQueryParamsInResponse
      def self.parse(http_resp)
        data = Types::IgnoreQueryParamsInResponseOutput.new
        data
      end
    end

    class InputAndOutputWithHeaders
      def self.parse(http_resp)
        data = Types::InputAndOutputWithHeadersOutput.new
        data.header_string = http_resp.headers['X-String']
        data.header_byte = http_resp.headers['X-Byte'].to_i unless http_resp.headers['X-Byte'].nil?
        data.header_short = http_resp.headers['X-Short'].to_i unless http_resp.headers['X-Short'].nil?
        data.header_integer = http_resp.headers['X-Integer'].to_i unless http_resp.headers['X-Integer'].nil?
        data.header_long = http_resp.headers['X-Long'].to_i unless http_resp.headers['X-Long'].nil?
        data.header_float = Hearth::NumberHelper.deserialize(http_resp.headers['X-Float']) unless http_resp.headers['X-Float'].nil?
        data.header_double = Hearth::NumberHelper.deserialize(http_resp.headers['X-Double']) unless http_resp.headers['X-Double'].nil?
        data.header_true_bool = http_resp.headers['X-Boolean1'] == 'true' unless http_resp.headers['X-Boolean1'].nil?
        data.header_false_bool = http_resp.headers['X-Boolean2'] == 'true' unless http_resp.headers['X-Boolean2'].nil?
        unless http_resp.headers['X-StringList'].nil? || http_resp.headers['X-StringList'].empty?
          data.header_string_list = Hearth::HTTP::HeaderListParser.parse_string_list(http_resp.headers['X-StringList'])
        end
        unless http_resp.headers['X-StringSet'].nil? || http_resp.headers['X-StringSet'].empty?
          data.header_string_set = Hearth::HTTP::HeaderListParser.parse_string_list(http_resp.headers['X-StringSet'])
        end
        unless http_resp.headers['X-IntegerList'].nil? || http_resp.headers['X-IntegerList'].empty?
          data.header_integer_list = Hearth::HTTP::HeaderListParser.parse_integer_list(http_resp.headers['X-IntegerList'])
        end
        unless http_resp.headers['X-BooleanList'].nil? || http_resp.headers['X-BooleanList'].empty?
          data.header_boolean_list = Hearth::HTTP::HeaderListParser.parse_boolean_list(http_resp.headers['X-BooleanList'])
        end
        unless http_resp.headers['X-TimestampList'].nil? || http_resp.headers['X-TimestampList'].empty?
          data.header_timestamp_list = Hearth::HTTP::HeaderListParser.parse_http_date_list(http_resp.headers['X-TimestampList'])
        end
        data.header_enum = http_resp.headers['X-Enum']
        unless http_resp.headers['X-EnumList'].nil? || http_resp.headers['X-EnumList'].empty?
          data.header_enum_list = Hearth::HTTP::HeaderListParser.parse_string_list(http_resp.headers['X-EnumList'])
        end
        data.header_integer_enum = http_resp.headers['X-IntegerEnum'].to_i unless http_resp.headers['X-IntegerEnum'].nil?
        unless http_resp.headers['X-IntegerEnumList'].nil? || http_resp.headers['X-IntegerEnumList'].empty?
          data.header_integer_enum_list = Hearth::HTTP::HeaderListParser.parse_integer_list(http_resp.headers['X-IntegerEnumList'])
        end
        data
      end
    end

    class IntegerEnumList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class IntegerEnumMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class IntegerEnumSet
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class IntegerList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    # Error Parser for InvalidGreeting
    class InvalidGreeting
      def self.parse(http_resp)
        data = Types::InvalidGreeting.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.message = map['message'] unless map['message'].nil?
        data
      end
    end

    class JsonBlobs
      def self.parse(http_resp)
        data = Types::JsonBlobsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.data = ::Base64::decode64(map['data']) unless map['data'].nil?
        data
      end
    end

    class JsonEnums
      def self.parse(http_resp)
        data = Types::JsonEnumsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.foo_enum1 = map['foo_enum1'] unless map['foo_enum1'].nil?
        data.foo_enum2 = map['foo_enum2'] unless map['foo_enum2'].nil?
        data.foo_enum3 = map['foo_enum3'] unless map['foo_enum3'].nil?
        data.foo_enum_list = Parsers::FooEnumList.parse(map['foo_enum_list']) unless map['foo_enum_list'].nil?
        data.foo_enum_set = Parsers::FooEnumSet.parse(map['foo_enum_set']) unless map['foo_enum_set'].nil?
        data.foo_enum_map = Parsers::FooEnumMap.parse(map['foo_enum_map']) unless map['foo_enum_map'].nil?
        data
      end
    end

    class JsonIntEnums
      def self.parse(http_resp)
        data = Types::JsonIntEnumsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.integer_enum1 = map['integer_enum1'] unless map['integer_enum1'].nil?
        data.integer_enum2 = map['integer_enum2'] unless map['integer_enum2'].nil?
        data.integer_enum3 = map['integer_enum3'] unless map['integer_enum3'].nil?
        data.integer_enum_list = Parsers::IntegerEnumList.parse(map['integer_enum_list']) unless map['integer_enum_list'].nil?
        data.integer_enum_set = Parsers::IntegerEnumSet.parse(map['integer_enum_set']) unless map['integer_enum_set'].nil?
        data.integer_enum_map = Parsers::IntegerEnumMap.parse(map['integer_enum_map']) unless map['integer_enum_map'].nil?
        data
      end
    end

    class JsonLists
      def self.parse(http_resp)
        data = Types::JsonListsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.string_list = Parsers::StringList.parse(map['string_list']) unless map['string_list'].nil?
        data.string_set = Parsers::StringSet.parse(map['string_set']) unless map['string_set'].nil?
        data.integer_list = Parsers::IntegerList.parse(map['integer_list']) unless map['integer_list'].nil?
        data.boolean_list = Parsers::BooleanList.parse(map['boolean_list']) unless map['boolean_list'].nil?
        data.timestamp_list = Parsers::TimestampList.parse(map['timestamp_list']) unless map['timestamp_list'].nil?
        data.enum_list = Parsers::FooEnumList.parse(map['enum_list']) unless map['enum_list'].nil?
        data.int_enum_list = Parsers::IntegerEnumList.parse(map['int_enum_list']) unless map['int_enum_list'].nil?
        data.nested_string_list = Parsers::NestedStringList.parse(map['nested_string_list']) unless map['nested_string_list'].nil?
        data.structure_list = Parsers::StructureList.parse(map['myStructureList']) unless map['myStructureList'].nil?
        data
      end
    end

    class JsonMaps
      def self.parse(http_resp)
        data = Types::JsonMapsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.dense_struct_map = Parsers::DenseStructMap.parse(map['dense_struct_map']) unless map['dense_struct_map'].nil?
        data.dense_number_map = Parsers::DenseNumberMap.parse(map['dense_number_map']) unless map['dense_number_map'].nil?
        data.dense_boolean_map = Parsers::DenseBooleanMap.parse(map['dense_boolean_map']) unless map['dense_boolean_map'].nil?
        data.dense_string_map = Parsers::DenseStringMap.parse(map['dense_string_map']) unless map['dense_string_map'].nil?
        data.dense_set_map = Parsers::DenseSetMap.parse(map['dense_set_map']) unless map['dense_set_map'].nil?
        data
      end
    end

    class JsonTimestamps
      def self.parse(http_resp)
        data = Types::JsonTimestampsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.normal = Time.at(map['normal'].to_i) if map['normal']
        data.date_time = Time.parse(map['date_time']) if map['date_time']
        data.date_time_on_target = Time.parse(map['date_time_on_target']) if map['date_time_on_target']
        data.epoch_seconds = Time.at(map['epoch_seconds'].to_i) if map['epoch_seconds']
        data.epoch_seconds_on_target = Time.at(map['epoch_seconds_on_target'].to_i) if map['epoch_seconds_on_target']
        data.http_date = Time.parse(map['http_date']) if map['http_date']
        data.http_date_on_target = Time.parse(map['http_date_on_target']) if map['http_date_on_target']
        data
      end
    end

    class JsonUnions
      def self.parse(http_resp)
        data = Types::JsonUnionsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.contents = Parsers::MyUnion.parse(map['contents']) unless map['contents'].nil?
        data
      end
    end

    class MediaTypeHeader
      def self.parse(http_resp)
        data = Types::MediaTypeHeaderOutput.new
        data.json = ::Base64::decode64(http_resp.headers['X-Json']).strip unless http_resp.headers['X-Json'].nil?
        data
      end
    end

    class MyUnion
      def self.parse(map)
        key, value = map.flatten
        return nil if key.nil?

        case key
        when 'string_value'
          Types::MyUnion::StringValue.new(value) if value
        when 'boolean_value'
          Types::MyUnion::BooleanValue.new(value) if value
        when 'number_value'
          Types::MyUnion::NumberValue.new(value) if value
        when 'blob_value'
          value = ::Base64::decode64(value) unless value.nil?
          Types::MyUnion::BlobValue.new(value) if value
        when 'timestamp_value'
          value = Time.at(value.to_i) if value
          Types::MyUnion::TimestampValue.new(value) if value
        when 'enum_value'
          Types::MyUnion::EnumValue.new(value) if value
        when 'list_value'
          value = (Parsers::StringList.parse(value) unless value.nil?)
          Types::MyUnion::ListValue.new(value) if value
        when 'map_value'
          value = (Parsers::StringMap.parse(value) unless value.nil?)
          Types::MyUnion::MapValue.new(value) if value
        when 'structure_value'
          value = (Parsers::GreetingStruct.parse(value) unless value.nil?)
          Types::MyUnion::StructureValue.new(value) if value
        when 'renamed_structure_value'
          value = (Parsers::RenamedGreeting.parse(value) unless value.nil?)
          Types::MyUnion::RenamedStructureValue.new(value) if value
        else
          Types::MyUnion::Unknown.new(name: key, value: value)
        end
      end
    end

    class NestedPayload
      def self.parse(map)
        data = Types::NestedPayload.new
        data.greeting = map['greeting'] unless map['greeting'].nil?
        data.name = map['name'] unless map['name'].nil?
        data
      end
    end

    class NestedStringList
      def self.parse(list)
        list.map do |value|
          Parsers::StringList.parse(value) unless value.nil?
        end
      end
    end

    class NoInputAndNoOutput
      def self.parse(http_resp)
        data = Types::NoInputAndNoOutputOutput.new
        data
      end
    end

    class NoInputAndOutput
      def self.parse(http_resp)
        data = Types::NoInputAndOutputOutput.new
        data
      end
    end

    class NullAndEmptyHeadersClient
      def self.parse(http_resp)
        data = Types::NullAndEmptyHeadersClientOutput.new
        data.a = http_resp.headers['X-A']
        data.b = http_resp.headers['X-B']
        unless http_resp.headers['X-C'].nil? || http_resp.headers['X-C'].empty?
          data.c = Hearth::HTTP::HeaderListParser.parse_string_list(http_resp.headers['X-C'])
        end
        data
      end
    end

    class NullAndEmptyHeadersServer
      def self.parse(http_resp)
        data = Types::NullAndEmptyHeadersServerOutput.new
        data.a = http_resp.headers['X-A']
        data.b = http_resp.headers['X-B']
        unless http_resp.headers['X-C'].nil? || http_resp.headers['X-C'].empty?
          data.c = Hearth::HTTP::HeaderListParser.parse_string_list(http_resp.headers['X-C'])
        end
        data
      end
    end

    class OmitsNullSerializesEmptyString
      def self.parse(http_resp)
        data = Types::OmitsNullSerializesEmptyStringOutput.new
        data
      end
    end

    class OmitsSerializingEmptyLists
      def self.parse(http_resp)
        data = Types::OmitsSerializingEmptyListsOutput.new
        data
      end
    end

    class OperationWithDefaults
      def self.parse(http_resp)
        data = Types::OperationWithDefaultsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.default_string = map['default_string'] unless map['default_string'].nil?
        data.default_boolean = map['default_boolean'] unless map['default_boolean'].nil?
        data.default_list = Parsers::TestStringList.parse(map['default_list']) unless map['default_list'].nil?
        data.default_document_map = map['default_document_map'] unless map['default_document_map'].nil?
        data.default_document_string = map['default_document_string'] unless map['default_document_string'].nil?
        data.default_document_boolean = map['default_document_boolean'] unless map['default_document_boolean'].nil?
        data.default_document_list = map['default_document_list'] unless map['default_document_list'].nil?
        data.default_null_document = map['default_null_document'] unless map['default_null_document'].nil?
        data.default_timestamp = Time.parse(map['default_timestamp']) if map['default_timestamp']
        data.default_blob = ::Base64::decode64(map['default_blob']) unless map['default_blob'].nil?
        data.default_byte = map['default_byte'] unless map['default_byte'].nil?
        data.default_short = map['default_short'] unless map['default_short'].nil?
        data.default_integer = map['default_integer'] unless map['default_integer'].nil?
        data.default_long = map['default_long'] unless map['default_long'].nil?
        data.default_float = Hearth::NumberHelper.deserialize(map['default_float']) unless map['default_float'].nil?
        data.default_double = Hearth::NumberHelper.deserialize(map['default_double']) unless map['default_double'].nil?
        data.default_map = Parsers::TestStringMap.parse(map['default_map']) unless map['default_map'].nil?
        data.default_enum = map['default_enum'] unless map['default_enum'].nil?
        data.default_int_enum = map['default_int_enum'] unless map['default_int_enum'].nil?
        data.empty_string = map['empty_string'] unless map['empty_string'].nil?
        data.false_boolean = map['false_boolean'] unless map['false_boolean'].nil?
        data.empty_blob = ::Base64::decode64(map['empty_blob']) unless map['empty_blob'].nil?
        data.zero_byte = map['zero_byte'] unless map['zero_byte'].nil?
        data.zero_short = map['zero_short'] unless map['zero_short'].nil?
        data.zero_integer = map['zero_integer'] unless map['zero_integer'].nil?
        data.zero_long = map['zero_long'] unless map['zero_long'].nil?
        data.zero_float = Hearth::NumberHelper.deserialize(map['zero_float']) unless map['zero_float'].nil?
        data.zero_double = Hearth::NumberHelper.deserialize(map['zero_double']) unless map['zero_double'].nil?
        data
      end
    end

    class PayloadConfig
      def self.parse(map)
        data = Types::PayloadConfig.new
        data.data = map['data'] unless map['data'].nil?
        data
      end
    end

    class PlayerAction
      def self.parse(map)
        key, value = map.flatten
        return nil if key.nil?

        case key
        when 'quit'
          value = (Parsers::Unit.parse(value) unless value.nil?)
          Types::PlayerAction::Quit.new(value) if value
        else
          Types::PlayerAction::Unknown.new(name: key, value: value)
        end
      end
    end

    class PostPlayerAction
      def self.parse(http_resp)
        data = Types::PostPlayerActionOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.action = Parsers::PlayerAction.parse(map['action']) unless map['action'].nil?
        data
      end
    end

    class PostUnionWithJsonName
      def self.parse(http_resp)
        data = Types::PostUnionWithJsonNameOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.value = Parsers::UnionWithJsonName.parse(map['value']) unless map['value'].nil?
        data
      end
    end

    class PutWithContentEncoding
      def self.parse(http_resp)
        data = Types::PutWithContentEncodingOutput.new
        data
      end
    end

    class QueryIdempotencyTokenAutoFill
      def self.parse(http_resp)
        data = Types::QueryIdempotencyTokenAutoFillOutput.new
        data
      end
    end

    class QueryParamsAsStringListMap
      def self.parse(http_resp)
        data = Types::QueryParamsAsStringListMapOutput.new
        data
      end
    end

    class QueryPrecedence
      def self.parse(http_resp)
        data = Types::QueryPrecedenceOutput.new
        data
      end
    end

    class RecursiveShapes
      def self.parse(http_resp)
        data = Types::RecursiveShapesOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.nested = Parsers::RecursiveShapesInputOutputNested1.parse(map['nested']) unless map['nested'].nil?
        data
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.parse(map)
        data = Types::RecursiveShapesInputOutputNested1.new
        data.foo = map['foo'] unless map['foo'].nil?
        data.nested = Parsers::RecursiveShapesInputOutputNested2.parse(map['nested']) unless map['nested'].nil?
        data
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.parse(map)
        data = Types::RecursiveShapesInputOutputNested2.new
        data.bar = map['bar'] unless map['bar'].nil?
        data.recursive_member = Parsers::RecursiveShapesInputOutputNested1.parse(map['recursive_member']) unless map['recursive_member'].nil?
        data
      end
    end

    class SimpleScalarProperties
      def self.parse(http_resp)
        data = Types::SimpleScalarPropertiesOutput.new
        data.foo = http_resp.headers['X-Foo']
        map = Hearth::JSON.parse(http_resp.body.read)
        data.string_value = map['string_value'] unless map['string_value'].nil?
        data.true_boolean_value = map['true_boolean_value'] unless map['true_boolean_value'].nil?
        data.false_boolean_value = map['false_boolean_value'] unless map['false_boolean_value'].nil?
        data.byte_value = map['byte_value'] unless map['byte_value'].nil?
        data.short_value = map['short_value'] unless map['short_value'].nil?
        data.integer_value = map['integer_value'] unless map['integer_value'].nil?
        data.long_value = map['long_value'] unless map['long_value'].nil?
        data.float_value = Hearth::NumberHelper.deserialize(map['float_value']) unless map['float_value'].nil?
        data.double_value = Hearth::NumberHelper.deserialize(map['DoubleDribble']) unless map['DoubleDribble'].nil?
        data
      end
    end

    class SparseBooleanMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseJsonLists
      def self.parse(http_resp)
        data = Types::SparseJsonListsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.sparse_string_list = Parsers::SparseStringList.parse(map['sparse_string_list']) unless map['sparse_string_list'].nil?
        data
      end
    end

    class SparseJsonMaps
      def self.parse(http_resp)
        data = Types::SparseJsonMapsOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.sparse_struct_map = Parsers::SparseStructMap.parse(map['sparse_struct_map']) unless map['sparse_struct_map'].nil?
        data.sparse_number_map = Parsers::SparseNumberMap.parse(map['sparse_number_map']) unless map['sparse_number_map'].nil?
        data.sparse_boolean_map = Parsers::SparseBooleanMap.parse(map['sparse_boolean_map']) unless map['sparse_boolean_map'].nil?
        data.sparse_string_map = Parsers::SparseStringMap.parse(map['sparse_string_map']) unless map['sparse_string_map'].nil?
        data.sparse_set_map = Parsers::SparseSetMap.parse(map['sparse_set_map']) unless map['sparse_set_map'].nil?
        data
      end
    end

    class SparseNumberMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseSetMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = (Parsers::StringSet.parse(value) unless value.nil?)
        end
        data
      end
    end

    class SparseStringList
      def self.parse(list)
        list.map do |value|
          value
        end
      end
    end

    class SparseStringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseStructMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = (Parsers::GreetingStruct.parse(value) unless value.nil?)
        end
        data
      end
    end

    class StreamingTraits
      def self.parse(http_resp)
        data = Types::StreamingTraitsOutput.new
        data.foo = http_resp.headers['X-Foo']
        data.blob = http_resp.body
        data
      end
    end

    class StreamingTraitsRequireLength
      def self.parse(http_resp)
        data = Types::StreamingTraitsRequireLengthOutput.new
        data
      end
    end

    class StreamingTraitsWithMediaType
      def self.parse(http_resp)
        data = Types::StreamingTraitsWithMediaTypeOutput.new
        data.foo = http_resp.headers['X-Foo']
        data.blob = http_resp.body
        data
      end
    end

    class StringList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class StringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class StringSet
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class StructureList
      def self.parse(list)
        list.map do |value|
          Parsers::StructureListMember.parse(value) unless value.nil?
        end
      end
    end

    class StructureListMember
      def self.parse(map)
        data = Types::StructureListMember.new
        data.a = map['value'] unless map['value'].nil?
        data.b = map['other'] unless map['other'].nil?
        data
      end
    end

    class TestBodyStructure
      def self.parse(http_resp)
        data = Types::TestBodyStructureOutput.new
        data.test_id = http_resp.headers['x-amz-test-id']
        map = Hearth::JSON.parse(http_resp.body.read)
        data.test_config = Parsers::TestConfig.parse(map['test_config']) unless map['test_config'].nil?
        data
      end
    end

    class TestConfig
      def self.parse(map)
        data = Types::TestConfig.new
        data.timeout = map['timeout'] unless map['timeout'].nil?
        data
      end
    end

    class TestNoPayload
      def self.parse(http_resp)
        data = Types::TestNoPayloadOutput.new
        data.test_id = http_resp.headers['X-Amz-Test-Id']
        data
      end
    end

    class TestPayloadBlob
      def self.parse(http_resp)
        data = Types::TestPayloadBlobOutput.new
        data.content_type = http_resp.headers['Content-Type']
        payload = http_resp.body.read
        data.data = payload unless payload.empty?
        data
      end
    end

    class TestPayloadStructure
      def self.parse(http_resp)
        data = Types::TestPayloadStructureOutput.new
        data.test_id = http_resp.headers['x-amz-test-id']
        map = Hearth::JSON.parse(http_resp.body.read)
        data.payload_config = Parsers::PayloadConfig.parse(map)
        data
      end
    end

    class TestStringList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class TestStringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class TimestampFormatHeaders
      def self.parse(http_resp)
        data = Types::TimestampFormatHeadersOutput.new
        data.member_epoch_seconds = Time.at(http_resp.headers['X-memberEpochSeconds'].to_i) if http_resp.headers['X-memberEpochSeconds']
        data.member_http_date = Time.parse(http_resp.headers['X-memberHttpDate']) if http_resp.headers['X-memberHttpDate']
        data.member_date_time = Time.parse(http_resp.headers['X-memberDateTime']) if http_resp.headers['X-memberDateTime']
        data.default_format = Time.parse(http_resp.headers['X-defaultFormat']) if http_resp.headers['X-defaultFormat']
        data.target_epoch_seconds = Time.at(http_resp.headers['X-targetEpochSeconds'].to_i) if http_resp.headers['X-targetEpochSeconds']
        data.target_http_date = Time.parse(http_resp.headers['X-targetHttpDate']) if http_resp.headers['X-targetHttpDate']
        data.target_date_time = Time.parse(http_resp.headers['X-targetDateTime']) if http_resp.headers['X-targetDateTime']
        data
      end
    end

    class TimestampList
      def self.parse(list)
        list.map do |value|
          Time.parse(value) if value
        end
      end
    end

    class UnionPayload
      def self.parse(map)
        key, value = map.flatten
        return nil if key.nil?

        case key
        when 'greeting'
          Types::UnionPayload::Greeting.new(value) if value
        else
          Types::UnionPayload::Unknown.new(name: key, value: value)
        end
      end
    end

    class UnionWithJsonName
      def self.parse(map)
        key, value = map.flatten
        return nil if key.nil?

        case key
        when 'FOO'
          Types::UnionWithJsonName::Foo.new(value) if value
        when 'bar'
          Types::UnionWithJsonName::Bar.new(value) if value
        when '_baz'
          Types::UnionWithJsonName::Baz.new(value) if value
        else
          Types::UnionWithJsonName::Unknown.new(name: key, value: value)
        end
      end
    end

    class Unit
      def self.parse(map)
        data = Types::Unit.new
        data
      end
    end

    class UnitInputAndOutput
      def self.parse(http_resp)
        data = Types::UnitInputAndOutputOutput.new
        data
      end
    end
  end
end
