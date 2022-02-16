# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module RailsJson
  module Parsers

    # Operation Parser for AllQueryStringTypes
    class AllQueryStringTypes

      def self.parse(http_resp)
        data = Types::AllQueryStringTypesOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for ConstantAndVariableQueryString
    class ConstantAndVariableQueryString

      def self.parse(http_resp)
        data = Types::ConstantAndVariableQueryStringOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for ConstantQueryString
    class ConstantQueryString

      def self.parse(http_resp)
        data = Types::ConstantQueryStringOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for DocumentType
    class DocumentType

      def self.parse(http_resp)
        data = Types::DocumentTypeOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.string_value = map['string_value']
        data.document_value = map['document_value']
        data
      end
    end

    # Operation Parser for DocumentTypeAsPayload
    class DocumentTypeAsPayload

      def self.parse(http_resp)
        data = Types::DocumentTypeAsPayloadOutput.new
        payload = Hearth::JSON.load(http_resp.body.read)
        data.document_value = payload
        data
      end
    end

    # Operation Parser for EmptyOperation
    class EmptyOperation

      def self.parse(http_resp)
        data = Types::EmptyOperationOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for EndpointOperation
    class EndpointOperation

      def self.parse(http_resp)
        data = Types::EndpointOperationOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for EndpointWithHostLabelOperation
    class EndpointWithHostLabelOperation

      def self.parse(http_resp)
        data = Types::EndpointWithHostLabelOperationOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for GreetingWithErrors
    class GreetingWithErrors

      def self.parse(http_resp)
        data = Types::GreetingWithErrorsOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.greeting = map['greeting']
        data
      end
    end

    # Error Parser for InvalidGreeting
    class InvalidGreeting

      def self.parse(http_resp)
        data = Types::InvalidGreeting.new
        map = Hearth::JSON.load(http_resp.body)
        data.message = map['message']
        data
      end
    end

    # Error Parser for ComplexError
    class ComplexError

      def self.parse(http_resp)
        data = Types::ComplexError.new
        map = Hearth::JSON.load(http_resp.body)
        data.top_level = map['top_level']
        data.nested = (Parsers::ComplexNestedErrorData.parse(map['nested']) unless map['nested'].nil?)
        data
      end
    end

    class ComplexNestedErrorData
      def self.parse(map)
        data = Types::ComplexNestedErrorData.new
        data.foo = map['Fooooo']
        return data
      end
    end

    # Operation Parser for HttpPayloadTraits
    class HttpPayloadTraits

      def self.parse(http_resp)
        data = Types::HttpPayloadTraitsOutput.new
        data.foo = http_resp.headers['X-Foo']
        payload = http_resp.body.read
        data.blob = payload unless payload.empty?
        data
      end
    end

    # Operation Parser for HttpPayloadTraitsWithMediaType
    class HttpPayloadTraitsWithMediaType

      def self.parse(http_resp)
        data = Types::HttpPayloadTraitsWithMediaTypeOutput.new
        data.foo = http_resp.headers['X-Foo']
        payload = http_resp.body.read
        data.blob = payload unless payload.empty?
        data
      end
    end

    # Operation Parser for HttpPayloadWithStructure
    class HttpPayloadWithStructure

      def self.parse(http_resp)
        data = Types::HttpPayloadWithStructureOutput.new
        json = Hearth::JSON.load(http_resp.body)
        data.nested = Parsers::NestedPayload.parse(json)
        data
      end
    end

    class NestedPayload
      def self.parse(map)
        data = Types::NestedPayload.new
        data.greeting = map['greeting']
        data.member_name = map['name']
        return data
      end
    end

    # Operation Parser for HttpPrefixHeaders
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
        map = Hearth::JSON.load(http_resp.body)
        data
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

    # Operation Parser for HttpPrefixHeadersInResponse
    class HttpPrefixHeadersInResponse

      def self.parse(http_resp)
        data = Types::HttpPrefixHeadersInResponseOutput.new
        data.prefix_headers = {}
        http_resp.headers.each do |key, value|
          if key.start_with?('')
            data.prefix_headers[key.delete_prefix('')] = value
          end
        end
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for HttpRequestWithFloatLabels
    class HttpRequestWithFloatLabels

      def self.parse(http_resp)
        data = Types::HttpRequestWithFloatLabelsOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for HttpRequestWithGreedyLabelInPath
    class HttpRequestWithGreedyLabelInPath

      def self.parse(http_resp)
        data = Types::HttpRequestWithGreedyLabelInPathOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for HttpRequestWithLabels
    class HttpRequestWithLabels

      def self.parse(http_resp)
        data = Types::HttpRequestWithLabelsOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for HttpRequestWithLabelsAndTimestampFormat
    class HttpRequestWithLabelsAndTimestampFormat

      def self.parse(http_resp)
        data = Types::HttpRequestWithLabelsAndTimestampFormatOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for HttpResponseCode
    class HttpResponseCode

      def self.parse(http_resp)
        data = Types::HttpResponseCodeOutput.new
        data.status = http_resp.status
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for IgnoreQueryParamsInResponse
    class IgnoreQueryParamsInResponse

      def self.parse(http_resp)
        data = Types::IgnoreQueryParamsInResponseOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for InputAndOutputWithHeaders
    class InputAndOutputWithHeaders

      def self.parse(http_resp)
        data = Types::InputAndOutputWithHeadersOutput.new
        data.header_string = http_resp.headers['X-String']
        data.header_byte = http_resp.headers['X-Byte']&.to_i
        data.header_short = http_resp.headers['X-Short']&.to_i
        data.header_integer = http_resp.headers['X-Integer']&.to_i
        data.header_long = http_resp.headers['X-Long']&.to_i
        data.header_float = Hearth::NumberHelper.deserialize(http_resp.headers['X-Float']) unless http_resp.headers['X-Float'].nil?
        data.header_double = Hearth::NumberHelper.deserialize(http_resp.headers['X-Double']) unless http_resp.headers['X-Double'].nil?
        data.header_true_bool = http_resp.headers['X-Boolean1'] == 'true' unless http_resp.headers['X-Boolean1'].nil?
        data.header_false_bool = http_resp.headers['X-Boolean2'] == 'true' unless http_resp.headers['X-Boolean2'].nil?
        unless http_resp.headers['X-StringList'].nil? || http_resp.headers['X-StringList'].empty?
          data.header_string_list = http_resp.headers['X-StringList']
            .split(', ')
            .map { |s| s.to_s }
        end
        unless http_resp.headers['X-StringSet'].nil? || http_resp.headers['X-StringSet'].empty?
          data.header_string_set = Set.new(http_resp.headers['X-StringSet']
            .split(', ')
            .map { |s| s.to_s }
          )
        end
        unless http_resp.headers['X-IntegerList'].nil? || http_resp.headers['X-IntegerList'].empty?
          data.header_integer_list = http_resp.headers['X-IntegerList']
            .split(', ')
            .map { |s| s.to_i }
        end
        unless http_resp.headers['X-BooleanList'].nil? || http_resp.headers['X-BooleanList'].empty?
          data.header_boolean_list = http_resp.headers['X-BooleanList']
            .split(', ')
            .map { |s| s == 'true' }
        end
        unless http_resp.headers['X-TimestampList'].nil? || http_resp.headers['X-TimestampList'].empty?
          data.header_timestamp_list = http_resp.headers['X-TimestampList']
            .split(', ')
            .map { |s| Time.parse(s) }
        end
        data.header_enum = http_resp.headers['X-Enum']
        unless http_resp.headers['X-EnumList'].nil? || http_resp.headers['X-EnumList'].empty?
          data.header_enum_list = http_resp.headers['X-EnumList']
            .split(', ')
            .map { |s| s.to_s }
        end
        map = Hearth::JSON.load(http_resp.body)
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

    class TimestampList
      def self.parse(list)
        list.map do |value|
          Time.parse(value) if value
        end
      end
    end

    class BooleanList
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

    class StringSet
      def self.parse(list)
        data = list.map do |value|
          value unless value.nil?
        end
        Set.new(data)
      end
    end

    class StringList
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    # Operation Parser for JsonEnums
    class JsonEnums

      def self.parse(http_resp)
        data = Types::JsonEnumsOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.foo_enum1 = map['foo_enum1']
        data.foo_enum2 = map['foo_enum2']
        data.foo_enum3 = map['foo_enum3']
        data.foo_enum_list = (Parsers::FooEnumList.parse(map['foo_enum_list']) unless map['foo_enum_list'].nil?)
        data.foo_enum_set = map['foo_enum_set']
        data.foo_enum_map = (Parsers::FooEnumMap.parse(map['foo_enum_map']) unless map['foo_enum_map'].nil?)
        data
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
        data = list.map do |value|
          value unless value.nil?
        end
        Set.new(data)
      end
    end

    # Operation Parser for JsonMaps
    class JsonMaps

      def self.parse(http_resp)
        data = Types::JsonMapsOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.dense_struct_map = (Parsers::DenseStructMap.parse(map['dense_struct_map']) unless map['dense_struct_map'].nil?)
        data.sparse_struct_map = (Parsers::SparseStructMap.parse(map['sparse_struct_map']) unless map['sparse_struct_map'].nil?)
        data.dense_number_map = (Parsers::DenseNumberMap.parse(map['dense_number_map']) unless map['dense_number_map'].nil?)
        data.dense_boolean_map = (Parsers::DenseBooleanMap.parse(map['dense_boolean_map']) unless map['dense_boolean_map'].nil?)
        data.dense_string_map = (Parsers::DenseStringMap.parse(map['dense_string_map']) unless map['dense_string_map'].nil?)
        data.sparse_number_map = (Parsers::SparseNumberMap.parse(map['sparse_number_map']) unless map['sparse_number_map'].nil?)
        data.sparse_boolean_map = (Parsers::SparseBooleanMap.parse(map['sparse_boolean_map']) unless map['sparse_boolean_map'].nil?)
        data.sparse_string_map = (Parsers::SparseStringMap.parse(map['sparse_string_map']) unless map['sparse_string_map'].nil?)
        data.dense_set_map = (Parsers::DenseSetMap.parse(map['dense_set_map']) unless map['dense_set_map'].nil?)
        data.sparse_set_map = (Parsers::SparseSetMap.parse(map['sparse_set_map']) unless map['sparse_set_map'].nil?)
        data
      end
    end

    class SparseSetMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    class DenseSetMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
        data
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

    class SparseBooleanMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value
        end
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

    class DenseStringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = value unless value.nil?
        end
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

    class SparseStructMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = (Parsers::GreetingStruct.parse(value) unless value.nil?)
        end
        data
      end
    end

    class GreetingStruct
      def self.parse(map)
        data = Types::GreetingStruct.new
        data.hi = map['hi']
        return data
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

    # Operation Parser for JsonUnions
    class JsonUnions

      def self.parse(http_resp)
        data = Types::JsonUnionsOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.contents = (Parsers::MyUnion.parse(map['contents']) unless map['contents'].nil?)
        data
      end
    end

    class MyUnion
      def self.parse(map)
        key, value = map.flatten
        case key
        when 'string_value'
          value = value
          Types::MyUnion::StringValue.new(value) if value
        when 'boolean_value'
          value = value
          Types::MyUnion::BooleanValue.new(value) if value
        when 'number_value'
          value = value
          Types::MyUnion::NumberValue.new(value) if value
        when 'blob_value'
          value = Base64::decode64(value) unless value.nil?
          Types::MyUnion::BlobValue.new(value) if value
        when 'timestamp_value'
          value = Time.parse(value) if value
          Types::MyUnion::TimestampValue.new(value) if value
        when 'enum_value'
          value = value
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
        else
          Types::MyUnion::Unknown.new({name: key, value: value})
        end
      end
    end

    # Operation Parser for KitchenSinkOperation
    class KitchenSinkOperation

      def self.parse(http_resp)
        data = Types::KitchenSinkOperationOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.blob = Base64::decode64(map['blob']) unless map['blob'].nil?
        data.boolean = map['boolean']
        data.double = Hearth::NumberHelper.deserialize(map['double'])
        data.empty_struct = (Parsers::EmptyStruct.parse(map['empty_struct']) unless map['empty_struct'].nil?)
        data.float = Hearth::NumberHelper.deserialize(map['float'])
        data.httpdate_timestamp = Time.parse(map['httpdate_timestamp']) if map['httpdate_timestamp']
        data.integer = map['integer']
        data.iso8601_timestamp = Time.parse(map['iso8601_timestamp']) if map['iso8601_timestamp']
        data.json_value = map['json_value']
        data.list_of_lists = (Parsers::ListOfListOfStrings.parse(map['list_of_lists']) unless map['list_of_lists'].nil?)
        data.list_of_maps_of_strings = (Parsers::ListOfMapsOfStrings.parse(map['list_of_maps_of_strings']) unless map['list_of_maps_of_strings'].nil?)
        data.list_of_strings = (Parsers::ListOfStrings.parse(map['list_of_strings']) unless map['list_of_strings'].nil?)
        data.list_of_structs = (Parsers::ListOfStructs.parse(map['list_of_structs']) unless map['list_of_structs'].nil?)
        data.long = map['long']
        data.map_of_lists_of_strings = (Parsers::MapOfListsOfStrings.parse(map['map_of_lists_of_strings']) unless map['map_of_lists_of_strings'].nil?)
        data.map_of_maps = (Parsers::MapOfMapOfStrings.parse(map['map_of_maps']) unless map['map_of_maps'].nil?)
        data.map_of_strings = (Parsers::MapOfStrings.parse(map['map_of_strings']) unless map['map_of_strings'].nil?)
        data.map_of_structs = (Parsers::MapOfStructs.parse(map['map_of_structs']) unless map['map_of_structs'].nil?)
        data.recursive_list = (Parsers::ListOfKitchenSinks.parse(map['recursive_list']) unless map['recursive_list'].nil?)
        data.recursive_map = (Parsers::MapOfKitchenSinks.parse(map['recursive_map']) unless map['recursive_map'].nil?)
        data.recursive_struct = (Parsers::KitchenSink.parse(map['recursive_struct']) unless map['recursive_struct'].nil?)
        data.simple_struct = (Parsers::SimpleStruct.parse(map['simple_struct']) unless map['simple_struct'].nil?)
        data.string = map['string']
        data.struct_with_location_name = (Parsers::StructWithLocationName.parse(map['struct_with_location_name']) unless map['struct_with_location_name'].nil?)
        data.timestamp = Time.parse(map['timestamp']) if map['timestamp']
        data.unix_timestamp = Time.at(map['unix_timestamp'].to_i) if map['unix_timestamp']
        data
      end
    end

    class StructWithLocationName
      def self.parse(map)
        data = Types::StructWithLocationName.new
        data.value = map['RenamedMember']
        return data
      end
    end

    class SimpleStruct
      def self.parse(map)
        data = Types::SimpleStruct.new
        data.value = map['value']
        return data
      end
    end

    class KitchenSink
      def self.parse(map)
        data = Types::KitchenSink.new
        data.blob = Base64::decode64(map['blob']) unless map['blob'].nil?
        data.boolean = map['boolean']
        data.double = Hearth::NumberHelper.deserialize(map['double'])
        data.empty_struct = (Parsers::EmptyStruct.parse(map['empty_struct']) unless map['empty_struct'].nil?)
        data.float = Hearth::NumberHelper.deserialize(map['float'])
        data.httpdate_timestamp = Time.parse(map['httpdate_timestamp']) if map['httpdate_timestamp']
        data.integer = map['integer']
        data.iso8601_timestamp = Time.parse(map['iso8601_timestamp']) if map['iso8601_timestamp']
        data.json_value = map['json_value']
        data.list_of_lists = (Parsers::ListOfListOfStrings.parse(map['list_of_lists']) unless map['list_of_lists'].nil?)
        data.list_of_maps_of_strings = (Parsers::ListOfMapsOfStrings.parse(map['list_of_maps_of_strings']) unless map['list_of_maps_of_strings'].nil?)
        data.list_of_strings = (Parsers::ListOfStrings.parse(map['list_of_strings']) unless map['list_of_strings'].nil?)
        data.list_of_structs = (Parsers::ListOfStructs.parse(map['list_of_structs']) unless map['list_of_structs'].nil?)
        data.long = map['long']
        data.map_of_lists_of_strings = (Parsers::MapOfListsOfStrings.parse(map['map_of_lists_of_strings']) unless map['map_of_lists_of_strings'].nil?)
        data.map_of_maps = (Parsers::MapOfMapOfStrings.parse(map['map_of_maps']) unless map['map_of_maps'].nil?)
        data.map_of_strings = (Parsers::MapOfStrings.parse(map['map_of_strings']) unless map['map_of_strings'].nil?)
        data.map_of_structs = (Parsers::MapOfStructs.parse(map['map_of_structs']) unless map['map_of_structs'].nil?)
        data.recursive_list = (Parsers::ListOfKitchenSinks.parse(map['recursive_list']) unless map['recursive_list'].nil?)
        data.recursive_map = (Parsers::MapOfKitchenSinks.parse(map['recursive_map']) unless map['recursive_map'].nil?)
        data.recursive_struct = (Parsers::KitchenSink.parse(map['recursive_struct']) unless map['recursive_struct'].nil?)
        data.simple_struct = (Parsers::SimpleStruct.parse(map['simple_struct']) unless map['simple_struct'].nil?)
        data.string = map['string']
        data.struct_with_location_name = (Parsers::StructWithLocationName.parse(map['struct_with_location_name']) unless map['struct_with_location_name'].nil?)
        data.timestamp = Time.parse(map['timestamp']) if map['timestamp']
        data.unix_timestamp = Time.at(map['unix_timestamp'].to_i) if map['unix_timestamp']
        return data
      end
    end

    class MapOfKitchenSinks
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::KitchenSink.parse(value) unless value.nil?
        end
        data
      end
    end

    class ListOfKitchenSinks
      def self.parse(list)
        list.map do |value|
          Parsers::KitchenSink.parse(value) unless value.nil?
        end
      end
    end

    class MapOfStructs
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::SimpleStruct.parse(value) unless value.nil?
        end
        data
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

    class MapOfMapOfStrings
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::MapOfStrings.parse(value) unless value.nil?
        end
        data
      end
    end

    class MapOfListsOfStrings
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::ListOfStrings.parse(value) unless value.nil?
        end
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
          Parsers::SimpleStruct.parse(value) unless value.nil?
        end
      end
    end

    class ListOfMapsOfStrings
      def self.parse(list)
        list.map do |value|
          Parsers::MapOfStrings.parse(value) unless value.nil?
        end
      end
    end

    class ListOfListOfStrings
      def self.parse(list)
        list.map do |value|
          Parsers::ListOfStrings.parse(value) unless value.nil?
        end
      end
    end

    class EmptyStruct
      def self.parse(map)
        data = Types::EmptyStruct.new
        return data
      end
    end

    # Error Parser for ErrorWithMembers
    class ErrorWithMembers

      def self.parse(http_resp)
        data = Types::ErrorWithMembers.new
        map = Hearth::JSON.load(http_resp.body)
        data.code = map['code']
        data.complex_data = (Parsers::KitchenSink.parse(map['complex_data']) unless map['complex_data'].nil?)
        data.integer_field = map['integer_field']
        data.list_field = (Parsers::ListOfStrings.parse(map['list_field']) unless map['list_field'].nil?)
        data.map_field = (Parsers::MapOfStrings.parse(map['map_field']) unless map['map_field'].nil?)
        data.message = map['message']
        data.string_field = map['string_field']
        data
      end
    end

    # Error Parser for ErrorWithoutMembers
    class ErrorWithoutMembers

      def self.parse(http_resp)
        data = Types::ErrorWithoutMembers.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for MediaTypeHeader
    class MediaTypeHeader

      def self.parse(http_resp)
        data = Types::MediaTypeHeaderOutput.new
        data.json = Base64::decode64(http_resp.headers['X-Json']).strip unless http_resp.headers['X-Json'].nil?
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for NestedAttributesOperation
    class NestedAttributesOperation

      def self.parse(http_resp)
        data = Types::NestedAttributesOperationOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.value = map['value']
        data
      end
    end

    # Operation Parser for NullAndEmptyHeadersClient
    class NullAndEmptyHeadersClient

      def self.parse(http_resp)
        data = Types::NullAndEmptyHeadersClientOutput.new
        data.a = http_resp.headers['X-A']
        data.b = http_resp.headers['X-B']
        unless http_resp.headers['X-C'].nil? || http_resp.headers['X-C'].empty?
          data.c = http_resp.headers['X-C']
            .split(', ')
            .map { |s| s.to_s }
        end
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for NullOperation
    class NullOperation

      def self.parse(http_resp)
        data = Types::NullOperationOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.string = map['string']
        data.sparse_string_list = (Parsers::SparseStringList.parse(map['sparse_string_list']) unless map['sparse_string_list'].nil?)
        data.sparse_string_map = (Parsers::SparseStringMap.parse(map['sparse_string_map']) unless map['sparse_string_map'].nil?)
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

    # Operation Parser for OmitsNullSerializesEmptyString
    class OmitsNullSerializesEmptyString

      def self.parse(http_resp)
        data = Types::OmitsNullSerializesEmptyStringOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for OperationWithOptionalInputOutput
    class OperationWithOptionalInputOutput

      def self.parse(http_resp)
        data = Types::OperationWithOptionalInputOutputOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.value = map['value']
        data
      end
    end

    # Operation Parser for QueryIdempotencyTokenAutoFill
    class QueryIdempotencyTokenAutoFill

      def self.parse(http_resp)
        data = Types::QueryIdempotencyTokenAutoFillOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for QueryParamsAsStringListMap
    class QueryParamsAsStringListMap

      def self.parse(http_resp)
        data = Types::QueryParamsAsStringListMapOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for TimestampFormatHeaders
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
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for __789BadName
    class Operation____789BadName

      def self.parse(http_resp)
        data = Types::Struct____789BadNameOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data.member = (Parsers::Struct____456efg.parse(map['member']) unless map['member'].nil?)
        data
      end
    end

    class Struct____456efg
      def self.parse(map)
        data = Types::Struct____456efg.new
        data.member____123foo = map['__123foo']
        return data
      end
    end
  end
end
