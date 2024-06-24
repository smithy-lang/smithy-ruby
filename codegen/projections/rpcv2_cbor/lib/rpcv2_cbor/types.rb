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
    ClientOptionalDefaults = ::Struct.new(
      :member,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    ComplexError = ::Struct.new(
      :top_level,
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    # @!attribute foo
    #   @return [String]
    ComplexNestedErrorData = ::Struct.new(
      :foo,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    #   @option params [Hash<String, String>] :default_map
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
    #   @return [Hash<String, String>]
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
    Defaults = ::Struct.new(
      :default_string,
      :default_boolean,
      :default_list,
      :default_timestamp,
      :default_blob,
      :default_byte,
      :default_short,
      :default_integer,
      :default_long,
      :default_float,
      :default_double,
      :default_map,
      :default_enum,
      :default_int_enum,
      :empty_string,
      :false_boolean,
      :empty_blob,
      :zero_byte,
      :zero_short,
      :zero_integer,
      :zero_long,
      :zero_float,
      :zero_double,
      keyword_init: true
    ) do
      include Hearth::Structure

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
    EmptyInputOutputInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EmptyInputOutputOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    Float16Input = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Float] :value
    # @!attribute value
    #   @return [Float]
    Float16Output = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    FractionalSecondsInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Time] :datetime
    # @!attribute datetime
    #   @return [Time]
    FractionalSecondsOutput = ::Struct.new(
      :datetime,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :hi
    # @!attribute hi
    #   @return [String]
    GreetingStruct = ::Struct.new(
      :hi,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    GreetingWithErrorsInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :greeting
    # @!attribute greeting
    #   @return [String]
    GreetingWithErrorsOutput = ::Struct.new(
      :greeting,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    InvalidGreeting = ::Struct.new(
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoInputOutputInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoInputOutputOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    OperationWithDefaultsInput = ::Struct.new(
      :defaults,
      :client_optional_defaults,
      :top_level_default,
      :other_top_level_default,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    #   @option params [Hash<String, String>] :default_map
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
    #   @return [Hash<String, String>]
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
    OperationWithDefaultsOutput = ::Struct.new(
      :default_string,
      :default_boolean,
      :default_list,
      :default_timestamp,
      :default_blob,
      :default_byte,
      :default_short,
      :default_integer,
      :default_long,
      :default_float,
      :default_double,
      :default_map,
      :default_enum,
      :default_int_enum,
      :empty_string,
      :false_boolean,
      :empty_blob,
      :zero_byte,
      :zero_short,
      :zero_integer,
      :zero_long,
      :zero_float,
      :zero_double,
      keyword_init: true
    ) do
      include Hearth::Structure

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
    OptionalInputOutputInput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    OptionalInputOutputOutput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [RecursiveShapesInputOutputNested1] :nested
    # @!attribute nested
    #   @return [RecursiveShapesInputOutputNested1]
    RecursiveShapesInput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [RecursiveShapesInputOutputNested2] :nested
    # @!attribute foo
    #   @return [String]
    # @!attribute nested
    #   @return [RecursiveShapesInputOutputNested2]
    RecursiveShapesInputOutputNested1 = ::Struct.new(
      :foo,
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :bar
    #   @option params [RecursiveShapesInputOutputNested1] :recursive_member
    # @!attribute bar
    #   @return [String]
    # @!attribute recursive_member
    #   @return [RecursiveShapesInputOutputNested1]
    RecursiveShapesInputOutputNested2 = ::Struct.new(
      :bar,
      :recursive_member,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [RecursiveShapesInputOutputNested1] :nested
    # @!attribute nested
    #   @return [RecursiveShapesInputOutputNested1]
    RecursiveShapesOutput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, GreetingStruct>] :dense_struct_map
    #   @option params [Hash<String, Integer>] :dense_number_map
    #   @option params [Hash<String, Boolean>] :dense_boolean_map
    #   @option params [Hash<String, String>] :dense_string_map
    #   @option params [Hash<String, Array<String>>] :dense_set_map
    # @!attribute dense_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute dense_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute dense_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute dense_string_map
    #   @return [Hash<String, String>]
    # @!attribute dense_set_map
    #   @return [Hash<String, Array<String>>]
    RpcV2CborDenseMapsInput = ::Struct.new(
      :dense_struct_map,
      :dense_number_map,
      :dense_boolean_map,
      :dense_string_map,
      :dense_set_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, GreetingStruct>] :dense_struct_map
    #   @option params [Hash<String, Integer>] :dense_number_map
    #   @option params [Hash<String, Boolean>] :dense_boolean_map
    #   @option params [Hash<String, String>] :dense_string_map
    #   @option params [Hash<String, Array<String>>] :dense_set_map
    # @!attribute dense_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute dense_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute dense_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute dense_string_map
    #   @return [Hash<String, String>]
    # @!attribute dense_set_map
    #   @return [Hash<String, Array<String>>]
    RpcV2CborDenseMapsOutput = ::Struct.new(
      :dense_struct_map,
      :dense_number_map,
      :dense_boolean_map,
      :dense_string_map,
      :dense_set_map,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    RpcV2CborListsInput = ::Struct.new(
      :string_list,
      :string_set,
      :integer_list,
      :boolean_list,
      :timestamp_list,
      :enum_list,
      :int_enum_list,
      :nested_string_list,
      :structure_list,
      :blob_list,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    RpcV2CborListsOutput = ::Struct.new(
      :string_list,
      :string_set,
      :integer_list,
      :boolean_list,
      :timestamp_list,
      :enum_list,
      :int_enum_list,
      :nested_string_list,
      :structure_list,
      :blob_list,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, GreetingStruct>] :sparse_struct_map
    #   @option params [Hash<String, Integer>] :sparse_number_map
    #   @option params [Hash<String, Boolean>] :sparse_boolean_map
    #   @option params [Hash<String, String>] :sparse_string_map
    #   @option params [Hash<String, Array<String>>] :sparse_set_map
    # @!attribute sparse_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute sparse_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute sparse_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    # @!attribute sparse_set_map
    #   @return [Hash<String, Array<String>>]
    RpcV2CborSparseMapsInput = ::Struct.new(
      :sparse_struct_map,
      :sparse_number_map,
      :sparse_boolean_map,
      :sparse_string_map,
      :sparse_set_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, GreetingStruct>] :sparse_struct_map
    #   @option params [Hash<String, Integer>] :sparse_number_map
    #   @option params [Hash<String, Boolean>] :sparse_boolean_map
    #   @option params [Hash<String, String>] :sparse_string_map
    #   @option params [Hash<String, Array<String>>] :sparse_set_map
    # @!attribute sparse_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute sparse_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute sparse_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    # @!attribute sparse_set_map
    #   @return [Hash<String, Array<String>>]
    RpcV2CborSparseMapsOutput = ::Struct.new(
      :sparse_struct_map,
      :sparse_number_map,
      :sparse_boolean_map,
      :sparse_string_map,
      :sparse_set_map,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    SimpleScalarPropertiesInput = ::Struct.new(
      :true_boolean_value,
      :false_boolean_value,
      :byte_value,
      :double_value,
      :float_value,
      :integer_value,
      :long_value,
      :short_value,
      :string_value,
      :blob_value,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    SimpleScalarPropertiesOutput = ::Struct.new(
      :true_boolean_value,
      :false_boolean_value,
      :byte_value,
      :double_value,
      :float_value,
      :integer_value,
      :long_value,
      :short_value,
      :string_value,
      :blob_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    #   @option params [Hash<String, String>] :sparse_string_map
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    SparseNullsOperationInput = ::Struct.new(
      :sparse_string_list,
      :sparse_string_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    #   @option params [Hash<String, String>] :sparse_string_map
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    SparseNullsOperationOutput = ::Struct.new(
      :sparse_string_list,
      :sparse_string_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :a
    #   @option params [String] :b
    # @!attribute a
    #   @return [String]
    # @!attribute b
    #   @return [String]
    StructureListMember = ::Struct.new(
      :a,
      :b,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    ValidationException = ::Struct.new(
      :message,
      :field_list,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    ValidationExceptionField = ::Struct.new(
      :path,
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
