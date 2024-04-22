# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'securerandom'

module RailsJson
  # @api private
  module Params

    class AllQueryStringTypesInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::AllQueryStringTypesInput, context: context)
        type = Types::AllQueryStringTypesInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.query_string = params[:query_string]
        type.query_string_list = StringList.build(params[:query_string_list], context: "#{context}[:query_string_list]") unless params[:query_string_list].nil?
        type.query_string_set = StringSet.build(params[:query_string_set], context: "#{context}[:query_string_set]") unless params[:query_string_set].nil?
        type.query_byte = params[:query_byte]
        type.query_short = params[:query_short]
        type.query_integer = params[:query_integer]
        type.query_integer_list = IntegerList.build(params[:query_integer_list], context: "#{context}[:query_integer_list]") unless params[:query_integer_list].nil?
        type.query_integer_set = IntegerSet.build(params[:query_integer_set], context: "#{context}[:query_integer_set]") unless params[:query_integer_set].nil?
        type.query_long = params[:query_long]
        type.query_float = params[:query_float]&.to_f
        type.query_double = params[:query_double]&.to_f
        type.query_double_list = DoubleList.build(params[:query_double_list], context: "#{context}[:query_double_list]") unless params[:query_double_list].nil?
        type.query_boolean = params[:query_boolean]
        type.query_boolean_list = BooleanList.build(params[:query_boolean_list], context: "#{context}[:query_boolean_list]") unless params[:query_boolean_list].nil?
        type.query_timestamp = params[:query_timestamp]
        type.query_timestamp_list = TimestampList.build(params[:query_timestamp_list], context: "#{context}[:query_timestamp_list]") unless params[:query_timestamp_list].nil?
        type.query_enum = params[:query_enum]
        type.query_enum_list = FooEnumList.build(params[:query_enum_list], context: "#{context}[:query_enum_list]") unless params[:query_enum_list].nil?
        type.query_integer_enum = params[:query_integer_enum]
        type.query_integer_enum_list = IntegerEnumList.build(params[:query_integer_enum_list], context: "#{context}[:query_integer_enum_list]") unless params[:query_integer_enum_list].nil?
        type.query_params_map_of_string_list = StringListMap.build(params[:query_params_map_of_string_list], context: "#{context}[:query_params_map_of_string_list]") unless params[:query_params_map_of_string_list].nil?
        type
      end
    end

    class AllQueryStringTypesOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::AllQueryStringTypesOutput, context: context)
        type = Types::AllQueryStringTypesOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class BooleanList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class ComplexError
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ComplexError, context: context)
        type = Types::ComplexError.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.header = params[:header]
        type.top_level = params[:top_level]
        type.nested = ComplexNestedErrorData.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class ComplexNestedErrorData
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ComplexNestedErrorData, context: context)
        type = Types::ComplexNestedErrorData.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type
      end
    end

    class ConstantAndVariableQueryStringInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ConstantAndVariableQueryStringInput, context: context)
        type = Types::ConstantAndVariableQueryStringInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.baz = params[:baz]
        type.maybe_set = params[:maybe_set]
        type
      end
    end

    class ConstantAndVariableQueryStringOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ConstantAndVariableQueryStringOutput, context: context)
        type = Types::ConstantAndVariableQueryStringOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class ConstantQueryStringInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ConstantQueryStringInput, context: context)
        type = Types::ConstantQueryStringInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.hello = params[:hello]
        type
      end
    end

    class ConstantQueryStringOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ConstantQueryStringOutput, context: context)
        type = Types::ConstantQueryStringOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class DatetimeOffsetsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DatetimeOffsetsInput, context: context)
        type = Types::DatetimeOffsetsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class DatetimeOffsetsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DatetimeOffsetsOutput, context: context)
        type = Types::DatetimeOffsetsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.datetime = params[:datetime]
        type
      end
    end

    class DenseBooleanMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class DenseNumberMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class DenseSetMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = StringSet.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    class DenseStringMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class DenseStructMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = GreetingStruct.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    class DocumentTypeAsMapValueInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DocumentTypeAsMapValueInput, context: context)
        type = Types::DocumentTypeAsMapValueInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.doc_valued_map = DocumentValuedMap.build(params[:doc_valued_map], context: "#{context}[:doc_valued_map]") unless params[:doc_valued_map].nil?
        type
      end
    end

    class DocumentTypeAsMapValueOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DocumentTypeAsMapValueOutput, context: context)
        type = Types::DocumentTypeAsMapValueOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.doc_valued_map = DocumentValuedMap.build(params[:doc_valued_map], context: "#{context}[:doc_valued_map]") unless params[:doc_valued_map].nil?
        type
      end
    end

    class DocumentTypeAsPayloadInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DocumentTypeAsPayloadInput, context: context)
        type = Types::DocumentTypeAsPayloadInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.document_value = params[:document_value]
        type
      end
    end

    class DocumentTypeAsPayloadOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DocumentTypeAsPayloadOutput, context: context)
        type = Types::DocumentTypeAsPayloadOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.document_value = params[:document_value]
        type
      end
    end

    class DocumentTypeInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DocumentTypeInput, context: context)
        type = Types::DocumentTypeInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string_value = params[:string_value]
        type.document_value = params[:document_value]
        type
      end
    end

    class DocumentTypeOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DocumentTypeOutput, context: context)
        type = Types::DocumentTypeOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string_value = params[:string_value]
        type.document_value = params[:document_value]
        type
      end
    end

    class DocumentValuedMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class DoubleList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element&.to_f
        end
        data
      end
    end

    class EmptyInputAndEmptyOutputInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EmptyInputAndEmptyOutputInput, context: context)
        type = Types::EmptyInputAndEmptyOutputInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class EmptyInputAndEmptyOutputOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EmptyInputAndEmptyOutputOutput, context: context)
        type = Types::EmptyInputAndEmptyOutputOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class EndpointOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointOperationInput, context: context)
        type = Types::EndpointOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class EndpointOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointOperationOutput, context: context)
        type = Types::EndpointOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class EndpointWithHostLabelOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointWithHostLabelOperationInput, context: context)
        type = Types::EndpointWithHostLabelOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.label = params[:label]
        type
      end
    end

    class EndpointWithHostLabelOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointWithHostLabelOperationOutput, context: context)
        type = Types::EndpointWithHostLabelOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class FooEnumList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class FooEnumMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class FooEnumSet
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class FooError
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::FooError, context: context)
        type = Types::FooError.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class FractionalSecondsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::FractionalSecondsInput, context: context)
        type = Types::FractionalSecondsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class FractionalSecondsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::FractionalSecondsOutput, context: context)
        type = Types::FractionalSecondsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.datetime = params[:datetime]
        type
      end
    end

    class RenamedGreeting
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RenamedGreeting, context: context)
        type = Types::RenamedGreeting.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.salutation = params[:salutation]
        type
      end
    end

    class GreetingStruct
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::GreetingStruct, context: context)
        type = Types::GreetingStruct.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.hi = params[:hi]
        type
      end
    end

    class GreetingWithErrorsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::GreetingWithErrorsInput, context: context)
        type = Types::GreetingWithErrorsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class GreetingWithErrorsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::GreetingWithErrorsOutput, context: context)
        type = Types::GreetingWithErrorsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.greeting = params[:greeting]
        type
      end
    end

    class HostWithPathOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HostWithPathOperationInput, context: context)
        type = Types::HostWithPathOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HostWithPathOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HostWithPathOperationOutput, context: context)
        type = Types::HostWithPathOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpChecksumRequiredInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpChecksumRequiredInput, context: context)
        type = Types::HttpChecksumRequiredInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type
      end
    end

    class HttpChecksumRequiredOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpChecksumRequiredOutput, context: context)
        type = Types::HttpChecksumRequiredOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type
      end
    end

    class HttpEnumPayloadInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpEnumPayloadInput, context: context)
        type = Types::HttpEnumPayloadInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.payload = params[:payload]
        type
      end
    end

    class HttpEnumPayloadOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpEnumPayloadOutput, context: context)
        type = Types::HttpEnumPayloadOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.payload = params[:payload]
        type
      end
    end

    class HttpPayloadTraitsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadTraitsInput, context: context)
        type = Types::HttpPayloadTraitsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    class HttpPayloadTraitsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadTraitsOutput, context: context)
        type = Types::HttpPayloadTraitsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    class HttpPayloadTraitsWithMediaTypeInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadTraitsWithMediaTypeInput, context: context)
        type = Types::HttpPayloadTraitsWithMediaTypeInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    class HttpPayloadTraitsWithMediaTypeOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadTraitsWithMediaTypeOutput, context: context)
        type = Types::HttpPayloadTraitsWithMediaTypeOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    class HttpPayloadWithStructureInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadWithStructureInput, context: context)
        type = Types::HttpPayloadWithStructureInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = NestedPayload.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class HttpPayloadWithStructureOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadWithStructureOutput, context: context)
        type = Types::HttpPayloadWithStructureOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = NestedPayload.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class HttpPayloadWithUnionInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadWithUnionInput, context: context)
        type = Types::HttpPayloadWithUnionInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = UnionPayload.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class HttpPayloadWithUnionOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPayloadWithUnionOutput, context: context)
        type = Types::HttpPayloadWithUnionOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = UnionPayload.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class HttpPrefixHeadersInResponseInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPrefixHeadersInResponseInput, context: context)
        type = Types::HttpPrefixHeadersInResponseInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpPrefixHeadersInResponseOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPrefixHeadersInResponseOutput, context: context)
        type = Types::HttpPrefixHeadersInResponseOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.prefix_headers = StringMap.build(params[:prefix_headers], context: "#{context}[:prefix_headers]") unless params[:prefix_headers].nil?
        type
      end
    end

    class HttpPrefixHeadersInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPrefixHeadersInput, context: context)
        type = Types::HttpPrefixHeadersInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.foo_map = StringMap.build(params[:foo_map], context: "#{context}[:foo_map]") unless params[:foo_map].nil?
        type
      end
    end

    class HttpPrefixHeadersOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpPrefixHeadersOutput, context: context)
        type = Types::HttpPrefixHeadersOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.foo_map = StringMap.build(params[:foo_map], context: "#{context}[:foo_map]") unless params[:foo_map].nil?
        type
      end
    end

    class HttpRequestWithFloatLabelsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithFloatLabelsInput, context: context)
        type = Types::HttpRequestWithFloatLabelsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.float = params[:float]&.to_f
        type.double = params[:double]&.to_f
        type
      end
    end

    class HttpRequestWithFloatLabelsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithFloatLabelsOutput, context: context)
        type = Types::HttpRequestWithFloatLabelsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpRequestWithGreedyLabelInPathInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithGreedyLabelInPathInput, context: context)
        type = Types::HttpRequestWithGreedyLabelInPathInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.baz = params[:baz]
        type
      end
    end

    class HttpRequestWithGreedyLabelInPathOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithGreedyLabelInPathOutput, context: context)
        type = Types::HttpRequestWithGreedyLabelInPathOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpRequestWithLabelsAndTimestampFormatInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithLabelsAndTimestampFormatInput, context: context)
        type = Types::HttpRequestWithLabelsAndTimestampFormatInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.member_epoch_seconds = params[:member_epoch_seconds]
        type.member_http_date = params[:member_http_date]
        type.member_date_time = params[:member_date_time]
        type.default_format = params[:default_format]
        type.target_epoch_seconds = params[:target_epoch_seconds]
        type.target_http_date = params[:target_http_date]
        type.target_date_time = params[:target_date_time]
        type
      end
    end

    class HttpRequestWithLabelsAndTimestampFormatOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithLabelsAndTimestampFormatOutput, context: context)
        type = Types::HttpRequestWithLabelsAndTimestampFormatOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpRequestWithLabelsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithLabelsInput, context: context)
        type = Types::HttpRequestWithLabelsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string = params[:string]
        type.short = params[:short]
        type.integer = params[:integer]
        type.long = params[:long]
        type.float = params[:float]&.to_f
        type.double = params[:double]&.to_f
        type.boolean = params[:boolean]
        type.timestamp = params[:timestamp]
        type
      end
    end

    class HttpRequestWithLabelsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithLabelsOutput, context: context)
        type = Types::HttpRequestWithLabelsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpRequestWithRegexLiteralInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithRegexLiteralInput, context: context)
        type = Types::HttpRequestWithRegexLiteralInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.str = params[:str]
        type
      end
    end

    class HttpRequestWithRegexLiteralOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpRequestWithRegexLiteralOutput, context: context)
        type = Types::HttpRequestWithRegexLiteralOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpResponseCodeInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpResponseCodeInput, context: context)
        type = Types::HttpResponseCodeInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class HttpResponseCodeOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpResponseCodeOutput, context: context)
        type = Types::HttpResponseCodeOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.status = params[:status]
        type
      end
    end

    class HttpStringPayloadInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpStringPayloadInput, context: context)
        type = Types::HttpStringPayloadInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.payload = params[:payload]
        type
      end
    end

    class HttpStringPayloadOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpStringPayloadOutput, context: context)
        type = Types::HttpStringPayloadOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.payload = params[:payload]
        type
      end
    end

    class IgnoreQueryParamsInResponseInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::IgnoreQueryParamsInResponseInput, context: context)
        type = Types::IgnoreQueryParamsInResponseInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class IgnoreQueryParamsInResponseOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::IgnoreQueryParamsInResponseOutput, context: context)
        type = Types::IgnoreQueryParamsInResponseOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.baz = params[:baz]
        type
      end
    end

    class InputAndOutputWithHeadersInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::InputAndOutputWithHeadersInput, context: context)
        type = Types::InputAndOutputWithHeadersInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.header_string = params[:header_string]
        type.header_byte = params[:header_byte]
        type.header_short = params[:header_short]
        type.header_integer = params[:header_integer]
        type.header_long = params[:header_long]
        type.header_float = params[:header_float]&.to_f
        type.header_double = params[:header_double]&.to_f
        type.header_true_bool = params[:header_true_bool]
        type.header_false_bool = params[:header_false_bool]
        type.header_string_list = StringList.build(params[:header_string_list], context: "#{context}[:header_string_list]") unless params[:header_string_list].nil?
        type.header_string_set = StringSet.build(params[:header_string_set], context: "#{context}[:header_string_set]") unless params[:header_string_set].nil?
        type.header_integer_list = IntegerList.build(params[:header_integer_list], context: "#{context}[:header_integer_list]") unless params[:header_integer_list].nil?
        type.header_boolean_list = BooleanList.build(params[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless params[:header_boolean_list].nil?
        type.header_timestamp_list = TimestampList.build(params[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless params[:header_timestamp_list].nil?
        type.header_enum = params[:header_enum]
        type.header_enum_list = FooEnumList.build(params[:header_enum_list], context: "#{context}[:header_enum_list]") unless params[:header_enum_list].nil?
        type.header_integer_enum = params[:header_integer_enum]
        type.header_integer_enum_list = IntegerEnumList.build(params[:header_integer_enum_list], context: "#{context}[:header_integer_enum_list]") unless params[:header_integer_enum_list].nil?
        type
      end
    end

    class InputAndOutputWithHeadersOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::InputAndOutputWithHeadersOutput, context: context)
        type = Types::InputAndOutputWithHeadersOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.header_string = params[:header_string]
        type.header_byte = params[:header_byte]
        type.header_short = params[:header_short]
        type.header_integer = params[:header_integer]
        type.header_long = params[:header_long]
        type.header_float = params[:header_float]&.to_f
        type.header_double = params[:header_double]&.to_f
        type.header_true_bool = params[:header_true_bool]
        type.header_false_bool = params[:header_false_bool]
        type.header_string_list = StringList.build(params[:header_string_list], context: "#{context}[:header_string_list]") unless params[:header_string_list].nil?
        type.header_string_set = StringSet.build(params[:header_string_set], context: "#{context}[:header_string_set]") unless params[:header_string_set].nil?
        type.header_integer_list = IntegerList.build(params[:header_integer_list], context: "#{context}[:header_integer_list]") unless params[:header_integer_list].nil?
        type.header_boolean_list = BooleanList.build(params[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless params[:header_boolean_list].nil?
        type.header_timestamp_list = TimestampList.build(params[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless params[:header_timestamp_list].nil?
        type.header_enum = params[:header_enum]
        type.header_enum_list = FooEnumList.build(params[:header_enum_list], context: "#{context}[:header_enum_list]") unless params[:header_enum_list].nil?
        type.header_integer_enum = params[:header_integer_enum]
        type.header_integer_enum_list = IntegerEnumList.build(params[:header_integer_enum_list], context: "#{context}[:header_integer_enum_list]") unless params[:header_integer_enum_list].nil?
        type
      end
    end

    class IntegerEnumList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class IntegerEnumMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class IntegerEnumSet
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class IntegerList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class IntegerSet
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class InvalidGreeting
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::InvalidGreeting, context: context)
        type = Types::InvalidGreeting.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.message = params[:message]
        type
      end
    end

    class JsonBlobsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonBlobsInput, context: context)
        type = Types::JsonBlobsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.data = params[:data]
        type
      end
    end

    class JsonBlobsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonBlobsOutput, context: context)
        type = Types::JsonBlobsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.data = params[:data]
        type
      end
    end

    class JsonEnumsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonEnumsInput, context: context)
        type = Types::JsonEnumsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo_enum1 = params[:foo_enum1]
        type.foo_enum2 = params[:foo_enum2]
        type.foo_enum3 = params[:foo_enum3]
        type.foo_enum_list = FooEnumList.build(params[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless params[:foo_enum_list].nil?
        type.foo_enum_set = FooEnumSet.build(params[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless params[:foo_enum_set].nil?
        type.foo_enum_map = FooEnumMap.build(params[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless params[:foo_enum_map].nil?
        type
      end
    end

    class JsonEnumsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonEnumsOutput, context: context)
        type = Types::JsonEnumsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo_enum1 = params[:foo_enum1]
        type.foo_enum2 = params[:foo_enum2]
        type.foo_enum3 = params[:foo_enum3]
        type.foo_enum_list = FooEnumList.build(params[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless params[:foo_enum_list].nil?
        type.foo_enum_set = FooEnumSet.build(params[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless params[:foo_enum_set].nil?
        type.foo_enum_map = FooEnumMap.build(params[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless params[:foo_enum_map].nil?
        type
      end
    end

    class JsonIntEnumsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonIntEnumsInput, context: context)
        type = Types::JsonIntEnumsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.integer_enum1 = params[:integer_enum1]
        type.integer_enum2 = params[:integer_enum2]
        type.integer_enum3 = params[:integer_enum3]
        type.integer_enum_list = IntegerEnumList.build(params[:integer_enum_list], context: "#{context}[:integer_enum_list]") unless params[:integer_enum_list].nil?
        type.integer_enum_set = IntegerEnumSet.build(params[:integer_enum_set], context: "#{context}[:integer_enum_set]") unless params[:integer_enum_set].nil?
        type.integer_enum_map = IntegerEnumMap.build(params[:integer_enum_map], context: "#{context}[:integer_enum_map]") unless params[:integer_enum_map].nil?
        type
      end
    end

    class JsonIntEnumsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonIntEnumsOutput, context: context)
        type = Types::JsonIntEnumsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.integer_enum1 = params[:integer_enum1]
        type.integer_enum2 = params[:integer_enum2]
        type.integer_enum3 = params[:integer_enum3]
        type.integer_enum_list = IntegerEnumList.build(params[:integer_enum_list], context: "#{context}[:integer_enum_list]") unless params[:integer_enum_list].nil?
        type.integer_enum_set = IntegerEnumSet.build(params[:integer_enum_set], context: "#{context}[:integer_enum_set]") unless params[:integer_enum_set].nil?
        type.integer_enum_map = IntegerEnumMap.build(params[:integer_enum_map], context: "#{context}[:integer_enum_map]") unless params[:integer_enum_map].nil?
        type
      end
    end

    class JsonListsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonListsInput, context: context)
        type = Types::JsonListsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string_list = StringList.build(params[:string_list], context: "#{context}[:string_list]") unless params[:string_list].nil?
        type.string_set = StringSet.build(params[:string_set], context: "#{context}[:string_set]") unless params[:string_set].nil?
        type.integer_list = IntegerList.build(params[:integer_list], context: "#{context}[:integer_list]") unless params[:integer_list].nil?
        type.boolean_list = BooleanList.build(params[:boolean_list], context: "#{context}[:boolean_list]") unless params[:boolean_list].nil?
        type.timestamp_list = TimestampList.build(params[:timestamp_list], context: "#{context}[:timestamp_list]") unless params[:timestamp_list].nil?
        type.enum_list = FooEnumList.build(params[:enum_list], context: "#{context}[:enum_list]") unless params[:enum_list].nil?
        type.int_enum_list = IntegerEnumList.build(params[:int_enum_list], context: "#{context}[:int_enum_list]") unless params[:int_enum_list].nil?
        type.nested_string_list = NestedStringList.build(params[:nested_string_list], context: "#{context}[:nested_string_list]") unless params[:nested_string_list].nil?
        type.structure_list = StructureList.build(params[:structure_list], context: "#{context}[:structure_list]") unless params[:structure_list].nil?
        type
      end
    end

    class JsonListsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonListsOutput, context: context)
        type = Types::JsonListsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string_list = StringList.build(params[:string_list], context: "#{context}[:string_list]") unless params[:string_list].nil?
        type.string_set = StringSet.build(params[:string_set], context: "#{context}[:string_set]") unless params[:string_set].nil?
        type.integer_list = IntegerList.build(params[:integer_list], context: "#{context}[:integer_list]") unless params[:integer_list].nil?
        type.boolean_list = BooleanList.build(params[:boolean_list], context: "#{context}[:boolean_list]") unless params[:boolean_list].nil?
        type.timestamp_list = TimestampList.build(params[:timestamp_list], context: "#{context}[:timestamp_list]") unless params[:timestamp_list].nil?
        type.enum_list = FooEnumList.build(params[:enum_list], context: "#{context}[:enum_list]") unless params[:enum_list].nil?
        type.int_enum_list = IntegerEnumList.build(params[:int_enum_list], context: "#{context}[:int_enum_list]") unless params[:int_enum_list].nil?
        type.nested_string_list = NestedStringList.build(params[:nested_string_list], context: "#{context}[:nested_string_list]") unless params[:nested_string_list].nil?
        type.structure_list = StructureList.build(params[:structure_list], context: "#{context}[:structure_list]") unless params[:structure_list].nil?
        type
      end
    end

    class JsonMapsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonMapsInput, context: context)
        type = Types::JsonMapsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.dense_struct_map = DenseStructMap.build(params[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless params[:dense_struct_map].nil?
        type.dense_number_map = DenseNumberMap.build(params[:dense_number_map], context: "#{context}[:dense_number_map]") unless params[:dense_number_map].nil?
        type.dense_boolean_map = DenseBooleanMap.build(params[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless params[:dense_boolean_map].nil?
        type.dense_string_map = DenseStringMap.build(params[:dense_string_map], context: "#{context}[:dense_string_map]") unless params[:dense_string_map].nil?
        type.dense_set_map = DenseSetMap.build(params[:dense_set_map], context: "#{context}[:dense_set_map]") unless params[:dense_set_map].nil?
        type
      end
    end

    class JsonMapsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonMapsOutput, context: context)
        type = Types::JsonMapsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.dense_struct_map = DenseStructMap.build(params[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless params[:dense_struct_map].nil?
        type.dense_number_map = DenseNumberMap.build(params[:dense_number_map], context: "#{context}[:dense_number_map]") unless params[:dense_number_map].nil?
        type.dense_boolean_map = DenseBooleanMap.build(params[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless params[:dense_boolean_map].nil?
        type.dense_string_map = DenseStringMap.build(params[:dense_string_map], context: "#{context}[:dense_string_map]") unless params[:dense_string_map].nil?
        type.dense_set_map = DenseSetMap.build(params[:dense_set_map], context: "#{context}[:dense_set_map]") unless params[:dense_set_map].nil?
        type
      end
    end

    class JsonTimestampsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonTimestampsInput, context: context)
        type = Types::JsonTimestampsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.normal = params[:normal]
        type.date_time = params[:date_time]
        type.date_time_on_target = params[:date_time_on_target]
        type.epoch_seconds = params[:epoch_seconds]
        type.epoch_seconds_on_target = params[:epoch_seconds_on_target]
        type.http_date = params[:http_date]
        type.http_date_on_target = params[:http_date_on_target]
        type
      end
    end

    class JsonTimestampsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonTimestampsOutput, context: context)
        type = Types::JsonTimestampsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.normal = params[:normal]
        type.date_time = params[:date_time]
        type.date_time_on_target = params[:date_time_on_target]
        type.epoch_seconds = params[:epoch_seconds]
        type.epoch_seconds_on_target = params[:epoch_seconds_on_target]
        type.http_date = params[:http_date]
        type.http_date_on_target = params[:http_date_on_target]
        type
      end
    end

    class JsonUnionsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonUnionsInput, context: context)
        type = Types::JsonUnionsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.contents = MyUnion.build(params[:contents], context: "#{context}[:contents]") unless params[:contents].nil?
        type
      end
    end

    class JsonUnionsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::JsonUnionsOutput, context: context)
        type = Types::JsonUnionsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.contents = MyUnion.build(params[:contents], context: "#{context}[:contents]") unless params[:contents].nil?
        type
      end
    end

    class MediaTypeHeaderInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::MediaTypeHeaderInput, context: context)
        type = Types::MediaTypeHeaderInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.json = params[:json]
        type
      end
    end

    class MediaTypeHeaderOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::MediaTypeHeaderOutput, context: context)
        type = Types::MediaTypeHeaderOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.json = params[:json]
        type
      end
    end

    class MyUnion
      def self.build(params, context:)
        return params if params.is_a?(Types::MyUnion)
        Hearth::Validator.validate_types!(params, ::Hash, Types::MyUnion, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :string_value
          Types::MyUnion::StringValue.new(
            params[:string_value]
          )
        when :boolean_value
          Types::MyUnion::BooleanValue.new(
            params[:boolean_value]
          )
        when :number_value
          Types::MyUnion::NumberValue.new(
            params[:number_value]
          )
        when :blob_value
          Types::MyUnion::BlobValue.new(
            params[:blob_value]
          )
        when :timestamp_value
          Types::MyUnion::TimestampValue.new(
            params[:timestamp_value]
          )
        when :enum_value
          Types::MyUnion::EnumValue.new(
            params[:enum_value]
          )
        when :list_value
          Types::MyUnion::ListValue.new(
            (StringList.build(params[:list_value], context: "#{context}[:list_value]") unless params[:list_value].nil?)
          )
        when :map_value
          Types::MyUnion::MapValue.new(
            (StringMap.build(params[:map_value], context: "#{context}[:map_value]") unless params[:map_value].nil?)
          )
        when :structure_value
          Types::MyUnion::StructureValue.new(
            (GreetingStruct.build(params[:structure_value], context: "#{context}[:structure_value]") unless params[:structure_value].nil?)
          )
        when :renamed_structure_value
          Types::MyUnion::RenamedStructureValue.new(
            (RenamedGreeting.build(params[:renamed_structure_value], context: "#{context}[:renamed_structure_value]") unless params[:renamed_structure_value].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :string_value, :boolean_value, :number_value, :blob_value, :timestamp_value, :enum_value, :list_value, :map_value, :structure_value, :renamed_structure_value set"
        end
      end
    end

    class NestedPayload
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NestedPayload, context: context)
        type = Types::NestedPayload.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.greeting = params[:greeting]
        type.name = params[:name]
        type
      end
    end

    class NestedStringList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << StringList.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    class NoInputAndNoOutputInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NoInputAndNoOutputInput, context: context)
        type = Types::NoInputAndNoOutputInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class NoInputAndNoOutputOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NoInputAndNoOutputOutput, context: context)
        type = Types::NoInputAndNoOutputOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class NoInputAndOutputInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NoInputAndOutputInput, context: context)
        type = Types::NoInputAndOutputInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class NoInputAndOutputOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NoInputAndOutputOutput, context: context)
        type = Types::NoInputAndOutputOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class NullAndEmptyHeadersClientInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NullAndEmptyHeadersClientInput, context: context)
        type = Types::NullAndEmptyHeadersClientInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.a = params[:a]
        type.b = params[:b]
        type.c = StringList.build(params[:c], context: "#{context}[:c]") unless params[:c].nil?
        type
      end
    end

    class NullAndEmptyHeadersClientOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NullAndEmptyHeadersClientOutput, context: context)
        type = Types::NullAndEmptyHeadersClientOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.a = params[:a]
        type.b = params[:b]
        type.c = StringList.build(params[:c], context: "#{context}[:c]") unless params[:c].nil?
        type
      end
    end

    class NullAndEmptyHeadersServerInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NullAndEmptyHeadersServerInput, context: context)
        type = Types::NullAndEmptyHeadersServerInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.a = params[:a]
        type.b = params[:b]
        type.c = StringList.build(params[:c], context: "#{context}[:c]") unless params[:c].nil?
        type
      end
    end

    class NullAndEmptyHeadersServerOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NullAndEmptyHeadersServerOutput, context: context)
        type = Types::NullAndEmptyHeadersServerOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.a = params[:a]
        type.b = params[:b]
        type.c = StringList.build(params[:c], context: "#{context}[:c]") unless params[:c].nil?
        type
      end
    end

    class OmitsNullSerializesEmptyStringInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OmitsNullSerializesEmptyStringInput, context: context)
        type = Types::OmitsNullSerializesEmptyStringInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.null_value = params[:null_value]
        type.empty_string = params[:empty_string]
        type
      end
    end

    class OmitsNullSerializesEmptyStringOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OmitsNullSerializesEmptyStringOutput, context: context)
        type = Types::OmitsNullSerializesEmptyStringOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class OmitsSerializingEmptyListsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OmitsSerializingEmptyListsInput, context: context)
        type = Types::OmitsSerializingEmptyListsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.query_string_list = StringList.build(params[:query_string_list], context: "#{context}[:query_string_list]") unless params[:query_string_list].nil?
        type.query_integer_list = IntegerList.build(params[:query_integer_list], context: "#{context}[:query_integer_list]") unless params[:query_integer_list].nil?
        type.query_double_list = DoubleList.build(params[:query_double_list], context: "#{context}[:query_double_list]") unless params[:query_double_list].nil?
        type.query_boolean_list = BooleanList.build(params[:query_boolean_list], context: "#{context}[:query_boolean_list]") unless params[:query_boolean_list].nil?
        type.query_timestamp_list = TimestampList.build(params[:query_timestamp_list], context: "#{context}[:query_timestamp_list]") unless params[:query_timestamp_list].nil?
        type.query_enum_list = FooEnumList.build(params[:query_enum_list], context: "#{context}[:query_enum_list]") unless params[:query_enum_list].nil?
        type.query_integer_enum_list = IntegerEnumList.build(params[:query_integer_enum_list], context: "#{context}[:query_integer_enum_list]") unless params[:query_integer_enum_list].nil?
        type
      end
    end

    class OmitsSerializingEmptyListsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OmitsSerializingEmptyListsOutput, context: context)
        type = Types::OmitsSerializingEmptyListsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class PayloadConfig
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PayloadConfig, context: context)
        type = Types::PayloadConfig.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.data = params[:data]
        type
      end
    end

    class PlayerAction
      def self.build(params, context:)
        return params if params.is_a?(Types::PlayerAction)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PlayerAction, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :quit
          Types::PlayerAction::Quit.new(
            (Unit.build(params[:quit], context: "#{context}[:quit]") unless params[:quit].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :quit set"
        end
      end
    end

    class PostPlayerActionInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PostPlayerActionInput, context: context)
        type = Types::PostPlayerActionInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.action = PlayerAction.build(params[:action], context: "#{context}[:action]") unless params[:action].nil?
        type
      end
    end

    class PostPlayerActionOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PostPlayerActionOutput, context: context)
        type = Types::PostPlayerActionOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.action = PlayerAction.build(params[:action], context: "#{context}[:action]") unless params[:action].nil?
        type
      end
    end

    class PostUnionWithJsonNameInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PostUnionWithJsonNameInput, context: context)
        type = Types::PostUnionWithJsonNameInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.value = UnionWithJsonName.build(params[:value], context: "#{context}[:value]") unless params[:value].nil?
        type
      end
    end

    class PostUnionWithJsonNameOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PostUnionWithJsonNameOutput, context: context)
        type = Types::PostUnionWithJsonNameOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.value = UnionWithJsonName.build(params[:value], context: "#{context}[:value]") unless params[:value].nil?
        type
      end
    end

    class PutWithContentEncodingInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PutWithContentEncodingInput, context: context)
        type = Types::PutWithContentEncodingInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.encoding = params[:encoding]
        type.data = params[:data]
        type
      end
    end

    class PutWithContentEncodingOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PutWithContentEncodingOutput, context: context)
        type = Types::PutWithContentEncodingOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class QueryIdempotencyTokenAutoFillInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::QueryIdempotencyTokenAutoFillInput, context: context)
        type = Types::QueryIdempotencyTokenAutoFillInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.token = params[:token] || ::SecureRandom.uuid
        type
      end
    end

    class QueryIdempotencyTokenAutoFillOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::QueryIdempotencyTokenAutoFillOutput, context: context)
        type = Types::QueryIdempotencyTokenAutoFillOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class QueryParamsAsStringListMapInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::QueryParamsAsStringListMapInput, context: context)
        type = Types::QueryParamsAsStringListMapInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.qux = params[:qux]
        type.foo = StringListMap.build(params[:foo], context: "#{context}[:foo]") unless params[:foo].nil?
        type
      end
    end

    class QueryParamsAsStringListMapOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::QueryParamsAsStringListMapOutput, context: context)
        type = Types::QueryParamsAsStringListMapOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class QueryPrecedenceInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::QueryPrecedenceInput, context: context)
        type = Types::QueryPrecedenceInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.baz = StringMap.build(params[:baz], context: "#{context}[:baz]") unless params[:baz].nil?
        type
      end
    end

    class QueryPrecedenceOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::QueryPrecedenceOutput, context: context)
        type = Types::QueryPrecedenceOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class RecursiveShapesInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RecursiveShapesInput, context: context)
        type = Types::RecursiveShapesInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = RecursiveShapesInputOutputNested1.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RecursiveShapesInputOutputNested1, context: context)
        type = Types::RecursiveShapesInputOutputNested1.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.nested = RecursiveShapesInputOutputNested2.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RecursiveShapesInputOutputNested2, context: context)
        type = Types::RecursiveShapesInputOutputNested2.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.bar = params[:bar]
        type.recursive_member = RecursiveShapesInputOutputNested1.build(params[:recursive_member], context: "#{context}[:recursive_member]") unless params[:recursive_member].nil?
        type
      end
    end

    class RecursiveShapesOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RecursiveShapesOutput, context: context)
        type = Types::RecursiveShapesOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = RecursiveShapesInputOutputNested1.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class SimpleScalarPropertiesInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::SimpleScalarPropertiesInput, context: context)
        type = Types::SimpleScalarPropertiesInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.string_value = params[:string_value]
        type.true_boolean_value = params[:true_boolean_value]
        type.false_boolean_value = params[:false_boolean_value]
        type.byte_value = params[:byte_value]
        type.short_value = params[:short_value]
        type.integer_value = params[:integer_value]
        type.long_value = params[:long_value]
        type.float_value = params[:float_value]&.to_f
        type.double_value = params[:double_value]&.to_f
        type
      end
    end

    class SimpleScalarPropertiesOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::SimpleScalarPropertiesOutput, context: context)
        type = Types::SimpleScalarPropertiesOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        type.string_value = params[:string_value]
        type.true_boolean_value = params[:true_boolean_value]
        type.false_boolean_value = params[:false_boolean_value]
        type.byte_value = params[:byte_value]
        type.short_value = params[:short_value]
        type.integer_value = params[:integer_value]
        type.long_value = params[:long_value]
        type.float_value = params[:float_value]&.to_f
        type.double_value = params[:double_value]&.to_f
        type
      end
    end

    class SparseBooleanMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseJsonListsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::SparseJsonListsInput, context: context)
        type = Types::SparseJsonListsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.sparse_string_list = SparseStringList.build(params[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless params[:sparse_string_list].nil?
        type
      end
    end

    class SparseJsonListsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::SparseJsonListsOutput, context: context)
        type = Types::SparseJsonListsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.sparse_string_list = SparseStringList.build(params[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless params[:sparse_string_list].nil?
        type
      end
    end

    class SparseJsonMapsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::SparseJsonMapsInput, context: context)
        type = Types::SparseJsonMapsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.sparse_struct_map = SparseStructMap.build(params[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless params[:sparse_struct_map].nil?
        type.sparse_number_map = SparseNumberMap.build(params[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless params[:sparse_number_map].nil?
        type.sparse_boolean_map = SparseBooleanMap.build(params[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless params[:sparse_boolean_map].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type.sparse_set_map = SparseSetMap.build(params[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless params[:sparse_set_map].nil?
        type
      end
    end

    class SparseJsonMapsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::SparseJsonMapsOutput, context: context)
        type = Types::SparseJsonMapsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.sparse_struct_map = SparseStructMap.build(params[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless params[:sparse_struct_map].nil?
        type.sparse_number_map = SparseNumberMap.build(params[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless params[:sparse_number_map].nil?
        type.sparse_boolean_map = SparseBooleanMap.build(params[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless params[:sparse_boolean_map].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type.sparse_set_map = SparseSetMap.build(params[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless params[:sparse_set_map].nil?
        type
      end
    end

    class SparseNumberMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseSetMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = (StringSet.build(value, context: "#{context}[:#{key}]") unless value.nil?)
        end
        data
      end
    end

    class SparseStringList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class SparseStringMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class SparseStructMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = (GreetingStruct.build(value, context: "#{context}[:#{key}]") unless value.nil?)
        end
        data
      end
    end

    class StreamingTraitsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingTraitsInput, context: context)
        type = Types::StreamingTraitsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        io = params[:blob] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.blob = io
        type
      end
    end

    class StreamingTraitsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingTraitsOutput, context: context)
        type = Types::StreamingTraitsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        io = params[:blob] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.blob = io
        type
      end
    end

    class StreamingTraitsRequireLengthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingTraitsRequireLengthInput, context: context)
        type = Types::StreamingTraitsRequireLengthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        io = params[:blob] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.blob = io
        type
      end
    end

    class StreamingTraitsRequireLengthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingTraitsRequireLengthOutput, context: context)
        type = Types::StreamingTraitsRequireLengthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class StreamingTraitsWithMediaTypeInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingTraitsWithMediaTypeInput, context: context)
        type = Types::StreamingTraitsWithMediaTypeInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        io = params[:blob] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.blob = io
        type
      end
    end

    class StreamingTraitsWithMediaTypeOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingTraitsWithMediaTypeOutput, context: context)
        type = Types::StreamingTraitsWithMediaTypeOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.foo = params[:foo]
        io = params[:blob] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.blob = io
        type
      end
    end

    class StringList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class StringListMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = StringList.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    class StringMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    class StringSet
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class StructureList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << StructureListMember.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    class StructureListMember
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StructureListMember, context: context)
        type = Types::StructureListMember.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.a = params[:a]
        type.b = params[:b]
        type
      end
    end

    class TestBodyStructureInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestBodyStructureInput, context: context)
        type = Types::TestBodyStructureInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.test_id = params[:test_id]
        type.test_config = TestConfig.build(params[:test_config], context: "#{context}[:test_config]") unless params[:test_config].nil?
        type
      end
    end

    class TestBodyStructureOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestBodyStructureOutput, context: context)
        type = Types::TestBodyStructureOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.test_id = params[:test_id]
        type.test_config = TestConfig.build(params[:test_config], context: "#{context}[:test_config]") unless params[:test_config].nil?
        type
      end
    end

    class TestConfig
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestConfig, context: context)
        type = Types::TestConfig.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.timeout = params[:timeout]
        type
      end
    end

    class TestNoPayloadInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestNoPayloadInput, context: context)
        type = Types::TestNoPayloadInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.test_id = params[:test_id]
        type
      end
    end

    class TestNoPayloadOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestNoPayloadOutput, context: context)
        type = Types::TestNoPayloadOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.test_id = params[:test_id]
        type
      end
    end

    class TestPayloadBlobInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestPayloadBlobInput, context: context)
        type = Types::TestPayloadBlobInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.content_type = params[:content_type]
        type.data = params[:data]
        type
      end
    end

    class TestPayloadBlobOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestPayloadBlobOutput, context: context)
        type = Types::TestPayloadBlobOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.content_type = params[:content_type]
        type.data = params[:data]
        type
      end
    end

    class TestPayloadStructureInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestPayloadStructureInput, context: context)
        type = Types::TestPayloadStructureInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.test_id = params[:test_id]
        type.payload_config = PayloadConfig.build(params[:payload_config], context: "#{context}[:payload_config]") unless params[:payload_config].nil?
        type
      end
    end

    class TestPayloadStructureOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TestPayloadStructureOutput, context: context)
        type = Types::TestPayloadStructureOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.test_id = params[:test_id]
        type.payload_config = PayloadConfig.build(params[:payload_config], context: "#{context}[:payload_config]") unless params[:payload_config].nil?
        type
      end
    end

    class TimestampFormatHeadersInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TimestampFormatHeadersInput, context: context)
        type = Types::TimestampFormatHeadersInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.member_epoch_seconds = params[:member_epoch_seconds]
        type.member_http_date = params[:member_http_date]
        type.member_date_time = params[:member_date_time]
        type.default_format = params[:default_format]
        type.target_epoch_seconds = params[:target_epoch_seconds]
        type.target_http_date = params[:target_http_date]
        type.target_date_time = params[:target_date_time]
        type
      end
    end

    class TimestampFormatHeadersOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::TimestampFormatHeadersOutput, context: context)
        type = Types::TimestampFormatHeadersOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.member_epoch_seconds = params[:member_epoch_seconds]
        type.member_http_date = params[:member_http_date]
        type.member_date_time = params[:member_date_time]
        type.default_format = params[:default_format]
        type.target_epoch_seconds = params[:target_epoch_seconds]
        type.target_http_date = params[:target_http_date]
        type.target_date_time = params[:target_date_time]
        type
      end
    end

    class TimestampList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class UnionPayload
      def self.build(params, context:)
        return params if params.is_a?(Types::UnionPayload)
        Hearth::Validator.validate_types!(params, ::Hash, Types::UnionPayload, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :greeting
          Types::UnionPayload::Greeting.new(
            params[:greeting]
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :greeting set"
        end
      end
    end

    class UnionWithJsonName
      def self.build(params, context:)
        return params if params.is_a?(Types::UnionWithJsonName)
        Hearth::Validator.validate_types!(params, ::Hash, Types::UnionWithJsonName, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :foo
          Types::UnionWithJsonName::Foo.new(
            params[:foo]
          )
        when :bar
          Types::UnionWithJsonName::Bar.new(
            params[:bar]
          )
        when :baz
          Types::UnionWithJsonName::Baz.new(
            params[:baz]
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :foo, :bar, :baz set"
        end
      end
    end

    class Unit
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Unit, context: context)
        type = Types::Unit.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class UnitInputAndOutputInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::UnitInputAndOutputInput, context: context)
        type = Types::UnitInputAndOutputInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class UnitInputAndOutputOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::UnitInputAndOutputOutput, context: context)
        type = Types::UnitInputAndOutputOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

  end
end
