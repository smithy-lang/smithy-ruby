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
  module Stubs

    class AllQueryStringTypes
      def self.build(params, context:)
        Params::AllQueryStringTypesOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::AllQueryStringTypesOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class BooleanList
      def self.default(visited = [])
        return nil if visited.include?('BooleanList')
        visited = visited + ['BooleanList']
        [
          false
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

    class ComplexError
      def self.build(params, context:)
        Params::ComplexError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ComplexError.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          top_level: 'top_level',
          nested: ComplexNestedErrorData.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 400
        http_resp.headers['x-smithy-rails-error'] = 'ComplexError'
        http_resp.headers['Content-Type'] = 'application/json'
        data[:top_level] = stub[:top_level] unless stub[:top_level].nil?
        data[:nested] = Stubs::ComplexNestedErrorData.stub(stub[:nested]) unless stub[:nested].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class ComplexNestedErrorData
      def self.default(visited = [])
        return nil if visited.include?('ComplexNestedErrorData')
        visited = visited + ['ComplexNestedErrorData']
        {
          foo: 'foo',
        }
      end

      def self.stub(stub)
        stub ||= Types::ComplexNestedErrorData.new
        data = {}
        data['Fooooo'] = stub[:foo] unless stub[:foo].nil?
        data
      end
    end

    class ConstantAndVariableQueryString
      def self.build(params, context:)
        Params::ConstantAndVariableQueryStringOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ConstantAndVariableQueryStringOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class ConstantQueryString
      def self.build(params, context:)
        Params::ConstantQueryStringOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ConstantQueryStringOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class DenseBooleanMap
      def self.default(visited = [])
        return nil if visited.include?('DenseBooleanMap')
        visited = visited + ['DenseBooleanMap']
        {
          key: false
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

    class DenseNumberMap
      def self.default(visited = [])
        return nil if visited.include?('DenseNumberMap')
        visited = visited + ['DenseNumberMap']
        {
          key: 1
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

    class DenseSetMap
      def self.default(visited = [])
        return nil if visited.include?('DenseSetMap')
        visited = visited + ['DenseSetMap']
        {
          key: StringSet.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::StringSet.stub(value) unless value.nil?
        end
        data
      end
    end

    class DenseStringMap
      def self.default(visited = [])
        return nil if visited.include?('DenseStringMap')
        visited = visited + ['DenseStringMap']
        {
          key: 'value'
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

    class DenseStructMap
      def self.default(visited = [])
        return nil if visited.include?('DenseStructMap')
        visited = visited + ['DenseStructMap']
        {
          key: GreetingStruct.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::GreetingStruct.stub(value) unless value.nil?
        end
        data
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

    class DocumentType
      def self.build(params, context:)
        Params::DocumentTypeOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DocumentTypeOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string_value: 'string_value',
          document_value: nil,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:string_value] = stub[:string_value] unless stub[:string_value].nil?
        data[:document_value] = stub[:document_value] unless stub[:document_value].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class DocumentTypeAsPayload
      def self.build(params, context:)
        Params::DocumentTypeAsPayloadOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DocumentTypeAsPayloadOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          document_value: nil,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        http_resp.body.write(Hearth::JSON.dump(stub[:document_value]))
      end
    end

    class EmptyOperation
      def self.build(params, context:)
        Params::EmptyOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::EmptyOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class EmptyStruct
      def self.default(visited = [])
        return nil if visited.include?('EmptyStruct')
        visited = visited + ['EmptyStruct']
        {
        }
      end

      def self.stub(stub)
        stub ||= Types::EmptyStruct.new
        data = {}
        data
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
        http_resp.status = 200
      end
    end

    class ErrorWithMembers
      def self.build(params, context:)
        Params::ErrorWithMembers.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ErrorWithMembers.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          code: 'code',
          complex_data: KitchenSink.default(visited),
          integer_field: 1,
          list_field: ListOfStrings.default(visited),
          map_field: MapOfStrings.default(visited),
          message: 'message',
          string_field: 'string_field',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 400
        http_resp.headers['x-smithy-rails-error'] = 'ErrorWithMembers'
        http_resp.headers['Content-Type'] = 'application/json'
        data[:code] = stub[:code] unless stub[:code].nil?
        data[:complex_data] = Stubs::KitchenSink.stub(stub[:complex_data]) unless stub[:complex_data].nil?
        data[:integer_field] = stub[:integer_field] unless stub[:integer_field].nil?
        data[:list_field] = Stubs::ListOfStrings.stub(stub[:list_field]) unless stub[:list_field].nil?
        data[:map_field] = Stubs::MapOfStrings.stub(stub[:map_field]) unless stub[:map_field].nil?
        data[:message] = stub[:message] unless stub[:message].nil?
        data[:string_field] = stub[:string_field] unless stub[:string_field].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class ErrorWithoutMembers
      def self.build(params, context:)
        Params::ErrorWithoutMembers.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::ErrorWithoutMembers.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 500
        http_resp.headers['x-smithy-rails-error'] = 'ErrorWithoutMembers'
      end
    end

    class FooEnumList
      def self.default(visited = [])
        return nil if visited.include?('FooEnumList')
        visited = visited + ['FooEnumList']
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

    class FooEnumMap
      def self.default(visited = [])
        return nil if visited.include?('FooEnumMap')
        visited = visited + ['FooEnumMap']
        {
          key: 'value'
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

    class FooEnumSet
      def self.default(visited = [])
        return nil if visited.include?('FooEnumSet')
        visited = visited + ['FooEnumSet']
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

    class RenamedGreeting
      def self.default(visited = [])
        return nil if visited.include?('RenamedGreeting')
        visited = visited + ['RenamedGreeting']
        {
          salutation: 'salutation',
        }
      end

      def self.stub(stub)
        stub ||= Types::RenamedGreeting.new
        data = {}
        data[:salutation] = stub[:salutation] unless stub[:salutation].nil?
        data
      end
    end

    class GreetingStruct
      def self.default(visited = [])
        return nil if visited.include?('GreetingStruct')
        visited = visited + ['GreetingStruct']
        {
          hi: 'hi',
        }
      end

      def self.stub(stub)
        stub ||= Types::GreetingStruct.new
        data = {}
        data[:hi] = stub[:hi] unless stub[:hi].nil?
        data
      end
    end

    class GreetingWithErrors
      def self.build(params, context:)
        Params::GreetingWithErrorsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::GreetingWithErrorsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          greeting: 'greeting',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:greeting] = stub[:greeting] unless stub[:greeting].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class HttpPayloadTraits
      def self.build(params, context:)
        Params::HttpPayloadTraitsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpPayloadTraitsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          foo: 'foo',
          blob: 'blob',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Foo'] = stub[:foo] unless stub[:foo].nil? || stub[:foo].empty?
        http_resp.headers['Content-Type'] = 'application/octet-stream'
        http_resp.body.write(stub[:blob] || '')
      end
    end

    class HttpPayloadTraitsWithMediaType
      def self.build(params, context:)
        Params::HttpPayloadTraitsWithMediaTypeOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpPayloadTraitsWithMediaTypeOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          foo: 'foo',
          blob: 'blob',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Foo'] = stub[:foo] unless stub[:foo].nil? || stub[:foo].empty?
        http_resp.headers['Content-Type'] = 'text/plain'
        http_resp.body.write(stub[:blob] || '')
      end
    end

    class HttpPayloadWithStructure
      def self.build(params, context:)
        Params::HttpPayloadWithStructureOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpPayloadWithStructureOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          nested: NestedPayload.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::NestedPayload.stub(stub[:nested]) unless stub[:nested].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class HttpPrefixHeaders
      def self.build(params, context:)
        Params::HttpPrefixHeadersOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpPrefixHeadersOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          foo: 'foo',
          foo_map: StringMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Foo'] = stub[:foo] unless stub[:foo].nil? || stub[:foo].empty?
        stub[:foo_map]&.each do |key, value|
          http_resp.headers["X-Foo-#{key}"] = value unless value.nil? || value.empty?
        end
      end
    end

    class HttpPrefixHeadersInResponse
      def self.build(params, context:)
        Params::HttpPrefixHeadersInResponseOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpPrefixHeadersInResponseOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          prefix_headers: StringMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        stub[:prefix_headers]&.each do |key, value|
          http_resp.headers["#{key}"] = value unless value.nil? || value.empty?
        end
      end
    end

    class HttpRequestWithFloatLabels
      def self.build(params, context:)
        Params::HttpRequestWithFloatLabelsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpRequestWithFloatLabelsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpRequestWithGreedyLabelInPath
      def self.build(params, context:)
        Params::HttpRequestWithGreedyLabelInPathOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpRequestWithGreedyLabelInPathOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpRequestWithLabels
      def self.build(params, context:)
        Params::HttpRequestWithLabelsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpRequestWithLabelsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpRequestWithLabelsAndTimestampFormat
      def self.build(params, context:)
        Params::HttpRequestWithLabelsAndTimestampFormatOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpRequestWithLabelsAndTimestampFormatOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class HttpResponseCode
      def self.build(params, context:)
        Params::HttpResponseCodeOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpResponseCodeOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          status: 1,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.status = stub[:status]
      end
    end

    class IgnoreQueryParamsInResponse
      def self.build(params, context:)
        Params::IgnoreQueryParamsInResponseOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::IgnoreQueryParamsInResponseOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          baz: 'baz',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class InputAndOutputWithHeaders
      def self.build(params, context:)
        Params::InputAndOutputWithHeadersOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::InputAndOutputWithHeadersOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          header_string: 'header_string',
          header_byte: 1,
          header_short: 1,
          header_integer: 1,
          header_long: 1,
          header_float: 1.0,
          header_double: 1.0,
          header_true_bool: false,
          header_false_bool: false,
          header_string_list: StringList.default(visited),
          header_string_set: StringSet.default(visited),
          header_integer_list: IntegerList.default(visited),
          header_boolean_list: BooleanList.default(visited),
          header_timestamp_list: TimestampList.default(visited),
          header_enum: 'header_enum',
          header_enum_list: FooEnumList.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-String'] = stub[:header_string] unless stub[:header_string].nil? || stub[:header_string].empty?
        http_resp.headers['X-Byte'] = stub[:header_byte].to_s unless stub[:header_byte].nil?
        http_resp.headers['X-Short'] = stub[:header_short].to_s unless stub[:header_short].nil?
        http_resp.headers['X-Integer'] = stub[:header_integer].to_s unless stub[:header_integer].nil?
        http_resp.headers['X-Long'] = stub[:header_long].to_s unless stub[:header_long].nil?
        http_resp.headers['X-Float'] = Hearth::NumberHelper.serialize(stub[:header_float]) unless stub[:header_float].nil?
        http_resp.headers['X-Double'] = Hearth::NumberHelper.serialize(stub[:header_double]) unless stub[:header_double].nil?
        http_resp.headers['X-Boolean1'] = stub[:header_true_bool].to_s unless stub[:header_true_bool].nil?
        http_resp.headers['X-Boolean2'] = stub[:header_false_bool].to_s unless stub[:header_false_bool].nil?
        unless stub[:header_string_list].nil? || stub[:header_string_list].empty?
          http_resp.headers['X-StringList'] = stub[:header_string_list]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
        unless stub[:header_string_set].nil? || stub[:header_string_set].empty?
          http_resp.headers['X-StringSet'] = stub[:header_string_set]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
        unless stub[:header_integer_list].nil? || stub[:header_integer_list].empty?
          http_resp.headers['X-IntegerList'] = stub[:header_integer_list]
            .compact
            .map { |s| s.to_s }
            .join(', ')
        end
        unless stub[:header_boolean_list].nil? || stub[:header_boolean_list].empty?
          http_resp.headers['X-BooleanList'] = stub[:header_boolean_list]
            .compact
            .map { |s| s.to_s }
            .join(', ')
        end
        unless stub[:header_timestamp_list].nil? || stub[:header_timestamp_list].empty?
          http_resp.headers['X-TimestampList'] = stub[:header_timestamp_list]
            .compact
            .map { |s| Hearth::TimeHelper.to_date_time(s) }
            .join(', ')
        end
        http_resp.headers['X-Enum'] = stub[:header_enum] unless stub[:header_enum].nil? || stub[:header_enum].empty?
        unless stub[:header_enum_list].nil? || stub[:header_enum_list].empty?
          http_resp.headers['X-EnumList'] = stub[:header_enum_list]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
      end
    end

    class IntegerList
      def self.default(visited = [])
        return nil if visited.include?('IntegerList')
        visited = visited + ['IntegerList']
        [
          1
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

    class InvalidGreeting
      def self.build(params, context:)
        Params::InvalidGreeting.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::InvalidGreeting.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          message: 'message',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 400
        http_resp.headers['x-smithy-rails-error'] = 'InvalidGreeting'
        http_resp.headers['Content-Type'] = 'application/json'
        data[:message] = stub[:message] unless stub[:message].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class JsonEnums
      def self.build(params, context:)
        Params::JsonEnumsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::JsonEnumsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          foo_enum1: 'foo_enum1',
          foo_enum2: 'foo_enum2',
          foo_enum3: 'foo_enum3',
          foo_enum_list: FooEnumList.default(visited),
          foo_enum_set: FooEnumSet.default(visited),
          foo_enum_map: FooEnumMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:foo_enum1] = stub[:foo_enum1] unless stub[:foo_enum1].nil?
        data[:foo_enum2] = stub[:foo_enum2] unless stub[:foo_enum2].nil?
        data[:foo_enum3] = stub[:foo_enum3] unless stub[:foo_enum3].nil?
        data[:foo_enum_list] = Stubs::FooEnumList.stub(stub[:foo_enum_list]) unless stub[:foo_enum_list].nil?
        data[:foo_enum_set] = Stubs::FooEnumSet.stub(stub[:foo_enum_set]) unless stub[:foo_enum_set].nil?
        data[:foo_enum_map] = Stubs::FooEnumMap.stub(stub[:foo_enum_map]) unless stub[:foo_enum_map].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class JsonMaps
      def self.build(params, context:)
        Params::JsonMapsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::JsonMapsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          dense_struct_map: DenseStructMap.default(visited),
          sparse_struct_map: SparseStructMap.default(visited),
          dense_number_map: DenseNumberMap.default(visited),
          dense_boolean_map: DenseBooleanMap.default(visited),
          dense_string_map: DenseStringMap.default(visited),
          sparse_number_map: SparseNumberMap.default(visited),
          sparse_boolean_map: SparseBooleanMap.default(visited),
          sparse_string_map: SparseStringMap.default(visited),
          dense_set_map: DenseSetMap.default(visited),
          sparse_set_map: SparseSetMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:dense_struct_map] = Stubs::DenseStructMap.stub(stub[:dense_struct_map]) unless stub[:dense_struct_map].nil?
        data[:sparse_struct_map] = Stubs::SparseStructMap.stub(stub[:sparse_struct_map]) unless stub[:sparse_struct_map].nil?
        data[:dense_number_map] = Stubs::DenseNumberMap.stub(stub[:dense_number_map]) unless stub[:dense_number_map].nil?
        data[:dense_boolean_map] = Stubs::DenseBooleanMap.stub(stub[:dense_boolean_map]) unless stub[:dense_boolean_map].nil?
        data[:dense_string_map] = Stubs::DenseStringMap.stub(stub[:dense_string_map]) unless stub[:dense_string_map].nil?
        data[:sparse_number_map] = Stubs::SparseNumberMap.stub(stub[:sparse_number_map]) unless stub[:sparse_number_map].nil?
        data[:sparse_boolean_map] = Stubs::SparseBooleanMap.stub(stub[:sparse_boolean_map]) unless stub[:sparse_boolean_map].nil?
        data[:sparse_string_map] = Stubs::SparseStringMap.stub(stub[:sparse_string_map]) unless stub[:sparse_string_map].nil?
        data[:dense_set_map] = Stubs::DenseSetMap.stub(stub[:dense_set_map]) unless stub[:dense_set_map].nil?
        data[:sparse_set_map] = Stubs::SparseSetMap.stub(stub[:sparse_set_map]) unless stub[:sparse_set_map].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class JsonUnions
      def self.build(params, context:)
        Params::JsonUnionsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::JsonUnionsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          contents: MyUnion.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:contents] = Stubs::MyUnion.stub(stub[:contents]) unless stub[:contents].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class KitchenSink
      def self.default(visited = [])
        return nil if visited.include?('KitchenSink')
        visited = visited + ['KitchenSink']
        {
          blob: 'blob',
          boolean: false,
          double: 1.0,
          empty_struct: EmptyStruct.default(visited),
          float: 1.0,
          httpdate_timestamp: Time.now,
          integer: 1,
          iso8601_timestamp: Time.now,
          json_value: 'json_value',
          list_of_lists: ListOfListOfStrings.default(visited),
          list_of_maps_of_strings: ListOfMapsOfStrings.default(visited),
          list_of_strings: ListOfStrings.default(visited),
          list_of_structs: ListOfStructs.default(visited),
          long: 1,
          map_of_lists_of_strings: MapOfListsOfStrings.default(visited),
          map_of_maps: MapOfMapOfStrings.default(visited),
          map_of_strings: MapOfStrings.default(visited),
          map_of_structs: MapOfStructs.default(visited),
          recursive_list: ListOfKitchenSinks.default(visited),
          recursive_map: MapOfKitchenSinks.default(visited),
          recursive_struct: KitchenSink.default(visited),
          simple_struct: SimpleStruct.default(visited),
          string: 'string',
          struct_with_location_name: StructWithLocationName.default(visited),
          timestamp: Time.now,
          unix_timestamp: Time.now,
        }
      end

      def self.stub(stub)
        stub ||= Types::KitchenSink.new
        data = {}
        data[:blob] = ::Base64::encode64(stub[:blob]) unless stub[:blob].nil?
        data[:boolean] = stub[:boolean] unless stub[:boolean].nil?
        data[:double] = stub[:double] unless stub[:double].nil?
        data[:empty_struct] = Stubs::EmptyStruct.stub(stub[:empty_struct]) unless stub[:empty_struct].nil?
        data[:float] = stub[:float] unless stub[:float].nil?
        data[:httpdate_timestamp] = Hearth::TimeHelper.to_http_date(stub[:httpdate_timestamp]) unless stub[:httpdate_timestamp].nil?
        data[:integer] = stub[:integer] unless stub[:integer].nil?
        data[:iso8601_timestamp] = Hearth::TimeHelper.to_date_time(stub[:iso8601_timestamp]) unless stub[:iso8601_timestamp].nil?
        data[:json_value] = stub[:json_value] unless stub[:json_value].nil?
        data[:list_of_lists] = Stubs::ListOfListOfStrings.stub(stub[:list_of_lists]) unless stub[:list_of_lists].nil?
        data[:list_of_maps_of_strings] = Stubs::ListOfMapsOfStrings.stub(stub[:list_of_maps_of_strings]) unless stub[:list_of_maps_of_strings].nil?
        data[:list_of_strings] = Stubs::ListOfStrings.stub(stub[:list_of_strings]) unless stub[:list_of_strings].nil?
        data[:list_of_structs] = Stubs::ListOfStructs.stub(stub[:list_of_structs]) unless stub[:list_of_structs].nil?
        data[:long] = stub[:long] unless stub[:long].nil?
        data[:map_of_lists_of_strings] = Stubs::MapOfListsOfStrings.stub(stub[:map_of_lists_of_strings]) unless stub[:map_of_lists_of_strings].nil?
        data[:map_of_maps] = Stubs::MapOfMapOfStrings.stub(stub[:map_of_maps]) unless stub[:map_of_maps].nil?
        data[:map_of_strings] = Stubs::MapOfStrings.stub(stub[:map_of_strings]) unless stub[:map_of_strings].nil?
        data[:map_of_structs] = Stubs::MapOfStructs.stub(stub[:map_of_structs]) unless stub[:map_of_structs].nil?
        data[:recursive_list] = Stubs::ListOfKitchenSinks.stub(stub[:recursive_list]) unless stub[:recursive_list].nil?
        data[:recursive_map] = Stubs::MapOfKitchenSinks.stub(stub[:recursive_map]) unless stub[:recursive_map].nil?
        data[:recursive_struct] = Stubs::KitchenSink.stub(stub[:recursive_struct]) unless stub[:recursive_struct].nil?
        data[:simple_struct] = Stubs::SimpleStruct.stub(stub[:simple_struct]) unless stub[:simple_struct].nil?
        data[:string] = stub[:string] unless stub[:string].nil?
        data[:struct_with_location_name] = Stubs::StructWithLocationName.stub(stub[:struct_with_location_name]) unless stub[:struct_with_location_name].nil?
        data[:timestamp] = Hearth::TimeHelper.to_date_time(stub[:timestamp]) unless stub[:timestamp].nil?
        data[:unix_timestamp] = Hearth::TimeHelper.to_epoch_seconds(stub[:unix_timestamp]).to_i unless stub[:unix_timestamp].nil?
        data
      end
    end

    class KitchenSinkOperation
      def self.build(params, context:)
        Params::KitchenSinkOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::KitchenSinkOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          blob: 'blob',
          boolean: false,
          double: 1.0,
          empty_struct: EmptyStruct.default(visited),
          float: 1.0,
          httpdate_timestamp: Time.now,
          integer: 1,
          iso8601_timestamp: Time.now,
          json_value: 'json_value',
          list_of_lists: ListOfListOfStrings.default(visited),
          list_of_maps_of_strings: ListOfMapsOfStrings.default(visited),
          list_of_strings: ListOfStrings.default(visited),
          list_of_structs: ListOfStructs.default(visited),
          long: 1,
          map_of_lists_of_strings: MapOfListsOfStrings.default(visited),
          map_of_maps: MapOfMapOfStrings.default(visited),
          map_of_strings: MapOfStrings.default(visited),
          map_of_structs: MapOfStructs.default(visited),
          recursive_list: ListOfKitchenSinks.default(visited),
          recursive_map: MapOfKitchenSinks.default(visited),
          recursive_struct: KitchenSink.default(visited),
          simple_struct: SimpleStruct.default(visited),
          string: 'string',
          struct_with_location_name: StructWithLocationName.default(visited),
          timestamp: Time.now,
          unix_timestamp: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:blob] = ::Base64::encode64(stub[:blob]) unless stub[:blob].nil?
        data[:boolean] = stub[:boolean] unless stub[:boolean].nil?
        data[:double] = stub[:double] unless stub[:double].nil?
        data[:empty_struct] = Stubs::EmptyStruct.stub(stub[:empty_struct]) unless stub[:empty_struct].nil?
        data[:float] = stub[:float] unless stub[:float].nil?
        data[:httpdate_timestamp] = Hearth::TimeHelper.to_http_date(stub[:httpdate_timestamp]) unless stub[:httpdate_timestamp].nil?
        data[:integer] = stub[:integer] unless stub[:integer].nil?
        data[:iso8601_timestamp] = Hearth::TimeHelper.to_date_time(stub[:iso8601_timestamp]) unless stub[:iso8601_timestamp].nil?
        data[:json_value] = stub[:json_value] unless stub[:json_value].nil?
        data[:list_of_lists] = Stubs::ListOfListOfStrings.stub(stub[:list_of_lists]) unless stub[:list_of_lists].nil?
        data[:list_of_maps_of_strings] = Stubs::ListOfMapsOfStrings.stub(stub[:list_of_maps_of_strings]) unless stub[:list_of_maps_of_strings].nil?
        data[:list_of_strings] = Stubs::ListOfStrings.stub(stub[:list_of_strings]) unless stub[:list_of_strings].nil?
        data[:list_of_structs] = Stubs::ListOfStructs.stub(stub[:list_of_structs]) unless stub[:list_of_structs].nil?
        data[:long] = stub[:long] unless stub[:long].nil?
        data[:map_of_lists_of_strings] = Stubs::MapOfListsOfStrings.stub(stub[:map_of_lists_of_strings]) unless stub[:map_of_lists_of_strings].nil?
        data[:map_of_maps] = Stubs::MapOfMapOfStrings.stub(stub[:map_of_maps]) unless stub[:map_of_maps].nil?
        data[:map_of_strings] = Stubs::MapOfStrings.stub(stub[:map_of_strings]) unless stub[:map_of_strings].nil?
        data[:map_of_structs] = Stubs::MapOfStructs.stub(stub[:map_of_structs]) unless stub[:map_of_structs].nil?
        data[:recursive_list] = Stubs::ListOfKitchenSinks.stub(stub[:recursive_list]) unless stub[:recursive_list].nil?
        data[:recursive_map] = Stubs::MapOfKitchenSinks.stub(stub[:recursive_map]) unless stub[:recursive_map].nil?
        data[:recursive_struct] = Stubs::KitchenSink.stub(stub[:recursive_struct]) unless stub[:recursive_struct].nil?
        data[:simple_struct] = Stubs::SimpleStruct.stub(stub[:simple_struct]) unless stub[:simple_struct].nil?
        data[:string] = stub[:string] unless stub[:string].nil?
        data[:struct_with_location_name] = Stubs::StructWithLocationName.stub(stub[:struct_with_location_name]) unless stub[:struct_with_location_name].nil?
        data[:timestamp] = Hearth::TimeHelper.to_date_time(stub[:timestamp]) unless stub[:timestamp].nil?
        data[:unix_timestamp] = Hearth::TimeHelper.to_epoch_seconds(stub[:unix_timestamp]).to_i unless stub[:unix_timestamp].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class ListOfKitchenSinks
      def self.default(visited = [])
        return nil if visited.include?('ListOfKitchenSinks')
        visited = visited + ['ListOfKitchenSinks']
        [
          KitchenSink.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::KitchenSink.stub(element) unless element.nil?
        end
        data
      end
    end

    class ListOfListOfStrings
      def self.default(visited = [])
        return nil if visited.include?('ListOfListOfStrings')
        visited = visited + ['ListOfListOfStrings']
        [
          ListOfStrings.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::ListOfStrings.stub(element) unless element.nil?
        end
        data
      end
    end

    class ListOfMapsOfStrings
      def self.default(visited = [])
        return nil if visited.include?('ListOfMapsOfStrings')
        visited = visited + ['ListOfMapsOfStrings']
        [
          MapOfStrings.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::MapOfStrings.stub(element) unless element.nil?
        end
        data
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
          SimpleStruct.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::SimpleStruct.stub(element) unless element.nil?
        end
        data
      end
    end

    class MapOfKitchenSinks
      def self.default(visited = [])
        return nil if visited.include?('MapOfKitchenSinks')
        visited = visited + ['MapOfKitchenSinks']
        {
          key: KitchenSink.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::KitchenSink.stub(value) unless value.nil?
        end
        data
      end
    end

    class MapOfListsOfStrings
      def self.default(visited = [])
        return nil if visited.include?('MapOfListsOfStrings')
        visited = visited + ['MapOfListsOfStrings']
        {
          key: ListOfStrings.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::ListOfStrings.stub(value) unless value.nil?
        end
        data
      end
    end

    class MapOfMapOfStrings
      def self.default(visited = [])
        return nil if visited.include?('MapOfMapOfStrings')
        visited = visited + ['MapOfMapOfStrings']
        {
          key: MapOfStrings.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::MapOfStrings.stub(value) unless value.nil?
        end
        data
      end
    end

    class MapOfStrings
      def self.default(visited = [])
        return nil if visited.include?('MapOfStrings')
        visited = visited + ['MapOfStrings']
        {
          key: 'value'
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
          key: SimpleStruct.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::SimpleStruct.stub(value) unless value.nil?
        end
        data
      end
    end

    class MediaTypeHeader
      def self.build(params, context:)
        Params::MediaTypeHeaderOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::MediaTypeHeaderOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          json: 'json',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Json'] = ::Base64::encode64(stub[:json]).strip unless stub[:json].nil? || stub[:json].empty?
      end
    end

    class MyUnion
      def self.default(visited = [])
        return nil if visited.include?('MyUnion')
        visited = visited + ['MyUnion']
        {
          string_value: 'string_value',
        }
      end

      def self.stub(stub)
        data = {}
        case stub
        when Types::MyUnion::StringValue
          data[:string_value] = stub.__getobj__
        when Types::MyUnion::BooleanValue
          data[:boolean_value] = stub.__getobj__
        when Types::MyUnion::NumberValue
          data[:number_value] = stub.__getobj__
        when Types::MyUnion::BlobValue
          data[:blob_value] = ::Base64::encode64(stub.__getobj__)
        when Types::MyUnion::TimestampValue
          data[:timestamp_value] = Hearth::TimeHelper.to_date_time(stub.__getobj__)
        when Types::MyUnion::EnumValue
          data[:enum_value] = stub.__getobj__
        when Types::MyUnion::ListValue
          data[:list_value] = (Stubs::StringList.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        when Types::MyUnion::MapValue
          data[:map_value] = (Stubs::StringMap.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        when Types::MyUnion::StructureValue
          data[:structure_value] = (Stubs::GreetingStruct.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        when Types::MyUnion::RenamedStructureValue
          data[:renamed_structure_value] = (Stubs::RenamedGreeting.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::MyUnion"
        end

        data
      end
    end

    class NestedAttributesOperation
      def self.build(params, context:)
        Params::NestedAttributesOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NestedAttributesOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          value: 'value',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:value] = stub[:value] unless stub[:value].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class NestedPayload
      def self.default(visited = [])
        return nil if visited.include?('NestedPayload')
        visited = visited + ['NestedPayload']
        {
          greeting: 'greeting',
          name: 'name',
        }
      end

      def self.stub(stub)
        stub ||= Types::NestedPayload.new
        data = {}
        data[:greeting] = stub[:greeting] unless stub[:greeting].nil?
        data[:name] = stub[:name] unless stub[:name].nil?
        data
      end
    end

    class NullAndEmptyHeadersClient
      def self.build(params, context:)
        Params::NullAndEmptyHeadersClientOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NullAndEmptyHeadersClientOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          a: 'a',
          b: 'b',
          c: StringList.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-A'] = stub[:a] unless stub[:a].nil? || stub[:a].empty?
        http_resp.headers['X-B'] = stub[:b] unless stub[:b].nil? || stub[:b].empty?
        unless stub[:c].nil? || stub[:c].empty?
          http_resp.headers['X-C'] = stub[:c]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
      end
    end

    class NullOperation
      def self.build(params, context:)
        Params::NullOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NullOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string: 'string',
          sparse_string_list: SparseStringList.default(visited),
          sparse_string_map: SparseStringMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:string] = stub[:string] unless stub[:string].nil?
        data[:sparse_string_list] = Stubs::SparseStringList.stub(stub[:sparse_string_list]) unless stub[:sparse_string_list].nil?
        data[:sparse_string_map] = Stubs::SparseStringMap.stub(stub[:sparse_string_map]) unless stub[:sparse_string_map].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class OmitsNullSerializesEmptyString
      def self.build(params, context:)
        Params::OmitsNullSerializesEmptyStringOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OmitsNullSerializesEmptyStringOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class OperationWithOptionalInputOutput
      def self.build(params, context:)
        Params::OperationWithOptionalInputOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OperationWithOptionalInputOutputOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          value: 'value',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:value] = stub[:value] unless stub[:value].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class QueryIdempotencyTokenAutoFill
      def self.build(params, context:)
        Params::QueryIdempotencyTokenAutoFillOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::QueryIdempotencyTokenAutoFillOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class QueryParamsAsStringListMap
      def self.build(params, context:)
        Params::QueryParamsAsStringListMapOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::QueryParamsAsStringListMapOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class SimpleStruct
      def self.default(visited = [])
        return nil if visited.include?('SimpleStruct')
        visited = visited + ['SimpleStruct']
        {
          value: 'value',
        }
      end

      def self.stub(stub)
        stub ||= Types::SimpleStruct.new
        data = {}
        data[:value] = stub[:value] unless stub[:value].nil?
        data
      end
    end

    class SparseBooleanMap
      def self.default(visited = [])
        return nil if visited.include?('SparseBooleanMap')
        visited = visited + ['SparseBooleanMap']
        {
          key: false
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseNumberMap
      def self.default(visited = [])
        return nil if visited.include?('SparseNumberMap')
        visited = visited + ['SparseNumberMap']
        {
          key: 1
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseSetMap
      def self.default(visited = [])
        return nil if visited.include?('SparseSetMap')
        visited = visited + ['SparseSetMap']
        {
          key: StringSet.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = (Stubs::StringSet.stub(value) unless value.nil?)
        end
        data
      end
    end

    class SparseStringList
      def self.default(visited = [])
        return nil if visited.include?('SparseStringList')
        visited = visited + ['SparseStringList']
        [
          'member'
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << element
        end
        data
      end
    end

    class SparseStringMap
      def self.default(visited = [])
        return nil if visited.include?('SparseStringMap')
        visited = visited + ['SparseStringMap']
        {
          key: 'value'
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseStructMap
      def self.default(visited = [])
        return nil if visited.include?('SparseStructMap')
        visited = visited + ['SparseStructMap']
        {
          key: GreetingStruct.default(visited)
        }
      end

      def self.stub(stub)
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = (Stubs::GreetingStruct.stub(value) unless value.nil?)
        end
        data
      end
    end

    class StreamingOperation
      def self.build(params, context:)
        Params::StreamingOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingOperationOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          output: 'output',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        IO.copy_stream(stub[:output], http_resp.body)
      end
    end

    class StringList
      def self.default(visited = [])
        return nil if visited.include?('StringList')
        visited = visited + ['StringList']
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

    class StringMap
      def self.default(visited = [])
        return nil if visited.include?('StringMap')
        visited = visited + ['StringMap']
        {
          key: 'value'
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

    class StringSet
      def self.default(visited = [])
        return nil if visited.include?('StringSet')
        visited = visited + ['StringSet']
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

    class StructWithLocationName
      def self.default(visited = [])
        return nil if visited.include?('StructWithLocationName')
        visited = visited + ['StructWithLocationName']
        {
          value: 'value',
        }
      end

      def self.stub(stub)
        stub ||= Types::StructWithLocationName.new
        data = {}
        data['RenamedMember'] = stub[:value] unless stub[:value].nil?
        data
      end
    end

    class TimestampFormatHeaders
      def self.build(params, context:)
        Params::TimestampFormatHeadersOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::TimestampFormatHeadersOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          member_epoch_seconds: Time.now,
          member_http_date: Time.now,
          member_date_time: Time.now,
          default_format: Time.now,
          target_epoch_seconds: Time.now,
          target_http_date: Time.now,
          target_date_time: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-memberEpochSeconds'] = Hearth::TimeHelper.to_epoch_seconds(stub[:member_epoch_seconds]).to_i unless stub[:member_epoch_seconds].nil?
        http_resp.headers['X-memberHttpDate'] = Hearth::TimeHelper.to_http_date(stub[:member_http_date]) unless stub[:member_http_date].nil?
        http_resp.headers['X-memberDateTime'] = Hearth::TimeHelper.to_date_time(stub[:member_date_time]) unless stub[:member_date_time].nil?
        http_resp.headers['X-defaultFormat'] = Hearth::TimeHelper.to_date_time(stub[:default_format]) unless stub[:default_format].nil?
        http_resp.headers['X-targetEpochSeconds'] = Hearth::TimeHelper.to_epoch_seconds(stub[:target_epoch_seconds]).to_i unless stub[:target_epoch_seconds].nil?
        http_resp.headers['X-targetHttpDate'] = Hearth::TimeHelper.to_http_date(stub[:target_http_date]) unless stub[:target_http_date].nil?
        http_resp.headers['X-targetDateTime'] = Hearth::TimeHelper.to_date_time(stub[:target_date_time]) unless stub[:target_date_time].nil?
      end
    end

    class TimestampList
      def self.default(visited = [])
        return nil if visited.include?('TimestampList')
        visited = visited + ['TimestampList']
        [
          Time.now
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Hearth::TimeHelper.to_date_time(element) unless element.nil?
        end
        data
      end
    end

    class Struct____456efg
      def self.default(visited = [])
        return nil if visited.include?('Struct____456efg')
        visited = visited + ['Struct____456efg']
        {
          member___123foo: 'member___123foo',
        }
      end

      def self.stub(stub)
        stub ||= Types::Struct____456efg.new
        data = {}
        data[:__123foo] = stub[:member___123foo] unless stub[:member___123foo].nil?
        data
      end
    end

    class Operation____789BadName
      def self.build(params, context:)
        Params::Struct____789BadNameOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::Struct____789BadNameOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          member: Struct____456efg.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:member] = Stubs::Struct____456efg.stub(stub[:member]) unless stub[:member].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end
  end
end
