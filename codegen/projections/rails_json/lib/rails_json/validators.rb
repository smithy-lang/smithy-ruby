# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module RailsJson
  module Validators

    class AllQueryStringTypesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::AllQueryStringTypesInput, context: context)
        Hearth::Validator.validate!(input[:query_string], ::String, context: "#{context}[:query_string]")
        Validators::StringList.validate!(input[:query_string_list], context: "#{context}[:query_string_list]") unless input[:query_string_list].nil?
        Validators::StringSet.validate!(input[:query_string_set], context: "#{context}[:query_string_set]") unless input[:query_string_set].nil?
        Hearth::Validator.validate!(input[:query_byte], ::Integer, context: "#{context}[:query_byte]")
        Hearth::Validator.validate!(input[:query_short], ::Integer, context: "#{context}[:query_short]")
        Hearth::Validator.validate!(input[:query_integer], ::Integer, context: "#{context}[:query_integer]")
        Validators::IntegerList.validate!(input[:query_integer_list], context: "#{context}[:query_integer_list]") unless input[:query_integer_list].nil?
        Validators::IntegerSet.validate!(input[:query_integer_set], context: "#{context}[:query_integer_set]") unless input[:query_integer_set].nil?
        Hearth::Validator.validate!(input[:query_long], ::Integer, context: "#{context}[:query_long]")
        Hearth::Validator.validate!(input[:query_float], ::Float, context: "#{context}[:query_float]")
        Hearth::Validator.validate!(input[:query_double], ::Float, context: "#{context}[:query_double]")
        Validators::DoubleList.validate!(input[:query_double_list], context: "#{context}[:query_double_list]") unless input[:query_double_list].nil?
        Hearth::Validator.validate!(input[:query_boolean], ::TrueClass, ::FalseClass, context: "#{context}[:query_boolean]")
        Validators::BooleanList.validate!(input[:query_boolean_list], context: "#{context}[:query_boolean_list]") unless input[:query_boolean_list].nil?
        Hearth::Validator.validate!(input[:query_timestamp], ::Time, context: "#{context}[:query_timestamp]")
        Validators::TimestampList.validate!(input[:query_timestamp_list], context: "#{context}[:query_timestamp_list]") unless input[:query_timestamp_list].nil?
        Hearth::Validator.validate!(input[:query_enum], ::String, context: "#{context}[:query_enum]")
        Validators::FooEnumList.validate!(input[:query_enum_list], context: "#{context}[:query_enum_list]") unless input[:query_enum_list].nil?
        Validators::StringMap.validate!(input[:query_params_map_of_strings], context: "#{context}[:query_params_map_of_strings]") unless input[:query_params_map_of_strings].nil?
      end
    end

    class AllQueryStringTypesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::AllQueryStringTypesOutput, context: context)
      end
    end

    class BooleanList
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::TrueClass, ::FalseClass, context: "#{context}[#{index}]")
        end
      end
    end

    class ComplexError
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ComplexError, context: context)
        Hearth::Validator.validate!(input[:top_level], ::String, context: "#{context}[:top_level]")
        Validators::ComplexNestedErrorData.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class ComplexNestedErrorData
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ComplexNestedErrorData, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
      end
    end

    class ConstantAndVariableQueryStringInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ConstantAndVariableQueryStringInput, context: context)
        Hearth::Validator.validate!(input[:baz], ::String, context: "#{context}[:baz]")
        Hearth::Validator.validate!(input[:maybe_set], ::String, context: "#{context}[:maybe_set]")
      end
    end

    class ConstantAndVariableQueryStringOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ConstantAndVariableQueryStringOutput, context: context)
      end
    end

    class ConstantQueryStringInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ConstantQueryStringInput, context: context)
        Hearth::Validator.validate!(input[:hello], ::String, context: "#{context}[:hello]")
      end
    end

    class ConstantQueryStringOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ConstantQueryStringOutput, context: context)
      end
    end

    class DenseBooleanMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::TrueClass, ::FalseClass, context: "#{context}[:#{key}]")
        end
      end
    end

    class DenseNumberMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::Integer, context: "#{context}[:#{key}]")
        end
      end
    end

    class DenseSetMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::StringSet.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class DenseStringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class DenseStructMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::GreetingStruct.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class Document
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, ::String, ::Array, ::TrueClass, ::FalseClass, ::Numeric, context: context)
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

    class DocumentTypeAsPayloadInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::DocumentTypeAsPayloadInput, context: context)
        Validators::Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DocumentTypeAsPayloadOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::DocumentTypeAsPayloadOutput, context: context)
        Validators::Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DocumentTypeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::DocumentTypeInput, context: context)
        Hearth::Validator.validate!(input[:string_value], ::String, context: "#{context}[:string_value]")
        Validators::Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DocumentTypeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::DocumentTypeOutput, context: context)
        Hearth::Validator.validate!(input[:string_value], ::String, context: "#{context}[:string_value]")
        Validators::Document.validate!(input[:document_value], context: "#{context}[:document_value]") unless input[:document_value].nil?
      end
    end

    class DoubleList
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::Float, context: "#{context}[#{index}]")
        end
      end
    end

    class EmptyOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::EmptyOperationInput, context: context)
      end
    end

    class EmptyOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::EmptyOperationOutput, context: context)
      end
    end

    class EmptyStruct
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::EmptyStruct, context: context)
      end
    end

    class EndpointOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::EndpointOperationInput, context: context)
      end
    end

    class EndpointOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::EndpointOperationOutput, context: context)
      end
    end

    class EndpointWithHostLabelOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::EndpointWithHostLabelOperationInput, context: context)
        Hearth::Validator.validate!(input[:label], ::String, context: "#{context}[:label]")
      end
    end

    class EndpointWithHostLabelOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::EndpointWithHostLabelOperationOutput, context: context)
      end
    end

    class ErrorWithMembers
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ErrorWithMembers, context: context)
        Hearth::Validator.validate!(input[:code], ::String, context: "#{context}[:code]")
        Validators::KitchenSink.validate!(input[:complex_data], context: "#{context}[:complex_data]") unless input[:complex_data].nil?
        Hearth::Validator.validate!(input[:integer_field], ::Integer, context: "#{context}[:integer_field]")
        Validators::ListOfStrings.validate!(input[:list_field], context: "#{context}[:list_field]") unless input[:list_field].nil?
        Validators::MapOfStrings.validate!(input[:map_field], context: "#{context}[:map_field]") unless input[:map_field].nil?
        Hearth::Validator.validate!(input[:message], ::String, context: "#{context}[:message]")
        Hearth::Validator.validate!(input[:string_field], ::String, context: "#{context}[:string_field]")
      end
    end

    class ErrorWithoutMembers
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ErrorWithoutMembers, context: context)
      end
    end

    class FooEnumList
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class FooEnumMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class FooEnumSet
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Set, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class GreetingStruct
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GreetingStruct, context: context)
        Hearth::Validator.validate!(input[:hi], ::String, context: "#{context}[:hi]")
      end
    end

    class GreetingWithErrorsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GreetingWithErrorsInput, context: context)
      end
    end

    class GreetingWithErrorsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GreetingWithErrorsOutput, context: context)
        Hearth::Validator.validate!(input[:greeting], ::String, context: "#{context}[:greeting]")
      end
    end

    class HttpPayloadTraitsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPayloadTraitsInput, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadTraitsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPayloadTraitsOutput, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadTraitsWithMediaTypeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPayloadTraitsWithMediaTypeInput, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadTraitsWithMediaTypeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPayloadTraitsWithMediaTypeOutput, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate!(input[:blob], ::String, context: "#{context}[:blob]")
      end
    end

    class HttpPayloadWithStructureInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPayloadWithStructureInput, context: context)
        Validators::NestedPayload.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class HttpPayloadWithStructureOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPayloadWithStructureOutput, context: context)
        Validators::NestedPayload.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class HttpPrefixHeadersInResponseInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPrefixHeadersInResponseInput, context: context)
      end
    end

    class HttpPrefixHeadersInResponseOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPrefixHeadersInResponseOutput, context: context)
        Validators::StringMap.validate!(input[:prefix_headers], context: "#{context}[:prefix_headers]") unless input[:prefix_headers].nil?
      end
    end

    class HttpPrefixHeadersInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPrefixHeadersInput, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
        Validators::StringMap.validate!(input[:foo_map], context: "#{context}[:foo_map]") unless input[:foo_map].nil?
      end
    end

    class HttpPrefixHeadersOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpPrefixHeadersOutput, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
        Validators::StringMap.validate!(input[:foo_map], context: "#{context}[:foo_map]") unless input[:foo_map].nil?
      end
    end

    class HttpRequestWithFloatLabelsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithFloatLabelsInput, context: context)
        Hearth::Validator.validate!(input[:float], ::Float, context: "#{context}[:float]")
        Hearth::Validator.validate!(input[:double], ::Float, context: "#{context}[:double]")
      end
    end

    class HttpRequestWithFloatLabelsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithFloatLabelsOutput, context: context)
      end
    end

    class HttpRequestWithGreedyLabelInPathInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithGreedyLabelInPathInput, context: context)
        Hearth::Validator.validate!(input[:foo], ::String, context: "#{context}[:foo]")
        Hearth::Validator.validate!(input[:baz], ::String, context: "#{context}[:baz]")
      end
    end

    class HttpRequestWithGreedyLabelInPathOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithGreedyLabelInPathOutput, context: context)
      end
    end

    class HttpRequestWithLabelsAndTimestampFormatInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithLabelsAndTimestampFormatInput, context: context)
        Hearth::Validator.validate!(input[:member_epoch_seconds], ::Time, context: "#{context}[:member_epoch_seconds]")
        Hearth::Validator.validate!(input[:member_http_date], ::Time, context: "#{context}[:member_http_date]")
        Hearth::Validator.validate!(input[:member_date_time], ::Time, context: "#{context}[:member_date_time]")
        Hearth::Validator.validate!(input[:default_format], ::Time, context: "#{context}[:default_format]")
        Hearth::Validator.validate!(input[:target_epoch_seconds], ::Time, context: "#{context}[:target_epoch_seconds]")
        Hearth::Validator.validate!(input[:target_http_date], ::Time, context: "#{context}[:target_http_date]")
        Hearth::Validator.validate!(input[:target_date_time], ::Time, context: "#{context}[:target_date_time]")
      end
    end

    class HttpRequestWithLabelsAndTimestampFormatOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithLabelsAndTimestampFormatOutput, context: context)
      end
    end

    class HttpRequestWithLabelsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithLabelsInput, context: context)
        Hearth::Validator.validate!(input[:string], ::String, context: "#{context}[:string]")
        Hearth::Validator.validate!(input[:short], ::Integer, context: "#{context}[:short]")
        Hearth::Validator.validate!(input[:integer], ::Integer, context: "#{context}[:integer]")
        Hearth::Validator.validate!(input[:long], ::Integer, context: "#{context}[:long]")
        Hearth::Validator.validate!(input[:float], ::Float, context: "#{context}[:float]")
        Hearth::Validator.validate!(input[:double], ::Float, context: "#{context}[:double]")
        Hearth::Validator.validate!(input[:boolean], ::TrueClass, ::FalseClass, context: "#{context}[:boolean]")
        Hearth::Validator.validate!(input[:timestamp], ::Time, context: "#{context}[:timestamp]")
      end
    end

    class HttpRequestWithLabelsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpRequestWithLabelsOutput, context: context)
      end
    end

    class HttpResponseCodeInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpResponseCodeInput, context: context)
      end
    end

    class HttpResponseCodeOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HttpResponseCodeOutput, context: context)
        Hearth::Validator.validate!(input[:status], ::Integer, context: "#{context}[:status]")
      end
    end

    class IgnoreQueryParamsInResponseInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::IgnoreQueryParamsInResponseInput, context: context)
      end
    end

    class IgnoreQueryParamsInResponseOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::IgnoreQueryParamsInResponseOutput, context: context)
        Hearth::Validator.validate!(input[:baz], ::String, context: "#{context}[:baz]")
      end
    end

    class InputAndOutputWithHeadersInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::InputAndOutputWithHeadersInput, context: context)
        Hearth::Validator.validate!(input[:header_string], ::String, context: "#{context}[:header_string]")
        Hearth::Validator.validate!(input[:header_byte], ::Integer, context: "#{context}[:header_byte]")
        Hearth::Validator.validate!(input[:header_short], ::Integer, context: "#{context}[:header_short]")
        Hearth::Validator.validate!(input[:header_integer], ::Integer, context: "#{context}[:header_integer]")
        Hearth::Validator.validate!(input[:header_long], ::Integer, context: "#{context}[:header_long]")
        Hearth::Validator.validate!(input[:header_float], ::Float, context: "#{context}[:header_float]")
        Hearth::Validator.validate!(input[:header_double], ::Float, context: "#{context}[:header_double]")
        Hearth::Validator.validate!(input[:header_true_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_true_bool]")
        Hearth::Validator.validate!(input[:header_false_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_false_bool]")
        Validators::StringList.validate!(input[:header_string_list], context: "#{context}[:header_string_list]") unless input[:header_string_list].nil?
        Validators::StringSet.validate!(input[:header_string_set], context: "#{context}[:header_string_set]") unless input[:header_string_set].nil?
        Validators::IntegerList.validate!(input[:header_integer_list], context: "#{context}[:header_integer_list]") unless input[:header_integer_list].nil?
        Validators::BooleanList.validate!(input[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless input[:header_boolean_list].nil?
        Validators::TimestampList.validate!(input[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless input[:header_timestamp_list].nil?
        Hearth::Validator.validate!(input[:header_enum], ::String, context: "#{context}[:header_enum]")
        Validators::FooEnumList.validate!(input[:header_enum_list], context: "#{context}[:header_enum_list]") unless input[:header_enum_list].nil?
      end
    end

    class InputAndOutputWithHeadersOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::InputAndOutputWithHeadersOutput, context: context)
        Hearth::Validator.validate!(input[:header_string], ::String, context: "#{context}[:header_string]")
        Hearth::Validator.validate!(input[:header_byte], ::Integer, context: "#{context}[:header_byte]")
        Hearth::Validator.validate!(input[:header_short], ::Integer, context: "#{context}[:header_short]")
        Hearth::Validator.validate!(input[:header_integer], ::Integer, context: "#{context}[:header_integer]")
        Hearth::Validator.validate!(input[:header_long], ::Integer, context: "#{context}[:header_long]")
        Hearth::Validator.validate!(input[:header_float], ::Float, context: "#{context}[:header_float]")
        Hearth::Validator.validate!(input[:header_double], ::Float, context: "#{context}[:header_double]")
        Hearth::Validator.validate!(input[:header_true_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_true_bool]")
        Hearth::Validator.validate!(input[:header_false_bool], ::TrueClass, ::FalseClass, context: "#{context}[:header_false_bool]")
        Validators::StringList.validate!(input[:header_string_list], context: "#{context}[:header_string_list]") unless input[:header_string_list].nil?
        Validators::StringSet.validate!(input[:header_string_set], context: "#{context}[:header_string_set]") unless input[:header_string_set].nil?
        Validators::IntegerList.validate!(input[:header_integer_list], context: "#{context}[:header_integer_list]") unless input[:header_integer_list].nil?
        Validators::BooleanList.validate!(input[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless input[:header_boolean_list].nil?
        Validators::TimestampList.validate!(input[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless input[:header_timestamp_list].nil?
        Hearth::Validator.validate!(input[:header_enum], ::String, context: "#{context}[:header_enum]")
        Validators::FooEnumList.validate!(input[:header_enum_list], context: "#{context}[:header_enum_list]") unless input[:header_enum_list].nil?
      end
    end

    class IntegerList
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::Integer, context: "#{context}[#{index}]")
        end
      end
    end

    class IntegerSet
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Set, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::Integer, context: "#{context}[#{index}]")
        end
      end
    end

    class InvalidGreeting
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::InvalidGreeting, context: context)
        Hearth::Validator.validate!(input[:message], ::String, context: "#{context}[:message]")
      end
    end

    class JsonEnumsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::JsonEnumsInput, context: context)
        Hearth::Validator.validate!(input[:foo_enum1], ::String, context: "#{context}[:foo_enum1]")
        Hearth::Validator.validate!(input[:foo_enum2], ::String, context: "#{context}[:foo_enum2]")
        Hearth::Validator.validate!(input[:foo_enum3], ::String, context: "#{context}[:foo_enum3]")
        Validators::FooEnumList.validate!(input[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless input[:foo_enum_list].nil?
        Validators::FooEnumSet.validate!(input[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless input[:foo_enum_set].nil?
        Validators::FooEnumMap.validate!(input[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless input[:foo_enum_map].nil?
      end
    end

    class JsonEnumsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::JsonEnumsOutput, context: context)
        Hearth::Validator.validate!(input[:foo_enum1], ::String, context: "#{context}[:foo_enum1]")
        Hearth::Validator.validate!(input[:foo_enum2], ::String, context: "#{context}[:foo_enum2]")
        Hearth::Validator.validate!(input[:foo_enum3], ::String, context: "#{context}[:foo_enum3]")
        Validators::FooEnumList.validate!(input[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless input[:foo_enum_list].nil?
        Validators::FooEnumSet.validate!(input[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless input[:foo_enum_set].nil?
        Validators::FooEnumMap.validate!(input[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless input[:foo_enum_map].nil?
      end
    end

    class JsonMapsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::JsonMapsInput, context: context)
        Validators::DenseStructMap.validate!(input[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless input[:dense_struct_map].nil?
        Validators::SparseStructMap.validate!(input[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless input[:sparse_struct_map].nil?
        Validators::DenseNumberMap.validate!(input[:dense_number_map], context: "#{context}[:dense_number_map]") unless input[:dense_number_map].nil?
        Validators::DenseBooleanMap.validate!(input[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless input[:dense_boolean_map].nil?
        Validators::DenseStringMap.validate!(input[:dense_string_map], context: "#{context}[:dense_string_map]") unless input[:dense_string_map].nil?
        Validators::SparseNumberMap.validate!(input[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless input[:sparse_number_map].nil?
        Validators::SparseBooleanMap.validate!(input[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless input[:sparse_boolean_map].nil?
        Validators::SparseStringMap.validate!(input[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless input[:sparse_string_map].nil?
        Validators::DenseSetMap.validate!(input[:dense_set_map], context: "#{context}[:dense_set_map]") unless input[:dense_set_map].nil?
        Validators::SparseSetMap.validate!(input[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless input[:sparse_set_map].nil?
      end
    end

    class JsonMapsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::JsonMapsOutput, context: context)
        Validators::DenseStructMap.validate!(input[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless input[:dense_struct_map].nil?
        Validators::SparseStructMap.validate!(input[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless input[:sparse_struct_map].nil?
        Validators::DenseNumberMap.validate!(input[:dense_number_map], context: "#{context}[:dense_number_map]") unless input[:dense_number_map].nil?
        Validators::DenseBooleanMap.validate!(input[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless input[:dense_boolean_map].nil?
        Validators::DenseStringMap.validate!(input[:dense_string_map], context: "#{context}[:dense_string_map]") unless input[:dense_string_map].nil?
        Validators::SparseNumberMap.validate!(input[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless input[:sparse_number_map].nil?
        Validators::SparseBooleanMap.validate!(input[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless input[:sparse_boolean_map].nil?
        Validators::SparseStringMap.validate!(input[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless input[:sparse_string_map].nil?
        Validators::DenseSetMap.validate!(input[:dense_set_map], context: "#{context}[:dense_set_map]") unless input[:dense_set_map].nil?
        Validators::SparseSetMap.validate!(input[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless input[:sparse_set_map].nil?
      end
    end

    class JsonUnionsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::JsonUnionsInput, context: context)
        Validators::MyUnion.validate!(input[:contents], context: "#{context}[:contents]") unless input[:contents].nil?
      end
    end

    class JsonUnionsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::JsonUnionsOutput, context: context)
        Validators::MyUnion.validate!(input[:contents], context: "#{context}[:contents]") unless input[:contents].nil?
      end
    end

    class KitchenSink
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::KitchenSink, context: context)
        Hearth::Validator.validate!(input[:blob], ::String, context: "#{context}[:blob]")
        Hearth::Validator.validate!(input[:boolean], ::TrueClass, ::FalseClass, context: "#{context}[:boolean]")
        Hearth::Validator.validate!(input[:double], ::Float, context: "#{context}[:double]")
        Validators::EmptyStruct.validate!(input[:empty_struct], context: "#{context}[:empty_struct]") unless input[:empty_struct].nil?
        Hearth::Validator.validate!(input[:float], ::Float, context: "#{context}[:float]")
        Hearth::Validator.validate!(input[:httpdate_timestamp], ::Time, context: "#{context}[:httpdate_timestamp]")
        Hearth::Validator.validate!(input[:integer], ::Integer, context: "#{context}[:integer]")
        Hearth::Validator.validate!(input[:iso8601_timestamp], ::Time, context: "#{context}[:iso8601_timestamp]")
        Hearth::Validator.validate!(input[:json_value], ::String, context: "#{context}[:json_value]")
        Validators::ListOfListOfStrings.validate!(input[:list_of_lists], context: "#{context}[:list_of_lists]") unless input[:list_of_lists].nil?
        Validators::ListOfMapsOfStrings.validate!(input[:list_of_maps_of_strings], context: "#{context}[:list_of_maps_of_strings]") unless input[:list_of_maps_of_strings].nil?
        Validators::ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        Validators::ListOfStructs.validate!(input[:list_of_structs], context: "#{context}[:list_of_structs]") unless input[:list_of_structs].nil?
        Hearth::Validator.validate!(input[:long], ::Integer, context: "#{context}[:long]")
        Validators::MapOfListsOfStrings.validate!(input[:map_of_lists_of_strings], context: "#{context}[:map_of_lists_of_strings]") unless input[:map_of_lists_of_strings].nil?
        Validators::MapOfMapOfStrings.validate!(input[:map_of_maps], context: "#{context}[:map_of_maps]") unless input[:map_of_maps].nil?
        Validators::MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        Validators::MapOfStructs.validate!(input[:map_of_structs], context: "#{context}[:map_of_structs]") unless input[:map_of_structs].nil?
        Validators::ListOfKitchenSinks.validate!(input[:recursive_list], context: "#{context}[:recursive_list]") unless input[:recursive_list].nil?
        Validators::MapOfKitchenSinks.validate!(input[:recursive_map], context: "#{context}[:recursive_map]") unless input[:recursive_map].nil?
        Validators::KitchenSink.validate!(input[:recursive_struct], context: "#{context}[:recursive_struct]") unless input[:recursive_struct].nil?
        Validators::SimpleStruct.validate!(input[:simple_struct], context: "#{context}[:simple_struct]") unless input[:simple_struct].nil?
        Hearth::Validator.validate!(input[:string], ::String, context: "#{context}[:string]")
        Validators::StructWithLocationName.validate!(input[:struct_with_location_name], context: "#{context}[:struct_with_location_name]") unless input[:struct_with_location_name].nil?
        Hearth::Validator.validate!(input[:timestamp], ::Time, context: "#{context}[:timestamp]")
        Hearth::Validator.validate!(input[:unix_timestamp], ::Time, context: "#{context}[:unix_timestamp]")
      end
    end

    class KitchenSinkOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::KitchenSinkOperationInput, context: context)
        Hearth::Validator.validate!(input[:blob], ::String, context: "#{context}[:blob]")
        Hearth::Validator.validate!(input[:boolean], ::TrueClass, ::FalseClass, context: "#{context}[:boolean]")
        Hearth::Validator.validate!(input[:double], ::Float, context: "#{context}[:double]")
        Validators::EmptyStruct.validate!(input[:empty_struct], context: "#{context}[:empty_struct]") unless input[:empty_struct].nil?
        Hearth::Validator.validate!(input[:float], ::Float, context: "#{context}[:float]")
        Hearth::Validator.validate!(input[:httpdate_timestamp], ::Time, context: "#{context}[:httpdate_timestamp]")
        Hearth::Validator.validate!(input[:integer], ::Integer, context: "#{context}[:integer]")
        Hearth::Validator.validate!(input[:iso8601_timestamp], ::Time, context: "#{context}[:iso8601_timestamp]")
        Hearth::Validator.validate!(input[:json_value], ::String, context: "#{context}[:json_value]")
        Validators::ListOfListOfStrings.validate!(input[:list_of_lists], context: "#{context}[:list_of_lists]") unless input[:list_of_lists].nil?
        Validators::ListOfMapsOfStrings.validate!(input[:list_of_maps_of_strings], context: "#{context}[:list_of_maps_of_strings]") unless input[:list_of_maps_of_strings].nil?
        Validators::ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        Validators::ListOfStructs.validate!(input[:list_of_structs], context: "#{context}[:list_of_structs]") unless input[:list_of_structs].nil?
        Hearth::Validator.validate!(input[:long], ::Integer, context: "#{context}[:long]")
        Validators::MapOfListsOfStrings.validate!(input[:map_of_lists_of_strings], context: "#{context}[:map_of_lists_of_strings]") unless input[:map_of_lists_of_strings].nil?
        Validators::MapOfMapOfStrings.validate!(input[:map_of_maps], context: "#{context}[:map_of_maps]") unless input[:map_of_maps].nil?
        Validators::MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        Validators::MapOfStructs.validate!(input[:map_of_structs], context: "#{context}[:map_of_structs]") unless input[:map_of_structs].nil?
        Validators::ListOfKitchenSinks.validate!(input[:recursive_list], context: "#{context}[:recursive_list]") unless input[:recursive_list].nil?
        Validators::MapOfKitchenSinks.validate!(input[:recursive_map], context: "#{context}[:recursive_map]") unless input[:recursive_map].nil?
        Validators::KitchenSink.validate!(input[:recursive_struct], context: "#{context}[:recursive_struct]") unless input[:recursive_struct].nil?
        Validators::SimpleStruct.validate!(input[:simple_struct], context: "#{context}[:simple_struct]") unless input[:simple_struct].nil?
        Hearth::Validator.validate!(input[:string], ::String, context: "#{context}[:string]")
        Validators::StructWithLocationName.validate!(input[:struct_with_location_name], context: "#{context}[:struct_with_location_name]") unless input[:struct_with_location_name].nil?
        Hearth::Validator.validate!(input[:timestamp], ::Time, context: "#{context}[:timestamp]")
        Hearth::Validator.validate!(input[:unix_timestamp], ::Time, context: "#{context}[:unix_timestamp]")
      end
    end

    class KitchenSinkOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::KitchenSinkOperationOutput, context: context)
        Hearth::Validator.validate!(input[:blob], ::String, context: "#{context}[:blob]")
        Hearth::Validator.validate!(input[:boolean], ::TrueClass, ::FalseClass, context: "#{context}[:boolean]")
        Hearth::Validator.validate!(input[:double], ::Float, context: "#{context}[:double]")
        Validators::EmptyStruct.validate!(input[:empty_struct], context: "#{context}[:empty_struct]") unless input[:empty_struct].nil?
        Hearth::Validator.validate!(input[:float], ::Float, context: "#{context}[:float]")
        Hearth::Validator.validate!(input[:httpdate_timestamp], ::Time, context: "#{context}[:httpdate_timestamp]")
        Hearth::Validator.validate!(input[:integer], ::Integer, context: "#{context}[:integer]")
        Hearth::Validator.validate!(input[:iso8601_timestamp], ::Time, context: "#{context}[:iso8601_timestamp]")
        Hearth::Validator.validate!(input[:json_value], ::String, context: "#{context}[:json_value]")
        Validators::ListOfListOfStrings.validate!(input[:list_of_lists], context: "#{context}[:list_of_lists]") unless input[:list_of_lists].nil?
        Validators::ListOfMapsOfStrings.validate!(input[:list_of_maps_of_strings], context: "#{context}[:list_of_maps_of_strings]") unless input[:list_of_maps_of_strings].nil?
        Validators::ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        Validators::ListOfStructs.validate!(input[:list_of_structs], context: "#{context}[:list_of_structs]") unless input[:list_of_structs].nil?
        Hearth::Validator.validate!(input[:long], ::Integer, context: "#{context}[:long]")
        Validators::MapOfListsOfStrings.validate!(input[:map_of_lists_of_strings], context: "#{context}[:map_of_lists_of_strings]") unless input[:map_of_lists_of_strings].nil?
        Validators::MapOfMapOfStrings.validate!(input[:map_of_maps], context: "#{context}[:map_of_maps]") unless input[:map_of_maps].nil?
        Validators::MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        Validators::MapOfStructs.validate!(input[:map_of_structs], context: "#{context}[:map_of_structs]") unless input[:map_of_structs].nil?
        Validators::ListOfKitchenSinks.validate!(input[:recursive_list], context: "#{context}[:recursive_list]") unless input[:recursive_list].nil?
        Validators::MapOfKitchenSinks.validate!(input[:recursive_map], context: "#{context}[:recursive_map]") unless input[:recursive_map].nil?
        Validators::KitchenSink.validate!(input[:recursive_struct], context: "#{context}[:recursive_struct]") unless input[:recursive_struct].nil?
        Validators::SimpleStruct.validate!(input[:simple_struct], context: "#{context}[:simple_struct]") unless input[:simple_struct].nil?
        Hearth::Validator.validate!(input[:string], ::String, context: "#{context}[:string]")
        Validators::StructWithLocationName.validate!(input[:struct_with_location_name], context: "#{context}[:struct_with_location_name]") unless input[:struct_with_location_name].nil?
        Hearth::Validator.validate!(input[:timestamp], ::Time, context: "#{context}[:timestamp]")
        Hearth::Validator.validate!(input[:unix_timestamp], ::Time, context: "#{context}[:unix_timestamp]")
      end
    end

    class ListOfKitchenSinks
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Validators::KitchenSink.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class ListOfListOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Validators::ListOfStrings.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class ListOfMapsOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Validators::MapOfStrings.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class ListOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class ListOfStructs
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Validators::SimpleStruct.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class MapOfKitchenSinks
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::KitchenSink.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class MapOfListsOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::ListOfStrings.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class MapOfMapOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::MapOfStrings.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class MapOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class MapOfStructs
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::SimpleStruct.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class MediaTypeHeaderInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::MediaTypeHeaderInput, context: context)
        Hearth::Validator.validate!(input[:json], ::String, context: "#{context}[:json]")
      end
    end

    class MediaTypeHeaderOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::MediaTypeHeaderOutput, context: context)
        Hearth::Validator.validate!(input[:json], ::String, context: "#{context}[:json]")
      end
    end

    class MyUnion
      def self.validate!(input, context:)
        case input
        when Types::MyUnion::StringValue
          Hearth::Validator.validate!(input.__getobj__, ::String, context: context)
        when Types::MyUnion::BooleanValue
          Hearth::Validator.validate!(input.__getobj__, ::TrueClass, ::FalseClass, context: context)
        when Types::MyUnion::NumberValue
          Hearth::Validator.validate!(input.__getobj__, ::Integer, context: context)
        when Types::MyUnion::BlobValue
          Hearth::Validator.validate!(input.__getobj__, ::String, context: context)
        when Types::MyUnion::TimestampValue
          Hearth::Validator.validate!(input.__getobj__, ::Time, context: context)
        when Types::MyUnion::EnumValue
          Hearth::Validator.validate!(input.__getobj__, ::String, context: context)
        when Types::MyUnion::ListValue
          Validators::StringList.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::MyUnion::MapValue
          Validators::StringMap.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::MyUnion::StructureValue
          Validators::GreetingStruct.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::MyUnion, got #{input.class}."
        end
      end

      class StringValue
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::String, context: context)
        end
      end

      class BooleanValue
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::TrueClass, ::FalseClass, context: context)
        end
      end

      class NumberValue
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::Integer, context: context)
        end
      end

      class BlobValue
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::String, context: context)
        end
      end

      class TimestampValue
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::Time, context: context)
        end
      end

      class EnumValue
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::String, context: context)
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
    end

    class NestedAttributesOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NestedAttributesOperationInput, context: context)
        Validators::SimpleStruct.validate!(input[:simple_struct], context: "#{context}[:simple_struct]") unless input[:simple_struct].nil?
      end
    end

    class NestedAttributesOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NestedAttributesOperationOutput, context: context)
        Hearth::Validator.validate!(input[:value], ::String, context: "#{context}[:value]")
      end
    end

    class NestedPayload
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NestedPayload, context: context)
        Hearth::Validator.validate!(input[:greeting], ::String, context: "#{context}[:greeting]")
        Hearth::Validator.validate!(input[:member_name], ::String, context: "#{context}[:member_name]")
      end
    end

    class NullAndEmptyHeadersClientInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NullAndEmptyHeadersClientInput, context: context)
        Hearth::Validator.validate!(input[:a], ::String, context: "#{context}[:a]")
        Hearth::Validator.validate!(input[:b], ::String, context: "#{context}[:b]")
        Validators::StringList.validate!(input[:c], context: "#{context}[:c]") unless input[:c].nil?
      end
    end

    class NullAndEmptyHeadersClientOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NullAndEmptyHeadersClientOutput, context: context)
        Hearth::Validator.validate!(input[:a], ::String, context: "#{context}[:a]")
        Hearth::Validator.validate!(input[:b], ::String, context: "#{context}[:b]")
        Validators::StringList.validate!(input[:c], context: "#{context}[:c]") unless input[:c].nil?
      end
    end

    class NullOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NullOperationInput, context: context)
        Hearth::Validator.validate!(input[:string], ::String, context: "#{context}[:string]")
        Validators::SparseStringList.validate!(input[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless input[:sparse_string_list].nil?
        Validators::SparseStringMap.validate!(input[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless input[:sparse_string_map].nil?
      end
    end

    class NullOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::NullOperationOutput, context: context)
        Hearth::Validator.validate!(input[:string], ::String, context: "#{context}[:string]")
        Validators::SparseStringList.validate!(input[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless input[:sparse_string_list].nil?
        Validators::SparseStringMap.validate!(input[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless input[:sparse_string_map].nil?
      end
    end

    class OmitsNullSerializesEmptyStringInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::OmitsNullSerializesEmptyStringInput, context: context)
        Hearth::Validator.validate!(input[:null_value], ::String, context: "#{context}[:null_value]")
        Hearth::Validator.validate!(input[:empty_string], ::String, context: "#{context}[:empty_string]")
      end
    end

    class OmitsNullSerializesEmptyStringOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::OmitsNullSerializesEmptyStringOutput, context: context)
      end
    end

    class OperationWithOptionalInputOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::OperationWithOptionalInputOutputInput, context: context)
        Hearth::Validator.validate!(input[:value], ::String, context: "#{context}[:value]")
      end
    end

    class OperationWithOptionalInputOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::OperationWithOptionalInputOutputOutput, context: context)
        Hearth::Validator.validate!(input[:value], ::String, context: "#{context}[:value]")
      end
    end

    class QueryIdempotencyTokenAutoFillInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::QueryIdempotencyTokenAutoFillInput, context: context)
        Hearth::Validator.validate!(input[:token], ::String, context: "#{context}[:token]")
      end
    end

    class QueryIdempotencyTokenAutoFillOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::QueryIdempotencyTokenAutoFillOutput, context: context)
      end
    end

    class QueryParamsAsStringListMapInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::QueryParamsAsStringListMapInput, context: context)
        Hearth::Validator.validate!(input[:qux], ::String, context: "#{context}[:qux]")
        Validators::StringListMap.validate!(input[:foo], context: "#{context}[:foo]") unless input[:foo].nil?
      end
    end

    class QueryParamsAsStringListMapOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::QueryParamsAsStringListMapOutput, context: context)
      end
    end

    class SimpleStruct
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::SimpleStruct, context: context)
        Hearth::Validator.validate!(input[:value], ::String, context: "#{context}[:value]")
      end
    end

    class SparseBooleanMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::TrueClass, ::FalseClass, context: "#{context}[:#{key}]")
        end
      end
    end

    class SparseNumberMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::Integer, context: "#{context}[:#{key}]")
        end
      end
    end

    class SparseSetMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::StringSet.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class SparseStringList
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class SparseStringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class SparseStructMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::GreetingStruct.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class StringList
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class StringListMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::StringList.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class StringMap
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class StringSet
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Set, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class StructWithLocationName
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::StructWithLocationName, context: context)
        Hearth::Validator.validate!(input[:value], ::String, context: "#{context}[:value]")
      end
    end

    class TimestampFormatHeadersInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::TimestampFormatHeadersInput, context: context)
        Hearth::Validator.validate!(input[:member_epoch_seconds], ::Time, context: "#{context}[:member_epoch_seconds]")
        Hearth::Validator.validate!(input[:member_http_date], ::Time, context: "#{context}[:member_http_date]")
        Hearth::Validator.validate!(input[:member_date_time], ::Time, context: "#{context}[:member_date_time]")
        Hearth::Validator.validate!(input[:default_format], ::Time, context: "#{context}[:default_format]")
        Hearth::Validator.validate!(input[:target_epoch_seconds], ::Time, context: "#{context}[:target_epoch_seconds]")
        Hearth::Validator.validate!(input[:target_http_date], ::Time, context: "#{context}[:target_http_date]")
        Hearth::Validator.validate!(input[:target_date_time], ::Time, context: "#{context}[:target_date_time]")
      end
    end

    class TimestampFormatHeadersOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::TimestampFormatHeadersOutput, context: context)
        Hearth::Validator.validate!(input[:member_epoch_seconds], ::Time, context: "#{context}[:member_epoch_seconds]")
        Hearth::Validator.validate!(input[:member_http_date], ::Time, context: "#{context}[:member_http_date]")
        Hearth::Validator.validate!(input[:member_date_time], ::Time, context: "#{context}[:member_date_time]")
        Hearth::Validator.validate!(input[:default_format], ::Time, context: "#{context}[:default_format]")
        Hearth::Validator.validate!(input[:target_epoch_seconds], ::Time, context: "#{context}[:target_epoch_seconds]")
        Hearth::Validator.validate!(input[:target_http_date], ::Time, context: "#{context}[:target_http_date]")
        Hearth::Validator.validate!(input[:target_date_time], ::Time, context: "#{context}[:target_date_time]")
      end
    end

    class TimestampList
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::Time, context: "#{context}[#{index}]")
        end
      end
    end

    class Struct____456efg
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct____456efg, context: context)
        Hearth::Validator.validate!(input[:member____123foo], ::String, context: "#{context}[:member____123foo]")
      end
    end

    class Struct____789BadNameInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct____789BadNameInput, context: context)
        Hearth::Validator.validate!(input[:member____123abc], ::String, context: "#{context}[:member____123abc]")
        Validators::Struct____456efg.validate!(input[:member], context: "#{context}[:member]") unless input[:member].nil?
      end
    end

    class Struct____789BadNameOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct____789BadNameOutput, context: context)
        Validators::Struct____456efg.validate!(input[:member], context: "#{context}[:member]") unless input[:member].nil?
      end
    end

  end
end
