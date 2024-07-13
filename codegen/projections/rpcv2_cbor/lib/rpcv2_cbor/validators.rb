# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'time'

module Rpcv2Cbor
  # @api private
  module Validators

    class BlobList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
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
        Hearth::Validator.validate_types!(input.member, ::Integer, context: "#{context}[:member]")
      end
    end

    class ComplexError
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ComplexError, context: context)
        Hearth::Validator.validate_types!(input.top_level, ::String, context: "#{context}[:top_level]")
        ComplexNestedErrorData.validate!(input.nested, context: "#{context}[:nested]") unless input.nested.nil?
      end
    end

    class ComplexNestedErrorData
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ComplexNestedErrorData, context: context)
        Hearth::Validator.validate_types!(input.foo, ::String, context: "#{context}[:foo]")
      end
    end

    class Defaults
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Defaults, context: context)
        Hearth::Validator.validate_types!(input.default_string, ::String, context: "#{context}[:default_string]")
        Hearth::Validator.validate_types!(input.default_boolean, ::TrueClass, ::FalseClass, context: "#{context}[:default_boolean]")
        TestStringList.validate!(input.default_list, context: "#{context}[:default_list]") unless input.default_list.nil?
        Hearth::Validator.validate_types!(input.default_timestamp, ::Time, context: "#{context}[:default_timestamp]")
        Hearth::Validator.validate_types!(input.default_blob, ::String, context: "#{context}[:default_blob]")
        Hearth::Validator.validate_types!(input.default_byte, ::Integer, context: "#{context}[:default_byte]")
        Hearth::Validator.validate_types!(input.default_short, ::Integer, context: "#{context}[:default_short]")
        Hearth::Validator.validate_types!(input.default_integer, ::Integer, context: "#{context}[:default_integer]")
        Hearth::Validator.validate_types!(input.default_long, ::Integer, context: "#{context}[:default_long]")
        Hearth::Validator.validate_types!(input.default_float, ::Float, context: "#{context}[:default_float]")
        Hearth::Validator.validate_types!(input.default_double, ::Float, context: "#{context}[:default_double]")
        TestStringMap.validate!(input.default_map, context: "#{context}[:default_map]") unless input.default_map.nil?
        Hearth::Validator.validate_types!(input.default_enum, ::String, context: "#{context}[:default_enum]")
        Hearth::Validator.validate_types!(input.default_int_enum, ::Integer, context: "#{context}[:default_int_enum]")
        Hearth::Validator.validate_types!(input.empty_string, ::String, context: "#{context}[:empty_string]")
        Hearth::Validator.validate_types!(input.false_boolean, ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean]")
        Hearth::Validator.validate_types!(input.empty_blob, ::String, context: "#{context}[:empty_blob]")
        Hearth::Validator.validate_types!(input.zero_byte, ::Integer, context: "#{context}[:zero_byte]")
        Hearth::Validator.validate_types!(input.zero_short, ::Integer, context: "#{context}[:zero_short]")
        Hearth::Validator.validate_types!(input.zero_integer, ::Integer, context: "#{context}[:zero_integer]")
        Hearth::Validator.validate_types!(input.zero_long, ::Integer, context: "#{context}[:zero_long]")
        Hearth::Validator.validate_types!(input.zero_float, ::Float, context: "#{context}[:zero_float]")
        Hearth::Validator.validate_types!(input.zero_double, ::Float, context: "#{context}[:zero_double]")
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

    class EmptyInputOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EmptyInputOutputInput, context: context)
      end
    end

    class EmptyInputOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EmptyInputOutputOutput, context: context)
      end
    end

    class Float16Input
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Float16Input, context: context)
      end
    end

    class Float16Output
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Float16Output, context: context)
        Hearth::Validator.validate_types!(input.value, ::Float, context: "#{context}[:value]")
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

    class FractionalSecondsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::FractionalSecondsInput, context: context)
      end
    end

    class FractionalSecondsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::FractionalSecondsOutput, context: context)
        Hearth::Validator.validate_types!(input.datetime, ::Time, context: "#{context}[:datetime]")
      end
    end

    class GreetingStruct
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GreetingStruct, context: context)
        Hearth::Validator.validate_types!(input.hi, ::String, context: "#{context}[:hi]")
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
        Hearth::Validator.validate_types!(input.greeting, ::String, context: "#{context}[:greeting]")
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

    class IntegerList
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
        Hearth::Validator.validate_types!(input.message, ::String, context: "#{context}[:message]")
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

    class NoInputOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoInputOutputInput, context: context)
      end
    end

    class NoInputOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoInputOutputOutput, context: context)
      end
    end

    class OperationWithDefaultsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OperationWithDefaultsInput, context: context)
        Defaults.validate!(input.defaults, context: "#{context}[:defaults]") unless input.defaults.nil?
        ClientOptionalDefaults.validate!(input.client_optional_defaults, context: "#{context}[:client_optional_defaults]") unless input.client_optional_defaults.nil?
        Hearth::Validator.validate_types!(input.top_level_default, ::String, context: "#{context}[:top_level_default]")
        Hearth::Validator.validate_types!(input.other_top_level_default, ::Integer, context: "#{context}[:other_top_level_default]")
      end
    end

    class OperationWithDefaultsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OperationWithDefaultsOutput, context: context)
        Hearth::Validator.validate_types!(input.default_string, ::String, context: "#{context}[:default_string]")
        Hearth::Validator.validate_types!(input.default_boolean, ::TrueClass, ::FalseClass, context: "#{context}[:default_boolean]")
        TestStringList.validate!(input.default_list, context: "#{context}[:default_list]") unless input.default_list.nil?
        Hearth::Validator.validate_types!(input.default_timestamp, ::Time, context: "#{context}[:default_timestamp]")
        Hearth::Validator.validate_types!(input.default_blob, ::String, context: "#{context}[:default_blob]")
        Hearth::Validator.validate_types!(input.default_byte, ::Integer, context: "#{context}[:default_byte]")
        Hearth::Validator.validate_types!(input.default_short, ::Integer, context: "#{context}[:default_short]")
        Hearth::Validator.validate_types!(input.default_integer, ::Integer, context: "#{context}[:default_integer]")
        Hearth::Validator.validate_types!(input.default_long, ::Integer, context: "#{context}[:default_long]")
        Hearth::Validator.validate_types!(input.default_float, ::Float, context: "#{context}[:default_float]")
        Hearth::Validator.validate_types!(input.default_double, ::Float, context: "#{context}[:default_double]")
        TestStringMap.validate!(input.default_map, context: "#{context}[:default_map]") unless input.default_map.nil?
        Hearth::Validator.validate_types!(input.default_enum, ::String, context: "#{context}[:default_enum]")
        Hearth::Validator.validate_types!(input.default_int_enum, ::Integer, context: "#{context}[:default_int_enum]")
        Hearth::Validator.validate_types!(input.empty_string, ::String, context: "#{context}[:empty_string]")
        Hearth::Validator.validate_types!(input.false_boolean, ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean]")
        Hearth::Validator.validate_types!(input.empty_blob, ::String, context: "#{context}[:empty_blob]")
        Hearth::Validator.validate_types!(input.zero_byte, ::Integer, context: "#{context}[:zero_byte]")
        Hearth::Validator.validate_types!(input.zero_short, ::Integer, context: "#{context}[:zero_short]")
        Hearth::Validator.validate_types!(input.zero_integer, ::Integer, context: "#{context}[:zero_integer]")
        Hearth::Validator.validate_types!(input.zero_long, ::Integer, context: "#{context}[:zero_long]")
        Hearth::Validator.validate_types!(input.zero_float, ::Float, context: "#{context}[:zero_float]")
        Hearth::Validator.validate_types!(input.zero_double, ::Float, context: "#{context}[:zero_double]")
      end
    end

    class OptionalInputOutputInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OptionalInputOutputInput, context: context)
        Hearth::Validator.validate_types!(input.value, ::String, context: "#{context}[:value]")
      end
    end

    class OptionalInputOutputOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OptionalInputOutputOutput, context: context)
        Hearth::Validator.validate_types!(input.value, ::String, context: "#{context}[:value]")
      end
    end

    class RecursiveShapesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesInput, context: context)
        RecursiveShapesInputOutputNested1.validate!(input.nested, context: "#{context}[:nested]") unless input.nested.nil?
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesInputOutputNested1, context: context)
        Hearth::Validator.validate_types!(input.foo, ::String, context: "#{context}[:foo]")
        RecursiveShapesInputOutputNested2.validate!(input.nested, context: "#{context}[:nested]") unless input.nested.nil?
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesInputOutputNested2, context: context)
        Hearth::Validator.validate_types!(input.bar, ::String, context: "#{context}[:bar]")
        RecursiveShapesInputOutputNested1.validate!(input.recursive_member, context: "#{context}[:recursive_member]") unless input.recursive_member.nil?
      end
    end

    class RecursiveShapesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RecursiveShapesOutput, context: context)
        RecursiveShapesInputOutputNested1.validate!(input.nested, context: "#{context}[:nested]") unless input.nested.nil?
      end
    end

    class RpcV2CborDenseMapsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RpcV2CborDenseMapsInput, context: context)
        DenseStructMap.validate!(input.dense_struct_map, context: "#{context}[:dense_struct_map]") unless input.dense_struct_map.nil?
        DenseNumberMap.validate!(input.dense_number_map, context: "#{context}[:dense_number_map]") unless input.dense_number_map.nil?
        DenseBooleanMap.validate!(input.dense_boolean_map, context: "#{context}[:dense_boolean_map]") unless input.dense_boolean_map.nil?
        DenseStringMap.validate!(input.dense_string_map, context: "#{context}[:dense_string_map]") unless input.dense_string_map.nil?
        DenseSetMap.validate!(input.dense_set_map, context: "#{context}[:dense_set_map]") unless input.dense_set_map.nil?
      end
    end

    class RpcV2CborDenseMapsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RpcV2CborDenseMapsOutput, context: context)
        DenseStructMap.validate!(input.dense_struct_map, context: "#{context}[:dense_struct_map]") unless input.dense_struct_map.nil?
        DenseNumberMap.validate!(input.dense_number_map, context: "#{context}[:dense_number_map]") unless input.dense_number_map.nil?
        DenseBooleanMap.validate!(input.dense_boolean_map, context: "#{context}[:dense_boolean_map]") unless input.dense_boolean_map.nil?
        DenseStringMap.validate!(input.dense_string_map, context: "#{context}[:dense_string_map]") unless input.dense_string_map.nil?
        DenseSetMap.validate!(input.dense_set_map, context: "#{context}[:dense_set_map]") unless input.dense_set_map.nil?
      end
    end

    class RpcV2CborListsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RpcV2CborListsInput, context: context)
        StringList.validate!(input.string_list, context: "#{context}[:string_list]") unless input.string_list.nil?
        StringSet.validate!(input.string_set, context: "#{context}[:string_set]") unless input.string_set.nil?
        IntegerList.validate!(input.integer_list, context: "#{context}[:integer_list]") unless input.integer_list.nil?
        BooleanList.validate!(input.boolean_list, context: "#{context}[:boolean_list]") unless input.boolean_list.nil?
        TimestampList.validate!(input.timestamp_list, context: "#{context}[:timestamp_list]") unless input.timestamp_list.nil?
        FooEnumList.validate!(input.enum_list, context: "#{context}[:enum_list]") unless input.enum_list.nil?
        IntegerEnumList.validate!(input.int_enum_list, context: "#{context}[:int_enum_list]") unless input.int_enum_list.nil?
        NestedStringList.validate!(input.nested_string_list, context: "#{context}[:nested_string_list]") unless input.nested_string_list.nil?
        StructureList.validate!(input.structure_list, context: "#{context}[:structure_list]") unless input.structure_list.nil?
        BlobList.validate!(input.blob_list, context: "#{context}[:blob_list]") unless input.blob_list.nil?
      end
    end

    class RpcV2CborListsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RpcV2CborListsOutput, context: context)
        StringList.validate!(input.string_list, context: "#{context}[:string_list]") unless input.string_list.nil?
        StringSet.validate!(input.string_set, context: "#{context}[:string_set]") unless input.string_set.nil?
        IntegerList.validate!(input.integer_list, context: "#{context}[:integer_list]") unless input.integer_list.nil?
        BooleanList.validate!(input.boolean_list, context: "#{context}[:boolean_list]") unless input.boolean_list.nil?
        TimestampList.validate!(input.timestamp_list, context: "#{context}[:timestamp_list]") unless input.timestamp_list.nil?
        FooEnumList.validate!(input.enum_list, context: "#{context}[:enum_list]") unless input.enum_list.nil?
        IntegerEnumList.validate!(input.int_enum_list, context: "#{context}[:int_enum_list]") unless input.int_enum_list.nil?
        NestedStringList.validate!(input.nested_string_list, context: "#{context}[:nested_string_list]") unless input.nested_string_list.nil?
        StructureList.validate!(input.structure_list, context: "#{context}[:structure_list]") unless input.structure_list.nil?
        BlobList.validate!(input.blob_list, context: "#{context}[:blob_list]") unless input.blob_list.nil?
      end
    end

    class RpcV2CborSparseMapsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RpcV2CborSparseMapsInput, context: context)
        SparseStructMap.validate!(input.sparse_struct_map, context: "#{context}[:sparse_struct_map]") unless input.sparse_struct_map.nil?
        SparseNumberMap.validate!(input.sparse_number_map, context: "#{context}[:sparse_number_map]") unless input.sparse_number_map.nil?
        SparseBooleanMap.validate!(input.sparse_boolean_map, context: "#{context}[:sparse_boolean_map]") unless input.sparse_boolean_map.nil?
        SparseStringMap.validate!(input.sparse_string_map, context: "#{context}[:sparse_string_map]") unless input.sparse_string_map.nil?
        SparseSetMap.validate!(input.sparse_set_map, context: "#{context}[:sparse_set_map]") unless input.sparse_set_map.nil?
      end
    end

    class RpcV2CborSparseMapsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RpcV2CborSparseMapsOutput, context: context)
        SparseStructMap.validate!(input.sparse_struct_map, context: "#{context}[:sparse_struct_map]") unless input.sparse_struct_map.nil?
        SparseNumberMap.validate!(input.sparse_number_map, context: "#{context}[:sparse_number_map]") unless input.sparse_number_map.nil?
        SparseBooleanMap.validate!(input.sparse_boolean_map, context: "#{context}[:sparse_boolean_map]") unless input.sparse_boolean_map.nil?
        SparseStringMap.validate!(input.sparse_string_map, context: "#{context}[:sparse_string_map]") unless input.sparse_string_map.nil?
        SparseSetMap.validate!(input.sparse_set_map, context: "#{context}[:sparse_set_map]") unless input.sparse_set_map.nil?
      end
    end

    class SimpleScalarPropertiesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SimpleScalarPropertiesInput, context: context)
        Hearth::Validator.validate_types!(input.true_boolean_value, ::TrueClass, ::FalseClass, context: "#{context}[:true_boolean_value]")
        Hearth::Validator.validate_types!(input.false_boolean_value, ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean_value]")
        Hearth::Validator.validate_types!(input.byte_value, ::Integer, context: "#{context}[:byte_value]")
        Hearth::Validator.validate_types!(input.double_value, ::Float, context: "#{context}[:double_value]")
        Hearth::Validator.validate_types!(input.float_value, ::Float, context: "#{context}[:float_value]")
        Hearth::Validator.validate_types!(input.integer_value, ::Integer, context: "#{context}[:integer_value]")
        Hearth::Validator.validate_types!(input.long_value, ::Integer, context: "#{context}[:long_value]")
        Hearth::Validator.validate_types!(input.short_value, ::Integer, context: "#{context}[:short_value]")
        Hearth::Validator.validate_types!(input.string_value, ::String, context: "#{context}[:string_value]")
        Hearth::Validator.validate_types!(input.blob_value, ::String, context: "#{context}[:blob_value]")
      end
    end

    class SimpleScalarPropertiesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SimpleScalarPropertiesOutput, context: context)
        Hearth::Validator.validate_types!(input.true_boolean_value, ::TrueClass, ::FalseClass, context: "#{context}[:true_boolean_value]")
        Hearth::Validator.validate_types!(input.false_boolean_value, ::TrueClass, ::FalseClass, context: "#{context}[:false_boolean_value]")
        Hearth::Validator.validate_types!(input.byte_value, ::Integer, context: "#{context}[:byte_value]")
        Hearth::Validator.validate_types!(input.double_value, ::Float, context: "#{context}[:double_value]")
        Hearth::Validator.validate_types!(input.float_value, ::Float, context: "#{context}[:float_value]")
        Hearth::Validator.validate_types!(input.integer_value, ::Integer, context: "#{context}[:integer_value]")
        Hearth::Validator.validate_types!(input.long_value, ::Integer, context: "#{context}[:long_value]")
        Hearth::Validator.validate_types!(input.short_value, ::Integer, context: "#{context}[:short_value]")
        Hearth::Validator.validate_types!(input.string_value, ::String, context: "#{context}[:string_value]")
        Hearth::Validator.validate_types!(input.blob_value, ::String, context: "#{context}[:blob_value]")
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

    class SparseNullsOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SparseNullsOperationInput, context: context)
        SparseStringList.validate!(input.sparse_string_list, context: "#{context}[:sparse_string_list]") unless input.sparse_string_list.nil?
        SparseStringMap.validate!(input.sparse_string_map, context: "#{context}[:sparse_string_map]") unless input.sparse_string_map.nil?
      end
    end

    class SparseNullsOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SparseNullsOperationOutput, context: context)
        SparseStringList.validate!(input.sparse_string_list, context: "#{context}[:sparse_string_list]") unless input.sparse_string_list.nil?
        SparseStringMap.validate!(input.sparse_string_map, context: "#{context}[:sparse_string_map]") unless input.sparse_string_map.nil?
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

    class StringList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
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
        Hearth::Validator.validate_types!(input.a, ::String, context: "#{context}[:a]")
        Hearth::Validator.validate_types!(input.b, ::String, context: "#{context}[:b]")
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

    class TimestampList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::Time, context: "#{context}[#{index}]")
        end
      end
    end

    class ValidationException
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ValidationException, context: context)
        Hearth::Validator.validate_required!(input.message, context: "#{context}[:message]")
        Hearth::Validator.validate_types!(input.message, ::String, context: "#{context}[:message]")
        ValidationExceptionFieldList.validate!(input.field_list, context: "#{context}[:field_list]") unless input.field_list.nil?
      end
    end

    class ValidationExceptionField
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ValidationExceptionField, context: context)
        Hearth::Validator.validate_required!(input.path, context: "#{context}[:path]")
        Hearth::Validator.validate_types!(input.path, ::String, context: "#{context}[:path]")
        Hearth::Validator.validate_required!(input.message, context: "#{context}[:message]")
        Hearth::Validator.validate_types!(input.message, ::String, context: "#{context}[:message]")
      end
    end

    class ValidationExceptionFieldList
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          ValidationExceptionField.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

  end
end
