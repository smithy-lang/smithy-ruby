# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Rpcv2Cbor
  # @api private
  module Params

    class BlobList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class BooleanList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ClientOptionalDefaults
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::ClientOptionalDefaults.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.member = params[:member] unless params[:member].nil?
        type
      end
    end

    class ComplexError
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::ComplexError.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.top_level = params[:top_level] unless params[:top_level].nil?
        type.nested = ComplexNestedErrorData.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class ComplexNestedErrorData
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::ComplexNestedErrorData.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.foo = params[:foo] unless params[:foo].nil?
        type
      end
    end

    class Defaults
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::Defaults.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.default_string = params[:default_string] unless params[:default_string].nil?
        type.default_boolean = params[:default_boolean] unless params[:default_boolean].nil?
        type.default_list = TestStringList.build(params[:default_list], context: "#{context}[:default_list]") unless params[:default_list].nil?
        type.default_timestamp = params[:default_timestamp] unless params[:default_timestamp].nil?
        type.default_blob = params[:default_blob] unless params[:default_blob].nil?
        type.default_byte = params[:default_byte] unless params[:default_byte].nil?
        type.default_short = params[:default_short] unless params[:default_short].nil?
        type.default_integer = params[:default_integer] unless params[:default_integer].nil?
        type.default_long = params[:default_long] unless params[:default_long].nil?
        type.default_float = params[:default_float]&.to_f unless params[:default_float].nil?
        type.default_double = params[:default_double]&.to_f unless params[:default_double].nil?
        type.default_map = TestStringMap.build(params[:default_map], context: "#{context}[:default_map]") unless params[:default_map].nil?
        type.default_enum = params[:default_enum] unless params[:default_enum].nil?
        type.default_int_enum = params[:default_int_enum] unless params[:default_int_enum].nil?
        type.empty_string = params[:empty_string] unless params[:empty_string].nil?
        type.false_boolean = params[:false_boolean] unless params[:false_boolean].nil?
        type.empty_blob = params[:empty_blob] unless params[:empty_blob].nil?
        type.zero_byte = params[:zero_byte] unless params[:zero_byte].nil?
        type.zero_short = params[:zero_short] unless params[:zero_short].nil?
        type.zero_integer = params[:zero_integer] unless params[:zero_integer].nil?
        type.zero_long = params[:zero_long] unless params[:zero_long].nil?
        type.zero_float = params[:zero_float]&.to_f unless params[:zero_float].nil?
        type.zero_double = params[:zero_double]&.to_f unless params[:zero_double].nil?
        type
      end
    end

    class DenseBooleanMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class DenseNumberMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value unless value.nil?
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
          data[key] = value unless value.nil?
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

    class EmptyInputOutputInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::EmptyInputOutputInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type
      end
    end

    class EmptyInputOutputOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::EmptyInputOutputOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type
      end
    end

    class Float16Input
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::Float16Input.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type
      end
    end

    class Float16Output
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::Float16Output.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.value = params[:value]&.to_f unless params[:value].nil?
        type
      end
    end

    class FooEnumList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class FractionalSecondsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::FractionalSecondsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type
      end
    end

    class FractionalSecondsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::FractionalSecondsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.datetime = params[:datetime] unless params[:datetime].nil?
        type
      end
    end

    class GreetingStruct
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::GreetingStruct.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.hi = params[:hi] unless params[:hi].nil?
        type
      end
    end

    class GreetingWithErrorsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::GreetingWithErrorsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type
      end
    end

    class GreetingWithErrorsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::GreetingWithErrorsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.greeting = params[:greeting] unless params[:greeting].nil?
        type
      end
    end

    class IntegerEnumList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class IntegerList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class InvalidGreeting
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::InvalidGreeting.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.message = params[:message] unless params[:message].nil?
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

    class NoInputOutputInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::NoInputOutputInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type
      end
    end

    class NoInputOutputOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::NoInputOutputOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type
      end
    end

    class OperationWithDefaultsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::OperationWithDefaultsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.defaults = Defaults.build(params[:defaults], context: "#{context}[:defaults]") unless params[:defaults].nil?
        type.client_optional_defaults = ClientOptionalDefaults.build(params[:client_optional_defaults], context: "#{context}[:client_optional_defaults]") unless params[:client_optional_defaults].nil?
        type.top_level_default = params[:top_level_default] unless params[:top_level_default].nil?
        type.other_top_level_default = params[:other_top_level_default] unless params[:other_top_level_default].nil?
        type
      end
    end

    class OperationWithDefaultsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::OperationWithDefaultsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.default_string = params[:default_string] unless params[:default_string].nil?
        type.default_boolean = params[:default_boolean] unless params[:default_boolean].nil?
        type.default_list = TestStringList.build(params[:default_list], context: "#{context}[:default_list]") unless params[:default_list].nil?
        type.default_timestamp = params[:default_timestamp] unless params[:default_timestamp].nil?
        type.default_blob = params[:default_blob] unless params[:default_blob].nil?
        type.default_byte = params[:default_byte] unless params[:default_byte].nil?
        type.default_short = params[:default_short] unless params[:default_short].nil?
        type.default_integer = params[:default_integer] unless params[:default_integer].nil?
        type.default_long = params[:default_long] unless params[:default_long].nil?
        type.default_float = params[:default_float]&.to_f unless params[:default_float].nil?
        type.default_double = params[:default_double]&.to_f unless params[:default_double].nil?
        type.default_map = TestStringMap.build(params[:default_map], context: "#{context}[:default_map]") unless params[:default_map].nil?
        type.default_enum = params[:default_enum] unless params[:default_enum].nil?
        type.default_int_enum = params[:default_int_enum] unless params[:default_int_enum].nil?
        type.empty_string = params[:empty_string] unless params[:empty_string].nil?
        type.false_boolean = params[:false_boolean] unless params[:false_boolean].nil?
        type.empty_blob = params[:empty_blob] unless params[:empty_blob].nil?
        type.zero_byte = params[:zero_byte] unless params[:zero_byte].nil?
        type.zero_short = params[:zero_short] unless params[:zero_short].nil?
        type.zero_integer = params[:zero_integer] unless params[:zero_integer].nil?
        type.zero_long = params[:zero_long] unless params[:zero_long].nil?
        type.zero_float = params[:zero_float]&.to_f unless params[:zero_float].nil?
        type.zero_double = params[:zero_double]&.to_f unless params[:zero_double].nil?
        type
      end
    end

    class OptionalInputOutputInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::OptionalInputOutputInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.value = params[:value] unless params[:value].nil?
        type
      end
    end

    class OptionalInputOutputOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::OptionalInputOutputOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.value = params[:value] unless params[:value].nil?
        type
      end
    end

    class RecursiveShapesInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RecursiveShapesInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.nested = RecursiveShapesInputOutputNested1.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class RecursiveShapesInputOutputNested1
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RecursiveShapesInputOutputNested1.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.foo = params[:foo] unless params[:foo].nil?
        type.nested = RecursiveShapesInputOutputNested2.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class RecursiveShapesInputOutputNested2
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RecursiveShapesInputOutputNested2.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.bar = params[:bar] unless params[:bar].nil?
        type.recursive_member = RecursiveShapesInputOutputNested1.build(params[:recursive_member], context: "#{context}[:recursive_member]") unless params[:recursive_member].nil?
        type
      end
    end

    class RecursiveShapesOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RecursiveShapesOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.nested = RecursiveShapesInputOutputNested1.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class RpcV2CborDenseMapsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RpcV2CborDenseMapsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.dense_struct_map = DenseStructMap.build(params[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless params[:dense_struct_map].nil?
        type.dense_number_map = DenseNumberMap.build(params[:dense_number_map], context: "#{context}[:dense_number_map]") unless params[:dense_number_map].nil?
        type.dense_boolean_map = DenseBooleanMap.build(params[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless params[:dense_boolean_map].nil?
        type.dense_string_map = DenseStringMap.build(params[:dense_string_map], context: "#{context}[:dense_string_map]") unless params[:dense_string_map].nil?
        type.dense_set_map = DenseSetMap.build(params[:dense_set_map], context: "#{context}[:dense_set_map]") unless params[:dense_set_map].nil?
        type
      end
    end

    class RpcV2CborDenseMapsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RpcV2CborDenseMapsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.dense_struct_map = DenseStructMap.build(params[:dense_struct_map], context: "#{context}[:dense_struct_map]") unless params[:dense_struct_map].nil?
        type.dense_number_map = DenseNumberMap.build(params[:dense_number_map], context: "#{context}[:dense_number_map]") unless params[:dense_number_map].nil?
        type.dense_boolean_map = DenseBooleanMap.build(params[:dense_boolean_map], context: "#{context}[:dense_boolean_map]") unless params[:dense_boolean_map].nil?
        type.dense_string_map = DenseStringMap.build(params[:dense_string_map], context: "#{context}[:dense_string_map]") unless params[:dense_string_map].nil?
        type.dense_set_map = DenseSetMap.build(params[:dense_set_map], context: "#{context}[:dense_set_map]") unless params[:dense_set_map].nil?
        type
      end
    end

    class RpcV2CborListsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RpcV2CborListsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.string_list = StringList.build(params[:string_list], context: "#{context}[:string_list]") unless params[:string_list].nil?
        type.string_set = StringSet.build(params[:string_set], context: "#{context}[:string_set]") unless params[:string_set].nil?
        type.integer_list = IntegerList.build(params[:integer_list], context: "#{context}[:integer_list]") unless params[:integer_list].nil?
        type.boolean_list = BooleanList.build(params[:boolean_list], context: "#{context}[:boolean_list]") unless params[:boolean_list].nil?
        type.timestamp_list = TimestampList.build(params[:timestamp_list], context: "#{context}[:timestamp_list]") unless params[:timestamp_list].nil?
        type.enum_list = FooEnumList.build(params[:enum_list], context: "#{context}[:enum_list]") unless params[:enum_list].nil?
        type.int_enum_list = IntegerEnumList.build(params[:int_enum_list], context: "#{context}[:int_enum_list]") unless params[:int_enum_list].nil?
        type.nested_string_list = NestedStringList.build(params[:nested_string_list], context: "#{context}[:nested_string_list]") unless params[:nested_string_list].nil?
        type.structure_list = StructureList.build(params[:structure_list], context: "#{context}[:structure_list]") unless params[:structure_list].nil?
        type.blob_list = BlobList.build(params[:blob_list], context: "#{context}[:blob_list]") unless params[:blob_list].nil?
        type
      end
    end

    class RpcV2CborListsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RpcV2CborListsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.string_list = StringList.build(params[:string_list], context: "#{context}[:string_list]") unless params[:string_list].nil?
        type.string_set = StringSet.build(params[:string_set], context: "#{context}[:string_set]") unless params[:string_set].nil?
        type.integer_list = IntegerList.build(params[:integer_list], context: "#{context}[:integer_list]") unless params[:integer_list].nil?
        type.boolean_list = BooleanList.build(params[:boolean_list], context: "#{context}[:boolean_list]") unless params[:boolean_list].nil?
        type.timestamp_list = TimestampList.build(params[:timestamp_list], context: "#{context}[:timestamp_list]") unless params[:timestamp_list].nil?
        type.enum_list = FooEnumList.build(params[:enum_list], context: "#{context}[:enum_list]") unless params[:enum_list].nil?
        type.int_enum_list = IntegerEnumList.build(params[:int_enum_list], context: "#{context}[:int_enum_list]") unless params[:int_enum_list].nil?
        type.nested_string_list = NestedStringList.build(params[:nested_string_list], context: "#{context}[:nested_string_list]") unless params[:nested_string_list].nil?
        type.structure_list = StructureList.build(params[:structure_list], context: "#{context}[:structure_list]") unless params[:structure_list].nil?
        type.blob_list = BlobList.build(params[:blob_list], context: "#{context}[:blob_list]") unless params[:blob_list].nil?
        type
      end
    end

    class RpcV2CborSparseMapsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RpcV2CborSparseMapsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.sparse_struct_map = SparseStructMap.build(params[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless params[:sparse_struct_map].nil?
        type.sparse_number_map = SparseNumberMap.build(params[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless params[:sparse_number_map].nil?
        type.sparse_boolean_map = SparseBooleanMap.build(params[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless params[:sparse_boolean_map].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type.sparse_set_map = SparseSetMap.build(params[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless params[:sparse_set_map].nil?
        type
      end
    end

    class RpcV2CborSparseMapsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::RpcV2CborSparseMapsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.sparse_struct_map = SparseStructMap.build(params[:sparse_struct_map], context: "#{context}[:sparse_struct_map]") unless params[:sparse_struct_map].nil?
        type.sparse_number_map = SparseNumberMap.build(params[:sparse_number_map], context: "#{context}[:sparse_number_map]") unless params[:sparse_number_map].nil?
        type.sparse_boolean_map = SparseBooleanMap.build(params[:sparse_boolean_map], context: "#{context}[:sparse_boolean_map]") unless params[:sparse_boolean_map].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type.sparse_set_map = SparseSetMap.build(params[:sparse_set_map], context: "#{context}[:sparse_set_map]") unless params[:sparse_set_map].nil?
        type
      end
    end

    class SimpleScalarPropertiesInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::SimpleScalarPropertiesInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.true_boolean_value = params[:true_boolean_value] unless params[:true_boolean_value].nil?
        type.false_boolean_value = params[:false_boolean_value] unless params[:false_boolean_value].nil?
        type.byte_value = params[:byte_value] unless params[:byte_value].nil?
        type.double_value = params[:double_value]&.to_f unless params[:double_value].nil?
        type.float_value = params[:float_value]&.to_f unless params[:float_value].nil?
        type.integer_value = params[:integer_value] unless params[:integer_value].nil?
        type.long_value = params[:long_value] unless params[:long_value].nil?
        type.short_value = params[:short_value] unless params[:short_value].nil?
        type.string_value = params[:string_value] unless params[:string_value].nil?
        type.blob_value = params[:blob_value] unless params[:blob_value].nil?
        type
      end
    end

    class SimpleScalarPropertiesOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::SimpleScalarPropertiesOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.true_boolean_value = params[:true_boolean_value] unless params[:true_boolean_value].nil?
        type.false_boolean_value = params[:false_boolean_value] unless params[:false_boolean_value].nil?
        type.byte_value = params[:byte_value] unless params[:byte_value].nil?
        type.double_value = params[:double_value]&.to_f unless params[:double_value].nil?
        type.float_value = params[:float_value]&.to_f unless params[:float_value].nil?
        type.integer_value = params[:integer_value] unless params[:integer_value].nil?
        type.long_value = params[:long_value] unless params[:long_value].nil?
        type.short_value = params[:short_value] unless params[:short_value].nil?
        type.string_value = params[:string_value] unless params[:string_value].nil?
        type.blob_value = params[:blob_value] unless params[:blob_value].nil?
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

    class SparseNullsOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::SparseNullsOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.sparse_string_list = SparseStringList.build(params[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless params[:sparse_string_list].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
        type
      end
    end

    class SparseNullsOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::SparseNullsOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.sparse_string_list = SparseStringList.build(params[:sparse_string_list], context: "#{context}[:sparse_string_list]") unless params[:sparse_string_list].nil?
        type.sparse_string_map = SparseStringMap.build(params[:sparse_string_map], context: "#{context}[:sparse_string_map]") unless params[:sparse_string_map].nil?
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

    class StringList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class StringSet
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
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
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::StructureListMember.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.a = params[:a] unless params[:a].nil?
        type.b = params[:b] unless params[:b].nil?
        type
      end
    end

    class TestStringList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class TestStringMap
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    class TimestampList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    class ValidationException
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::ValidationException.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.message = params[:message] unless params[:message].nil?
        type.field_list = ValidationExceptionFieldList.build(params[:field_list], context: "#{context}[:field_list]") unless params[:field_list].nil?
        type
      end
    end

    class ValidationExceptionField
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        type = Types::ValidationExceptionField.new
        Hearth::Validator.validate_unknown!(type, params, context: context)
        type.path = params[:path] unless params[:path].nil?
        type.message = params[:message] unless params[:message].nil?
        type
      end
    end

    class ValidationExceptionFieldList
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << ValidationExceptionField.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

  end
end
