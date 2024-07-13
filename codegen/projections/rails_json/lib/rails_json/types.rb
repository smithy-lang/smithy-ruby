# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module RailsJson
  module Types

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :query_string
    #   @option params [Array<String>] :query_string_list
    #   @option params [Array<String>] :query_string_set
    #   @option params [Integer] :query_byte
    #   @option params [Integer] :query_short
    #   @option params [Integer] :query_integer
    #   @option params [Array<Integer>] :query_integer_list
    #   @option params [Array<Integer>] :query_integer_set
    #   @option params [Integer] :query_long
    #   @option params [Float] :query_float
    #   @option params [Float] :query_double
    #   @option params [Array<Float>] :query_double_list
    #   @option params [Boolean] :query_boolean
    #   @option params [Array<Boolean>] :query_boolean_list
    #   @option params [Time] :query_timestamp
    #   @option params [Array<Time>] :query_timestamp_list
    #   @option params [String] :query_enum
    #   @option params [Array<String>] :query_enum_list
    #   @option params [Integer] :query_integer_enum
    #   @option params [Array<Integer>] :query_integer_enum_list
    #   @option params [Hash<Symbol, Array<String>>] :query_params_map_of_string_list
    # @!attribute query_string
    #   @return [String]
    # @!attribute query_string_list
    #   @return [Array<String>]
    # @!attribute query_string_set
    #   @return [Array<String>]
    # @!attribute query_byte
    #   @return [Integer]
    # @!attribute query_short
    #   @return [Integer]
    # @!attribute query_integer
    #   @return [Integer]
    # @!attribute query_integer_list
    #   @return [Array<Integer>]
    # @!attribute query_integer_set
    #   @return [Array<Integer>]
    # @!attribute query_long
    #   @return [Integer]
    # @!attribute query_float
    #   @return [Float]
    # @!attribute query_double
    #   @return [Float]
    # @!attribute query_double_list
    #   @return [Array<Float>]
    # @!attribute query_boolean
    #   @return [Boolean]
    # @!attribute query_boolean_list
    #   @return [Array<Boolean>]
    # @!attribute query_timestamp
    #   @return [Time]
    # @!attribute query_timestamp_list
    #   @return [Array<Time>]
    # @!attribute query_enum
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute query_enum_list
    #   @return [Array<String>]
    # @!attribute query_integer_enum
    #   @return [Integer]
    # @!attribute query_integer_enum_list
    #   @return [Array<Integer>]
    # @!attribute query_params_map_of_string_list
    #   @return [Hash<Symbol, Array<String>>]
    class AllQueryStringTypesInput
      include Hearth::Structure

      MEMBERS = %i[
        query_string
        query_string_list
        query_string_set
        query_byte
        query_short
        query_integer
        query_integer_list
        query_integer_set
        query_long
        query_float
        query_double
        query_double_list
        query_boolean
        query_boolean_list
        query_timestamp
        query_timestamp_list
        query_enum
        query_enum_list
        query_integer_enum
        query_integer_enum_list
        query_params_map_of_string_list
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class AllQueryStringTypesOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

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
    #   @option params [String] :header
    #   @option params [String] :top_level
    #   @option params [ComplexNestedErrorData] :nested
    # @!attribute header
    #   @return [String]
    # @!attribute top_level
    #   @return [String]
    # @!attribute nested
    #   @return [ComplexNestedErrorData]
    class ComplexError
      include Hearth::Structure

      MEMBERS = %i[
        header
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
    #   @option params [String] :baz
    #   @option params [String] :maybe_set
    # @!attribute baz
    #   @return [String]
    # @!attribute maybe_set
    #   @return [String]
    class ConstantAndVariableQueryStringInput
      include Hearth::Structure

      MEMBERS = %i[
        baz
        maybe_set
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class ConstantAndVariableQueryStringOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :hello
    # @!attribute hello
    #   @return [String]
    class ConstantQueryStringInput
      include Hearth::Structure

      MEMBERS = %i[
        hello
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class ConstantQueryStringOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class DatetimeOffsetsInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Time] :datetime
    # @!attribute datetime
    #   @return [Time]
    class DatetimeOffsetsOutput
      include Hearth::Structure

      MEMBERS = %i[
        datetime
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :default_string
    #   @option params [Boolean] :default_boolean
    #   @option params [Array<String>] :default_list
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_map
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_string
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_boolean
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_list
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_null_document
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
    # @!attribute default_document_map
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_document_string
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_document_boolean
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_document_list
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_null_document
    #   @return [Hash, Array, String, Boolean, Numeric]
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
        default_document_map
        default_document_string
        default_document_boolean
        default_document_list
        default_null_document
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
          default_document_map: {},
          default_document_string: "hi",
          default_document_boolean: true,
          default_document_list: [],
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
    #   @option params [String] :language
    #   @option params [String] :greeting
    #   @option params [Farewell] :farewell
    # @!attribute language
    #   @return [String]
    # @!attribute greeting
    #   @return [String]
    # @!attribute farewell
    #   @return [Farewell]
    class Dialog
      include Hearth::Structure

      MEMBERS = %i[
        language
        greeting
        farewell
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          greeting: "hi"
        }
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<Symbol, Hash, Array, String, Boolean, Numeric>] :doc_valued_map
    # @!attribute doc_valued_map
    #   @return [Hash<Symbol, Hash, Array, String, Boolean, Numeric>]
    class DocumentTypeAsMapValueInput
      include Hearth::Structure

      MEMBERS = %i[
        doc_valued_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<Symbol, Hash, Array, String, Boolean, Numeric>] :doc_valued_map
    # @!attribute doc_valued_map
    #   @return [Hash<Symbol, Hash, Array, String, Boolean, Numeric>]
    class DocumentTypeAsMapValueOutput
      include Hearth::Structure

      MEMBERS = %i[
        doc_valued_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    class DocumentTypeAsPayloadInput
      include Hearth::Structure

      MEMBERS = %i[
        document_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    class DocumentTypeAsPayloadOutput
      include Hearth::Structure

      MEMBERS = %i[
        document_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string_value
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute string_value
    #   @return [String]
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    class DocumentTypeInput
      include Hearth::Structure

      MEMBERS = %i[
        string_value
        document_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string_value
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute string_value
    #   @return [String]
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    class DocumentTypeOutput
      include Hearth::Structure

      MEMBERS = %i[
        string_value
        document_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EmptyInputAndEmptyOutputInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EmptyInputAndEmptyOutputOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EndpointOperationInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EndpointOperationOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :label
    # @!attribute label
    #   @return [String]
    class EndpointWithHostLabelOperationInput
      include Hearth::Structure

      MEMBERS = %i[
        label
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EndpointWithHostLabelOperationOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :phrase
    # @!attribute phrase
    #   @return [String]
    class Farewell
      include Hearth::Structure

      MEMBERS = %i[
        phrase
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          phrase: "bye"
        }
      end
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HostWithPathOperationInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HostWithPathOperationOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    # @!attribute foo
    #   @return [String]
    class HttpChecksumRequiredInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    # @!attribute foo
    #   @return [String]
    class HttpChecksumRequiredOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   Enum, one of: ["enumvalue"]
    #   @return [String]
    class HttpEnumPayloadInput
      include Hearth::Structure

      MEMBERS = %i[
        payload
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   Enum, one of: ["enumvalue"]
    #   @return [String]
    class HttpEnumPayloadOutput
      include Hearth::Structure

      MEMBERS = %i[
        payload
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class HttpPayloadTraitsInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class HttpPayloadTraitsOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class HttpPayloadTraitsWithMediaTypeInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class HttpPayloadTraitsWithMediaTypeOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [NestedPayload] :nested
    # @!attribute nested
    #   @return [NestedPayload]
    class HttpPayloadWithStructureInput
      include Hearth::Structure

      MEMBERS = %i[
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [NestedPayload] :nested
    # @!attribute nested
    #   @return [NestedPayload]
    class HttpPayloadWithStructureOutput
      include Hearth::Structure

      MEMBERS = %i[
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionPayload] :nested
    # @!attribute nested
    #   @return [UnionPayload]
    class HttpPayloadWithUnionInput
      include Hearth::Structure

      MEMBERS = %i[
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionPayload] :nested
    # @!attribute nested
    #   @return [UnionPayload]
    class HttpPayloadWithUnionOutput
      include Hearth::Structure

      MEMBERS = %i[
        nested
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpPrefixHeadersInResponseInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<Symbol, String>] :prefix_headers
    # @!attribute prefix_headers
    #   @return [Hash<Symbol, String>]
    class HttpPrefixHeadersInResponseOutput
      include Hearth::Structure

      MEMBERS = %i[
        prefix_headers
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [Hash<Symbol, String>] :foo_map
    # @!attribute foo
    #   @return [String]
    # @!attribute foo_map
    #   @return [Hash<Symbol, String>]
    class HttpPrefixHeadersInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        foo_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [Hash<Symbol, String>] :foo_map
    # @!attribute foo
    #   @return [String]
    # @!attribute foo_map
    #   @return [Hash<Symbol, String>]
    class HttpPrefixHeadersOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        foo_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Float] :float
    #   @option params [Float] :double
    # @!attribute float
    #   @return [Float]
    # @!attribute double
    #   @return [Float]
    class HttpRequestWithFloatLabelsInput
      include Hearth::Structure

      MEMBERS = %i[
        float
        double
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpRequestWithFloatLabelsOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :baz
    # @!attribute foo
    #   @return [String]
    # @!attribute baz
    #   @return [String]
    class HttpRequestWithGreedyLabelInPathInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        baz
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpRequestWithGreedyLabelInPathOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Time] :member_epoch_seconds
    #   @option params [Time] :member_http_date
    #   @option params [Time] :member_date_time
    #   @option params [Time] :default_format
    #   @option params [Time] :target_epoch_seconds
    #   @option params [Time] :target_http_date
    #   @option params [Time] :target_date_time
    # @!attribute member_epoch_seconds
    #   @return [Time]
    # @!attribute member_http_date
    #   @return [Time]
    # @!attribute member_date_time
    #   @return [Time]
    # @!attribute default_format
    #   @return [Time]
    # @!attribute target_epoch_seconds
    #   @return [Time]
    # @!attribute target_http_date
    #   @return [Time]
    # @!attribute target_date_time
    #   @return [Time]
    class HttpRequestWithLabelsAndTimestampFormatInput
      include Hearth::Structure

      MEMBERS = %i[
        member_epoch_seconds
        member_http_date
        member_date_time
        default_format
        target_epoch_seconds
        target_http_date
        target_date_time
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpRequestWithLabelsAndTimestampFormatOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string
    #   @option params [Integer] :short
    #   @option params [Integer] :integer
    #   @option params [Integer] :long
    #   @option params [Float] :float
    #   @option params [Float] :double
    #   @option params [Boolean] :boolean
    #   @option params [Time] :timestamp
    # @!attribute string
    #   @return [String]
    # @!attribute short
    #   @return [Integer]
    # @!attribute integer
    #   @return [Integer]
    # @!attribute long
    #   @return [Integer]
    # @!attribute float
    #   @return [Float]
    # @!attribute double
    #   @return [Float]
    # @!attribute boolean
    #   Serialized in the path as true or false.
    #   @return [Boolean]
    # @!attribute timestamp
    #   Note that this member has no format, so it's serialized as an RFC 3399 date-time.
    #   @return [Time]
    class HttpRequestWithLabelsInput
      include Hearth::Structure

      MEMBERS = %i[
        string
        short
        integer
        long
        float
        double
        boolean
        timestamp
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpRequestWithLabelsOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :str
    # @!attribute str
    #   @return [String]
    class HttpRequestWithRegexLiteralInput
      include Hearth::Structure

      MEMBERS = %i[
        str
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpRequestWithRegexLiteralOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpResponseCodeInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :status
    # @!attribute status
    #   @return [Integer]
    class HttpResponseCodeOutput
      include Hearth::Structure

      MEMBERS = %i[
        status
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   @return [String]
    class HttpStringPayloadInput
      include Hearth::Structure

      MEMBERS = %i[
        payload
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   @return [String]
    class HttpStringPayloadOutput
      include Hearth::Structure

      MEMBERS = %i[
        payload
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class IgnoreQueryParamsInResponseInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :baz
    # @!attribute baz
    #   @return [String]
    class IgnoreQueryParamsInResponseOutput
      include Hearth::Structure

      MEMBERS = %i[
        baz
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :header_string
    #   @option params [Integer] :header_byte
    #   @option params [Integer] :header_short
    #   @option params [Integer] :header_integer
    #   @option params [Integer] :header_long
    #   @option params [Float] :header_float
    #   @option params [Float] :header_double
    #   @option params [Boolean] :header_true_bool
    #   @option params [Boolean] :header_false_bool
    #   @option params [Array<String>] :header_string_list
    #   @option params [Array<String>] :header_string_set
    #   @option params [Array<Integer>] :header_integer_list
    #   @option params [Array<Boolean>] :header_boolean_list
    #   @option params [Array<Time>] :header_timestamp_list
    #   @option params [String] :header_enum
    #   @option params [Array<String>] :header_enum_list
    #   @option params [Integer] :header_integer_enum
    #   @option params [Array<Integer>] :header_integer_enum_list
    # @!attribute header_string
    #   @return [String]
    # @!attribute header_byte
    #   @return [Integer]
    # @!attribute header_short
    #   @return [Integer]
    # @!attribute header_integer
    #   @return [Integer]
    # @!attribute header_long
    #   @return [Integer]
    # @!attribute header_float
    #   @return [Float]
    # @!attribute header_double
    #   @return [Float]
    # @!attribute header_true_bool
    #   @return [Boolean]
    # @!attribute header_false_bool
    #   @return [Boolean]
    # @!attribute header_string_list
    #   @return [Array<String>]
    # @!attribute header_string_set
    #   @return [Array<String>]
    # @!attribute header_integer_list
    #   @return [Array<Integer>]
    # @!attribute header_boolean_list
    #   @return [Array<Boolean>]
    # @!attribute header_timestamp_list
    #   @return [Array<Time>]
    # @!attribute header_enum
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute header_enum_list
    #   @return [Array<String>]
    # @!attribute header_integer_enum
    #   @return [Integer]
    # @!attribute header_integer_enum_list
    #   @return [Array<Integer>]
    class InputAndOutputWithHeadersInput
      include Hearth::Structure

      MEMBERS = %i[
        header_string
        header_byte
        header_short
        header_integer
        header_long
        header_float
        header_double
        header_true_bool
        header_false_bool
        header_string_list
        header_string_set
        header_integer_list
        header_boolean_list
        header_timestamp_list
        header_enum
        header_enum_list
        header_integer_enum
        header_integer_enum_list
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :header_string
    #   @option params [Integer] :header_byte
    #   @option params [Integer] :header_short
    #   @option params [Integer] :header_integer
    #   @option params [Integer] :header_long
    #   @option params [Float] :header_float
    #   @option params [Float] :header_double
    #   @option params [Boolean] :header_true_bool
    #   @option params [Boolean] :header_false_bool
    #   @option params [Array<String>] :header_string_list
    #   @option params [Array<String>] :header_string_set
    #   @option params [Array<Integer>] :header_integer_list
    #   @option params [Array<Boolean>] :header_boolean_list
    #   @option params [Array<Time>] :header_timestamp_list
    #   @option params [String] :header_enum
    #   @option params [Array<String>] :header_enum_list
    #   @option params [Integer] :header_integer_enum
    #   @option params [Array<Integer>] :header_integer_enum_list
    # @!attribute header_string
    #   @return [String]
    # @!attribute header_byte
    #   @return [Integer]
    # @!attribute header_short
    #   @return [Integer]
    # @!attribute header_integer
    #   @return [Integer]
    # @!attribute header_long
    #   @return [Integer]
    # @!attribute header_float
    #   @return [Float]
    # @!attribute header_double
    #   @return [Float]
    # @!attribute header_true_bool
    #   @return [Boolean]
    # @!attribute header_false_bool
    #   @return [Boolean]
    # @!attribute header_string_list
    #   @return [Array<String>]
    # @!attribute header_string_set
    #   @return [Array<String>]
    # @!attribute header_integer_list
    #   @return [Array<Integer>]
    # @!attribute header_boolean_list
    #   @return [Array<Boolean>]
    # @!attribute header_timestamp_list
    #   @return [Array<Time>]
    # @!attribute header_enum
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute header_enum_list
    #   @return [Array<String>]
    # @!attribute header_integer_enum
    #   @return [Integer]
    # @!attribute header_integer_enum_list
    #   @return [Array<Integer>]
    class InputAndOutputWithHeadersOutput
      include Hearth::Structure

      MEMBERS = %i[
        header_string
        header_byte
        header_short
        header_integer
        header_long
        header_float
        header_double
        header_true_bool
        header_false_bool
        header_string_list
        header_string_set
        header_integer_list
        header_boolean_list
        header_timestamp_list
        header_enum
        header_enum_list
        header_integer_enum
        header_integer_enum_list
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
    #   @option params [String] :data
    # @!attribute data
    #   @return [String]
    class JsonBlobsInput
      include Hearth::Structure

      MEMBERS = %i[
        data
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :data
    # @!attribute data
    #   @return [String]
    class JsonBlobsOutput
      include Hearth::Structure

      MEMBERS = %i[
        data
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo_enum1
    #   @option params [String] :foo_enum2
    #   @option params [String] :foo_enum3
    #   @option params [Array<String>] :foo_enum_list
    #   @option params [Array<String>] :foo_enum_set
    #   @option params [Hash<Symbol, String>] :foo_enum_map
    # @!attribute foo_enum1
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute foo_enum2
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute foo_enum3
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute foo_enum_list
    #   @return [Array<String>]
    # @!attribute foo_enum_set
    #   @return [Array<String>]
    # @!attribute foo_enum_map
    #   @return [Hash<Symbol, String>]
    class JsonEnumsInput
      include Hearth::Structure

      MEMBERS = %i[
        foo_enum1
        foo_enum2
        foo_enum3
        foo_enum_list
        foo_enum_set
        foo_enum_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo_enum1
    #   @option params [String] :foo_enum2
    #   @option params [String] :foo_enum3
    #   @option params [Array<String>] :foo_enum_list
    #   @option params [Array<String>] :foo_enum_set
    #   @option params [Hash<Symbol, String>] :foo_enum_map
    # @!attribute foo_enum1
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute foo_enum2
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute foo_enum3
    #   Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
    #   @return [String]
    # @!attribute foo_enum_list
    #   @return [Array<String>]
    # @!attribute foo_enum_set
    #   @return [Array<String>]
    # @!attribute foo_enum_map
    #   @return [Hash<Symbol, String>]
    class JsonEnumsOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo_enum1
        foo_enum2
        foo_enum3
        foo_enum_list
        foo_enum_set
        foo_enum_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :integer_enum1
    #   @option params [Integer] :integer_enum2
    #   @option params [Integer] :integer_enum3
    #   @option params [Array<Integer>] :integer_enum_list
    #   @option params [Array<Integer>] :integer_enum_set
    #   @option params [Hash<Symbol, Integer>] :integer_enum_map
    # @!attribute integer_enum1
    #   @return [Integer]
    # @!attribute integer_enum2
    #   @return [Integer]
    # @!attribute integer_enum3
    #   @return [Integer]
    # @!attribute integer_enum_list
    #   @return [Array<Integer>]
    # @!attribute integer_enum_set
    #   @return [Array<Integer>]
    # @!attribute integer_enum_map
    #   @return [Hash<Symbol, Integer>]
    class JsonIntEnumsInput
      include Hearth::Structure

      MEMBERS = %i[
        integer_enum1
        integer_enum2
        integer_enum3
        integer_enum_list
        integer_enum_set
        integer_enum_map
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :integer_enum1
    #   @option params [Integer] :integer_enum2
    #   @option params [Integer] :integer_enum3
    #   @option params [Array<Integer>] :integer_enum_list
    #   @option params [Array<Integer>] :integer_enum_set
    #   @option params [Hash<Symbol, Integer>] :integer_enum_map
    # @!attribute integer_enum1
    #   @return [Integer]
    # @!attribute integer_enum2
    #   @return [Integer]
    # @!attribute integer_enum3
    #   @return [Integer]
    # @!attribute integer_enum_list
    #   @return [Array<Integer>]
    # @!attribute integer_enum_set
    #   @return [Array<Integer>]
    # @!attribute integer_enum_map
    #   @return [Hash<Symbol, Integer>]
    class JsonIntEnumsOutput
      include Hearth::Structure

      MEMBERS = %i[
        integer_enum1
        integer_enum2
        integer_enum3
        integer_enum_list
        integer_enum_set
        integer_enum_map
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
    class JsonListsInput
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
    class JsonListsOutput
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
    class JsonMapsInput
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
    class JsonMapsOutput
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
    #   @option params [Time] :normal
    #   @option params [Time] :date_time
    #   @option params [Time] :date_time_on_target
    #   @option params [Time] :epoch_seconds
    #   @option params [Time] :epoch_seconds_on_target
    #   @option params [Time] :http_date
    #   @option params [Time] :http_date_on_target
    # @!attribute normal
    #   @return [Time]
    # @!attribute date_time
    #   @return [Time]
    # @!attribute date_time_on_target
    #   @return [Time]
    # @!attribute epoch_seconds
    #   @return [Time]
    # @!attribute epoch_seconds_on_target
    #   @return [Time]
    # @!attribute http_date
    #   @return [Time]
    # @!attribute http_date_on_target
    #   @return [Time]
    class JsonTimestampsInput
      include Hearth::Structure

      MEMBERS = %i[
        normal
        date_time
        date_time_on_target
        epoch_seconds
        epoch_seconds_on_target
        http_date
        http_date_on_target
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Time] :normal
    #   @option params [Time] :date_time
    #   @option params [Time] :date_time_on_target
    #   @option params [Time] :epoch_seconds
    #   @option params [Time] :epoch_seconds_on_target
    #   @option params [Time] :http_date
    #   @option params [Time] :http_date_on_target
    # @!attribute normal
    #   @return [Time]
    # @!attribute date_time
    #   @return [Time]
    # @!attribute date_time_on_target
    #   @return [Time]
    # @!attribute epoch_seconds
    #   @return [Time]
    # @!attribute epoch_seconds_on_target
    #   @return [Time]
    # @!attribute http_date
    #   @return [Time]
    # @!attribute http_date_on_target
    #   @return [Time]
    class JsonTimestampsOutput
      include Hearth::Structure

      MEMBERS = %i[
        normal
        date_time
        date_time_on_target
        epoch_seconds
        epoch_seconds_on_target
        http_date
        http_date_on_target
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # A shared structure that contains a single union member.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [MyUnion] :contents
    # @!attribute contents
    #   A union with a representative set of types for members.
    #   @return [MyUnion]
    class JsonUnionsInput
      include Hearth::Structure

      MEMBERS = %i[
        contents
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # A shared structure that contains a single union member.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [MyUnion] :contents
    # @!attribute contents
    #   A union with a representative set of types for members.
    #   @return [MyUnion]
    class JsonUnionsOutput
      include Hearth::Structure

      MEMBERS = %i[
        contents
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :json
    # @!attribute json
    #   @return [String]
    class MediaTypeHeaderInput
      include Hearth::Structure

      MEMBERS = %i[
        json
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :json
    # @!attribute json
    #   @return [String]
    class MediaTypeHeaderOutput
      include Hearth::Structure

      MEMBERS = %i[
        json
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # A union with a representative set of types for members.
    class MyUnion < Hearth::Union
      class StringValue < MyUnion
        def to_h
          { string_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::StringValue #{__getobj__ || 'nil'}>"
        end
      end

      class BooleanValue < MyUnion
        def to_h
          { boolean_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::BooleanValue #{__getobj__ || 'nil'}>"
        end
      end

      class NumberValue < MyUnion
        def to_h
          { number_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::NumberValue #{__getobj__ || 'nil'}>"
        end
      end

      class BlobValue < MyUnion
        def to_h
          { blob_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::BlobValue #{__getobj__ || 'nil'}>"
        end
      end

      class TimestampValue < MyUnion
        def to_h
          { timestamp_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::TimestampValue #{__getobj__ || 'nil'}>"
        end
      end

      # Enum, one of: ["Foo", "Baz", "Bar", "1", "0"]
      class EnumValue < MyUnion
        def to_h
          { enum_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::EnumValue #{__getobj__ || 'nil'}>"
        end
      end

      class ListValue < MyUnion
        def to_h
          { list_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::ListValue #{__getobj__ || 'nil'}>"
        end
      end

      class MapValue < MyUnion
        def to_h
          { map_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::MapValue #{__getobj__ || 'nil'}>"
        end
      end

      class StructureValue < MyUnion
        def to_h
          { structure_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::StructureValue #{__getobj__ || 'nil'}>"
        end
      end

      class RenamedStructureValue < MyUnion
        def to_h
          { renamed_structure_value: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::RenamedStructureValue #{__getobj__ || 'nil'}>"
        end
      end

      class Unknown < MyUnion
        def initialize(name:, value:)
          super({name: name, value: value})
        end

        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :greeting
    #   @option params [String] :name
    # @!attribute greeting
    #   @return [String]
    # @!attribute name
    #   @return [String]
    class NestedPayload
      include Hearth::Structure

      MEMBERS = %i[
        greeting
        name
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoInputAndNoOutputInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoInputAndNoOutputOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoInputAndOutputInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoInputAndOutputOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :a
    #   @option params [String] :b
    #   @option params [Array<String>] :c
    # @!attribute a
    #   @return [String]
    # @!attribute b
    #   @return [String]
    # @!attribute c
    #   @return [Array<String>]
    class NullAndEmptyHeadersClientInput
      include Hearth::Structure

      MEMBERS = %i[
        a
        b
        c
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :a
    #   @option params [String] :b
    #   @option params [Array<String>] :c
    # @!attribute a
    #   @return [String]
    # @!attribute b
    #   @return [String]
    # @!attribute c
    #   @return [Array<String>]
    class NullAndEmptyHeadersClientOutput
      include Hearth::Structure

      MEMBERS = %i[
        a
        b
        c
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :a
    #   @option params [String] :b
    #   @option params [Array<String>] :c
    # @!attribute a
    #   @return [String]
    # @!attribute b
    #   @return [String]
    # @!attribute c
    #   @return [Array<String>]
    class NullAndEmptyHeadersServerInput
      include Hearth::Structure

      MEMBERS = %i[
        a
        b
        c
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :a
    #   @option params [String] :b
    #   @option params [Array<String>] :c
    # @!attribute a
    #   @return [String]
    # @!attribute b
    #   @return [String]
    # @!attribute c
    #   @return [Array<String>]
    class NullAndEmptyHeadersServerOutput
      include Hearth::Structure

      MEMBERS = %i[
        a
        b
        c
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :null_value
    #   @option params [String] :empty_string
    # @!attribute null_value
    #   @return [String]
    # @!attribute empty_string
    #   @return [String]
    class OmitsNullSerializesEmptyStringInput
      include Hearth::Structure

      MEMBERS = %i[
        null_value
        empty_string
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class OmitsNullSerializesEmptyStringOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :query_string_list
    #   @option params [Array<Integer>] :query_integer_list
    #   @option params [Array<Float>] :query_double_list
    #   @option params [Array<Boolean>] :query_boolean_list
    #   @option params [Array<Time>] :query_timestamp_list
    #   @option params [Array<String>] :query_enum_list
    #   @option params [Array<Integer>] :query_integer_enum_list
    # @!attribute query_string_list
    #   @return [Array<String>]
    # @!attribute query_integer_list
    #   @return [Array<Integer>]
    # @!attribute query_double_list
    #   @return [Array<Float>]
    # @!attribute query_boolean_list
    #   @return [Array<Boolean>]
    # @!attribute query_timestamp_list
    #   @return [Array<Time>]
    # @!attribute query_enum_list
    #   @return [Array<String>]
    # @!attribute query_integer_enum_list
    #   @return [Array<Integer>]
    class OmitsSerializingEmptyListsInput
      include Hearth::Structure

      MEMBERS = %i[
        query_string_list
        query_integer_list
        query_double_list
        query_boolean_list
        query_timestamp_list
        query_enum_list
        query_integer_enum_list
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class OmitsSerializingEmptyListsOutput
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
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_map
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_string
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_boolean
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_document_list
    #   @option params [Hash, Array, String, Boolean, Numeric] :default_null_document
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
    # @!attribute default_document_map
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_document_string
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_document_boolean
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_document_list
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute default_null_document
    #   @return [Hash, Array, String, Boolean, Numeric]
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
        default_document_map
        default_document_string
        default_document_boolean
        default_document_list
        default_null_document
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
          default_document_map: {},
          default_document_string: "hi",
          default_document_boolean: true,
          default_document_list: [],
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
    #   @option params [TopLevel] :top_level
    # @!attribute top_level
    #   @return [TopLevel]
    class OperationWithNestedStructureInput
      include Hearth::Structure

      MEMBERS = %i[
        top_level
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Dialog] :dialog
    #   @option params [Array<Dialog>] :dialog_list
    #   @option params [Hash<Symbol, Dialog>] :dialog_map
    # @!attribute dialog
    #   @return [Dialog]
    # @!attribute dialog_list
    #   @return [Array<Dialog>]
    # @!attribute dialog_map
    #   @return [Hash<Symbol, Dialog>]
    class OperationWithNestedStructureOutput
      include Hearth::Structure

      MEMBERS = %i[
        dialog
        dialog_list
        dialog_map
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          dialog_list: [],
          dialog_map: {}
        }
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :data
    # @!attribute data
    #   @return [Integer]
    class PayloadConfig
      include Hearth::Structure

      MEMBERS = %i[
        data
      ].freeze

      attr_accessor(*MEMBERS)
    end

    class PlayerAction < Hearth::Union
      # Quit the game.
      class Quit < PlayerAction
        def to_h
          { quit: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Quit #{__getobj__ || 'nil'}>"
        end
      end

      class Unknown < PlayerAction
        def initialize(name:, value:)
          super({name: name, value: value})
        end

        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [PlayerAction] :action
    # @!attribute action
    #   @return [PlayerAction]
    class PostPlayerActionInput
      include Hearth::Structure

      MEMBERS = %i[
        action
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [PlayerAction] :action
    # @!attribute action
    #   @return [PlayerAction]
    class PostPlayerActionOutput
      include Hearth::Structure

      MEMBERS = %i[
        action
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionWithJsonName] :value
    # @!attribute value
    #   @return [UnionWithJsonName]
    class PostUnionWithJsonNameInput
      include Hearth::Structure

      MEMBERS = %i[
        value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionWithJsonName] :value
    # @!attribute value
    #   @return [UnionWithJsonName]
    class PostUnionWithJsonNameOutput
      include Hearth::Structure

      MEMBERS = %i[
        value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :encoding
    #   @option params [String] :data
    # @!attribute encoding
    #   @return [String]
    # @!attribute data
    #   @return [String]
    class PutWithContentEncodingInput
      include Hearth::Structure

      MEMBERS = %i[
        encoding
        data
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class PutWithContentEncodingOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :token
    # @!attribute token
    #   @return [String]
    class QueryIdempotencyTokenAutoFillInput
      include Hearth::Structure

      MEMBERS = %i[
        token
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class QueryIdempotencyTokenAutoFillOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :qux
    #   @option params [Hash<Symbol, Array<String>>] :foo
    # @!attribute qux
    #   @return [String]
    # @!attribute foo
    #   @return [Hash<Symbol, Array<String>>]
    class QueryParamsAsStringListMapInput
      include Hearth::Structure

      MEMBERS = %i[
        qux
        foo
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class QueryParamsAsStringListMapOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [Hash<Symbol, String>] :baz
    # @!attribute foo
    #   @return [String]
    # @!attribute baz
    #   @return [Hash<Symbol, String>]
    class QueryPrecedenceInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        baz
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class QueryPrecedenceOutput
      include Hearth::Structure

      MEMBERS = []

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
    #   @option params [String] :salutation
    # @!attribute salutation
    #   @return [String]
    class RenamedGreeting
      include Hearth::Structure

      MEMBERS = %i[
        salutation
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :string_value
    #   @option params [Boolean] :true_boolean_value
    #   @option params [Boolean] :false_boolean_value
    #   @option params [Integer] :byte_value
    #   @option params [Integer] :short_value
    #   @option params [Integer] :integer_value
    #   @option params [Integer] :long_value
    #   @option params [Float] :float_value
    #   @option params [Float] :double_value
    # @!attribute foo
    #   @return [String]
    # @!attribute string_value
    #   @return [String]
    # @!attribute true_boolean_value
    #   @return [Boolean]
    # @!attribute false_boolean_value
    #   @return [Boolean]
    # @!attribute byte_value
    #   @return [Integer]
    # @!attribute short_value
    #   @return [Integer]
    # @!attribute integer_value
    #   @return [Integer]
    # @!attribute long_value
    #   @return [Integer]
    # @!attribute float_value
    #   @return [Float]
    # @!attribute double_value
    #   @return [Float]
    class SimpleScalarPropertiesInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        string_value
        true_boolean_value
        false_boolean_value
        byte_value
        short_value
        integer_value
        long_value
        float_value
        double_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :string_value
    #   @option params [Boolean] :true_boolean_value
    #   @option params [Boolean] :false_boolean_value
    #   @option params [Integer] :byte_value
    #   @option params [Integer] :short_value
    #   @option params [Integer] :integer_value
    #   @option params [Integer] :long_value
    #   @option params [Float] :float_value
    #   @option params [Float] :double_value
    # @!attribute foo
    #   @return [String]
    # @!attribute string_value
    #   @return [String]
    # @!attribute true_boolean_value
    #   @return [Boolean]
    # @!attribute false_boolean_value
    #   @return [Boolean]
    # @!attribute byte_value
    #   @return [Integer]
    # @!attribute short_value
    #   @return [Integer]
    # @!attribute integer_value
    #   @return [Integer]
    # @!attribute long_value
    #   @return [Integer]
    # @!attribute float_value
    #   @return [Float]
    # @!attribute double_value
    #   @return [Float]
    class SimpleScalarPropertiesOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        string_value
        true_boolean_value
        false_boolean_value
        byte_value
        short_value
        integer_value
        long_value
        float_value
        double_value
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    class SparseJsonListsInput
      include Hearth::Structure

      MEMBERS = %i[
        sparse_string_list
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    class SparseJsonListsOutput
      include Hearth::Structure

      MEMBERS = %i[
        sparse_string_list
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
    class SparseJsonMapsInput
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
    class SparseJsonMapsOutput
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
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class StreamingTraitsInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class StreamingTraitsOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          blob: ""
        }
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class StreamingTraitsRequireLengthInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class StreamingTraitsRequireLengthOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class StreamingTraitsWithMediaTypeInput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    class StreamingTraitsWithMediaTypeOutput
      include Hearth::Structure

      MEMBERS = %i[
        foo
        blob
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          blob: ""
        }
      end
    end

    # Enum constants for StringEnum
    module StringEnum
      V = "enumvalue"
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [TestConfig] :test_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute test_config
    #   @return [TestConfig]
    class TestBodyStructureInput
      include Hearth::Structure

      MEMBERS = %i[
        test_id
        test_config
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [TestConfig] :test_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute test_config
    #   @return [TestConfig]
    class TestBodyStructureOutput
      include Hearth::Structure

      MEMBERS = %i[
        test_id
        test_config
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :timeout
    # @!attribute timeout
    #   @return [Integer]
    class TestConfig
      include Hearth::Structure

      MEMBERS = %i[
        timeout
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    # @!attribute test_id
    #   @return [String]
    class TestNoPayloadInput
      include Hearth::Structure

      MEMBERS = %i[
        test_id
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    # @!attribute test_id
    #   @return [String]
    class TestNoPayloadOutput
      include Hearth::Structure

      MEMBERS = %i[
        test_id
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :content_type
    #   @option params [String] :data
    # @!attribute content_type
    #   @return [String]
    # @!attribute data
    #   @return [String]
    class TestPayloadBlobInput
      include Hearth::Structure

      MEMBERS = %i[
        content_type
        data
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :content_type
    #   @option params [String] :data
    # @!attribute content_type
    #   @return [String]
    # @!attribute data
    #   @return [String]
    class TestPayloadBlobOutput
      include Hearth::Structure

      MEMBERS = %i[
        content_type
        data
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [PayloadConfig] :payload_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute payload_config
    #   @return [PayloadConfig]
    class TestPayloadStructureInput
      include Hearth::Structure

      MEMBERS = %i[
        test_id
        payload_config
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [PayloadConfig] :payload_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute payload_config
    #   @return [PayloadConfig]
    class TestPayloadStructureOutput
      include Hearth::Structure

      MEMBERS = %i[
        test_id
        payload_config
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Time] :member_epoch_seconds
    #   @option params [Time] :member_http_date
    #   @option params [Time] :member_date_time
    #   @option params [Time] :default_format
    #   @option params [Time] :target_epoch_seconds
    #   @option params [Time] :target_http_date
    #   @option params [Time] :target_date_time
    # @!attribute member_epoch_seconds
    #   @return [Time]
    # @!attribute member_http_date
    #   @return [Time]
    # @!attribute member_date_time
    #   @return [Time]
    # @!attribute default_format
    #   @return [Time]
    # @!attribute target_epoch_seconds
    #   @return [Time]
    # @!attribute target_http_date
    #   @return [Time]
    # @!attribute target_date_time
    #   @return [Time]
    class TimestampFormatHeadersInput
      include Hearth::Structure

      MEMBERS = %i[
        member_epoch_seconds
        member_http_date
        member_date_time
        default_format
        target_epoch_seconds
        target_http_date
        target_date_time
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Time] :member_epoch_seconds
    #   @option params [Time] :member_http_date
    #   @option params [Time] :member_date_time
    #   @option params [Time] :default_format
    #   @option params [Time] :target_epoch_seconds
    #   @option params [Time] :target_http_date
    #   @option params [Time] :target_date_time
    # @!attribute member_epoch_seconds
    #   @return [Time]
    # @!attribute member_http_date
    #   @return [Time]
    # @!attribute member_date_time
    #   @return [Time]
    # @!attribute default_format
    #   @return [Time]
    # @!attribute target_epoch_seconds
    #   @return [Time]
    # @!attribute target_http_date
    #   @return [Time]
    # @!attribute target_date_time
    #   @return [Time]
    class TimestampFormatHeadersOutput
      include Hearth::Structure

      MEMBERS = %i[
        member_epoch_seconds
        member_http_date
        member_date_time
        default_format
        target_epoch_seconds
        target_http_date
        target_date_time
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Dialog] :dialog
    #   @option params [Array<Dialog>] :dialog_list
    #   @option params [Hash<Symbol, Dialog>] :dialog_map
    # @!attribute dialog
    #   @return [Dialog]
    # @!attribute dialog_list
    #   @return [Array<Dialog>]
    # @!attribute dialog_map
    #   @return [Hash<Symbol, Dialog>]
    class TopLevel
      include Hearth::Structure

      MEMBERS = %i[
        dialog
        dialog_list
        dialog_map
      ].freeze

      attr_accessor(*MEMBERS)

      private

      def _defaults
        {
          dialog_list: [],
          dialog_map: {}
        }
      end
    end

    class UnionPayload < Hearth::Union
      class Greeting < UnionPayload
        def to_h
          { greeting: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Greeting #{__getobj__ || 'nil'}>"
        end
      end

      class Unknown < UnionPayload
        def initialize(name:, value:)
          super({name: name, value: value})
        end

        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    class UnionWithJsonName < Hearth::Union
      class Foo < UnionWithJsonName
        def to_h
          { foo: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Foo #{__getobj__ || 'nil'}>"
        end
      end

      class Bar < UnionWithJsonName
        def to_h
          { bar: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Bar #{__getobj__ || 'nil'}>"
        end
      end

      class Baz < UnionWithJsonName
        def to_h
          { baz: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Baz #{__getobj__ || 'nil'}>"
        end
      end

      class Unknown < UnionWithJsonName
        def initialize(name:, value:)
          super({name: name, value: value})
        end

        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class Unit
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class UnitInputAndOutputInput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class UnitInputAndOutputOutput
      include Hearth::Structure

      MEMBERS = []

      attr_accessor(*MEMBERS)
    end

  end
end
