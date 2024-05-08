# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'time'

module RailsJson
  # @api private
  module Validators

    class AllQueryStringTypesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::AllQueryStringTypesInput, context: context)
        Hearth::Validator.validate_types!(input[:query_string], ::String, context: "#{context}[:query_string]")
        StringList.validate!(input[:query_string_list], context: "#{context}[:query_string_list]") unless input[:query_string_list].nil?
        StringSet.validate!(input[:query_string_set], context: "#{context}[:query_string_set]") unless input[:query_string_set].nil?
        Hearth::Validator.validate_types!(input[:query_byte], ::Integer, context: "#{context}[:query_byte]")
        Hearth::Validator.validate_types!(input[:query_short], ::Integer, context: "#{context}[:query_short]")
        Hearth::Validator.validate_types!(input[:query_integer], ::Integer, context: "#{context}[:query_integer]")
        IntegerList.validate!(input[:query_integer_list], context: "#{context}[:query_integer_list]") unless input[:query_integer_list].nil?
        IntegerSet.validate!(input[:query_integer_set], context: "#{context}[:query_integer_set]") unless input[:query_integer_set].nil?
        Hearth::Validator.validate_types!(input[:query_long], ::Integer, context: "#{context}[:query_long]")
        Hearth::Validator.validate_types!(input[:query_float], ::Float, context: "#{context}[:query_float]")
        Hearth::Validator.validate_types!(input[:query_double], ::Float, context: "#{context}[:query_double]")
        DoubleList.validate!(input[:query_double_list], context: "#{context}[:query_double_list]") unless input[:query_double_list].nil?
        Hearth::Validator.validate_types!(input[:query_boolean], ::TrueClass, ::FalseClass, context: "#{context}[:query_boolean]")
        BooleanList.validate!(input[:query_boolean_list], context: "#{context}[:query_boolean_list]") unless input[:query_boolean_list].nil?
        Hearth::Validator.validate_types!(input[:query_timestamp], ::Time, context: "#{context}[:query_timestamp]")
        TimestampList.validate!(input[:query_timestamp_list], context: "#{context}[:query_timestamp_list]") unless input[:query_timestamp_list].nil?
        Hearth::Validator.validate_types!(input[:query_enum], ::String, context: "#{context}[:query_enum]")
        FooEnumList.validate!(input[:query_enum_list], context: "#{context}[:query_enum_list]") unless input[:query_enum_list].nil?
        Hearth::Validator.validate_types!(input[:query_integer_enum], ::Integer, context: "#{context}[:query_integer_enum]")
        IntegerEnumList.validate!(input[:query_integer_enum_list], context: "#{context}[:query_integer_enum_list]") unless input[:query_integer_enum_list].nil?
        StringListMap.validate!(input[:query_params_map_of_string_list], context: "#{context}[:query_params_map_of_string_list]") unless input[:query_params_map_of_string_list].nil?
      end
    end

    class AllQueryStringTypesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::AllQueryStringTypesOutput, context: context)
      end
    end

    class BooleanList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::TrueClass, ::FalseClass, context: "#{context}[#{index}]")
        end
      end
    end

    class ClientOptionalDefaults
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ClientOptionalDefaults, context: context)
        Hearth::Validator.validate_types!(input[:member], ::Integer, context: "#{context}[:member]")
      end
    end

    class ComplexError
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ComplexError, context: context)
        Hearth::Validator.validate_types!(input[:header], ::String, context: "#{context}[:header]")
        Hearth::Validator.validate_types!(input[:top_level], ::String, context: "#{context}[:top_level]")
        ComplexNestedErrorData.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class ComplexNestedErrorData
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ComplexNestedErrorData, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
      end
    end

    class ConstantAndVariableQueryStringInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ConstantAndVariableQueryStringInput, context: context)
        Hearth::Validator.validate_types!(input[:baz], ::String, context: "#{context}[:baz]")
        Hearth::Validator.validate_types!(input[:maybe_set], ::String, context: "#{context}[:maybe_set]")
      end
    end

    class ConstantAndVariableQueryStringOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ConstantAndVariableQueryStringOutput, context: context)
      end
    end

    class ConstantQueryStringInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ConstantQueryStringInput, context: context)
        Hearth::Validator.validate_required!(input[:hello], context: "#{context}[:hello]")
        Hearth::Validator.validate_types!(input[:hello], ::String, context: "#{context}[:hello]")
      end
    end

    class ConstantQueryStringOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ConstantQueryStringOutput, context: context)
      end
    end

    class DatetimeOffsetsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DatetimeOffsetsInput, context: context)
      end
    end

    class DatetimeOffsetsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DatetimeOffsetsOutput, context: context)
        Hearth::Validator.validate_types!(input[:datetime], ::Time, context: "#{context}[:datetime]")
      end
    end

    class Defaults
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Defaults, context: context)
        Hearth::Validator.validate_types!(input[:default_string], ::String, context: "#{context}[:default_string]")
        Hearth::Validator.validate_types!(input[:default_boolean], ::TrueClass, ::FalseClass, context: "#{context}[:default_boolean]")
        TestStringList.validate!(input[:default_list], context: "#{context}[:default_list]") unless input[:default_list].nil?
        Document.validate!(input[:default_document_map], context: "#{context}[:default_document_map]") unless input[:default_document_map].nil?
        Document.validate!(input[:default_document_string], context: "#{context}[:default_document_string]") unless input[:default_document_string].nil?
        Document.validate!(input[:default_document_boolean], context: "#{context}[:default_document_boolean]") unless input[:default_document_boolean].nil?
        Document.validate!(input[:default_document_list], context: "#{context}[:default_document_list]") unless input[:default_document_list].nil?
        Document.validate!(input[:default_null_document], context: "#{context}[:default_null_document]") unless input[:default_null_document].nil?
        Hearth::Validator.validate_types!(input[:default_timestamp], ::Time, context: "#{context}[:default_timestamp]")
        Hearth::Validator.validate_types!(input[:default_blob], ::String, context: "#{context}[:default_blob]")
        Hearth::Validator.validate_types!(input[:default_byte], ::Integer, context: "#{context}[:default_byte]")
        Hearth::Validator.validate_types!(input[:default_short], ::Integer, context: "#{context}[:default_short]")
        Hearth::Validator.validate_types!(input[:default_integer], ::Integer, context: "#{context}[:default_integer]")
        Hearth::Validator.validate_types!(input[:default_long], ::Integer, context: "#{context}[:default_long]")
        Hearth::Validator.validate_types!(input[:default_float], ::Float, context: "#{context}[:default_float]")
        Hearth::Validator.validate_types!(input[:default_double], ::Float, context: "#{context}[:default_double]")
        TestStringMap.validate!(input[:default_map], context: "#{context}[:default_map]") unless input[:default_map].nil?
        Hearth::Validator.validate_types!(input[:default_enum], ::String, context: "#{context}[:default_enum]")
        Hearth::Validator.validate_types!(input[:default_int_enum], ::Integer, context: "#{context}[:default_int_enum]")
        Hearth::Validator.validate_types!(input[:empty_string], ::String, context: "#{context}[:empty_string]")
        Hearth::Validator.validate_types!(input[:false_boolean], ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean]")
        Hearth::Validator.validate_types!(input[:empty_blob], ::String, context: "#{context}[:empty_blob]")
        Hearth::Validator.validate_types!(input[:zero_byte], ::Integer, context: "#{context}[:zero_byte]")
        Hearth::Validator.validate_types!(input[:zero_short], ::Integer, context: "#{context}[:zero_short]")
        Hearth::Validator.validate_types!(input[:zero_integer], ::Integer, context: "#{context}[:zero_integer]")
        Hearth::Validator.validate_types!(input[:zero_long], ::Integer, context: "#{context}[:zero_long]")
        Hearth::Validator.validate_types!(input[:zero_float], ::Float, context: "#{context}[:zero_float]")
        Hearth::Validator.validate_types!(input[:zero_double], ::Float, context: "#{context}[:zero_double]")
      end
    end

    class DenseBooleanMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::TrueClass, ::FalseClass, context: "#{context}[:#{key}]")
        end
      end
    end

    class DenseNumberMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::Integer, context: "#{context}[:#{key}]")
        end
      end
    end

    class DenseSetMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          StringSet.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class DenseStringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class DenseStructMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          GreetingStruct.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class Dialog
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Dialog, context: context)
        Hearth::Validator.validate_types!(input[:language], ::String, context: "#{context}[:language]")
        Hearth::Validator.validate_types!(input[:greeting], ::String, context: "#{context}[:greeting]")
        Farewell.validate!(input[:farewell], context: "#{context}[:farewell]") unless input[:farewell].nil?
      end
    end

    class DialogList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Dialog.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class DialogMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Dialog.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class Document
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, ::String, ::Array, ::TrueClass, ::FalseClass, ::Numeric, context: context)
        case input
        when ::Hash
          input.each do |k,v|
            validate!(v, context: "#{context}[:#{k}]")
          end
        when ::Array
          input.each_with_index do |v, i|
            validate!(v, context: "#{context}[#{i}]")
          end
        end
      end
    end

    class DocumentTypeAsMapValueInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DocumentTypeAsMapValueInput, context: context)
        DocumentValuedMap.validate!(input[:doc_valued_map], context: "#{context}[:doc_valued_map]") unless input[:doc_valued_map].nil?
      end
    end

    class DocumentTypeAsMapValueOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DocumentTypeAsMapValueOutput, context: context)
        DocumentValuedMap.validate!(input[:doc_valued_map], context: "#{context}[:doc_valued_map]") unless input[:doc_valued_map].nil?
      end
    end

    class DocumentTypeAsPayloadInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DocumentTypeAsPayloadInput, context: context)
        Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DocumentTypeAsPayloadOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DocumentTypeAsPayloadOutput, context: context)
        Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DocumentTypeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DocumentTypeInput, context: context)
        Hearth::Validator.validate_types!(input[:string_value], ::String, context: "#{context}[:string_value]")
        Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DocumentTypeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DocumentTypeOutput, context: context)
        Hearth::Validator.validate_types!(input[:string_value], ::String, context: "#{context}[:string_value]")
        Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DocumentValuedMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Document.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class DoubleList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::Float, context: "#{context}[#{index}]")
        end
      end
    end

    class EmptyInputAndEmptyOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EmptyInputAndEmptyOutputInput, context: context)
      end
    end

    class EmptyInputAndEmptyOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EmptyInputAndEmptyOutputOutput, context: context)
      end
    end

    class EndpointOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointOperationInput, context: context)
      end
    end

    class EndpointOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointOperationOutput, context: context)
      end
    end

    class EndpointWithHostLabelOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointWithHostLabelOperationInput, context: context)
        Hearth::Validator.validate_required!(input[:label], context: "#{context}[:label]")
        Hearth::Validator.validate_types!(input[:label], ::String, context: "#{context}[:label]")
      end
    end

    class EndpointWithHostLabelOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointWithHostLabelOperationOutput, context: context)
      end
    end

    class Farewell
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Farewell, context: context)
        Hearth::Validator.validate_types!(input[:phrase], ::String, context: "#{context}[:phrase]")
      end
    end

    class FooEnumList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class FooEnumMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class FooEnumSet
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class FractionalSecondsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::FractionalSecondsInput, context: context)
      end
    end

    class FractionalSecondsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::FractionalSecondsOutput, context: context)
        Hearth::Validator.validate_types!(input[:datetime], ::Time, context: "#{context}[:datetime]")
      end
    end

    class RenamedGreeting
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RenamedGreeting, context: context)
        Hearth::Validator.validate_types!(input[:salutation], ::String, context: "#{context}[:salutation]")
      end
    end

    class GreetingStruct
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GreetingStruct, context: context)
        Hearth::Validator.validate_types!(input[:hi], ::String, context: "#{context}[:hi]")
      end
    end

    class GreetingWithErrorsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GreetingWithErrorsInput, context: context)
      end
    end

    class GreetingWithErrorsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GreetingWithErrorsOutput, context: context)
        Hearth::Validator.validate_types!(input[:greeting], ::String, context: "#{context}[:greeting]")
      end
    end

    class HostWithPathOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HostWithPathOperationInput, context: context)
      end
    end

    class HostWithPathOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HostWithPathOperationOutput, context: context)
      end
    end

    class HttpChecksumRequiredInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpChecksumRequiredInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
      end
    end

    class HttpChecksumRequiredOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpChecksumRequiredOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
      end
    end

    class HttpEnumPayloadInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpEnumPayloadInput, context: context)
        Hearth::Validator.validate_types!(input[:payload], ::String, context: "#{context}[:payload]")
      end
    end

    class HttpEnumPayloadOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpEnumPayloadOutput, context: context)
        Hearth::Validator.validate_types!(input[:payload], ::String, context: "#{context}[:payload]")
      end
    end

    class HttpPayloadTraitsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadTraitsInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate_types!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadTraitsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadTraitsOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate_types!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadTraitsWithMediaTypeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadTraitsWithMediaTypeInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate_types!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadTraitsWithMediaTypeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadTraitsWithMediaTypeOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate_types!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadWithStructureInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadWithStructureInput, context: context)
        NestedPayload.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class HttpPayloadWithStructureOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadWithStructureOutput, context: context)
        NestedPayload.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class HttpPayloadWithUnionInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadWithUnionInput, context: context)
        UnionPayload.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class HttpPayloadWithUnionOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPayloadWithUnionOutput, context: context)
        UnionPayload.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class HttpPrefixHeadersInResponseInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPrefixHeadersInResponseInput, context: context)
      end
    end

    class HttpPrefixHeadersInResponseOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPrefixHeadersInResponseOutput, context: context)
        StringMap.validate!(input[:prefix_headers], context: "#{context}[:prefix_headers]") unless input[:prefix_headers].nil?
      end
    end

    class HttpPrefixHeadersInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPrefixHeadersInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        StringMap.validate!(input[:foo_map], context: "#{context}[:foo_map]") unless input[:foo_map].nil?
      end
    end

    class HttpPrefixHeadersOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpPrefixHeadersOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        StringMap.validate!(input[:foo_map], context: "#{context}[:foo_map]") unless input[:foo_map].nil?
      end
    end

    class HttpRequestWithFloatLabelsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithFloatLabelsInput, context: context)
        Hearth::Validator.validate_required!(input[:float], context: "#{context}[:float]")
        Hearth::Validator.validate_types!(input[:float], ::Float, context: "#{context}[:float]")
        Hearth::Validator.validate_required!(input[:double], context: "#{context}[:double]")
        Hearth::Validator.validate_types!(input[:double], ::Float, context: "#{context}[:double]")
      end
    end

    class HttpRequestWithFloatLabelsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithFloatLabelsOutput, context: context)
      end
    end

    class HttpRequestWithGreedyLabelInPathInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithGreedyLabelInPathInput, context: context)
        Hearth::Validator.validate_required!(input[:foo], context: "#{context}[:foo]")
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate_required!(input[:baz], context: "#{context}[:baz]")
        Hearth::Validator.validate_types!(input[:baz], ::String, context: "#{context}[:baz]")
      end
    end

    class HttpRequestWithGreedyLabelInPathOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithGreedyLabelInPathOutput, context: context)
      end
    end

    class HttpRequestWithLabelsAndTimestampFormatInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithLabelsAndTimestampFormatInput, context: context)
        Hearth::Validator.validate_required!(input[:member_epoch_seconds], context: "#{context}[:member_epoch_seconds]")
        Hearth::Validator.validate_types!(input[:member_epoch_seconds], ::Time, context: "#{context}[:member_epoch_seconds]")
        Hearth::Validator.validate_required!(input[:member_http_date], context: "#{context}[:member_http_date]")
        Hearth::Validator.validate_types!(input[:member_http_date], ::Time, context: "#{context}[:member_http_date]")
        Hearth::Validator.validate_required!(input[:member_date_time], context: "#{context}[:member_date_time]")
        Hearth::Validator.validate_types!(input[:member_date_time], ::Time, context: "#{context}[:member_date_time]")
        Hearth::Validator.validate_required!(input[:default_format], context: "#{context}[:default_format]")
        Hearth::Validator.validate_types!(input[:default_format], ::Time, context: "#{context}[:default_format]")
        Hearth::Validator.validate_required!(input[:target_epoch_seconds], context: "#{context}[:target_epoch_seconds]")
        Hearth::Validator.validate_types!(input[:target_epoch_seconds], ::Time, context: "#{context}[:target_epoch_seconds]")
        Hearth::Validator.validate_required!(input[:target_http_date], context: "#{context}[:target_http_date]")
        Hearth::Validator.validate_types!(input[:target_http_date], ::Time, context: "#{context}[:target_http_date]")
        Hearth::Validator.validate_required!(input[:target_date_time], context: "#{context}[:target_date_time]")
        Hearth::Validator.validate_types!(input[:target_date_time], ::Time, context: "#{context}[:target_date_time]")
      end
    end

    class HttpRequestWithLabelsAndTimestampFormatOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithLabelsAndTimestampFormatOutput, context: context)
      end
    end

    class HttpRequestWithLabelsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithLabelsInput, context: context)
        Hearth::Validator.validate_required!(input[:string], context: "#{context}[:string]")
        Hearth::Validator.validate_types!(input[:string], ::String, context: "#{context}[:string]")
        Hearth::Validator.validate_required!(input[:short], context: "#{context}[:short]")
        Hearth::Validator.validate_types!(input[:short], ::Integer, context: "#{context}[:short]")
        Hearth::Validator.validate_required!(input[:integer], context: "#{context}[:integer]")
        Hearth::Validator.validate_types!(input[:integer], ::Integer, context: "#{context}[:integer]")
        Hearth::Validator.validate_required!(input[:long], context: "#{context}[:long]")
        Hearth::Validator.validate_types!(input[:long], ::Integer, context: "#{context}[:long]")
        Hearth::Validator.validate_required!(input[:float], context: "#{context}[:float]")
        Hearth::Validator.validate_types!(input[:float], ::Float, context: "#{context}[:float]")
        Hearth::Validator.validate_required!(input[:double], context: "#{context}[:double]")
        Hearth::Validator.validate_types!(input[:double], ::Float, context: "#{context}[:double]")
        Hearth::Validator.validate_required!(input[:boolean], context: "#{context}[:boolean]")
        Hearth::Validator.validate_types!(input[:boolean], ::TrueClass, ::FalseClass, context: "#{context}[:boolean]")
        Hearth::Validator.validate_required!(input[:timestamp], context: "#{context}[:timestamp]")
        Hearth::Validator.validate_types!(input[:timestamp], ::Time, context: "#{context}[:timestamp]")
      end
    end

    class HttpRequestWithLabelsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithLabelsOutput, context: context)
      end
    end

    class HttpRequestWithRegexLiteralInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithRegexLiteralInput, context: context)
        Hearth::Validator.validate_required!(input[:str], context: "#{context}[:str]")
        Hearth::Validator.validate_types!(input[:str], ::String, context: "#{context}[:str]")
      end
    end

    class HttpRequestWithRegexLiteralOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpRequestWithRegexLiteralOutput, context: context)
      end
    end

    class HttpResponseCodeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpResponseCodeInput, context: context)
      end
    end

    class HttpResponseCodeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpResponseCodeOutput, context: context)
        Hearth::Validator.validate_types!(input[:status], ::Integer, context: "#{context}[:status]")
      end
    end

    class HttpStringPayloadInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpStringPayloadInput, context: context)
        Hearth::Validator.validate_types!(input[:payload], ::String, context: "#{context}[:payload]")
      end
    end

    class HttpStringPayloadOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpStringPayloadOutput, context: context)
        Hearth::Validator.validate_types!(input[:payload], ::String, context: "#{context}[:payload]")
      end
    end

    class IgnoreQueryParamsInResponseInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::IgnoreQueryParamsInResponseInput, context: context)
      end
    end

    class IgnoreQueryParamsInResponseOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::IgnoreQueryParamsInResponseOutput, context: context)
        Hearth::Validator.validate_types!(input[:baz], ::String, context: "#{context}[:baz]")
      end
    end

    class InputAndOutputWithHeadersInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::InputAndOutputWithHeadersInput, context: context)
        Hearth::Validator.validate_types!(input[:header_string], ::String, context: "#{context}[:header_string]")
        Hearth::Validator.validate_types!(input[:header_byte], ::Integer, context: "#{context}[:header_byte]")
        Hearth::Validator.validate_types!(input[:header_short], ::Integer, context: "#{context}[:header_short]")
        Hearth::Validator.validate_types!(input[:header_integer], ::Integer, context: "#{context}[:header_integer]")
        Hearth::Validator.validate_types!(input[:header_long], ::Integer, context: "#{context}[:header_long]")
        Hearth::Validator.validate_types!(input[:header_float], ::Float, context: "#{context}[:header_float]")
        Hearth::Validator.validate_types!(input[:header_double], ::Float, context: "#{context}[:header_double]")
        Hearth::Validator.validate_types!(input[:header_true_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_true_bool]")
        Hearth::Validator.validate_types!(input[:header_false_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_false_bool]")
        StringList.validate!(input[:header_string_list], context: "#{context}[:header_string_list]") unless input[:header_string_list].nil?
        StringSet.validate!(input[:header_string_set], context: "#{context}[:header_string_set]") unless input[:header_string_set].nil?
        IntegerList.validate!(input[:header_integer_list], context: "#{context}[:header_integer_list]") unless input[:header_integer_list].nil?
        BooleanList.validate!(input[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless input[:header_boolean_list].nil?
        TimestampList.validate!(input[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless input[:header_timestamp_list].nil?
        Hearth::Validator.validate_types!(input[:header_enum], ::String, context: "#{context}[:header_enum]")
        FooEnumList.validate!(input[:header_enum_list], context: "#{context}[:header_enum_list]") unless input[:header_enum_list].nil?
        Hearth::Validator.validate_types!(input[:header_integer_enum], ::Integer, context: "#{context}[:header_integer_enum]")
        IntegerEnumList.validate!(input[:header_integer_enum_list], context: "#{context}[:header_integer_enum_list]") unless input[:header_integer_enum_list].nil?
      end
    end

    class InputAndOutputWithHeadersOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::InputAndOutputWithHeadersOutput, context: context)
        Hearth::Validator.validate_types!(input[:header_string], ::String, context: "#{context}[:header_string]")
        Hearth::Validator.validate_types!(input[:header_byte], ::Integer, context: "#{context}[:header_byte]")
        Hearth::Validator.validate_types!(input[:header_short], ::Integer, context: "#{context}[:header_short]")
        Hearth::Validator.validate_types!(input[:header_integer], ::Integer, context: "#{context}[:header_integer]")
        Hearth::Validator.validate_types!(input[:header_long], ::Integer, context: "#{context}[:header_long]")
        Hearth::Validator.validate_types!(input[:header_float], ::Float, context: "#{context}[:header_float]")
        Hearth::Validator.validate_types!(input[:header_double], ::Float, context: "#{context}[:header_double]")
        Hearth::Validator.validate_types!(input[:header_true_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_true_bool]")
        Hearth::Validator.validate_types!(input[:header_false_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_false_bool]")
        StringList.validate!(input[:header_string_list], context: "#{context}[:header_string_list]") unless input[:header_string_list].nil?
        StringSet.validate!(input[:header_string_set], context: "#{context}[:header_string_set]") unless input[:header_string_set].nil?
        IntegerList.validate!(input[:header_integer_list], context: "#{context}[:header_integer_list]") unless input[:header_integer_list].nil?
        BooleanList.validate!(input[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless input[:header_boolean_list].nil?
        TimestampList.validate!(input[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless input[:header_timestamp_list].nil?
        Hearth::Validator.validate_types!(input[:header_enum], ::String, context: "#{context}[:header_enum]")
        FooEnumList.validate!(input[:header_enum_list], context: "#{context}[:header_enum_list]") unless input[:header_enum_list].nil?
        Hearth::Validator.validate_types!(input[:header_integer_enum], ::Integer, context: "#{context}[:header_integer_enum]")
        IntegerEnumList.validate!(input[:header_integer_enum_list], context: "#{context}[:header_integer_enum_list]") unless input[:header_integer_enum_list].nil?
      end
    end

    class IntegerEnumList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::Integer, context: "#{context}[#{index}]")
        end
      end
    end

    class IntegerEnumMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::Integer, context: "#{context}[:#{key}]")
        end
      end
    end

    class IntegerEnumSet
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::Integer, context: "#{context}[#{index}]")
        end
      end
    end

    class IntegerList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::Integer, context: "#{context}[#{index}]")
        end
      end
    end

    class IntegerSet
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::Integer, context: "#{context}[#{index}]")
        end
      end
    end

    class InvalidGreeting
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::InvalidGreeting, context: context)
        Hearth::Validator.validate_types!(input[:message], ::String, context: "#{context}[:message]")
      end
    end

    class JsonBlobsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonBlobsInput, context: context)
        Hearth::Validator.validate_types!(input[:data], ::String, context: "#{context}[:data]")
      end
    end

    class JsonBlobsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonBlobsOutput, context: context)
        Hearth::Validator.validate_types!(input[:data], ::String, context: "#{context}[:data]")
      end
    end

    class JsonEnumsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonEnumsInput, context: context)
        Hearth::Validator.validate_types!(input[:foo_enum1], ::String, context: "#{context}[:foo_enum1]")
        Hearth::Validator.validate_types!(input[:foo_enum2], ::String, context: "#{context}[:foo_enum2]")
        Hearth::Validator.validate_types!(input[:foo_enum3], ::String, context: "#{context}[:foo_enum3]")
        FooEnumList.validate!(input[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless input[:foo_enum_list].nil?
        FooEnumSet.validate!(input[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless input[:foo_enum_set].nil?
        FooEnumMap.validate!(input[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless input[:foo_enum_map].nil?
      end
    end

    class JsonEnumsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonEnumsOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo_enum1], ::String, context: "#{context}[:foo_enum1]")
        Hearth::Validator.validate_types!(input[:foo_enum2], ::String, context: "#{context}[:foo_enum2]")
        Hearth::Validator.validate_types!(input[:foo_enum3], ::String, context: "#{context}[:foo_enum3]")
        FooEnumList.validate!(input[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless input[:foo_enum_list].nil?
        FooEnumSet.validate!(input[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless input[:foo_enum_set].nil?
        FooEnumMap.validate!(input[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless input[:foo_enum_map].nil?
      end
    end

    class JsonIntEnumsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonIntEnumsInput, context: context)
        Hearth::Validator.validate_types!(input[:integer_enum1], ::Integer, context: "#{context}[:integer_enum1]")
        Hearth::Validator.validate_types!(input[:integer_enum2], ::Integer, context: "#{context}[:integer_enum2]")
        Hearth::Validator.validate_types!(input[:integer_enum3], ::Integer, context: "#{context}[:integer_enum3]")
        IntegerEnumList.validate!(input[:integer_enum_list], context: "#{context}[:integer_enum_list]") unless input[:integer_enum_list].nil?
        IntegerEnumSet.validate!(input[:integer_enum_set], context: "#{context}[:integer_enum_set]") unless input[:integer_enum_set].nil?
        IntegerEnumMap.validate!(input[:integer_enum_map], context: "#{context}[:integer_enum_map]") unless input[:integer_enum_map].nil?
      end
    end

    class JsonIntEnumsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonIntEnumsOutput, context: context)
        Hearth::Validator.validate_types!(input[:integer_enum1], ::Integer, context: "#{context}[:integer_enum1]")
        Hearth::Validator.validate_types!(input[:integer_enum2], ::Integer, context: "#{context}[:integer_enum2]")
        Hearth::Validator.validate_types!(input[:integer_enum3], ::Integer, context: "#{context}[:integer_enum3]")
        IntegerEnumList.validate!(input[:integer_enum_list], context: "#{context}[:integer_enum_list]") unless input[:integer_enum_list].nil?
        IntegerEnumSet.validate!(input[:integer_enum_set], context: "#{context}[:integer_enum_set]") unless input[:integer_enum_set].nil?
        IntegerEnumMap.validate!(input[:integer_enum_map], context: "#{context}[:integer_enum_map]") unless input[:integer_enum_map].nil?
      end
    end

    class JsonListsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonListsInput, context: context)
        StringList.validate!(input[:string_list], context: "#{context}[:string_list]") unless input[:string_list].nil?
        StringSet.validate!(input[:string_set], context: "#{context}[:string_set]") unless input[:string_set].nil?
        IntegerList.validate!(input[:integer_list], context: "#{context}[:integer_list]") unless input[:integer_list].nil?
        BooleanList.validate!(input[:boolean_list], context: "#{context}[:boolean_list]") unless input[:boolean_list].nil?
        TimestampList.validate!(input[:timestamp_list], context: "#{context}[:timestamp_list]") unless input[:timestamp_list].nil?
        FooEnumList.validate!(input[:enum_list], context: "#{context}[:enum_list]") unless input[:enum_list].nil?
        IntegerEnumList.validate!(input[:int_enum_list], context: "#{context}[:int_enum_list]") unless input[:int_enum_list].nil?
        NestedStringList.validate!(input[:nested_string_list], context: "#{context}[:nested_string_list]") unless input[:nested_string_list].nil?
        StructureList.validate!(input[:structure_list], context: "#{context}[:structure_list]") unless input[:structure_list].nil?
      end
    end

    class JsonListsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonListsOutput, context: context)
        StringList.validate!(input[:string_list], context: "#{context}[:string_list]") unless input[:string_list].nil?
        StringSet.validate!(input[:string_set], context: "#{context}[:string_set]") unless input[:string_set].nil?
        IntegerList.validate!(input[:integer_list], context: "#{context}[:integer_list]") unless input[:integer_list].nil?
        BooleanList.validate!(input[:boolean_list], context: "#{context}[:boolean_list]") unless input[:boolean_list].nil?
        TimestampList.validate!(input[:timestamp_list], context: "#{context}[:timestamp_list]") unless input[:timestamp_list].nil?
        FooEnumList.validate!(input[:enum_list], context: "#{context}[:enum_list]") unless input[:enum_list].nil?
        IntegerEnumList.validate!(input[:int_enum_list], context: "#{context}[:int_enum_list]") unless input[:int_enum_list].nil?
        NestedStringList.validate!(input[:nested_string_list], context: "#{context}[:nested_string_list]") unless input[:nested_string_list].nil?
        StructureList.validate!(input[:structure_list], context: "#{context}[:structure_list]") unless input[:structure_list].nil?
      end
    end

    class JsonMapsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonMapsInput, context: context)
        DenseStructMap.validate!(input[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless input[:dense_struct_map].nil?
        DenseNumberMap.validate!(input[:dense_number_map], context: "#{context}[:dense_number_map]") unless input[:dense_number_map].nil?
        DenseBooleanMap.validate!(input[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless input[:dense_boolean_map].nil?
        DenseStringMap.validate!(input[:dense_string_map], context: "#{context}[:dense_string_map]") unless input[:dense_string_map].nil?
        DenseSetMap.validate!(input[:dense_set_map], context: "#{context}[:dense_set_map]") unless input[:dense_set_map].nil?
      end
    end

    class JsonMapsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonMapsOutput, context: context)
        DenseStructMap.validate!(input[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless input[:dense_struct_map].nil?
        DenseNumberMap.validate!(input[:dense_number_map], context: "#{context}[:dense_number_map]") unless input[:dense_number_map].nil?
        DenseBooleanMap.validate!(input[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless input[:dense_boolean_map].nil?
        DenseStringMap.validate!(input[:dense_string_map], context: "#{context}[:dense_string_map]") unless input[:dense_string_map].nil?
        DenseSetMap.validate!(input[:dense_set_map], context: "#{context}[:dense_set_map]") unless input[:dense_set_map].nil?
      end
    end

    class JsonTimestampsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonTimestampsInput, context: context)
        Hearth::Validator.validate_types!(input[:normal], ::Time, context: "#{context}[:normal]")
        Hearth::Validator.validate_types!(input[:date_time], ::Time, context: "#{context}[:date_time]")
        Hearth::Validator.validate_types!(input[:date_time_on_target], ::Time, context: "#{context}[:date_time_on_target]")
        Hearth::Validator.validate_types!(input[:epoch_seconds], ::Time, context: "#{context}[:epoch_seconds]")
        Hearth::Validator.validate_types!(input[:epoch_seconds_on_target], ::Time, context: "#{context}[:epoch_seconds_on_target]")
        Hearth::Validator.validate_types!(input[:http_date], ::Time, context: "#{context}[:http_date]")
        Hearth::Validator.validate_types!(input[:http_date_on_target], ::Time, context: "#{context}[:http_date_on_target]")
      end
    end

    class JsonTimestampsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonTimestampsOutput, context: context)
        Hearth::Validator.validate_types!(input[:normal], ::Time, context: "#{context}[:normal]")
        Hearth::Validator.validate_types!(input[:date_time], ::Time, context: "#{context}[:date_time]")
        Hearth::Validator.validate_types!(input[:date_time_on_target], ::Time, context: "#{context}[:date_time_on_target]")
        Hearth::Validator.validate_types!(input[:epoch_seconds], ::Time, context: "#{context}[:epoch_seconds]")
        Hearth::Validator.validate_types!(input[:epoch_seconds_on_target], ::Time, context: "#{context}[:epoch_seconds_on_target]")
        Hearth::Validator.validate_types!(input[:http_date], ::Time, context: "#{context}[:http_date]")
        Hearth::Validator.validate_types!(input[:http_date_on_target], ::Time, context: "#{context}[:http_date_on_target]")
      end
    end

    class JsonUnionsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonUnionsInput, context: context)
        MyUnion.validate!(input[:contents], context: "#{context}[:contents]") unless input[:contents].nil?
      end
    end

    class JsonUnionsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::JsonUnionsOutput, context: context)
        MyUnion.validate!(input[:contents], context: "#{context}[:contents]") unless input[:contents].nil?
      end
    end

    class MediaTypeHeaderInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::MediaTypeHeaderInput, context: context)
        Hearth::Validator.validate_types!(input[:json], ::String, context: "#{context}[:json]")
      end
    end

    class MediaTypeHeaderOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::MediaTypeHeaderOutput, context: context)
        Hearth::Validator.validate_types!(input[:json], ::String, context: "#{context}[:json]")
      end
    end

    class MyUnion
      def self.validate!(input, context:)
        case input
        when Types::MyUnion::StringValue
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::MyUnion::BooleanValue
          Hearth::Validator.validate_types!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::MyUnion::NumberValue
          Hearth::Validator.validate_types!(input.__getobj__, ::Integer, context: context)
        when Types::MyUnion::BlobValue
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::MyUnion::TimestampValue
          Hearth::Validator.validate_types!(input.__getobj__, ::Time, context: context)
        when Types::MyUnion::EnumValue
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::MyUnion::ListValue
          StringList.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::MyUnion::MapValue
          StringMap.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::MyUnion::StructureValue
          GreetingStruct.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::MyUnion::RenamedStructureValue
          RenamedGreeting.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::MyUnion, got #{input.class}."
        end
      end

      class StringValue
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class BooleanValue
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::TrueClass, ::FalseClass, context: context)
        end
      end

      class NumberValue
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::Integer, context: context)
        end
      end

      class BlobValue
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class TimestampValue
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::Time, context: context)
        end
      end

      class EnumValue
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class ListValue
        def self.validate!(input, context:)
          Validators::StringList.validate!(input, context: context) unless input.nil?
        end
      end

      class MapValue
        def self.validate!(input, context:)
          Validators::StringMap.validate!(input, context: context) unless input.nil?
        end
      end

      class StructureValue
        def self.validate!(input, context:)
          Validators::GreetingStruct.validate!(input, context: context) unless input.nil?
        end
      end

      class RenamedStructureValue
        def self.validate!(input, context:)
          Validators::RenamedGreeting.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class NestedPayload
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NestedPayload, context: context)
        Hearth::Validator.validate_types!(input[:greeting], ::String, context: "#{context}[:greeting]")
        Hearth::Validator.validate_types!(input[:name], ::String, context: "#{context}[:name]")
      end
    end

    class NestedStringList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          StringList.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class NoInputAndNoOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoInputAndNoOutputInput, context: context)
      end
    end

    class NoInputAndNoOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoInputAndNoOutputOutput, context: context)
      end
    end

    class NoInputAndOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoInputAndOutputInput, context: context)
      end
    end

    class NoInputAndOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoInputAndOutputOutput, context: context)
      end
    end

    class NullAndEmptyHeadersClientInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NullAndEmptyHeadersClientInput, context: context)
        Hearth::Validator.validate_types!(input[:a], ::String, context: "#{context}[:a]")
        Hearth::Validator.validate_types!(input[:b], ::String, context: "#{context}[:b]")
        StringList.validate!(input[:c], context: "#{context}[:c]") unless input[:c].nil?
      end
    end

    class NullAndEmptyHeadersClientOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NullAndEmptyHeadersClientOutput, context: context)
        Hearth::Validator.validate_types!(input[:a], ::String, context: "#{context}[:a]")
        Hearth::Validator.validate_types!(input[:b], ::String, context: "#{context}[:b]")
        StringList.validate!(input[:c], context: "#{context}[:c]") unless input[:c].nil?
      end
    end

    class NullAndEmptyHeadersServerInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NullAndEmptyHeadersServerInput, context: context)
        Hearth::Validator.validate_types!(input[:a], ::String, context: "#{context}[:a]")
        Hearth::Validator.validate_types!(input[:b], ::String, context: "#{context}[:b]")
        StringList.validate!(input[:c], context: "#{context}[:c]") unless input[:c].nil?
      end
    end

    class NullAndEmptyHeadersServerOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NullAndEmptyHeadersServerOutput, context: context)
        Hearth::Validator.validate_types!(input[:a], ::String, context: "#{context}[:a]")
        Hearth::Validator.validate_types!(input[:b], ::String, context: "#{context}[:b]")
        StringList.validate!(input[:c], context: "#{context}[:c]") unless input[:c].nil?
      end
    end

    class OmitsNullSerializesEmptyStringInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OmitsNullSerializesEmptyStringInput, context: context)
        Hearth::Validator.validate_types!(input[:null_value], ::String, context: "#{context}[:null_value]")
        Hearth::Validator.validate_types!(input[:empty_string], ::String, context: "#{context}[:empty_string]")
      end
    end

    class OmitsNullSerializesEmptyStringOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OmitsNullSerializesEmptyStringOutput, context: context)
      end
    end

    class OmitsSerializingEmptyListsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OmitsSerializingEmptyListsInput, context: context)
        StringList.validate!(input[:query_string_list], context: "#{context}[:query_string_list]") unless input[:query_string_list].nil?
        IntegerList.validate!(input[:query_integer_list], context: "#{context}[:query_integer_list]") unless input[:query_integer_list].nil?
        DoubleList.validate!(input[:query_double_list], context: "#{context}[:query_double_list]") unless input[:query_double_list].nil?
        BooleanList.validate!(input[:query_boolean_list], context: "#{context}[:query_boolean_list]") unless input[:query_boolean_list].nil?
        TimestampList.validate!(input[:query_timestamp_list], context: "#{context}[:query_timestamp_list]") unless input[:query_timestamp_list].nil?
        FooEnumList.validate!(input[:query_enum_list], context: "#{context}[:query_enum_list]") unless input[:query_enum_list].nil?
        IntegerEnumList.validate!(input[:query_integer_enum_list], context: "#{context}[:query_integer_enum_list]") unless input[:query_integer_enum_list].nil?
      end
    end

    class OmitsSerializingEmptyListsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OmitsSerializingEmptyListsOutput, context: context)
      end
    end

    class OperationWithDefaultsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OperationWithDefaultsInput, context: context)
        Defaults.validate!(input[:defaults], context: "#{context}[:defaults]") unless input[:defaults].nil?
        ClientOptionalDefaults.validate!(input[:client_optional_defaults], context: "#{context}[:client_optional_defaults]") unless input[:client_optional_defaults].nil?
        Hearth::Validator.validate_types!(input[:top_level_default], ::String, context: "#{context}[:top_level_default]")
        Hearth::Validator.validate_types!(input[:other_top_level_default], ::Integer, context: "#{context}[:other_top_level_default]")
      end
    end

    class OperationWithDefaultsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OperationWithDefaultsOutput, context: context)
        Hearth::Validator.validate_types!(input[:default_string], ::String, context: "#{context}[:default_string]")
        Hearth::Validator.validate_types!(input[:default_boolean], ::TrueClass, ::FalseClass, context: "#{context}[:default_boolean]")
        TestStringList.validate!(input[:default_list], context: "#{context}[:default_list]") unless input[:default_list].nil?
        Document.validate!(input[:default_document_map], context: "#{context}[:default_document_map]") unless input[:default_document_map].nil?
        Document.validate!(input[:default_document_string], context: "#{context}[:default_document_string]") unless input[:default_document_string].nil?
        Document.validate!(input[:default_document_boolean], context: "#{context}[:default_document_boolean]") unless input[:default_document_boolean].nil?
        Document.validate!(input[:default_document_list], context: "#{context}[:default_document_list]") unless input[:default_document_list].nil?
        Document.validate!(input[:default_null_document], context: "#{context}[:default_null_document]") unless input[:default_null_document].nil?
        Hearth::Validator.validate_types!(input[:default_timestamp], ::Time, context: "#{context}[:default_timestamp]")
        Hearth::Validator.validate_types!(input[:default_blob], ::String, context: "#{context}[:default_blob]")
        Hearth::Validator.validate_types!(input[:default_byte], ::Integer, context: "#{context}[:default_byte]")
        Hearth::Validator.validate_types!(input[:default_short], ::Integer, context: "#{context}[:default_short]")
        Hearth::Validator.validate_types!(input[:default_integer], ::Integer, context: "#{context}[:default_integer]")
        Hearth::Validator.validate_types!(input[:default_long], ::Integer, context: "#{context}[:default_long]")
        Hearth::Validator.validate_types!(input[:default_float], ::Float, context: "#{context}[:default_float]")
        Hearth::Validator.validate_types!(input[:default_double], ::Float, context: "#{context}[:default_double]")
        TestStringMap.validate!(input[:default_map], context: "#{context}[:default_map]") unless input[:default_map].nil?
        Hearth::Validator.validate_types!(input[:default_enum], ::String, context: "#{context}[:default_enum]")
        Hearth::Validator.validate_types!(input[:default_int_enum], ::Integer, context: "#{context}[:default_int_enum]")
        Hearth::Validator.validate_types!(input[:empty_string], ::String, context: "#{context}[:empty_string]")
        Hearth::Validator.validate_types!(input[:false_boolean], ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean]")
        Hearth::Validator.validate_types!(input[:empty_blob], ::String, context: "#{context}[:empty_blob]")
        Hearth::Validator.validate_types!(input[:zero_byte], ::Integer, context: "#{context}[:zero_byte]")
        Hearth::Validator.validate_types!(input[:zero_short], ::Integer, context: "#{context}[:zero_short]")
        Hearth::Validator.validate_types!(input[:zero_integer], ::Integer, context: "#{context}[:zero_integer]")
        Hearth::Validator.validate_types!(input[:zero_long], ::Integer, context: "#{context}[:zero_long]")
        Hearth::Validator.validate_types!(input[:zero_float], ::Float, context: "#{context}[:zero_float]")
        Hearth::Validator.validate_types!(input[:zero_double], ::Float, context: "#{context}[:zero_double]")
      end
    end

    class OperationWithNestedStructureInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OperationWithNestedStructureInput, context: context)
        Hearth::Validator.validate_required!(input[:top_level], context: "#{context}[:top_level]")
        TopLevel.validate!(input[:top_level], context: "#{context}[:top_level]") unless input[:top_level].nil?
      end
    end

    class OperationWithNestedStructureOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OperationWithNestedStructureOutput, context: context)
        Hearth::Validator.validate_required!(input[:dialog], context: "#{context}[:dialog]")
        Dialog.validate!(input[:dialog], context: "#{context}[:dialog]") unless input[:dialog].nil?
        DialogList.validate!(input[:dialog_list], context: "#{context}[:dialog_list]") unless input[:dialog_list].nil?
        DialogMap.validate!(input[:dialog_map], context: "#{context}[:dialog_map]") unless input[:dialog_map].nil?
      end
    end

    class PayloadConfig
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PayloadConfig, context: context)
        Hearth::Validator.validate_types!(input[:data], ::Integer, context: "#{context}[:data]")
      end
    end

    class PlayerAction
      def self.validate!(input, context:)
        case input
        when Types::PlayerAction::Quit
          Unit.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::PlayerAction, got #{input.class}."
        end
      end

      class Quit
        def self.validate!(input, context:)
          Validators::Unit.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class PostPlayerActionInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PostPlayerActionInput, context: context)
        PlayerAction.validate!(input[:action], context: "#{context}[:action]") unless input[:action].nil?
      end
    end

    class PostPlayerActionOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PostPlayerActionOutput, context: context)
        Hearth::Validator.validate_required!(input[:action], context: "#{context}[:action]")
        PlayerAction.validate!(input[:action], context: "#{context}[:action]") unless input[:action].nil?
      end
    end

    class PostUnionWithJsonNameInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PostUnionWithJsonNameInput, context: context)
        UnionWithJsonName.validate!(input[:value], context: "#{context}[:value]") unless input[:value].nil?
      end
    end

    class PostUnionWithJsonNameOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PostUnionWithJsonNameOutput, context: context)
        Hearth::Validator.validate_required!(input[:value], context: "#{context}[:value]")
        UnionWithJsonName.validate!(input[:value], context: "#{context}[:value]") unless input[:value].nil?
      end
    end

    class PutWithContentEncodingInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PutWithContentEncodingInput, context: context)
        Hearth::Validator.validate_types!(input[:encoding], ::String, context: "#{context}[:encoding]")
        Hearth::Validator.validate_types!(input[:data], ::String, context: "#{context}[:data]")
      end
    end

    class PutWithContentEncodingOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PutWithContentEncodingOutput, context: context)
      end
    end

    class QueryIdempotencyTokenAutoFillInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::QueryIdempotencyTokenAutoFillInput, context: context)
        Hearth::Validator.validate_types!(input[:token], ::String, context: "#{context}[:token]")
      end
    end

    class QueryIdempotencyTokenAutoFillOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::QueryIdempotencyTokenAutoFillOutput, context: context)
      end
    end

    class QueryParamsAsStringListMapInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::QueryParamsAsStringListMapInput, context: context)
        Hearth::Validator.validate_types!(input[:qux], ::String, context: "#{context}[:qux]")
        StringListMap.validate!(input[:foo], context: "#{context}[:foo]") unless input[:foo].nil?
      end
    end

    class QueryParamsAsStringListMapOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::QueryParamsAsStringListMapOutput, context: context)
      end
    end

    class QueryPrecedenceInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::QueryPrecedenceInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        StringMap.validate!(input[:baz], context: "#{context}[:baz]") unless input[:baz].nil?
      end
    end

    class QueryPrecedenceOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::QueryPrecedenceOutput, context: context)
      end
    end

    class RecursiveShapesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesInput, context: context)
        RecursiveShapesInputOutputNested1.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesInputOutputNested1, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        RecursiveShapesInputOutputNested2.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesInputOutputNested2, context: context)
        Hearth::Validator.validate_types!(input[:bar], ::String, context: "#{context}[:bar]")
        RecursiveShapesInputOutputNested1.validate!(input[:recursive_member], context: "#{context}[:recursive_member]") unless input[:recursive_member].nil?
      end
    end

    class RecursiveShapesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesOutput, context: context)
        RecursiveShapesInputOutputNested1.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class SimpleScalarPropertiesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SimpleScalarPropertiesInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate_types!(input[:string_value], ::String, context: "#{context}[:string_value]")
        Hearth::Validator.validate_types!(input[:true_boolean_value], ::TrueClass, ::FalseClass, context: "#{context}[:true_boolean_value]")
        Hearth::Validator.validate_types!(input[:false_boolean_value], ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean_value]")
        Hearth::Validator.validate_types!(input[:byte_value], ::Integer, context: "#{context}[:byte_value]")
        Hearth::Validator.validate_types!(input[:short_value], ::Integer, context: "#{context}[:short_value]")
        Hearth::Validator.validate_types!(input[:integer_value], ::Integer, context: "#{context}[:integer_value]")
        Hearth::Validator.validate_types!(input[:long_value], ::Integer, context: "#{context}[:long_value]")
        Hearth::Validator.validate_types!(input[:float_value], ::Float, context: "#{context}[:float_value]")
        Hearth::Validator.validate_types!(input[:double_value], ::Float, context: "#{context}[:double_value]")
      end
    end

    class SimpleScalarPropertiesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SimpleScalarPropertiesOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate_types!(input[:string_value], ::String, context: "#{context}[:string_value]")
        Hearth::Validator.validate_types!(input[:true_boolean_value], ::TrueClass, ::FalseClass, context: "#{context}[:true_boolean_value]")
        Hearth::Validator.validate_types!(input[:false_boolean_value], ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean_value]")
        Hearth::Validator.validate_types!(input[:byte_value], ::Integer, context: "#{context}[:byte_value]")
        Hearth::Validator.validate_types!(input[:short_value], ::Integer, context: "#{context}[:short_value]")
        Hearth::Validator.validate_types!(input[:integer_value], ::Integer, context: "#{context}[:integer_value]")
        Hearth::Validator.validate_types!(input[:long_value], ::Integer, context: "#{context}[:long_value]")
        Hearth::Validator.validate_types!(input[:float_value], ::Float, context: "#{context}[:float_value]")
        Hearth::Validator.validate_types!(input[:double_value], ::Float, context: "#{context}[:double_value]")
      end
    end

    class SparseBooleanMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::TrueClass, ::FalseClass, context: "#{context}[:#{key}]")
        end
      end
    end

    class SparseJsonListsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SparseJsonListsInput, context: context)
        SparseStringList.validate!(input[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless input[:sparse_string_list].nil?
      end
    end

    class SparseJsonListsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SparseJsonListsOutput, context: context)
        SparseStringList.validate!(input[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless input[:sparse_string_list].nil?
      end
    end

    class SparseJsonMapsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SparseJsonMapsInput, context: context)
        SparseStructMap.validate!(input[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless input[:sparse_struct_map].nil?
        SparseNumberMap.validate!(input[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless input[:sparse_number_map].nil?
        SparseBooleanMap.validate!(input[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless input[:sparse_boolean_map].nil?
        SparseStringMap.validate!(input[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless input[:sparse_string_map].nil?
        SparseSetMap.validate!(input[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless input[:sparse_set_map].nil?
      end
    end

    class SparseJsonMapsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SparseJsonMapsOutput, context: context)
        SparseStructMap.validate!(input[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless input[:sparse_struct_map].nil?
        SparseNumberMap.validate!(input[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless input[:sparse_number_map].nil?
        SparseBooleanMap.validate!(input[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless input[:sparse_boolean_map].nil?
        SparseStringMap.validate!(input[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless input[:sparse_string_map].nil?
        SparseSetMap.validate!(input[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless input[:sparse_set_map].nil?
      end
    end

    class SparseNumberMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::Integer, context: "#{context}[:#{key}]")
        end
      end
    end

    class SparseSetMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          StringSet.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class SparseStringList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class SparseStringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class SparseStructMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          GreetingStruct.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class StreamingTraitsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingTraitsInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        unless input[:blob].respond_to?(:read) || input[:blob].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:blob].class}"
        end
      end
    end

    class StreamingTraitsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingTraitsOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        unless input[:blob].respond_to?(:read) || input[:blob].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:blob].class}"
        end
      end
    end

    class StreamingTraitsRequireLengthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingTraitsRequireLengthInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        unless input[:blob].respond_to?(:read) || input[:blob].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:blob].class}"
        end

        unless input[:blob].respond_to?(:size)
          raise ArgumentError, "Expected #{context} to respond_to(:size)"
        end
      end
    end

    class StreamingTraitsRequireLengthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingTraitsRequireLengthOutput, context: context)
      end
    end

    class StreamingTraitsWithMediaTypeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingTraitsWithMediaTypeInput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        unless input[:blob].respond_to?(:read) || input[:blob].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:blob].class}"
        end
      end
    end

    class StreamingTraitsWithMediaTypeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingTraitsWithMediaTypeOutput, context: context)
        Hearth::Validator.validate_types!(input[:foo], ::String, context: "#{context}[:foo]")
        unless input[:blob].respond_to?(:read) || input[:blob].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:blob].class}"
        end
      end
    end

    class StringList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class StringListMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          StringList.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class StringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class StringSet
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class StructureList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          StructureListMember.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class StructureListMember
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StructureListMember, context: context)
        Hearth::Validator.validate_types!(input[:a], ::String, context: "#{context}[:a]")
        Hearth::Validator.validate_types!(input[:b], ::String, context: "#{context}[:b]")
      end
    end

    class TestBodyStructureInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestBodyStructureInput, context: context)
        Hearth::Validator.validate_types!(input[:test_id], ::String, context: "#{context}[:test_id]")
        TestConfig.validate!(input[:test_config], context: "#{context}[:test_config]") unless input[:test_config].nil?
      end
    end

    class TestBodyStructureOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestBodyStructureOutput, context: context)
        Hearth::Validator.validate_types!(input[:test_id], ::String, context: "#{context}[:test_id]")
        TestConfig.validate!(input[:test_config], context: "#{context}[:test_config]") unless input[:test_config].nil?
      end
    end

    class TestConfig
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestConfig, context: context)
        Hearth::Validator.validate_types!(input[:timeout], ::Integer, context: "#{context}[:timeout]")
      end
    end

    class TestNoPayloadInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestNoPayloadInput, context: context)
        Hearth::Validator.validate_types!(input[:test_id], ::String, context: "#{context}[:test_id]")
      end
    end

    class TestNoPayloadOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestNoPayloadOutput, context: context)
        Hearth::Validator.validate_types!(input[:test_id], ::String, context: "#{context}[:test_id]")
      end
    end

    class TestPayloadBlobInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestPayloadBlobInput, context: context)
        Hearth::Validator.validate_types!(input[:content_type], ::String, context: "#{context}[:content_type]")
        Hearth::Validator.validate_types!(input[:data], ::String, context: "#{context}[:data]")
      end
    end

    class TestPayloadBlobOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestPayloadBlobOutput, context: context)
        Hearth::Validator.validate_types!(input[:content_type], ::String, context: "#{context}[:content_type]")
        Hearth::Validator.validate_types!(input[:data], ::String, context: "#{context}[:data]")
      end
    end

    class TestPayloadStructureInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestPayloadStructureInput, context: context)
        Hearth::Validator.validate_types!(input[:test_id], ::String, context: "#{context}[:test_id]")
        PayloadConfig.validate!(input[:payload_config], context: "#{context}[:payload_config]") unless input[:payload_config].nil?
      end
    end

    class TestPayloadStructureOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TestPayloadStructureOutput, context: context)
        Hearth::Validator.validate_types!(input[:test_id], ::String, context: "#{context}[:test_id]")
        PayloadConfig.validate!(input[:payload_config], context: "#{context}[:payload_config]") unless input[:payload_config].nil?
      end
    end

    class TestStringList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class TestStringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class TimestampFormatHeadersInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TimestampFormatHeadersInput, context: context)
        Hearth::Validator.validate_types!(input[:member_epoch_seconds], ::Time, context: "#{context}[:member_epoch_seconds]")
        Hearth::Validator.validate_types!(input[:member_http_date], ::Time, context: "#{context}[:member_http_date]")
        Hearth::Validator.validate_types!(input[:member_date_time], ::Time, context: "#{context}[:member_date_time]")
        Hearth::Validator.validate_types!(input[:default_format], ::Time, context: "#{context}[:default_format]")
        Hearth::Validator.validate_types!(input[:target_epoch_seconds], ::Time, context: "#{context}[:target_epoch_seconds]")
        Hearth::Validator.validate_types!(input[:target_http_date], ::Time, context: "#{context}[:target_http_date]")
        Hearth::Validator.validate_types!(input[:target_date_time], ::Time, context: "#{context}[:target_date_time]")
      end
    end

    class TimestampFormatHeadersOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TimestampFormatHeadersOutput, context: context)
        Hearth::Validator.validate_types!(input[:member_epoch_seconds], ::Time, context: "#{context}[:member_epoch_seconds]")
        Hearth::Validator.validate_types!(input[:member_http_date], ::Time, context: "#{context}[:member_http_date]")
        Hearth::Validator.validate_types!(input[:member_date_time], ::Time, context: "#{context}[:member_date_time]")
        Hearth::Validator.validate_types!(input[:default_format], ::Time, context: "#{context}[:default_format]")
        Hearth::Validator.validate_types!(input[:target_epoch_seconds], ::Time, context: "#{context}[:target_epoch_seconds]")
        Hearth::Validator.validate_types!(input[:target_http_date], ::Time, context: "#{context}[:target_http_date]")
        Hearth::Validator.validate_types!(input[:target_date_time], ::Time, context: "#{context}[:target_date_time]")
      end
    end

    class TimestampList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::Time, context: "#{context}[#{index}]")
        end
      end
    end

    class TopLevel
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::TopLevel, context: context)
        Hearth::Validator.validate_required!(input[:dialog], context: "#{context}[:dialog]")
        Dialog.validate!(input[:dialog], context: "#{context}[:dialog]") unless input[:dialog].nil?
        DialogList.validate!(input[:dialog_list], context: "#{context}[:dialog_list]") unless input[:dialog_list].nil?
        DialogMap.validate!(input[:dialog_map], context: "#{context}[:dialog_map]") unless input[:dialog_map].nil?
      end
    end

    class UnionPayload
      def self.validate!(input, context:)
        case input
        when Types::UnionPayload::Greeting
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::UnionPayload, got #{input.class}."
        end
      end

      class Greeting
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end
    end

    class UnionWithJsonName
      def self.validate!(input, context:)
        case input
        when Types::UnionWithJsonName::Foo
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::UnionWithJsonName::Bar
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::UnionWithJsonName::Baz
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::UnionWithJsonName, got #{input.class}."
        end
      end

      class Foo
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class Bar
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end

      class Baz
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
        end
      end
    end

    class Unit
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Unit, context: context)
      end
    end

    class UnitInputAndOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::UnitInputAndOutputInput, context: context)
      end
    end

    class UnitInputAndOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::UnitInputAndOutputOutput, context: context)
      end
    end

  end
end
