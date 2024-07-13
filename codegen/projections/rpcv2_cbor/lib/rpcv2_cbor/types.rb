# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Rpcv2Cbor
  module Types

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :member
    # @!attribute member
    #   @return [Integer]
    class ClientOptionalDefaults
      include Hearth::Structure

      MEMBERS = %i[
        member
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # This error is thrown when a request is invalid.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :top_level
    #   @option params [ComplexNestedErrorData] :nested
    # @!attribute top_level
    #   @return [String]
    # @!attribute nested
    #   @return [ComplexNestedErrorData]
    class ComplexError
      include Hearth::Structure

      MEMBERS = %i[
        top_level
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    # @!attribute foo
    #   @return [String]
    class ComplexNestedErrorData
      include Hearth::Structure

      MEMBERS = %i[
        foo
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :default_string
    #   @option params [Boolean] :default_boolean
    #   @option params [Array<String>] :default_list
    #   @option params [Time] :default_timestamp
    #   @option params [String] :default_blob
    #   @option params [Integer] :default_byte
    #   @option params [Integer] :default_short
    #   @option params [Integer] :default_integer
    #   @option params [Integer] :default_long
    #   @option params [Float] :default_float
    #   @option params [Float] :default_double
    #   @option params [Hash<Symbol, String>] :default_map
    #   @option params [String] :default_enum
    #   @option params [Integer] :default_int_enum
    #   @option params [String] :empty_string
    #   @option params [Boolean] :false_boolean (false)
    #   @option params [String] :empty_blob
    #   @option params [Integer] :zero_byte (0)
    #   @option params [Integer] :zero_short (0)
    #   @option params [Integer] :zero_integer (0)
    #   @option params [Integer] :zero_long (0)
    #   @option params [Float] :zero_float (0)
    #   @option params [Float] :zero_double (0)
    # @!attribute default_string
    #   @return [String]
    # @!attribute default_boolean
    #   @return [Boolean]
    # @!attribute default_list
    #   @return [Array<String>]
    # @!attribute default_timestamp
    #   @return [Time]
    # @!attribute default_blob
    #   @return [String]
    # @!attribute default_byte
    #   @return [Integer]
    # @!attribute default_short
    #   @return [Integer]
    # @!attribute default_integer
    #   @return [Integer]
    # @!attribute default_long
    #   @return [Integer]
    # @!attribute default_float
    #   @return [Float]
    # @!attribute default_double
    #   @return [Float]
    # @!attribute default_map
    #   @return [Hash<Symbol, String>]
    # @!attribute default_enum
    #   Enum, one of: ["FOO", "BAR", "BAZ"]
    #   @return [String]
    # @!attribute default_int_enum
    #   @return [Integer]
    # @!attribute empty_string
    #   @return [String]
    # @!attribute false_boolean
    #   @return [Boolean]
    # @!attribute empty_blob
    #   @return [String]
    # @!attribute zero_byte
    #   @return [Integer]
    # @!attribute zero_short
    #   @return [Integer]
    # @!attribute zero_integer
    #   @return [Integer]
    # @!attribute zero_long
    #   @return [Integer]
    # @!attribute zero_float
    #   @return [Float]
    # @!attribute zero_double
    #   @return [Float]
    class Defaults
      include Hearth::Structure

      MEMBERS = %i[
        default_string
        default_boolean
        default_list
        default_timestamp
        default_blob
        default_byte
        default_short
        default_integer
        default_long
        default_float
        default_double
        default_map
        default_enum
        default_int_enum
        empty_string
        false_boolean
        empty_blob
        zero_byte
        zero_short
        zero_integer
        zero_long
        zero_float
        zero_double
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          default_string: "hi",
          default_boolean: true,
          default_list: [],
          default_timestamp: Time.at(0),
          default_blob: "abc",
          default_byte: 1,
          default_short: 1,
          default_integer: 10,
          default_long: 100,
          default_float: 1.0.to_f,
          default_double: 1.0.to_f,
          default_map: {},
          default_enum: "FOO",
          default_int_enum: 1,
          empty_string: "",
          false_boolean: false,
          empty_blob: "",
          zero_byte: 0,
          zero_short: 0,
          zero_integer: 0,
          zero_long: 0,
          zero_float: 0.0.to_f,
          zero_double: 0.0.to_f
        }
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EmptyInputOutputInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EmptyInputOutputOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class Float16Input
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Float] :value
    # @!attribute value
    #   @return [Float]
    class Float16Output
      include Hearth::Structure

      MEMBERS = %i[
        value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Enum constants for FooEnum
    module FooEnum
      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class FractionalSecondsInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Time] :datetime
    # @!attribute datetime
    #   @return [Time]
    class FractionalSecondsOutput
      include Hearth::Structure

      MEMBERS = %i[
        datetime
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :hi
    # @!attribute hi
    #   @return [String]
    class GreetingStruct
      include Hearth::Structure

      MEMBERS = %i[
        hi
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class GreetingWithErrorsInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :greeting
    # @!attribute greeting
    #   @return [String]
    class GreetingWithErrorsOutput
      include Hearth::Structure

      MEMBERS = %i[
        greeting
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Enum constants for IntegerEnum
    module IntegerEnum
      A = 1

      B = 2

      C = 3
    end

    # This error is thrown when an invalid greeting value is provided.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :message
    # @!attribute message
    #   @return [String]
    class InvalidGreeting
      include Hearth::Structure

      MEMBERS = %i[
        message
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoInputOutputInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoInputOutputOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Defaults] :defaults
    #   @option params [ClientOptionalDefaults] :client_optional_defaults
    #   @option params [String] :top_level_default
    #   @option params [Integer] :other_top_level_default (0)
    # @!attribute defaults
    #   @return [Defaults]
    # @!attribute client_optional_defaults
    #   @return [ClientOptionalDefaults]
    # @!attribute top_level_default
    #   @return [String]
    # @!attribute other_top_level_default
    #   @return [Integer]
    class OperationWithDefaultsInput
      include Hearth::Structure

      MEMBERS = %i[
        defaults
        client_optional_defaults
        top_level_default
        other_top_level_default
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :default_string
    #   @option params [Boolean] :default_boolean
    #   @option params [Array<String>] :default_list
    #   @option params [Time] :default_timestamp
    #   @option params [String] :default_blob
    #   @option params [Integer] :default_byte
    #   @option params [Integer] :default_short
    #   @option params [Integer] :default_integer
    #   @option params [Integer] :default_long
    #   @option params [Float] :default_float
    #   @option params [Float] :default_double
    #   @option params [Hash<Symbol, String>] :default_map
    #   @option params [String] :default_enum
    #   @option params [Integer] :default_int_enum
    #   @option params [String] :empty_string
    #   @option params [Boolean] :false_boolean (false)
    #   @option params [String] :empty_blob
    #   @option params [Integer] :zero_byte (0)
    #   @option params [Integer] :zero_short (0)
    #   @option params [Integer] :zero_integer (0)
    #   @option params [Integer] :zero_long (0)
    #   @option params [Float] :zero_float (0)
    #   @option params [Float] :zero_double (0)
    # @!attribute default_string
    #   @return [String]
    # @!attribute default_boolean
    #   @return [Boolean]
    # @!attribute default_list
    #   @return [Array<String>]
    # @!attribute default_timestamp
    #   @return [Time]
    # @!attribute default_blob
    #   @return [String]
    # @!attribute default_byte
    #   @return [Integer]
    # @!attribute default_short
    #   @return [Integer]
    # @!attribute default_integer
    #   @return [Integer]
    # @!attribute default_long
    #   @return [Integer]
    # @!attribute default_float
    #   @return [Float]
    # @!attribute default_double
    #   @return [Float]
    # @!attribute default_map
    #   @return [Hash<Symbol, String>]
    # @!attribute default_enum
    #   Enum, one of: ["FOO", "BAR", "BAZ"]
    #   @return [String]
    # @!attribute default_int_enum
    #   @return [Integer]
    # @!attribute empty_string
    #   @return [String]
    # @!attribute false_boolean
    #   @return [Boolean]
    # @!attribute empty_blob
    #   @return [String]
    # @!attribute zero_byte
    #   @return [Integer]
    # @!attribute zero_short
    #   @return [Integer]
    # @!attribute zero_integer
    #   @return [Integer]
    # @!attribute zero_long
    #   @return [Integer]
    # @!attribute zero_float
    #   @return [Float]
    # @!attribute zero_double
    #   @return [Float]
    class OperationWithDefaultsOutput
      include Hearth::Structure

      MEMBERS = %i[
        default_string
        default_boolean
        default_list
        default_timestamp
        default_blob
        default_byte
        default_short
        default_integer
        default_long
        default_float
        default_double
        default_map
        default_enum
        default_int_enum
        empty_string
        false_boolean
        empty_blob
        zero_byte
        zero_short
        zero_integer
        zero_long
        zero_float
        zero_double
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          default_string: "hi",
          default_boolean: true,
          default_list: [],
          default_timestamp: Time.at(0),
          default_blob: "abc",
          default_byte: 1,
          default_short: 1,
          default_integer: 10,
          default_long: 100,
          default_float: 1.0.to_f,
          default_double: 1.0.to_f,
          default_map: {},
          default_enum: "FOO",
          default_int_enum: 1,
          empty_string: "",
          false_boolean: false,
          empty_blob: "",
          zero_byte: 0,
          zero_short: 0,
          zero_integer: 0,
          zero_long: 0,
          zero_float: 0.0.to_f,
          zero_double: 0.0.to_f
        }
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    class OptionalInputOutputInput
      include Hearth::Structure

      MEMBERS = %i[
        value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    class OptionalInputOutputOutput
      include Hearth::Structure

      MEMBERS = %i[
        value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [RecursiveShapesInputOutputNested1] :nested
    # @!attribute nested
    #   @return [RecursiveShapesInputOutputNested1]
    class RecursiveShapesInput
      include Hearth::Structure

      MEMBERS = %i[
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [RecursiveShapesInputOutputNested2] :nested
    # @!attribute foo
    #   @return [String]
    # @!attribute nested
    #   @return [RecursiveShapesInputOutputNested2]
    class RecursiveShapesInputOutputNested1
      include Hearth::Structure

      MEMBERS = %i[
        foo
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :bar
    #   @option params [RecursiveShapesInputOutputNested1] :recursive_member
    # @!attribute bar
    #   @return [String]
    # @!attribute recursive_member
    #   @return [RecursiveShapesInputOutputNested1]
    class RecursiveShapesInputOutputNested2
      include Hearth::Structure

      MEMBERS = %i[
        bar
        recursive_member
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [RecursiveShapesInputOutputNested1] :nested
    # @!attribute nested
    #   @return [RecursiveShapesInputOutputNested1]
    class RecursiveShapesOutput
      include Hearth::Structure

      MEMBERS = %i[
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<Symbol, GreetingStruct>] :dense_struct_map
    #   @option params [Hash<Symbol, Integer>] :dense_number_map
    #   @option params [Hash<Symbol, Boolean>] :dense_boolean_map
    #   @option params [Hash<Symbol, String>] :dense_string_map
    #   @option params [Hash<Symbol, Array<String>>] :dense_set_map
    # @!attribute dense_struct_map
    #   @return [Hash<Symbol, GreetingStruct>]
    # @!attribute dense_number_map
    #   @return [Hash<Symbol, Integer>]
    # @!attribute dense_boolean_map
    #   @return [Hash<Symbol, Boolean>]
    # @!attribute dense_string_map
    #   @return [Hash<Symbol, String>]
    # @!attribute dense_set_map
    #   @return [Hash<Symbol, Array<String>>]
    class RpcV2CborDenseMapsInput
      include Hearth::Structure

      MEMBERS = %i[
        dense_struct_map
        dense_number_map
        dense_boolean_map
        dense_string_map
        dense_set_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<Symbol, GreetingStruct>] :dense_struct_map
    #   @option params [Hash<Symbol, Integer>] :dense_number_map
    #   @option params [Hash<Symbol, Boolean>] :dense_boolean_map
    #   @option params [Hash<Symbol, String>] :dense_string_map
    #   @option params [Hash<Symbol, Array<String>>] :dense_set_map
    # @!attribute dense_struct_map
    #   @return [Hash<Symbol, GreetingStruct>]
    # @!attribute dense_number_map
    #   @return [Hash<Symbol, Integer>]
    # @!attribute dense_boolean_map
    #   @return [Hash<Symbol, Boolean>]
    # @!attribute dense_string_map
    #   @return [Hash<Symbol, String>]
    # @!attribute dense_set_map
    #   @return [Hash<Symbol, Array<String>>]
    class RpcV2CborDenseMapsOutput
      include Hearth::Structure

      MEMBERS = %i[
        dense_struct_map
        dense_number_map
        dense_boolean_map
        dense_string_map
        dense_set_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :string_list
    #   @option params [Array<String>] :string_set
    #   @option params [Array<Integer>] :integer_list
    #   @option params [Array<Boolean>] :boolean_list
    #   @option params [Array<Time>] :timestamp_list
    #   @option params [Array<String>] :enum_list
    #   @option params [Array<Integer>] :int_enum_list
    #   @option params [Array<Array<String>>] :nested_string_list
    #   @option params [Array<StructureListMember>] :structure_list
    #   @option params [Array<String>] :blob_list
    # @!attribute string_list
    #   @return [Array<String>]
    # @!attribute string_set
    #   @return [Array<String>]
    # @!attribute integer_list
    #   @return [Array<Integer>]
    # @!attribute boolean_list
    #   @return [Array<Boolean>]
    # @!attribute timestamp_list
    #   @return [Array<Time>]
    # @!attribute enum_list
    #   @return [Array<String>]
    # @!attribute int_enum_list
    #   @return [Array<Integer>]
    # @!attribute nested_string_list
    #   A list of lists of strings.
    #   @return [Array<Array<String>>]
    # @!attribute structure_list
    #   @return [Array<StructureListMember>]
    # @!attribute blob_list
    #   @return [Array<String>]
    class RpcV2CborListsInput
      include Hearth::Structure

      MEMBERS = %i[
        string_list
        string_set
        integer_list
        boolean_list
        timestamp_list
        enum_list
        int_enum_list
        nested_string_list
        structure_list
        blob_list
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :string_list
    #   @option params [Array<String>] :string_set
    #   @option params [Array<Integer>] :integer_list
    #   @option params [Array<Boolean>] :boolean_list
    #   @option params [Array<Time>] :timestamp_list
    #   @option params [Array<String>] :enum_list
    #   @option params [Array<Integer>] :int_enum_list
    #   @option params [Array<Array<String>>] :nested_string_list
    #   @option params [Array<StructureListMember>] :structure_list
    #   @option params [Array<String>] :blob_list
    # @!attribute string_list
    #   @return [Array<String>]
    # @!attribute string_set
    #   @return [Array<String>]
    # @!attribute integer_list
    #   @return [Array<Integer>]
    # @!attribute boolean_list
    #   @return [Array<Boolean>]
    # @!attribute timestamp_list
    #   @return [Array<Time>]
    # @!attribute enum_list
    #   @return [Array<String>]
    # @!attribute int_enum_list
    #   @return [Array<Integer>]
    # @!attribute nested_string_list
    #   A list of lists of strings.
    #   @return [Array<Array<String>>]
    # @!attribute structure_list
    #   @return [Array<StructureListMember>]
    # @!attribute blob_list
    #   @return [Array<String>]
    class RpcV2CborListsOutput
      include Hearth::Structure

      MEMBERS = %i[
        string_list
        string_set
        integer_list
        boolean_list
        timestamp_list
        enum_list
        int_enum_list
        nested_string_list
        structure_list
        blob_list
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<Symbol, GreetingStruct>] :sparse_struct_map
    #   @option params [Hash<Symbol, Integer>] :sparse_number_map
    #   @option params [Hash<Symbol, Boolean>] :sparse_boolean_map
    #   @option params [Hash<Symbol, String>] :sparse_string_map
    #   @option params [Hash<Symbol, Array<String>>] :sparse_set_map
    # @!attribute sparse_struct_map
    #   @return [Hash<Symbol, GreetingStruct>]
    # @!attribute sparse_number_map
    #   @return [Hash<Symbol, Integer>]
    # @!attribute sparse_boolean_map
    #   @return [Hash<Symbol, Boolean>]
    # @!attribute sparse_string_map
    #   @return [Hash<Symbol, String>]
    # @!attribute sparse_set_map
    #   @return [Hash<Symbol, Array<String>>]
    class RpcV2CborSparseMapsInput
      include Hearth::Structure

      MEMBERS = %i[
        sparse_struct_map
        sparse_number_map
        sparse_boolean_map
        sparse_string_map
        sparse_set_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<Symbol, GreetingStruct>] :sparse_struct_map
    #   @option params [Hash<Symbol, Integer>] :sparse_number_map
    #   @option params [Hash<Symbol, Boolean>] :sparse_boolean_map
    #   @option params [Hash<Symbol, String>] :sparse_string_map
    #   @option params [Hash<Symbol, Array<String>>] :sparse_set_map
    # @!attribute sparse_struct_map
    #   @return [Hash<Symbol, GreetingStruct>]
    # @!attribute sparse_number_map
    #   @return [Hash<Symbol, Integer>]
    # @!attribute sparse_boolean_map
    #   @return [Hash<Symbol, Boolean>]
    # @!attribute sparse_string_map
    #   @return [Hash<Symbol, String>]
    # @!attribute sparse_set_map
    #   @return [Hash<Symbol, Array<String>>]
    class RpcV2CborSparseMapsOutput
      include Hearth::Structure

      MEMBERS = %i[
        sparse_struct_map
        sparse_number_map
        sparse_boolean_map
        sparse_string_map
        sparse_set_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Boolean] :true_boolean_value
    #   @option params [Boolean] :false_boolean_value
    #   @option params [Integer] :byte_value
    #   @option params [Float] :double_value
    #   @option params [Float] :float_value
    #   @option params [Integer] :integer_value
    #   @option params [Integer] :long_value
    #   @option params [Integer] :short_value
    #   @option params [String] :string_value
    #   @option params [String] :blob_value
    # @!attribute true_boolean_value
    #   @return [Boolean]
    # @!attribute false_boolean_value
    #   @return [Boolean]
    # @!attribute byte_value
    #   @return [Integer]
    # @!attribute double_value
    #   @return [Float]
    # @!attribute float_value
    #   @return [Float]
    # @!attribute integer_value
    #   @return [Integer]
    # @!attribute long_value
    #   @return [Integer]
    # @!attribute short_value
    #   @return [Integer]
    # @!attribute string_value
    #   @return [String]
    # @!attribute blob_value
    #   @return [String]
    class SimpleScalarPropertiesInput
      include Hearth::Structure

      MEMBERS = %i[
        true_boolean_value
        false_boolean_value
        byte_value
        double_value
        float_value
        integer_value
        long_value
        short_value
        string_value
        blob_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Boolean] :true_boolean_value
    #   @option params [Boolean] :false_boolean_value
    #   @option params [Integer] :byte_value
    #   @option params [Float] :double_value
    #   @option params [Float] :float_value
    #   @option params [Integer] :integer_value
    #   @option params [Integer] :long_value
    #   @option params [Integer] :short_value
    #   @option params [String] :string_value
    #   @option params [String] :blob_value
    # @!attribute true_boolean_value
    #   @return [Boolean]
    # @!attribute false_boolean_value
    #   @return [Boolean]
    # @!attribute byte_value
    #   @return [Integer]
    # @!attribute double_value
    #   @return [Float]
    # @!attribute float_value
    #   @return [Float]
    # @!attribute integer_value
    #   @return [Integer]
    # @!attribute long_value
    #   @return [Integer]
    # @!attribute short_value
    #   @return [Integer]
    # @!attribute string_value
    #   @return [String]
    # @!attribute blob_value
    #   @return [String]
    class SimpleScalarPropertiesOutput
      include Hearth::Structure

      MEMBERS = %i[
        true_boolean_value
        false_boolean_value
        byte_value
        double_value
        float_value
        integer_value
        long_value
        short_value
        string_value
        blob_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    #   @option params [Hash<Symbol, String>] :sparse_string_map
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    # @!attribute sparse_string_map
    #   @return [Hash<Symbol, String>]
    class SparseNullsOperationInput
      include Hearth::Structure

      MEMBERS = %i[
        sparse_string_list
        sparse_string_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    #   @option params [Hash<Symbol, String>] :sparse_string_map
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    # @!attribute sparse_string_map
    #   @return [Hash<Symbol, String>]
    class SparseNullsOperationOutput
      include Hearth::Structure

      MEMBERS = %i[
        sparse_string_list
        sparse_string_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :a
    #   @option params [String] :b
    # @!attribute a
    #   @return [String]
    # @!attribute b
    #   @return [String]
    class StructureListMember
      include Hearth::Structure

      MEMBERS = %i[
        a
        b
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Enum constants for TestEnum
    module TestEnum
      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"
    end

    # Enum constants for TestIntEnum
    module TestIntEnum
      ONE = 1

      TWO = 2
    end

    # A standard error for input validation failures.
    # This should be thrown by services when a member of the input structure
    # falls outside of the modeled or documented constraints.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :message
    #   @option params [Array<ValidationExceptionField>] :field_list
    # @!attribute message
    #   A summary of the validation failure.
    #   @return [String]
    # @!attribute field_list
    #   A list of specific failures encountered while validating the input.
    #   A member can appear in this list more than once if it failed to satisfy multiple constraints.
    #   @return [Array<ValidationExceptionField>]
    class ValidationException
      include Hearth::Structure

      MEMBERS = %i[
        message
        field_list
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Describes one specific validation failure for an input member.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :path
    #   @option params [String] :message
    # @!attribute path
    #   A JSONPointer expression to the structure member whose value failed to satisfy the modeled constraints.
    #   @return [String]
    # @!attribute message
    #   A detailed description of the validation failure.
    #   @return [String]
    class ValidationExceptionField
      include Hearth::Structure

      MEMBERS = %i[
        path
        message
      ].freeze

      attr_accessor(*MEMBERS)
    end

  end
end
