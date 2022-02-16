# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module RailsJson
  module Stubs

    # Operation Stubber for AllQueryStringTypes
    class AllQueryStringTypes

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for ConstantAndVariableQueryString
    class ConstantAndVariableQueryString

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for ConstantQueryString
    class ConstantQueryString

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for DocumentType
    class DocumentType

      def self.default(visited=[])
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
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Document Type Stubber for Document
    class Document
      def self.default(visited=[])
        return nil if visited.include?('Document')
        visited = visited + ['Document']
        { 'Document' => [0, 1, 2] }
      end

      def self.stub(stub = {})
        stub
      end
    end

    # Operation Stubber for DocumentTypeAsPayload
    class DocumentTypeAsPayload

      def self.default(visited=[])
        {
          document_value: nil,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        http_resp.body = StringIO.new(Hearth::JSON.dump(stub[:document_value]))
      end
    end

    # Operation Stubber for EmptyOperation
    class EmptyOperation

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for EndpointOperation
    class EndpointOperation

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for EndpointWithHostLabelOperation
    class EndpointWithHostLabelOperation

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for GreetingWithErrors
    class GreetingWithErrors

      def self.default(visited=[])
        {
          greeting: 'greeting',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:greeting] = stub[:greeting] unless stub[:greeting].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Operation Stubber for HttpPayloadTraits
    class HttpPayloadTraits

      def self.default(visited=[])
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
        http_resp.body = StringIO.new(stub[:blob] || '')
      end
    end

    # Operation Stubber for HttpPayloadTraitsWithMediaType
    class HttpPayloadTraitsWithMediaType

      def self.default(visited=[])
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
        http_resp.body = StringIO.new(stub[:blob] || '')
      end
    end

    # Operation Stubber for HttpPayloadWithStructure
    class HttpPayloadWithStructure

      def self.default(visited=[])
        {
          nested: Stubs::NestedPayload.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::NestedPayload.stub(stub[:nested]) unless stub[:nested].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Structure Stubber for NestedPayload
    class NestedPayload

      def self.default(visited=[])
        return nil if visited.include?('NestedPayload')
        visited = visited + ['NestedPayload']
        {
          greeting: 'greeting',
          member_name: 'member_name',
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data[:greeting] = stub[:greeting] unless stub[:greeting].nil?
        data[:name] = stub[:member_name] unless stub[:member_name].nil?
        data
      end
    end

    # Operation Stubber for HttpPrefixHeaders
    class HttpPrefixHeaders

      def self.default(visited=[])
        {
          foo: 'foo',
          foo_map: Stubs::StringMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Foo'] = stub[:foo] unless stub[:foo].nil? || stub[:foo].empty?
        stub[:foo_map].each do |key, value|
          http_resp.headers["X-Foo-#{key}"] = value unless value.nil? || value.empty?
        end
      end
    end

    # Map Stubber for StringMap
    class StringMap
      def self.default(visited=[])
        return nil if visited.include?('StringMap')
        visited = visited + ['StringMap']
        {
          test_key: 'value'
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    # Operation Stubber for HttpPrefixHeadersInResponse
    class HttpPrefixHeadersInResponse

      def self.default(visited=[])
        {
          prefix_headers: Stubs::StringMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        stub[:prefix_headers].each do |key, value|
          http_resp.headers["#{key}"] = value unless value.nil? || value.empty?
        end
      end
    end

    # Operation Stubber for HttpRequestWithFloatLabels
    class HttpRequestWithFloatLabels

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for HttpRequestWithGreedyLabelInPath
    class HttpRequestWithGreedyLabelInPath

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for HttpRequestWithLabels
    class HttpRequestWithLabels

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for HttpRequestWithLabelsAndTimestampFormat
    class HttpRequestWithLabelsAndTimestampFormat

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for HttpResponseCode
    class HttpResponseCode

      def self.default(visited=[])
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

    # Operation Stubber for IgnoreQueryParamsInResponse
    class IgnoreQueryParamsInResponse

      def self.default(visited=[])
        {
          baz: 'baz',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for InputAndOutputWithHeaders
    class InputAndOutputWithHeaders

      def self.default(visited=[])
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
          header_string_list: Stubs::StringList.default(visited),
          header_string_set: Stubs::StringSet.default(visited),
          header_integer_list: Stubs::IntegerList.default(visited),
          header_boolean_list: Stubs::BooleanList.default(visited),
          header_timestamp_list: Stubs::TimestampList.default(visited),
          header_enum: 'header_enum',
          header_enum_list: Stubs::FooEnumList.default(visited),
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
            .to_a
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

    # List Stubber for FooEnumList
    class FooEnumList
      def self.default(visited=[])
        return nil if visited.include?('FooEnumList')
        visited = visited + ['FooEnumList']
        [
          'member'
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    # List Stubber for TimestampList
    class TimestampList
      def self.default(visited=[])
        return nil if visited.include?('TimestampList')
        visited = visited + ['TimestampList']
        [
          Time.now
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << Hearth::TimeHelper.to_date_time(element) unless element.nil?
        end
        data
      end
    end

    # List Stubber for BooleanList
    class BooleanList
      def self.default(visited=[])
        return nil if visited.include?('BooleanList')
        visited = visited + ['BooleanList']
        [
          false
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    # List Stubber for IntegerList
    class IntegerList
      def self.default(visited=[])
        return nil if visited.include?('IntegerList')
        visited = visited + ['IntegerList']
        [
          1
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    # Set Stubber for StringSet
    class StringSet
      def self.default(visited=[])
        return nil if visited.include?('StringSet')
        visited = visited + ['StringSet']
        [
          'member'
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = Set.new
        stub.each do |element|
          data << element unless element.nil?
        end
        data.to_a
      end
    end

    # List Stubber for StringList
    class StringList
      def self.default(visited=[])
        return nil if visited.include?('StringList')
        visited = visited + ['StringList']
        [
          'member'
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    # Operation Stubber for JsonEnums
    class JsonEnums

      def self.default(visited=[])
        {
          foo_enum1: 'foo_enum1',
          foo_enum2: 'foo_enum2',
          foo_enum3: 'foo_enum3',
          foo_enum_list: Stubs::FooEnumList.default(visited),
          foo_enum_set: Stubs::FooEnumSet.default(visited),
          foo_enum_map: Stubs::FooEnumMap.default(visited),
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
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Map Stubber for FooEnumMap
    class FooEnumMap
      def self.default(visited=[])
        return nil if visited.include?('FooEnumMap')
        visited = visited + ['FooEnumMap']
        {
          test_key: 'value'
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    # Set Stubber for FooEnumSet
    class FooEnumSet
      def self.default(visited=[])
        return nil if visited.include?('FooEnumSet')
        visited = visited + ['FooEnumSet']
        [
          'member'
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = Set.new
        stub.each do |element|
          data << element unless element.nil?
        end
        data.to_a
      end
    end

    # Operation Stubber for JsonMaps
    class JsonMaps

      def self.default(visited=[])
        {
          dense_struct_map: Stubs::DenseStructMap.default(visited),
          sparse_struct_map: Stubs::SparseStructMap.default(visited),
          dense_number_map: Stubs::DenseNumberMap.default(visited),
          dense_boolean_map: Stubs::DenseBooleanMap.default(visited),
          dense_string_map: Stubs::DenseStringMap.default(visited),
          sparse_number_map: Stubs::SparseNumberMap.default(visited),
          sparse_boolean_map: Stubs::SparseBooleanMap.default(visited),
          sparse_string_map: Stubs::SparseStringMap.default(visited),
          dense_set_map: Stubs::DenseSetMap.default(visited),
          sparse_set_map: Stubs::SparseSetMap.default(visited),
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
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Map Stubber for SparseSetMap
    class SparseSetMap
      def self.default(visited=[])
        return nil if visited.include?('SparseSetMap')
        visited = visited + ['SparseSetMap']
        {
          test_key: Stubs::StringSet.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = (Stubs::StringSet.stub(value) unless value.nil?)
        end
        data
      end
    end

    # Map Stubber for DenseSetMap
    class DenseSetMap
      def self.default(visited=[])
        return nil if visited.include?('DenseSetMap')
        visited = visited + ['DenseSetMap']
        {
          test_key: Stubs::StringSet.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::StringSet.stub(value) unless value.nil?
        end
        data
      end
    end

    # Map Stubber for SparseStringMap
    class SparseStringMap
      def self.default(visited=[])
        return nil if visited.include?('SparseStringMap')
        visited = visited + ['SparseStringMap']
        {
          test_key: 'value'
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    # Map Stubber for SparseBooleanMap
    class SparseBooleanMap
      def self.default(visited=[])
        return nil if visited.include?('SparseBooleanMap')
        visited = visited + ['SparseBooleanMap']
        {
          test_key: false
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    # Map Stubber for SparseNumberMap
    class SparseNumberMap
      def self.default(visited=[])
        return nil if visited.include?('SparseNumberMap')
        visited = visited + ['SparseNumberMap']
        {
          test_key: 1
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    # Map Stubber for DenseStringMap
    class DenseStringMap
      def self.default(visited=[])
        return nil if visited.include?('DenseStringMap')
        visited = visited + ['DenseStringMap']
        {
          test_key: 'value'
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    # Map Stubber for DenseBooleanMap
    class DenseBooleanMap
      def self.default(visited=[])
        return nil if visited.include?('DenseBooleanMap')
        visited = visited + ['DenseBooleanMap']
        {
          test_key: false
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    # Map Stubber for DenseNumberMap
    class DenseNumberMap
      def self.default(visited=[])
        return nil if visited.include?('DenseNumberMap')
        visited = visited + ['DenseNumberMap']
        {
          test_key: 1
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    # Map Stubber for SparseStructMap
    class SparseStructMap
      def self.default(visited=[])
        return nil if visited.include?('SparseStructMap')
        visited = visited + ['SparseStructMap']
        {
          test_key: Stubs::GreetingStruct.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = (Stubs::GreetingStruct.stub(value) unless value.nil?)
        end
        data
      end
    end

    # Structure Stubber for GreetingStruct
    class GreetingStruct

      def self.default(visited=[])
        return nil if visited.include?('GreetingStruct')
        visited = visited + ['GreetingStruct']
        {
          hi: 'hi',
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data[:hi] = stub[:hi] unless stub[:hi].nil?
        data
      end
    end

    # Map Stubber for DenseStructMap
    class DenseStructMap
      def self.default(visited=[])
        return nil if visited.include?('DenseStructMap')
        visited = visited + ['DenseStructMap']
        {
          test_key: Stubs::GreetingStruct.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::GreetingStruct.stub(value) unless value.nil?
        end
        data
      end
    end

    # Operation Stubber for JsonUnions
    class JsonUnions

      def self.default(visited=[])
        {
          contents: Stubs::MyUnion.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:contents] = Stubs::MyUnion.stub(stub[:contents]) unless stub[:contents].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Union Stubber for MyUnion
    class MyUnion

      def self.default(visited=[])
        return nil if visited.include?('MyUnion')
        visited = visited + ['MyUnion']
        {
          string_value: 'string_value',
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data[:string_value] = stub[:string_value] unless stub[:string_value].nil?
        data[:boolean_value] = stub[:boolean_value] unless stub[:boolean_value].nil?
        data[:number_value] = stub[:number_value] unless stub[:number_value].nil?
        data[:blob_value] = Base64::encode64(stub[:blob_value]) unless stub[:blob_value].nil?
        data[:timestamp_value] = Hearth::TimeHelper.to_date_time(stub[:timestamp_value]) unless stub[:timestamp_value].nil?
        data[:enum_value] = stub[:enum_value] unless stub[:enum_value].nil?
        data[:list_value] = Stubs::StringList.stub(stub[:list_value]) unless stub[:list_value].nil?
        data[:map_value] = Stubs::StringMap.stub(stub[:map_value]) unless stub[:map_value].nil?
        data[:structure_value] = Stubs::GreetingStruct.stub(stub[:structure_value]) unless stub[:structure_value].nil?
        data
      end
    end

    # Operation Stubber for KitchenSinkOperation
    class KitchenSinkOperation

      def self.default(visited=[])
        {
          blob: 'blob',
          boolean: false,
          double: 1.0,
          empty_struct: Stubs::EmptyStruct.default(visited),
          float: 1.0,
          httpdate_timestamp: Time.now,
          integer: 1,
          iso8601_timestamp: Time.now,
          json_value: 'json_value',
          list_of_lists: Stubs::ListOfListOfStrings.default(visited),
          list_of_maps_of_strings: Stubs::ListOfMapsOfStrings.default(visited),
          list_of_strings: Stubs::ListOfStrings.default(visited),
          list_of_structs: Stubs::ListOfStructs.default(visited),
          long: 1,
          map_of_lists_of_strings: Stubs::MapOfListsOfStrings.default(visited),
          map_of_maps: Stubs::MapOfMapOfStrings.default(visited),
          map_of_strings: Stubs::MapOfStrings.default(visited),
          map_of_structs: Stubs::MapOfStructs.default(visited),
          recursive_list: Stubs::ListOfKitchenSinks.default(visited),
          recursive_map: Stubs::MapOfKitchenSinks.default(visited),
          recursive_struct: Stubs::KitchenSink.default(visited),
          simple_struct: Stubs::SimpleStruct.default(visited),
          string: 'string',
          struct_with_location_name: Stubs::StructWithLocationName.default(visited),
          timestamp: Time.now,
          unix_timestamp: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:blob] = Base64::encode64(stub[:blob]) unless stub[:blob].nil?
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
        data[:unix_timestamp] = Hearth::TimeHelper.to_epoch_seconds(stub[:unix_timestamp]) unless stub[:unix_timestamp].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Structure Stubber for StructWithLocationName
    class StructWithLocationName

      def self.default(visited=[])
        return nil if visited.include?('StructWithLocationName')
        visited = visited + ['StructWithLocationName']
        {
          value: 'value',
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data['RenamedMember'] = stub[:value] unless stub[:value].nil?
        data
      end
    end

    # Structure Stubber for SimpleStruct
    class SimpleStruct

      def self.default(visited=[])
        return nil if visited.include?('SimpleStruct')
        visited = visited + ['SimpleStruct']
        {
          value: 'value',
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data[:value] = stub[:value] unless stub[:value].nil?
        data
      end
    end

    # Structure Stubber for KitchenSink
    class KitchenSink

      def self.default(visited=[])
        return nil if visited.include?('KitchenSink')
        visited = visited + ['KitchenSink']
        {
          blob: 'blob',
          boolean: false,
          double: 1.0,
          empty_struct: Stubs::EmptyStruct.default(visited),
          float: 1.0,
          httpdate_timestamp: Time.now,
          integer: 1,
          iso8601_timestamp: Time.now,
          json_value: 'json_value',
          list_of_lists: Stubs::ListOfListOfStrings.default(visited),
          list_of_maps_of_strings: Stubs::ListOfMapsOfStrings.default(visited),
          list_of_strings: Stubs::ListOfStrings.default(visited),
          list_of_structs: Stubs::ListOfStructs.default(visited),
          long: 1,
          map_of_lists_of_strings: Stubs::MapOfListsOfStrings.default(visited),
          map_of_maps: Stubs::MapOfMapOfStrings.default(visited),
          map_of_strings: Stubs::MapOfStrings.default(visited),
          map_of_structs: Stubs::MapOfStructs.default(visited),
          recursive_list: Stubs::ListOfKitchenSinks.default(visited),
          recursive_map: Stubs::MapOfKitchenSinks.default(visited),
          recursive_struct: Stubs::KitchenSink.default(visited),
          simple_struct: Stubs::SimpleStruct.default(visited),
          string: 'string',
          struct_with_location_name: Stubs::StructWithLocationName.default(visited),
          timestamp: Time.now,
          unix_timestamp: Time.now,
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data[:blob] = Base64::encode64(stub[:blob]) unless stub[:blob].nil?
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
        data[:unix_timestamp] = Hearth::TimeHelper.to_epoch_seconds(stub[:unix_timestamp]) unless stub[:unix_timestamp].nil?
        data
      end
    end

    # Map Stubber for MapOfKitchenSinks
    class MapOfKitchenSinks
      def self.default(visited=[])
        return nil if visited.include?('MapOfKitchenSinks')
        visited = visited + ['MapOfKitchenSinks']
        {
          test_key: Stubs::KitchenSink.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::KitchenSink.stub(value) unless value.nil?
        end
        data
      end
    end

    # List Stubber for ListOfKitchenSinks
    class ListOfKitchenSinks
      def self.default(visited=[])
        return nil if visited.include?('ListOfKitchenSinks')
        visited = visited + ['ListOfKitchenSinks']
        [
          Stubs::KitchenSink.default(visited)
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::KitchenSink.stub(element) unless element.nil?
        end
        data
      end
    end

    # Map Stubber for MapOfStructs
    class MapOfStructs
      def self.default(visited=[])
        return nil if visited.include?('MapOfStructs')
        visited = visited + ['MapOfStructs']
        {
          test_key: Stubs::SimpleStruct.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::SimpleStruct.stub(value) unless value.nil?
        end
        data
      end
    end

    # Map Stubber for MapOfStrings
    class MapOfStrings
      def self.default(visited=[])
        return nil if visited.include?('MapOfStrings')
        visited = visited + ['MapOfStrings']
        {
          test_key: 'value'
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    # Map Stubber for MapOfMapOfStrings
    class MapOfMapOfStrings
      def self.default(visited=[])
        return nil if visited.include?('MapOfMapOfStrings')
        visited = visited + ['MapOfMapOfStrings']
        {
          test_key: Stubs::MapOfStrings.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::MapOfStrings.stub(value) unless value.nil?
        end
        data
      end
    end

    # Map Stubber for MapOfListsOfStrings
    class MapOfListsOfStrings
      def self.default(visited=[])
        return nil if visited.include?('MapOfListsOfStrings')
        visited = visited + ['MapOfListsOfStrings']
        {
          test_key: Stubs::ListOfStrings.default(visited)
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::ListOfStrings.stub(value) unless value.nil?
        end
        data
      end
    end

    # List Stubber for ListOfStrings
    class ListOfStrings
      def self.default(visited=[])
        return nil if visited.include?('ListOfStrings')
        visited = visited + ['ListOfStrings']
        [
          'member'
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    # List Stubber for ListOfStructs
    class ListOfStructs
      def self.default(visited=[])
        return nil if visited.include?('ListOfStructs')
        visited = visited + ['ListOfStructs']
        [
          Stubs::SimpleStruct.default(visited)
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::SimpleStruct.stub(element) unless element.nil?
        end
        data
      end
    end

    # List Stubber for ListOfMapsOfStrings
    class ListOfMapsOfStrings
      def self.default(visited=[])
        return nil if visited.include?('ListOfMapsOfStrings')
        visited = visited + ['ListOfMapsOfStrings']
        [
          Stubs::MapOfStrings.default(visited)
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::MapOfStrings.stub(element) unless element.nil?
        end
        data
      end
    end

    # List Stubber for ListOfListOfStrings
    class ListOfListOfStrings
      def self.default(visited=[])
        return nil if visited.include?('ListOfListOfStrings')
        visited = visited + ['ListOfListOfStrings']
        [
          Stubs::ListOfStrings.default(visited)
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::ListOfStrings.stub(element) unless element.nil?
        end
        data
      end
    end

    # Structure Stubber for EmptyStruct
    class EmptyStruct

      def self.default(visited=[])
        return nil if visited.include?('EmptyStruct')
        visited = visited + ['EmptyStruct']
        {
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data
      end
    end

    # Operation Stubber for MediaTypeHeader
    class MediaTypeHeader

      def self.default(visited=[])
        {
          json: 'json',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Json'] = Base64::encode64(stub[:json]).strip unless stub[:json].nil? || stub[:json].empty?
      end
    end

    # Operation Stubber for NestedAttributesOperation
    class NestedAttributesOperation

      def self.default(visited=[])
        {
          value: 'value',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:value] = stub[:value] unless stub[:value].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Operation Stubber for NullAndEmptyHeadersClient
    class NullAndEmptyHeadersClient

      def self.default(visited=[])
        {
          a: 'a',
          b: 'b',
          c: Stubs::StringList.default(visited),
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

    # Operation Stubber for NullOperation
    class NullOperation

      def self.default(visited=[])
        {
          string: 'string',
          sparse_string_list: Stubs::SparseStringList.default(visited),
          sparse_string_map: Stubs::SparseStringMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:string] = stub[:string] unless stub[:string].nil?
        data[:sparse_string_list] = Stubs::SparseStringList.stub(stub[:sparse_string_list]) unless stub[:sparse_string_list].nil?
        data[:sparse_string_map] = Stubs::SparseStringMap.stub(stub[:sparse_string_map]) unless stub[:sparse_string_map].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # List Stubber for SparseStringList
    class SparseStringList
      def self.default(visited=[])
        return nil if visited.include?('SparseStringList')
        visited = visited + ['SparseStringList']
        [
          'member'
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << element
        end
        data
      end
    end

    # Operation Stubber for OmitsNullSerializesEmptyString
    class OmitsNullSerializesEmptyString

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for OperationWithOptionalInputOutput
    class OperationWithOptionalInputOutput

      def self.default(visited=[])
        {
          value: 'value',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:value] = stub[:value] unless stub[:value].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Operation Stubber for QueryIdempotencyTokenAutoFill
    class QueryIdempotencyTokenAutoFill

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for QueryParamsAsStringListMap
    class QueryParamsAsStringListMap

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for TimestampFormatHeaders
    class TimestampFormatHeaders

      def self.default(visited=[])
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
        http_resp.headers['X-defaultFormat'] = Hearth::TimeHelper.to_http_date(stub[:default_format]) unless stub[:default_format].nil?
        http_resp.headers['X-targetEpochSeconds'] = Hearth::TimeHelper.to_epoch_seconds(stub[:target_epoch_seconds]).to_i unless stub[:target_epoch_seconds].nil?
        http_resp.headers['X-targetHttpDate'] = Hearth::TimeHelper.to_http_date(stub[:target_http_date]) unless stub[:target_http_date].nil?
        http_resp.headers['X-targetDateTime'] = Hearth::TimeHelper.to_date_time(stub[:target_date_time]) unless stub[:target_date_time].nil?
      end
    end

    # Operation Stubber for __789BadName
    class Operation____789BadName

      def self.default(visited=[])
        {
          member: Stubs::Struct____456efg.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:member] = Stubs::Struct____456efg.stub(stub[:member]) unless stub[:member].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Structure Stubber for __456efg
    class Struct____456efg

      def self.default(visited=[])
        return nil if visited.include?('Struct____456efg')
        visited = visited + ['Struct____456efg']
        {
          member____123foo: 'member____123foo',
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data[:__123foo] = stub[:member____123foo] unless stub[:member____123foo].nil?
        data
      end
    end
  end
end
