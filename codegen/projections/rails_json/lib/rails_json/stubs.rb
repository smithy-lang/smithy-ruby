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
          header: 'header',
          top_level: 'top_level',
          nested: ComplexNestedErrorData.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 403
        http_resp.headers['X-Header'] = stub[:header] unless stub[:header].nil? || stub[:header].empty?
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

    class DatetimeOffsets
      def self.build(params, context:)
        Params::DatetimeOffsetsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DatetimeOffsetsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          datetime: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:datetime] = Hearth::TimeHelper.to_date_time(stub[:datetime]) unless stub[:datetime].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
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

    class DocumentTypeAsMapValue
      def self.build(params, context:)
        Params::DocumentTypeAsMapValueOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::DocumentTypeAsMapValueOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          doc_valued_map: DocumentValuedMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:doc_valued_map] = Stubs::DocumentValuedMap.stub(stub[:doc_valued_map]) unless stub[:doc_valued_map].nil?
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

    class DocumentValuedMap
      def self.default(visited = [])
        return nil if visited.include?('DocumentValuedMap')
        visited = visited + ['DocumentValuedMap']
        {
          key: nil
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

    class EmptyInputAndEmptyOutput
      def self.build(params, context:)
        Params::EmptyInputAndEmptyOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::EmptyInputAndEmptyOutputOutput.validate!(output, context: context)
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

    class FooError
      def self.build(params, context:)
        Params::FooError.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::FooError.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 500
      end
    end

    class FractionalSeconds
      def self.build(params, context:)
        Params::FractionalSecondsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::FractionalSecondsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          datetime: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:datetime] = Hearth::TimeHelper.to_date_time(stub[:datetime]) unless stub[:datetime].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
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
        http_resp.headers['X-Greeting'] = stub[:greeting] unless stub[:greeting].nil? || stub[:greeting].empty?
      end
    end

    class HostWithPathOperation
      def self.build(params, context:)
        Params::HostWithPathOperationOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HostWithPathOperationOutput.validate!(output, context: context)
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

    class HttpChecksumRequired
      def self.build(params, context:)
        Params::HttpChecksumRequiredOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpChecksumRequiredOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          foo: 'foo',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:foo] = stub[:foo] unless stub[:foo].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class HttpEnumPayload
      def self.build(params, context:)
        Params::HttpEnumPayloadOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpEnumPayloadOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          payload: 'payload',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'text/plain'
        http_resp.body.write(stub[:payload] || '')
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

    class HttpPayloadWithUnion
      def self.build(params, context:)
        Params::HttpPayloadWithUnionOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpPayloadWithUnionOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          nested: UnionPayload.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::UnionPayload.stub(stub[:nested]) unless stub[:nested].nil?
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

    class HttpRequestWithRegexLiteral
      def self.build(params, context:)
        Params::HttpRequestWithRegexLiteralOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpRequestWithRegexLiteralOutput.validate!(output, context: context)
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

    class HttpStringPayload
      def self.build(params, context:)
        Params::HttpStringPayloadOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::HttpStringPayloadOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          payload: 'payload',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'text/plain'
        http_resp.body.write(stub[:payload] || '')
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
          header_integer_enum: 1,
          header_integer_enum_list: IntegerEnumList.default(visited),
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
            .map { |s| Hearth::TimeHelper.to_http_date(s) }
            .join(', ')
        end
        http_resp.headers['X-Enum'] = stub[:header_enum] unless stub[:header_enum].nil? || stub[:header_enum].empty?
        unless stub[:header_enum_list].nil? || stub[:header_enum_list].empty?
          http_resp.headers['X-EnumList'] = stub[:header_enum_list]
            .compact
            .map { |s| (s.include?('"') || s.include?(",")) ? "\"#{s.gsub('"', '\"')}\"" : s }
            .join(', ')
        end
        http_resp.headers['X-IntegerEnum'] = stub[:header_integer_enum].to_s unless stub[:header_integer_enum].nil?
        unless stub[:header_integer_enum_list].nil? || stub[:header_integer_enum_list].empty?
          http_resp.headers['X-IntegerEnumList'] = stub[:header_integer_enum_list]
            .compact
            .map { |s| s.to_s }
            .join(', ')
        end
      end
    end

    class IntegerEnumList
      def self.default(visited = [])
        return nil if visited.include?('IntegerEnumList')
        visited = visited + ['IntegerEnumList']
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

    class IntegerEnumMap
      def self.default(visited = [])
        return nil if visited.include?('IntegerEnumMap')
        visited = visited + ['IntegerEnumMap']
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

    class IntegerEnumSet
      def self.default(visited = [])
        return nil if visited.include?('IntegerEnumSet')
        visited = visited + ['IntegerEnumSet']
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
        http_resp.headers['Content-Type'] = 'application/json'
        data[:message] = stub[:message] unless stub[:message].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class JsonBlobs
      def self.build(params, context:)
        Params::JsonBlobsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::JsonBlobsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          data: 'data',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:data] = ::Base64::encode64(stub[:data]) unless stub[:data].nil?
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

    class JsonIntEnums
      def self.build(params, context:)
        Params::JsonIntEnumsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::JsonIntEnumsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          integer_enum1: 1,
          integer_enum2: 1,
          integer_enum3: 1,
          integer_enum_list: IntegerEnumList.default(visited),
          integer_enum_set: IntegerEnumSet.default(visited),
          integer_enum_map: IntegerEnumMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:integer_enum1] = stub[:integer_enum1] unless stub[:integer_enum1].nil?
        data[:integer_enum2] = stub[:integer_enum2] unless stub[:integer_enum2].nil?
        data[:integer_enum3] = stub[:integer_enum3] unless stub[:integer_enum3].nil?
        data[:integer_enum_list] = Stubs::IntegerEnumList.stub(stub[:integer_enum_list]) unless stub[:integer_enum_list].nil?
        data[:integer_enum_set] = Stubs::IntegerEnumSet.stub(stub[:integer_enum_set]) unless stub[:integer_enum_set].nil?
        data[:integer_enum_map] = Stubs::IntegerEnumMap.stub(stub[:integer_enum_map]) unless stub[:integer_enum_map].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class JsonLists
      def self.build(params, context:)
        Params::JsonListsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::JsonListsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          string_list: StringList.default(visited),
          string_set: StringSet.default(visited),
          integer_list: IntegerList.default(visited),
          boolean_list: BooleanList.default(visited),
          timestamp_list: TimestampList.default(visited),
          enum_list: FooEnumList.default(visited),
          int_enum_list: IntegerEnumList.default(visited),
          nested_string_list: NestedStringList.default(visited),
          structure_list: StructureList.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:string_list] = Stubs::StringList.stub(stub[:string_list]) unless stub[:string_list].nil?
        data[:string_set] = Stubs::StringSet.stub(stub[:string_set]) unless stub[:string_set].nil?
        data[:integer_list] = Stubs::IntegerList.stub(stub[:integer_list]) unless stub[:integer_list].nil?
        data[:boolean_list] = Stubs::BooleanList.stub(stub[:boolean_list]) unless stub[:boolean_list].nil?
        data[:timestamp_list] = Stubs::TimestampList.stub(stub[:timestamp_list]) unless stub[:timestamp_list].nil?
        data[:enum_list] = Stubs::FooEnumList.stub(stub[:enum_list]) unless stub[:enum_list].nil?
        data[:int_enum_list] = Stubs::IntegerEnumList.stub(stub[:int_enum_list]) unless stub[:int_enum_list].nil?
        data[:nested_string_list] = Stubs::NestedStringList.stub(stub[:nested_string_list]) unless stub[:nested_string_list].nil?
        data['myStructureList'] = Stubs::StructureList.stub(stub[:structure_list]) unless stub[:structure_list].nil?
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
          dense_number_map: DenseNumberMap.default(visited),
          dense_boolean_map: DenseBooleanMap.default(visited),
          dense_string_map: DenseStringMap.default(visited),
          dense_set_map: DenseSetMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:dense_struct_map] = Stubs::DenseStructMap.stub(stub[:dense_struct_map]) unless stub[:dense_struct_map].nil?
        data[:dense_number_map] = Stubs::DenseNumberMap.stub(stub[:dense_number_map]) unless stub[:dense_number_map].nil?
        data[:dense_boolean_map] = Stubs::DenseBooleanMap.stub(stub[:dense_boolean_map]) unless stub[:dense_boolean_map].nil?
        data[:dense_string_map] = Stubs::DenseStringMap.stub(stub[:dense_string_map]) unless stub[:dense_string_map].nil?
        data[:dense_set_map] = Stubs::DenseSetMap.stub(stub[:dense_set_map]) unless stub[:dense_set_map].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class JsonTimestamps
      def self.build(params, context:)
        Params::JsonTimestampsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::JsonTimestampsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          normal: Time.now,
          date_time: Time.now,
          date_time_on_target: Time.now,
          epoch_seconds: Time.now,
          epoch_seconds_on_target: Time.now,
          http_date: Time.now,
          http_date_on_target: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:normal] = Hearth::TimeHelper.to_date_time(stub[:normal]) unless stub[:normal].nil?
        data[:date_time] = Hearth::TimeHelper.to_date_time(stub[:date_time]) unless stub[:date_time].nil?
        data[:date_time_on_target] = Hearth::TimeHelper.to_date_time(stub[:date_time_on_target]) unless stub[:date_time_on_target].nil?
        data[:epoch_seconds] = Hearth::TimeHelper.to_epoch_seconds(stub[:epoch_seconds]).to_i unless stub[:epoch_seconds].nil?
        data[:epoch_seconds_on_target] = Hearth::TimeHelper.to_epoch_seconds(stub[:epoch_seconds_on_target]).to_i unless stub[:epoch_seconds_on_target].nil?
        data[:http_date] = Hearth::TimeHelper.to_http_date(stub[:http_date]) unless stub[:http_date].nil?
        data[:http_date_on_target] = Hearth::TimeHelper.to_http_date(stub[:http_date_on_target]) unless stub[:http_date_on_target].nil?
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

    class NestedStringList
      def self.default(visited = [])
        return nil if visited.include?('NestedStringList')
        visited = visited + ['NestedStringList']
        [
          StringList.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::StringList.stub(element) unless element.nil?
        end
        data
      end
    end

    class NoInputAndNoOutput
      def self.build(params, context:)
        Params::NoInputAndNoOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NoInputAndNoOutputOutput.validate!(output, context: context)
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

    class NoInputAndOutput
      def self.build(params, context:)
        Params::NoInputAndOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NoInputAndOutputOutput.validate!(output, context: context)
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

    class NullAndEmptyHeadersServer
      def self.build(params, context:)
        Params::NullAndEmptyHeadersServerOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::NullAndEmptyHeadersServerOutput.validate!(output, context: context)
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

    class OmitsSerializingEmptyLists
      def self.build(params, context:)
        Params::OmitsSerializingEmptyListsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::OmitsSerializingEmptyListsOutput.validate!(output, context: context)
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

    class PayloadConfig
      def self.default(visited = [])
        return nil if visited.include?('PayloadConfig')
        visited = visited + ['PayloadConfig']
        {
          data: 1,
        }
      end

      def self.stub(stub)
        stub ||= Types::PayloadConfig.new
        data = {}
        data[:data] = stub[:data] unless stub[:data].nil?
        data
      end
    end

    class PlayerAction
      def self.default(visited = [])
        return nil if visited.include?('PlayerAction')
        visited = visited + ['PlayerAction']
        {
          quit: Unit.default(visited),
        }
      end

      def self.stub(stub)
        data = {}
        case stub
        when Types::PlayerAction::Quit
          data[:quit] = (Stubs::Unit.stub(stub.__getobj__) unless stub.__getobj__.nil?)
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::PlayerAction"
        end

        data
      end
    end

    class PostPlayerAction
      def self.build(params, context:)
        Params::PostPlayerActionOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::PostPlayerActionOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          action: PlayerAction.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:action] = Stubs::PlayerAction.stub(stub[:action]) unless stub[:action].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class PostUnionWithJsonName
      def self.build(params, context:)
        Params::PostUnionWithJsonNameOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::PostUnionWithJsonNameOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          value: UnionWithJsonName.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:value] = Stubs::UnionWithJsonName.stub(stub[:value]) unless stub[:value].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class PutWithContentEncoding
      def self.build(params, context:)
        Params::PutWithContentEncodingOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::PutWithContentEncodingOutput.validate!(output, context: context)
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

    class QueryPrecedence
      def self.build(params, context:)
        Params::QueryPrecedenceOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::QueryPrecedenceOutput.validate!(output, context: context)
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

    class RecursiveShapes
      def self.build(params, context:)
        Params::RecursiveShapesOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::RecursiveShapesOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          nested: RecursiveShapesInputOutputNested1.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:nested] = Stubs::RecursiveShapesInputOutputNested1.stub(stub[:nested]) unless stub[:nested].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.default(visited = [])
        return nil if visited.include?('RecursiveShapesInputOutputNested1')
        visited = visited + ['RecursiveShapesInputOutputNested1']
        {
          foo: 'foo',
          nested: RecursiveShapesInputOutputNested2.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::RecursiveShapesInputOutputNested1.new
        data = {}
        data[:foo] = stub[:foo] unless stub[:foo].nil?
        data[:nested] = Stubs::RecursiveShapesInputOutputNested2.stub(stub[:nested]) unless stub[:nested].nil?
        data
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.default(visited = [])
        return nil if visited.include?('RecursiveShapesInputOutputNested2')
        visited = visited + ['RecursiveShapesInputOutputNested2']
        {
          bar: 'bar',
          recursive_member: RecursiveShapesInputOutputNested1.default(visited),
        }
      end

      def self.stub(stub)
        stub ||= Types::RecursiveShapesInputOutputNested2.new
        data = {}
        data[:bar] = stub[:bar] unless stub[:bar].nil?
        data[:recursive_member] = Stubs::RecursiveShapesInputOutputNested1.stub(stub[:recursive_member]) unless stub[:recursive_member].nil?
        data
      end
    end

    class SimpleScalarProperties
      def self.build(params, context:)
        Params::SimpleScalarPropertiesOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::SimpleScalarPropertiesOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          foo: 'foo',
          string_value: 'string_value',
          true_boolean_value: false,
          false_boolean_value: false,
          byte_value: 1,
          short_value: 1,
          integer_value: 1,
          long_value: 1,
          float_value: 1.0,
          double_value: 1.0,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Foo'] = stub[:foo] unless stub[:foo].nil? || stub[:foo].empty?
        http_resp.headers['Content-Type'] = 'application/json'
        data[:string_value] = stub[:string_value] unless stub[:string_value].nil?
        data[:true_boolean_value] = stub[:true_boolean_value] unless stub[:true_boolean_value].nil?
        data[:false_boolean_value] = stub[:false_boolean_value] unless stub[:false_boolean_value].nil?
        data[:byte_value] = stub[:byte_value] unless stub[:byte_value].nil?
        data[:short_value] = stub[:short_value] unless stub[:short_value].nil?
        data[:integer_value] = stub[:integer_value] unless stub[:integer_value].nil?
        data[:long_value] = stub[:long_value] unless stub[:long_value].nil?
        data[:float_value] = stub[:float_value] unless stub[:float_value].nil?
        data['DoubleDribble'] = stub[:double_value] unless stub[:double_value].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
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

    class SparseJsonLists
      def self.build(params, context:)
        Params::SparseJsonListsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::SparseJsonListsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          sparse_string_list: SparseStringList.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:sparse_string_list] = Stubs::SparseStringList.stub(stub[:sparse_string_list]) unless stub[:sparse_string_list].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class SparseJsonMaps
      def self.build(params, context:)
        Params::SparseJsonMapsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::SparseJsonMapsOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          sparse_struct_map: SparseStructMap.default(visited),
          sparse_number_map: SparseNumberMap.default(visited),
          sparse_boolean_map: SparseBooleanMap.default(visited),
          sparse_string_map: SparseStringMap.default(visited),
          sparse_set_map: SparseSetMap.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data[:sparse_struct_map] = Stubs::SparseStructMap.stub(stub[:sparse_struct_map]) unless stub[:sparse_struct_map].nil?
        data[:sparse_number_map] = Stubs::SparseNumberMap.stub(stub[:sparse_number_map]) unless stub[:sparse_number_map].nil?
        data[:sparse_boolean_map] = Stubs::SparseBooleanMap.stub(stub[:sparse_boolean_map]) unless stub[:sparse_boolean_map].nil?
        data[:sparse_string_map] = Stubs::SparseStringMap.stub(stub[:sparse_string_map]) unless stub[:sparse_string_map].nil?
        data[:sparse_set_map] = Stubs::SparseSetMap.stub(stub[:sparse_set_map]) unless stub[:sparse_set_map].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
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

    class StreamingTraits
      def self.build(params, context:)
        Params::StreamingTraitsOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingTraitsOutput.validate!(output, context: context)
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
        IO.copy_stream(stub[:blob], http_resp.body)
      end
    end

    class StreamingTraitsRequireLength
      def self.build(params, context:)
        Params::StreamingTraitsRequireLengthOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingTraitsRequireLengthOutput.validate!(output, context: context)
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

    class StreamingTraitsWithMediaType
      def self.build(params, context:)
        Params::StreamingTraitsWithMediaTypeOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::StreamingTraitsWithMediaTypeOutput.validate!(output, context: context)
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
        IO.copy_stream(stub[:blob], http_resp.body)
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

    class StructureList
      def self.default(visited = [])
        return nil if visited.include?('StructureList')
        visited = visited + ['StructureList']
        [
          StructureListMember.default(visited)
        ]
      end

      def self.stub(stub)
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::StructureListMember.stub(element) unless element.nil?
        end
        data
      end
    end

    class StructureListMember
      def self.default(visited = [])
        return nil if visited.include?('StructureListMember')
        visited = visited + ['StructureListMember']
        {
          a: 'a',
          b: 'b',
        }
      end

      def self.stub(stub)
        stub ||= Types::StructureListMember.new
        data = {}
        data['value'] = stub[:a] unless stub[:a].nil?
        data['other'] = stub[:b] unless stub[:b].nil?
        data
      end
    end

    class TestBodyStructure
      def self.build(params, context:)
        Params::TestBodyStructureOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::TestBodyStructureOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          test_id: 'test_id',
          test_config: TestConfig.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['x-amz-test-id'] = stub[:test_id] unless stub[:test_id].nil? || stub[:test_id].empty?
        http_resp.headers['Content-Type'] = 'application/json'
        data[:test_config] = Stubs::TestConfig.stub(stub[:test_config]) unless stub[:test_config].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
      end
    end

    class TestConfig
      def self.default(visited = [])
        return nil if visited.include?('TestConfig')
        visited = visited + ['TestConfig']
        {
          timeout: 1,
        }
      end

      def self.stub(stub)
        stub ||= Types::TestConfig.new
        data = {}
        data[:timeout] = stub[:timeout] unless stub[:timeout].nil?
        data
      end
    end

    class TestNoPayload
      def self.build(params, context:)
        Params::TestNoPayloadOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::TestNoPayloadOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          test_id: 'test_id',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['X-Amz-Test-Id'] = stub[:test_id] unless stub[:test_id].nil? || stub[:test_id].empty?
      end
    end

    class TestPayloadBlob
      def self.build(params, context:)
        Params::TestPayloadBlobOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::TestPayloadBlobOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          content_type: 'content_type',
          data: 'data',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = stub[:content_type] unless stub[:content_type].nil? || stub[:content_type].empty?
        http_resp.headers['Content-Type'] = 'application/octet-stream'
        http_resp.body.write(stub[:data] || '')
      end
    end

    class TestPayloadStructure
      def self.build(params, context:)
        Params::TestPayloadStructureOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::TestPayloadStructureOutput.validate!(output, context: context)
      end

      def self.default(visited = [])
        {
          test_id: 'test_id',
          payload_config: PayloadConfig.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['x-amz-test-id'] = stub[:test_id] unless stub[:test_id].nil? || stub[:test_id].empty?
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::PayloadConfig.stub(stub[:payload_config]) unless stub[:payload_config].nil?
        http_resp.body.write(Hearth::JSON.dump(data))
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
        http_resp.headers['X-defaultFormat'] = Hearth::TimeHelper.to_http_date(stub[:default_format]) unless stub[:default_format].nil?
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

    class UnionPayload
      def self.default(visited = [])
        return nil if visited.include?('UnionPayload')
        visited = visited + ['UnionPayload']
        {
          greeting: 'greeting',
        }
      end

      def self.stub(stub)
        data = {}
        case stub
        when Types::UnionPayload::Greeting
          data[:greeting] = stub.__getobj__
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::UnionPayload"
        end

        data
      end
    end

    class UnionWithJsonName
      def self.default(visited = [])
        return nil if visited.include?('UnionWithJsonName')
        visited = visited + ['UnionWithJsonName']
        {
          foo: 'foo',
        }
      end

      def self.stub(stub)
        data = {}
        case stub
        when Types::UnionWithJsonName::Foo
          data[:foo] = stub.__getobj__
        when Types::UnionWithJsonName::Bar
          data[:bar] = stub.__getobj__
        when Types::UnionWithJsonName::Baz
          data[:baz] = stub.__getobj__
        else
          raise ArgumentError,
          "Expected input to be one of the subclasses of Types::UnionWithJsonName"
        end

        data
      end
    end

    class Unit
      def self.default(visited = [])
        return nil if visited.include?('Unit')
        visited = visited + ['Unit']
        {
        }
      end

      def self.stub(stub)
        stub ||= Types::Unit.new
        data = {}
        data
      end
    end

    class UnitInputAndOutput
      def self.build(params, context:)
        Params::UnitInputAndOutputOutput.build(params, context: context)
      end

      def self.validate!(output, context:)
        Validators::UnitInputAndOutputOutput.validate!(output, context: context)
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
  end
end
