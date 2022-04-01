# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'securerandom'

module RailsJson
  module Params

    module AllQueryStringTypesInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::AllQueryStringTypesInput, context: context)
        type = Types::AllQueryStringTypesInput.new
        type.query_string = params[:query_string]
        type.query_string_list = StringList.build(params[:query_string_list], context: "#{context}[:query_string_list]") unless params[:query_string_list].nil?
        type.query_string_set = StringSet.build(params[:query_string_set], context: "#{context}[:query_string_set]") unless params[:query_string_set].nil?
        type.query_byte = params[:query_byte]
        type.query_short = params[:query_short]
        type.query_integer = params[:query_integer]
        type.query_integer_list = IntegerList.build(params[:query_integer_list], context: "#{context}[:query_integer_list]") unless params[:query_integer_list].nil?
        type.query_integer_set = IntegerSet.build(params[:query_integer_set], context: "#{context}[:query_integer_set]") unless params[:query_integer_set].nil?
        type.query_long = params[:query_long]
        type.query_float = params[:query_float]
        type.query_double = params[:query_double]
        type.query_double_list = DoubleList.build(params[:query_double_list], context: "#{context}[:query_double_list]") unless params[:query_double_list].nil?
        type.query_boolean = params[:query_boolean]
        type.query_boolean_list = BooleanList.build(params[:query_boolean_list], context: "#{context}[:query_boolean_list]") unless params[:query_boolean_list].nil?
        type.query_timestamp = params[:query_timestamp]
        type.query_timestamp_list = TimestampList.build(params[:query_timestamp_list], context: "#{context}[:query_timestamp_list]") unless params[:query_timestamp_list].nil?
        type.query_enum = params[:query_enum]
        type.query_enum_list = FooEnumList.build(params[:query_enum_list], context: "#{context}[:query_enum_list]") unless params[:query_enum_list].nil?
        type.query_params_map_of_strings = StringMap.build(params[:query_params_map_of_strings], context: "#{context}[:query_params_map_of_strings]") unless params[:query_params_map_of_strings].nil?
        type
      end
    end

    module AllQueryStringTypesOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::AllQueryStringTypesOutput, context: context)
        type = Types::AllQueryStringTypesOutput.new
        type
      end
    end

    module BooleanList
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module ComplexError
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ComplexError, context: context)
        type = Types::ComplexError.new
        type.top_level = params[:top_level]
        type.nested = ComplexNestedErrorData.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    module ComplexNestedErrorData
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ComplexNestedErrorData, context: context)
        type = Types::ComplexNestedErrorData.new
        type.foo = params[:foo]
        type
      end
    end

    module ConstantAndVariableQueryStringInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ConstantAndVariableQueryStringInput, context: context)
        type = Types::ConstantAndVariableQueryStringInput.new
        type.baz = params[:baz]
        type.maybe_set = params[:maybe_set]
        type
      end
    end

    module ConstantAndVariableQueryStringOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ConstantAndVariableQueryStringOutput, context: context)
        type = Types::ConstantAndVariableQueryStringOutput.new
        type
      end
    end

    module ConstantQueryStringInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ConstantQueryStringInput, context: context)
        type = Types::ConstantQueryStringInput.new
        type.hello = params[:hello]
        type
      end
    end

    module ConstantQueryStringOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ConstantQueryStringOutput, context: context)
        type = Types::ConstantQueryStringOutput.new
        type
      end
    end

    module DenseBooleanMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module DenseNumberMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module DenseSetMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = StringSet.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module DenseStringMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module DenseStructMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = GreetingStruct.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module DocumentTypeAsPayloadInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DocumentTypeAsPayloadInput, context: context)
        type = Types::DocumentTypeAsPayloadInput.new
        type.document_value = params[:document_value]
        type
      end
    end

    module DocumentTypeAsPayloadOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DocumentTypeAsPayloadOutput, context: context)
        type = Types::DocumentTypeAsPayloadOutput.new
        type.document_value = params[:document_value]
        type
      end
    end

    module DocumentTypeInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DocumentTypeInput, context: context)
        type = Types::DocumentTypeInput.new
        type.string_value = params[:string_value]
        type.document_value = params[:document_value]
        type
      end
    end

    module DocumentTypeOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DocumentTypeOutput, context: context)
        type = Types::DocumentTypeOutput.new
        type.string_value = params[:string_value]
        type.document_value = params[:document_value]
        type
      end
    end

    module DoubleList
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module EmptyOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::EmptyOperationInput, context: context)
        type = Types::EmptyOperationInput.new
        type
      end
    end

    module EmptyOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::EmptyOperationOutput, context: context)
        type = Types::EmptyOperationOutput.new
        type
      end
    end

    module EmptyStruct
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::EmptyStruct, context: context)
        type = Types::EmptyStruct.new
        type
      end
    end

    module EndpointOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::EndpointOperationInput, context: context)
        type = Types::EndpointOperationInput.new
        type
      end
    end

    module EndpointOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::EndpointOperationOutput, context: context)
        type = Types::EndpointOperationOutput.new
        type
      end
    end

    module EndpointWithHostLabelOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::EndpointWithHostLabelOperationInput, context: context)
        type = Types::EndpointWithHostLabelOperationInput.new
        type.label = params[:label]
        type
      end
    end

    module EndpointWithHostLabelOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::EndpointWithHostLabelOperationOutput, context: context)
        type = Types::EndpointWithHostLabelOperationOutput.new
        type
      end
    end

    module ErrorWithMembers
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ErrorWithMembers, context: context)
        type = Types::ErrorWithMembers.new
        type.code = params[:code]
        type.complex_data = KitchenSink.build(params[:complex_data], context: "#{context}[:complex_data]") unless params[:complex_data].nil?
        type.integer_field = params[:integer_field]
        type.list_field = ListOfStrings.build(params[:list_field], context: "#{context}[:list_field]") unless params[:list_field].nil?
        type.map_field = MapOfStrings.build(params[:map_field], context: "#{context}[:map_field]") unless params[:map_field].nil?
        type.message = params[:message]
        type.string_field = params[:string_field]
        type
      end
    end

    module ErrorWithoutMembers
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ErrorWithoutMembers, context: context)
        type = Types::ErrorWithoutMembers.new
        type
      end
    end

    module FooEnumList
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module FooEnumMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module FooEnumSet
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Set, ::Array, context: context)
        data = Set.new
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module GreetingStruct
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::GreetingStruct, context: context)
        type = Types::GreetingStruct.new
        type.hi = params[:hi]
        type
      end
    end

    module GreetingWithErrorsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::GreetingWithErrorsInput, context: context)
        type = Types::GreetingWithErrorsInput.new
        type
      end
    end

    module GreetingWithErrorsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::GreetingWithErrorsOutput, context: context)
        type = Types::GreetingWithErrorsOutput.new
        type.greeting = params[:greeting]
        type
      end
    end

    module HttpPayloadTraitsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPayloadTraitsInput, context: context)
        type = Types::HttpPayloadTraitsInput.new
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    module HttpPayloadTraitsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPayloadTraitsOutput, context: context)
        type = Types::HttpPayloadTraitsOutput.new
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    module HttpPayloadTraitsWithMediaTypeInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPayloadTraitsWithMediaTypeInput, context: context)
        type = Types::HttpPayloadTraitsWithMediaTypeInput.new
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    module HttpPayloadTraitsWithMediaTypeOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPayloadTraitsWithMediaTypeOutput, context: context)
        type = Types::HttpPayloadTraitsWithMediaTypeOutput.new
        type.foo = params[:foo]
        type.blob = params[:blob]
        type
      end
    end

    module HttpPayloadWithStructureInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPayloadWithStructureInput, context: context)
        type = Types::HttpPayloadWithStructureInput.new
        type.nested = NestedPayload.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    module HttpPayloadWithStructureOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPayloadWithStructureOutput, context: context)
        type = Types::HttpPayloadWithStructureOutput.new
        type.nested = NestedPayload.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    module HttpPrefixHeadersInResponseInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPrefixHeadersInResponseInput, context: context)
        type = Types::HttpPrefixHeadersInResponseInput.new
        type
      end
    end

    module HttpPrefixHeadersInResponseOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPrefixHeadersInResponseOutput, context: context)
        type = Types::HttpPrefixHeadersInResponseOutput.new
        type.prefix_headers = StringMap.build(params[:prefix_headers], context: "#{context}[:prefix_headers]") unless params[:prefix_headers].nil?
        type
      end
    end

    module HttpPrefixHeadersInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPrefixHeadersInput, context: context)
        type = Types::HttpPrefixHeadersInput.new
        type.foo = params[:foo]
        type.foo_map = StringMap.build(params[:foo_map], context: "#{context}[:foo_map]") unless params[:foo_map].nil?
        type
      end
    end

    module HttpPrefixHeadersOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpPrefixHeadersOutput, context: context)
        type = Types::HttpPrefixHeadersOutput.new
        type.foo = params[:foo]
        type.foo_map = StringMap.build(params[:foo_map], context: "#{context}[:foo_map]") unless params[:foo_map].nil?
        type
      end
    end

    module HttpRequestWithFloatLabelsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithFloatLabelsInput, context: context)
        type = Types::HttpRequestWithFloatLabelsInput.new
        type.float = params[:float]
        type.double = params[:double]
        type
      end
    end

    module HttpRequestWithFloatLabelsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithFloatLabelsOutput, context: context)
        type = Types::HttpRequestWithFloatLabelsOutput.new
        type
      end
    end

    module HttpRequestWithGreedyLabelInPathInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithGreedyLabelInPathInput, context: context)
        type = Types::HttpRequestWithGreedyLabelInPathInput.new
        type.foo = params[:foo]
        type.baz = params[:baz]
        type
      end
    end

    module HttpRequestWithGreedyLabelInPathOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithGreedyLabelInPathOutput, context: context)
        type = Types::HttpRequestWithGreedyLabelInPathOutput.new
        type
      end
    end

    module HttpRequestWithLabelsAndTimestampFormatInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithLabelsAndTimestampFormatInput, context: context)
        type = Types::HttpRequestWithLabelsAndTimestampFormatInput.new
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

    module HttpRequestWithLabelsAndTimestampFormatOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithLabelsAndTimestampFormatOutput, context: context)
        type = Types::HttpRequestWithLabelsAndTimestampFormatOutput.new
        type
      end
    end

    module HttpRequestWithLabelsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithLabelsInput, context: context)
        type = Types::HttpRequestWithLabelsInput.new
        type.string = params[:string]
        type.short = params[:short]
        type.integer = params[:integer]
        type.long = params[:long]
        type.float = params[:float]
        type.double = params[:double]
        type.boolean = params[:boolean]
        type.timestamp = params[:timestamp]
        type
      end
    end

    module HttpRequestWithLabelsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpRequestWithLabelsOutput, context: context)
        type = Types::HttpRequestWithLabelsOutput.new
        type
      end
    end

    module HttpResponseCodeInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpResponseCodeInput, context: context)
        type = Types::HttpResponseCodeInput.new
        type
      end
    end

    module HttpResponseCodeOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HttpResponseCodeOutput, context: context)
        type = Types::HttpResponseCodeOutput.new
        type.status = params[:status]
        type
      end
    end

    module IgnoreQueryParamsInResponseInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::IgnoreQueryParamsInResponseInput, context: context)
        type = Types::IgnoreQueryParamsInResponseInput.new
        type
      end
    end

    module IgnoreQueryParamsInResponseOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::IgnoreQueryParamsInResponseOutput, context: context)
        type = Types::IgnoreQueryParamsInResponseOutput.new
        type.baz = params[:baz]
        type
      end
    end

    module InputAndOutputWithHeadersInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::InputAndOutputWithHeadersInput, context: context)
        type = Types::InputAndOutputWithHeadersInput.new
        type.header_string = params[:header_string]
        type.header_byte = params[:header_byte]
        type.header_short = params[:header_short]
        type.header_integer = params[:header_integer]
        type.header_long = params[:header_long]
        type.header_float = params[:header_float]
        type.header_double = params[:header_double]
        type.header_true_bool = params[:header_true_bool]
        type.header_false_bool = params[:header_false_bool]
        type.header_string_list = StringList.build(params[:header_string_list], context: "#{context}[:header_string_list]") unless params[:header_string_list].nil?
        type.header_string_set = StringSet.build(params[:header_string_set], context: "#{context}[:header_string_set]") unless params[:header_string_set].nil?
        type.header_integer_list = IntegerList.build(params[:header_integer_list], context: "#{context}[:header_integer_list]") unless params[:header_integer_list].nil?
        type.header_boolean_list = BooleanList.build(params[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless params[:header_boolean_list].nil?
        type.header_timestamp_list = TimestampList.build(params[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless params[:header_timestamp_list].nil?
        type.header_enum = params[:header_enum]
        type.header_enum_list = FooEnumList.build(params[:header_enum_list], context: "#{context}[:header_enum_list]") unless params[:header_enum_list].nil?
        type
      end
    end

    module InputAndOutputWithHeadersOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::InputAndOutputWithHeadersOutput, context: context)
        type = Types::InputAndOutputWithHeadersOutput.new
        type.header_string = params[:header_string]
        type.header_byte = params[:header_byte]
        type.header_short = params[:header_short]
        type.header_integer = params[:header_integer]
        type.header_long = params[:header_long]
        type.header_float = params[:header_float]
        type.header_double = params[:header_double]
        type.header_true_bool = params[:header_true_bool]
        type.header_false_bool = params[:header_false_bool]
        type.header_string_list = StringList.build(params[:header_string_list], context: "#{context}[:header_string_list]") unless params[:header_string_list].nil?
        type.header_string_set = StringSet.build(params[:header_string_set], context: "#{context}[:header_string_set]") unless params[:header_string_set].nil?
        type.header_integer_list = IntegerList.build(params[:header_integer_list], context: "#{context}[:header_integer_list]") unless params[:header_integer_list].nil?
        type.header_boolean_list = BooleanList.build(params[:header_boolean_list], context: "#{context}[:header_boolean_list]") unless params[:header_boolean_list].nil?
        type.header_timestamp_list = TimestampList.build(params[:header_timestamp_list], context: "#{context}[:header_timestamp_list]") unless params[:header_timestamp_list].nil?
        type.header_enum = params[:header_enum]
        type.header_enum_list = FooEnumList.build(params[:header_enum_list], context: "#{context}[:header_enum_list]") unless params[:header_enum_list].nil?
        type
      end
    end

    module IntegerList
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module IntegerSet
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Set, ::Array, context: context)
        data = Set.new
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module InvalidGreeting
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::InvalidGreeting, context: context)
        type = Types::InvalidGreeting.new
        type.message = params[:message]
        type
      end
    end

    module JsonEnumsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::JsonEnumsInput, context: context)
        type = Types::JsonEnumsInput.new
        type.foo_enum1 = params[:foo_enum1]
        type.foo_enum2 = params[:foo_enum2]
        type.foo_enum3 = params[:foo_enum3]
        type.foo_enum_list = FooEnumList.build(params[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless params[:foo_enum_list].nil?
        type.foo_enum_set = FooEnumSet.build(params[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless params[:foo_enum_set].nil?
        type.foo_enum_map = FooEnumMap.build(params[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless params[:foo_enum_map].nil?
        type
      end
    end

    module JsonEnumsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::JsonEnumsOutput, context: context)
        type = Types::JsonEnumsOutput.new
        type.foo_enum1 = params[:foo_enum1]
        type.foo_enum2 = params[:foo_enum2]
        type.foo_enum3 = params[:foo_enum3]
        type.foo_enum_list = FooEnumList.build(params[:foo_enum_list], context: "#{context}[:foo_enum_list]") unless params[:foo_enum_list].nil?
        type.foo_enum_set = FooEnumSet.build(params[:foo_enum_set], context: "#{context}[:foo_enum_set]") unless params[:foo_enum_set].nil?
        type.foo_enum_map = FooEnumMap.build(params[:foo_enum_map], context: "#{context}[:foo_enum_map]") unless params[:foo_enum_map].nil?
        type
      end
    end

    module JsonMapsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::JsonMapsInput, context: context)
        type = Types::JsonMapsInput.new
        type.dense_struct_map = DenseStructMap.build(params[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless params[:dense_struct_map].nil?
        type.sparse_struct_map = SparseStructMap.build(params[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless params[:sparse_struct_map].nil?
        type.dense_number_map = DenseNumberMap.build(params[:dense_number_map], context: "#{context}[:dense_number_map]") unless params[:dense_number_map].nil?
        type.dense_boolean_map = DenseBooleanMap.build(params[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless params[:dense_boolean_map].nil?
        type.dense_string_map = DenseStringMap.build(params[:dense_string_map], context: "#{context}[:dense_string_map]") unless params[:dense_string_map].nil?
        type.sparse_number_map = SparseNumberMap.build(params[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless params[:sparse_number_map].nil?
        type.sparse_boolean_map = SparseBooleanMap.build(params[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless params[:sparse_boolean_map].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type.dense_set_map = DenseSetMap.build(params[:dense_set_map], context: "#{context}[:dense_set_map]") unless params[:dense_set_map].nil?
        type.sparse_set_map = SparseSetMap.build(params[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless params[:sparse_set_map].nil?
        type
      end
    end

    module JsonMapsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::JsonMapsOutput, context: context)
        type = Types::JsonMapsOutput.new
        type.dense_struct_map = DenseStructMap.build(params[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless params[:dense_struct_map].nil?
        type.sparse_struct_map = SparseStructMap.build(params[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless params[:sparse_struct_map].nil?
        type.dense_number_map = DenseNumberMap.build(params[:dense_number_map], context: "#{context}[:dense_number_map]") unless params[:dense_number_map].nil?
        type.dense_boolean_map = DenseBooleanMap.build(params[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless params[:dense_boolean_map].nil?
        type.dense_string_map = DenseStringMap.build(params[:dense_string_map], context: "#{context}[:dense_string_map]") unless params[:dense_string_map].nil?
        type.sparse_number_map = SparseNumberMap.build(params[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless params[:sparse_number_map].nil?
        type.sparse_boolean_map = SparseBooleanMap.build(params[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless params[:sparse_boolean_map].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type.dense_set_map = DenseSetMap.build(params[:dense_set_map], context: "#{context}[:dense_set_map]") unless params[:dense_set_map].nil?
        type.sparse_set_map = SparseSetMap.build(params[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless params[:sparse_set_map].nil?
        type
      end
    end

    module JsonUnionsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::JsonUnionsInput, context: context)
        type = Types::JsonUnionsInput.new
        type.contents = MyUnion.build(params[:contents], context: "#{context}[:contents]") unless params[:contents].nil?
        type
      end
    end

    module JsonUnionsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::JsonUnionsOutput, context: context)
        type = Types::JsonUnionsOutput.new
        type.contents = MyUnion.build(params[:contents], context: "#{context}[:contents]") unless params[:contents].nil?
        type
      end
    end

    module KitchenSink
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::KitchenSink, context: context)
        type = Types::KitchenSink.new
        type.blob = params[:blob]
        type.boolean = params[:boolean]
        type.double = params[:double]
        type.empty_struct = EmptyStruct.build(params[:empty_struct], context: "#{context}[:empty_struct]") unless params[:empty_struct].nil?
        type.float = params[:float]
        type.httpdate_timestamp = params[:httpdate_timestamp]
        type.integer = params[:integer]
        type.iso8601_timestamp = params[:iso8601_timestamp]
        type.json_value = params[:json_value]
        type.list_of_lists = ListOfListOfStrings.build(params[:list_of_lists], context: "#{context}[:list_of_lists]") unless params[:list_of_lists].nil?
        type.list_of_maps_of_strings = ListOfMapsOfStrings.build(params[:list_of_maps_of_strings], context: "#{context}[:list_of_maps_of_strings]") unless params[:list_of_maps_of_strings].nil?
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.long = params[:long]
        type.map_of_lists_of_strings = MapOfListsOfStrings.build(params[:map_of_lists_of_strings], context: "#{context}[:map_of_lists_of_strings]") unless params[:map_of_lists_of_strings].nil?
        type.map_of_maps = MapOfMapOfStrings.build(params[:map_of_maps], context: "#{context}[:map_of_maps]") unless params[:map_of_maps].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.recursive_list = ListOfKitchenSinks.build(params[:recursive_list], context: "#{context}[:recursive_list]") unless params[:recursive_list].nil?
        type.recursive_map = MapOfKitchenSinks.build(params[:recursive_map], context: "#{context}[:recursive_map]") unless params[:recursive_map].nil?
        type.recursive_struct = KitchenSink.build(params[:recursive_struct], context: "#{context}[:recursive_struct]") unless params[:recursive_struct].nil?
        type.simple_struct = SimpleStruct.build(params[:simple_struct], context: "#{context}[:simple_struct]") unless params[:simple_struct].nil?
        type.string = params[:string]
        type.struct_with_location_name = StructWithLocationName.build(params[:struct_with_location_name], context: "#{context}[:struct_with_location_name]") unless params[:struct_with_location_name].nil?
        type.timestamp = params[:timestamp]
        type.unix_timestamp = params[:unix_timestamp]
        type
      end
    end

    module KitchenSinkOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::KitchenSinkOperationInput, context: context)
        type = Types::KitchenSinkOperationInput.new
        type.blob = params[:blob]
        type.boolean = params[:boolean]
        type.double = params[:double]
        type.empty_struct = EmptyStruct.build(params[:empty_struct], context: "#{context}[:empty_struct]") unless params[:empty_struct].nil?
        type.float = params[:float]
        type.httpdate_timestamp = params[:httpdate_timestamp]
        type.integer = params[:integer]
        type.iso8601_timestamp = params[:iso8601_timestamp]
        type.json_value = params[:json_value]
        type.list_of_lists = ListOfListOfStrings.build(params[:list_of_lists], context: "#{context}[:list_of_lists]") unless params[:list_of_lists].nil?
        type.list_of_maps_of_strings = ListOfMapsOfStrings.build(params[:list_of_maps_of_strings], context: "#{context}[:list_of_maps_of_strings]") unless params[:list_of_maps_of_strings].nil?
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.long = params[:long]
        type.map_of_lists_of_strings = MapOfListsOfStrings.build(params[:map_of_lists_of_strings], context: "#{context}[:map_of_lists_of_strings]") unless params[:map_of_lists_of_strings].nil?
        type.map_of_maps = MapOfMapOfStrings.build(params[:map_of_maps], context: "#{context}[:map_of_maps]") unless params[:map_of_maps].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.recursive_list = ListOfKitchenSinks.build(params[:recursive_list], context: "#{context}[:recursive_list]") unless params[:recursive_list].nil?
        type.recursive_map = MapOfKitchenSinks.build(params[:recursive_map], context: "#{context}[:recursive_map]") unless params[:recursive_map].nil?
        type.recursive_struct = KitchenSink.build(params[:recursive_struct], context: "#{context}[:recursive_struct]") unless params[:recursive_struct].nil?
        type.simple_struct = SimpleStruct.build(params[:simple_struct], context: "#{context}[:simple_struct]") unless params[:simple_struct].nil?
        type.string = params[:string]
        type.struct_with_location_name = StructWithLocationName.build(params[:struct_with_location_name], context: "#{context}[:struct_with_location_name]") unless params[:struct_with_location_name].nil?
        type.timestamp = params[:timestamp]
        type.unix_timestamp = params[:unix_timestamp]
        type
      end
    end

    module KitchenSinkOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::KitchenSinkOperationOutput, context: context)
        type = Types::KitchenSinkOperationOutput.new
        type.blob = params[:blob]
        type.boolean = params[:boolean]
        type.double = params[:double]
        type.empty_struct = EmptyStruct.build(params[:empty_struct], context: "#{context}[:empty_struct]") unless params[:empty_struct].nil?
        type.float = params[:float]
        type.httpdate_timestamp = params[:httpdate_timestamp]
        type.integer = params[:integer]
        type.iso8601_timestamp = params[:iso8601_timestamp]
        type.json_value = params[:json_value]
        type.list_of_lists = ListOfListOfStrings.build(params[:list_of_lists], context: "#{context}[:list_of_lists]") unless params[:list_of_lists].nil?
        type.list_of_maps_of_strings = ListOfMapsOfStrings.build(params[:list_of_maps_of_strings], context: "#{context}[:list_of_maps_of_strings]") unless params[:list_of_maps_of_strings].nil?
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.long = params[:long]
        type.map_of_lists_of_strings = MapOfListsOfStrings.build(params[:map_of_lists_of_strings], context: "#{context}[:map_of_lists_of_strings]") unless params[:map_of_lists_of_strings].nil?
        type.map_of_maps = MapOfMapOfStrings.build(params[:map_of_maps], context: "#{context}[:map_of_maps]") unless params[:map_of_maps].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.recursive_list = ListOfKitchenSinks.build(params[:recursive_list], context: "#{context}[:recursive_list]") unless params[:recursive_list].nil?
        type.recursive_map = MapOfKitchenSinks.build(params[:recursive_map], context: "#{context}[:recursive_map]") unless params[:recursive_map].nil?
        type.recursive_struct = KitchenSink.build(params[:recursive_struct], context: "#{context}[:recursive_struct]") unless params[:recursive_struct].nil?
        type.simple_struct = SimpleStruct.build(params[:simple_struct], context: "#{context}[:simple_struct]") unless params[:simple_struct].nil?
        type.string = params[:string]
        type.struct_with_location_name = StructWithLocationName.build(params[:struct_with_location_name], context: "#{context}[:struct_with_location_name]") unless params[:struct_with_location_name].nil?
        type.timestamp = params[:timestamp]
        type.unix_timestamp = params[:unix_timestamp]
        type
      end
    end

    module ListOfKitchenSinks
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << KitchenSink.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module ListOfListOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << ListOfStrings.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module ListOfMapsOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << MapOfStrings.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module ListOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module ListOfStructs
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << SimpleStruct.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module MapOfKitchenSinks
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = KitchenSink.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module MapOfListsOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = ListOfStrings.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module MapOfMapOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = MapOfStrings.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module MapOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module MapOfStructs
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = SimpleStruct.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module MediaTypeHeaderInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::MediaTypeHeaderInput, context: context)
        type = Types::MediaTypeHeaderInput.new
        type.json = params[:json]
        type
      end
    end

    module MediaTypeHeaderOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::MediaTypeHeaderOutput, context: context)
        type = Types::MediaTypeHeaderOutput.new
        type.json = params[:json]
        type
      end
    end

    module MyUnion
      def self.build(params, context: '')
        return params if params.is_a?(Types::MyUnion)
        Hearth::Validator.validate!(params, ::Hash, Types::MyUnion, context: context)
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
        else
          raise ArgumentError,
                "Expected #{context} to have one of :string_value, :boolean_value, :number_value, :blob_value, :timestamp_value, :enum_value, :list_value, :map_value, :structure_value set"
        end
      end
    end

    module NestedAttributesOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::NestedAttributesOperationInput, context: context)
        type = Types::NestedAttributesOperationInput.new
        type.simple_struct = SimpleStruct.build(params[:simple_struct], context: "#{context}[:simple_struct]") unless params[:simple_struct].nil?
        type
      end
    end

    module NestedAttributesOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::NestedAttributesOperationOutput, context: context)
        type = Types::NestedAttributesOperationOutput.new
        type.value = params[:value]
        type
      end
    end

    module NestedPayload
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::NestedPayload, context: context)
        type = Types::NestedPayload.new
        type.greeting = params[:greeting]
        type.name = params[:name]
        type
      end
    end

    module NullAndEmptyHeadersClientInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::NullAndEmptyHeadersClientInput, context: context)
        type = Types::NullAndEmptyHeadersClientInput.new
        type.a = params[:a]
        type.b = params[:b]
        type.c = StringList.build(params[:c], context: "#{context}[:c]") unless params[:c].nil?
        type
      end
    end

    module NullAndEmptyHeadersClientOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::NullAndEmptyHeadersClientOutput, context: context)
        type = Types::NullAndEmptyHeadersClientOutput.new
        type.a = params[:a]
        type.b = params[:b]
        type.c = StringList.build(params[:c], context: "#{context}[:c]") unless params[:c].nil?
        type
      end
    end

    module NullOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::NullOperationInput, context: context)
        type = Types::NullOperationInput.new
        type.string = params[:string]
        type.sparse_string_list = SparseStringList.build(params[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless params[:sparse_string_list].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type
      end
    end

    module NullOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::NullOperationOutput, context: context)
        type = Types::NullOperationOutput.new
        type.string = params[:string]
        type.sparse_string_list = SparseStringList.build(params[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless params[:sparse_string_list].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type
      end
    end

    module OmitsNullSerializesEmptyStringInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::OmitsNullSerializesEmptyStringInput, context: context)
        type = Types::OmitsNullSerializesEmptyStringInput.new
        type.null_value = params[:null_value]
        type.empty_string = params[:empty_string]
        type
      end
    end

    module OmitsNullSerializesEmptyStringOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::OmitsNullSerializesEmptyStringOutput, context: context)
        type = Types::OmitsNullSerializesEmptyStringOutput.new
        type
      end
    end

    module OperationWithOptionalInputOutputInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::OperationWithOptionalInputOutputInput, context: context)
        type = Types::OperationWithOptionalInputOutputInput.new
        type.value = params[:value]
        type
      end
    end

    module OperationWithOptionalInputOutputOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::OperationWithOptionalInputOutputOutput, context: context)
        type = Types::OperationWithOptionalInputOutputOutput.new
        type.value = params[:value]
        type
      end
    end

    module QueryIdempotencyTokenAutoFillInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::QueryIdempotencyTokenAutoFillInput, context: context)
        type = Types::QueryIdempotencyTokenAutoFillInput.new
        type.token = params[:token] || SecureRandom.uuid
        type
      end
    end

    module QueryIdempotencyTokenAutoFillOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::QueryIdempotencyTokenAutoFillOutput, context: context)
        type = Types::QueryIdempotencyTokenAutoFillOutput.new
        type
      end
    end

    module QueryParamsAsStringListMapInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::QueryParamsAsStringListMapInput, context: context)
        type = Types::QueryParamsAsStringListMapInput.new
        type.qux = params[:qux]
        type.foo = StringListMap.build(params[:foo], context: "#{context}[:foo]") unless params[:foo].nil?
        type
      end
    end

    module QueryParamsAsStringListMapOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::QueryParamsAsStringListMapOutput, context: context)
        type = Types::QueryParamsAsStringListMapOutput.new
        type
      end
    end

    module SimpleStruct
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::SimpleStruct, context: context)
        type = Types::SimpleStruct.new
        type.value = params[:value]
        type
      end
    end

    module SparseBooleanMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module SparseNumberMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module SparseSetMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = (StringSet.build(value, context: "#{context}[:#{key}]") unless value.nil?)
        end
        data
      end
    end

    module SparseStringList
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module SparseStringMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module SparseStructMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = (GreetingStruct.build(value, context: "#{context}[:#{key}]") unless value.nil?)
        end
        data
      end
    end

    module StreamingOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::StreamingOperationInput, context: context)
        type = Types::StreamingOperationInput.new
        io = params[:output] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.output = io
        type
      end
    end

    module StreamingOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::StreamingOperationOutput, context: context)
        type = Types::StreamingOperationOutput.new
        io = params[:output] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.output = io
        type
      end
    end

    module StringList
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module StringListMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = StringList.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module StringMap
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module StringSet
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Set, ::Array, context: context)
        data = Set.new
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module StructWithLocationName
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::StructWithLocationName, context: context)
        type = Types::StructWithLocationName.new
        type.value = params[:value]
        type
      end
    end

    module TimestampFormatHeadersInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::TimestampFormatHeadersInput, context: context)
        type = Types::TimestampFormatHeadersInput.new
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

    module TimestampFormatHeadersOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::TimestampFormatHeadersOutput, context: context)
        type = Types::TimestampFormatHeadersOutput.new
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

    module TimestampList
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module Struct____456efg
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::Struct____456efg, context: context)
        type = Types::Struct____456efg.new
        type.member___123foo = params[:member___123foo]
        type
      end
    end

    module Struct____789BadNameInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::Struct____789BadNameInput, context: context)
        type = Types::Struct____789BadNameInput.new
        type.member___123abc = params[:member___123abc]
        type.member = Struct____456efg.build(params[:member], context: "#{context}[:member]") unless params[:member].nil?
        type
      end
    end

    module Struct____789BadNameOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::Struct____789BadNameOutput, context: context)
        type = Types::Struct____789BadNameOutput.new
        type.member = Struct____456efg.build(params[:member], context: "#{context}[:member]") unless params[:member].nil?
        type
      end
    end

  end
end
