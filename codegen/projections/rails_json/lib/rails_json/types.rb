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
    #   @option params [Hash<String, Array<String>>] :query_params_map_of_string_list
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
    #   @return [String]
    # @!attribute query_enum_list
    #   @return [Array<String>]
    # @!attribute query_integer_enum
    #   @return [Integer]
    # @!attribute query_integer_enum_list
    #   @return [Array<Integer>]
    # @!attribute query_params_map_of_string_list
    #   @return [Hash<String, Array<String>>]
    AllQueryStringTypesInput = ::Struct.new(
      :query_string,
      :query_string_list,
      :query_string_set,
      :query_byte,
      :query_short,
      :query_integer,
      :query_integer_list,
      :query_integer_set,
      :query_long,
      :query_float,
      :query_double,
      :query_double_list,
      :query_boolean,
      :query_boolean_list,
      :query_timestamp,
      :query_timestamp_list,
      :query_enum,
      :query_enum_list,
      :query_integer_enum,
      :query_integer_enum_list,
      :query_params_map_of_string_list,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    AllQueryStringTypesOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    ComplexError = ::Struct.new(
      :header,
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
    #   @option params [String] :baz
    #   @option params [String] :maybe_set
    # @!attribute baz
    #   @return [String]
    # @!attribute maybe_set
    #   @return [String]
    ConstantAndVariableQueryStringInput = ::Struct.new(
      :baz,
      :maybe_set,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    ConstantAndVariableQueryStringOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :hello
    # @!attribute hello
    #   @return [String]
    ConstantQueryStringInput = ::Struct.new(
      :hello,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    ConstantQueryStringOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    DatetimeOffsetsInput = ::Struct.new(
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
    DatetimeOffsetsOutput = ::Struct.new(
      :datetime,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, Hash, Array, String, Boolean, Numeric>] :doc_valued_map
    # @!attribute doc_valued_map
    #   @return [Hash<String, Hash, Array, String, Boolean, Numeric>]
    DocumentTypeAsMapValueInput = ::Struct.new(
      :doc_valued_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, Hash, Array, String, Boolean, Numeric>] :doc_valued_map
    # @!attribute doc_valued_map
    #   @return [Hash<String, Hash, Array, String, Boolean, Numeric>]
    DocumentTypeAsMapValueOutput = ::Struct.new(
      :doc_valued_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    DocumentTypeAsPayloadInput = ::Struct.new(
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    DocumentTypeAsPayloadOutput = ::Struct.new(
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string_value
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute string_value
    #   @return [String]
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    DocumentTypeInput = ::Struct.new(
      :string_value,
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string_value
    #   @option params [Hash, Array, String, Boolean, Numeric] :document_value
    # @!attribute string_value
    #   @return [String]
    # @!attribute document_value
    #   @return [Hash, Array, String, Boolean, Numeric]
    DocumentTypeOutput = ::Struct.new(
      :string_value,
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EmptyInputAndEmptyOutputInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EmptyInputAndEmptyOutputOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EndpointOperationInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EndpointOperationOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :label
    # @!attribute label
    #   @return [String]
    EndpointWithHostLabelOperationInput = ::Struct.new(
      :label,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EndpointWithHostLabelOperationOutput = ::Struct.new(
      nil,
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    HostWithPathOperationInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HostWithPathOperationOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    # @!attribute foo
    #   @return [String]
    HttpChecksumRequiredInput = ::Struct.new(
      :foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    # @!attribute foo
    #   @return [String]
    HttpChecksumRequiredOutput = ::Struct.new(
      :foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   @return [String]
    HttpEnumPayloadInput = ::Struct.new(
      :payload,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   @return [String]
    HttpEnumPayloadOutput = ::Struct.new(
      :payload,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    HttpPayloadTraitsInput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    HttpPayloadTraitsOutput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    HttpPayloadTraitsWithMediaTypeInput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    HttpPayloadTraitsWithMediaTypeOutput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [NestedPayload] :nested
    # @!attribute nested
    #   @return [NestedPayload]
    HttpPayloadWithStructureInput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [NestedPayload] :nested
    # @!attribute nested
    #   @return [NestedPayload]
    HttpPayloadWithStructureOutput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionPayload] :nested
    # @!attribute nested
    #   @return [UnionPayload]
    HttpPayloadWithUnionInput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionPayload] :nested
    # @!attribute nested
    #   @return [UnionPayload]
    HttpPayloadWithUnionOutput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpPrefixHeadersInResponseInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, String>] :prefix_headers
    # @!attribute prefix_headers
    #   @return [Hash<String, String>]
    HttpPrefixHeadersInResponseOutput = ::Struct.new(
      :prefix_headers,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [Hash<String, String>] :foo_map
    # @!attribute foo
    #   @return [String]
    # @!attribute foo_map
    #   @return [Hash<String, String>]
    HttpPrefixHeadersInput = ::Struct.new(
      :foo,
      :foo_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [Hash<String, String>] :foo_map
    # @!attribute foo
    #   @return [String]
    # @!attribute foo_map
    #   @return [Hash<String, String>]
    HttpPrefixHeadersOutput = ::Struct.new(
      :foo,
      :foo_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Float] :float
    #   @option params [Float] :double
    # @!attribute float
    #   @return [Float]
    # @!attribute double
    #   @return [Float]
    HttpRequestWithFloatLabelsInput = ::Struct.new(
      :float,
      :double,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpRequestWithFloatLabelsOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :baz
    # @!attribute foo
    #   @return [String]
    # @!attribute baz
    #   @return [String]
    HttpRequestWithGreedyLabelInPathInput = ::Struct.new(
      :foo,
      :baz,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpRequestWithGreedyLabelInPathOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    HttpRequestWithLabelsAndTimestampFormatInput = ::Struct.new(
      :member_epoch_seconds,
      :member_http_date,
      :member_date_time,
      :default_format,
      :target_epoch_seconds,
      :target_http_date,
      :target_date_time,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpRequestWithLabelsAndTimestampFormatOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    HttpRequestWithLabelsInput = ::Struct.new(
      :string,
      :short,
      :integer,
      :long,
      :float,
      :double,
      :boolean,
      :timestamp,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpRequestWithLabelsOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :str
    # @!attribute str
    #   @return [String]
    HttpRequestWithRegexLiteralInput = ::Struct.new(
      :str,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpRequestWithRegexLiteralOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpResponseCodeInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :status
    # @!attribute status
    #   @return [Integer]
    HttpResponseCodeOutput = ::Struct.new(
      :status,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   @return [String]
    HttpStringPayloadInput = ::Struct.new(
      :payload,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :payload
    # @!attribute payload
    #   @return [String]
    HttpStringPayloadOutput = ::Struct.new(
      :payload,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    IgnoreQueryParamsInResponseInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :baz
    # @!attribute baz
    #   @return [String]
    IgnoreQueryParamsInResponseOutput = ::Struct.new(
      :baz,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    #   @return [String]
    # @!attribute header_enum_list
    #   @return [Array<String>]
    # @!attribute header_integer_enum
    #   @return [Integer]
    # @!attribute header_integer_enum_list
    #   @return [Array<Integer>]
    InputAndOutputWithHeadersInput = ::Struct.new(
      :header_string,
      :header_byte,
      :header_short,
      :header_integer,
      :header_long,
      :header_float,
      :header_double,
      :header_true_bool,
      :header_false_bool,
      :header_string_list,
      :header_string_set,
      :header_integer_list,
      :header_boolean_list,
      :header_timestamp_list,
      :header_enum,
      :header_enum_list,
      :header_integer_enum,
      :header_integer_enum_list,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    #   @return [String]
    # @!attribute header_enum_list
    #   @return [Array<String>]
    # @!attribute header_integer_enum
    #   @return [Integer]
    # @!attribute header_integer_enum_list
    #   @return [Array<Integer>]
    InputAndOutputWithHeadersOutput = ::Struct.new(
      :header_string,
      :header_byte,
      :header_short,
      :header_integer,
      :header_long,
      :header_float,
      :header_double,
      :header_true_bool,
      :header_false_bool,
      :header_string_list,
      :header_string_set,
      :header_integer_list,
      :header_boolean_list,
      :header_timestamp_list,
      :header_enum,
      :header_enum_list,
      :header_integer_enum,
      :header_integer_enum_list,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Includes enum constants for IntegerEnum
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
    #   @option params [String] :data
    # @!attribute data
    #   @return [String]
    JsonBlobsInput = ::Struct.new(
      :data,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :data
    # @!attribute data
    #   @return [String]
    JsonBlobsOutput = ::Struct.new(
      :data,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo_enum1
    #   @option params [String] :foo_enum2
    #   @option params [String] :foo_enum3
    #   @option params [Array<String>] :foo_enum_list
    #   @option params [Array<String>] :foo_enum_set
    #   @option params [Hash<String, String>] :foo_enum_map
    # @!attribute foo_enum1
    #   @return [String]
    # @!attribute foo_enum2
    #   @return [String]
    # @!attribute foo_enum3
    #   @return [String]
    # @!attribute foo_enum_list
    #   @return [Array<String>]
    # @!attribute foo_enum_set
    #   @return [Array<String>]
    # @!attribute foo_enum_map
    #   @return [Hash<String, String>]
    JsonEnumsInput = ::Struct.new(
      :foo_enum1,
      :foo_enum2,
      :foo_enum3,
      :foo_enum_list,
      :foo_enum_set,
      :foo_enum_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo_enum1
    #   @option params [String] :foo_enum2
    #   @option params [String] :foo_enum3
    #   @option params [Array<String>] :foo_enum_list
    #   @option params [Array<String>] :foo_enum_set
    #   @option params [Hash<String, String>] :foo_enum_map
    # @!attribute foo_enum1
    #   @return [String]
    # @!attribute foo_enum2
    #   @return [String]
    # @!attribute foo_enum3
    #   @return [String]
    # @!attribute foo_enum_list
    #   @return [Array<String>]
    # @!attribute foo_enum_set
    #   @return [Array<String>]
    # @!attribute foo_enum_map
    #   @return [Hash<String, String>]
    JsonEnumsOutput = ::Struct.new(
      :foo_enum1,
      :foo_enum2,
      :foo_enum3,
      :foo_enum_list,
      :foo_enum_set,
      :foo_enum_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :integer_enum1
    #   @option params [Integer] :integer_enum2
    #   @option params [Integer] :integer_enum3
    #   @option params [Array<Integer>] :integer_enum_list
    #   @option params [Array<Integer>] :integer_enum_set
    #   @option params [Hash<String, Integer>] :integer_enum_map
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
    #   @return [Hash<String, Integer>]
    JsonIntEnumsInput = ::Struct.new(
      :integer_enum1,
      :integer_enum2,
      :integer_enum3,
      :integer_enum_list,
      :integer_enum_set,
      :integer_enum_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :integer_enum1
    #   @option params [Integer] :integer_enum2
    #   @option params [Integer] :integer_enum3
    #   @option params [Array<Integer>] :integer_enum_list
    #   @option params [Array<Integer>] :integer_enum_set
    #   @option params [Hash<String, Integer>] :integer_enum_map
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
    #   @return [Hash<String, Integer>]
    JsonIntEnumsOutput = ::Struct.new(
      :integer_enum1,
      :integer_enum2,
      :integer_enum3,
      :integer_enum_list,
      :integer_enum_set,
      :integer_enum_map,
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
    JsonListsInput = ::Struct.new(
      :string_list,
      :string_set,
      :integer_list,
      :boolean_list,
      :timestamp_list,
      :enum_list,
      :int_enum_list,
      :nested_string_list,
      :structure_list,
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
    JsonListsOutput = ::Struct.new(
      :string_list,
      :string_set,
      :integer_list,
      :boolean_list,
      :timestamp_list,
      :enum_list,
      :int_enum_list,
      :nested_string_list,
      :structure_list,
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
    JsonMapsInput = ::Struct.new(
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
    JsonMapsOutput = ::Struct.new(
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
    JsonTimestampsInput = ::Struct.new(
      :normal,
      :date_time,
      :date_time_on_target,
      :epoch_seconds,
      :epoch_seconds_on_target,
      :http_date,
      :http_date_on_target,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    JsonTimestampsOutput = ::Struct.new(
      :normal,
      :date_time,
      :date_time_on_target,
      :epoch_seconds,
      :epoch_seconds_on_target,
      :http_date,
      :http_date_on_target,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # A shared structure that contains a single union member.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [MyUnion] :contents
    # @!attribute contents
    #   A union with a representative set of types for members.
    #   @return [MyUnion]
    JsonUnionsInput = ::Struct.new(
      :contents,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # A shared structure that contains a single union member.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [MyUnion] :contents
    # @!attribute contents
    #   A union with a representative set of types for members.
    #   @return [MyUnion]
    JsonUnionsOutput = ::Struct.new(
      :contents,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :json
    # @!attribute json
    #   @return [String]
    MediaTypeHeaderInput = ::Struct.new(
      :json,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :json
    # @!attribute json
    #   @return [String]
    MediaTypeHeaderOutput = ::Struct.new(
      :json,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    NestedPayload = ::Struct.new(
      :greeting,
      :name,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoInputAndNoOutputInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoInputAndNoOutputOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoInputAndOutputInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoInputAndOutputOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    NullAndEmptyHeadersClientInput = ::Struct.new(
      :a,
      :b,
      :c,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    NullAndEmptyHeadersClientOutput = ::Struct.new(
      :a,
      :b,
      :c,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    NullAndEmptyHeadersServerInput = ::Struct.new(
      :a,
      :b,
      :c,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    NullAndEmptyHeadersServerOutput = ::Struct.new(
      :a,
      :b,
      :c,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :null_value
    #   @option params [String] :empty_string
    # @!attribute null_value
    #   @return [String]
    # @!attribute empty_string
    #   @return [String]
    OmitsNullSerializesEmptyStringInput = ::Struct.new(
      :null_value,
      :empty_string,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    OmitsNullSerializesEmptyStringOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    OmitsSerializingEmptyListsInput = ::Struct.new(
      :query_string_list,
      :query_integer_list,
      :query_double_list,
      :query_boolean_list,
      :query_timestamp_list,
      :query_enum_list,
      :query_integer_enum_list,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    OmitsSerializingEmptyListsOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :data
    # @!attribute data
    #   @return [Integer]
    PayloadConfig = ::Struct.new(
      :data,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    PostPlayerActionInput = ::Struct.new(
      :action,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [PlayerAction] :action
    # @!attribute action
    #   @return [PlayerAction]
    PostPlayerActionOutput = ::Struct.new(
      :action,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionWithJsonName] :value
    # @!attribute value
    #   @return [UnionWithJsonName]
    PostUnionWithJsonNameInput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [UnionWithJsonName] :value
    # @!attribute value
    #   @return [UnionWithJsonName]
    PostUnionWithJsonNameOutput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :encoding
    #   @option params [String] :data
    # @!attribute encoding
    #   @return [String]
    # @!attribute data
    #   @return [String]
    PutWithContentEncodingInput = ::Struct.new(
      :encoding,
      :data,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    PutWithContentEncodingOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :token
    # @!attribute token
    #   @return [String]
    QueryIdempotencyTokenAutoFillInput = ::Struct.new(
      :token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    QueryIdempotencyTokenAutoFillOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :qux
    #   @option params [Hash<String, Array<String>>] :foo
    # @!attribute qux
    #   @return [String]
    # @!attribute foo
    #   @return [Hash<String, Array<String>>]
    QueryParamsAsStringListMapInput = ::Struct.new(
      :qux,
      :foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    QueryParamsAsStringListMapOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [Hash<String, String>] :baz
    # @!attribute foo
    #   @return [String]
    # @!attribute baz
    #   @return [Hash<String, String>]
    QueryPrecedenceInput = ::Struct.new(
      :foo,
      :baz,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    QueryPrecedenceOutput = ::Struct.new(
      nil,
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
    #   @option params [String] :salutation
    # @!attribute salutation
    #   @return [String]
    RenamedGreeting = ::Struct.new(
      :salutation,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    SimpleScalarPropertiesInput = ::Struct.new(
      :foo,
      :string_value,
      :true_boolean_value,
      :false_boolean_value,
      :byte_value,
      :short_value,
      :integer_value,
      :long_value,
      :float_value,
      :double_value,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    SimpleScalarPropertiesOutput = ::Struct.new(
      :foo,
      :string_value,
      :true_boolean_value,
      :false_boolean_value,
      :byte_value,
      :short_value,
      :integer_value,
      :long_value,
      :float_value,
      :double_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    SparseJsonListsInput = ::Struct.new(
      :sparse_string_list,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<String>] :sparse_string_list
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    SparseJsonListsOutput = ::Struct.new(
      :sparse_string_list,
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
    SparseJsonMapsInput = ::Struct.new(
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
    SparseJsonMapsOutput = ::Struct.new(
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
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    StreamingTraitsInput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    StreamingTraitsOutput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    StreamingTraitsRequireLengthInput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    StreamingTraitsRequireLengthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    StreamingTraitsWithMediaTypeInput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :foo
    #   @option params [String] :blob
    # @!attribute foo
    #   @return [String]
    # @!attribute blob
    #   @return [String]
    StreamingTraitsWithMediaTypeOutput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    StructureListMember = ::Struct.new(
      :a,
      :b,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [TestConfig] :test_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute test_config
    #   @return [TestConfig]
    TestBodyStructureInput = ::Struct.new(
      :test_id,
      :test_config,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [TestConfig] :test_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute test_config
    #   @return [TestConfig]
    TestBodyStructureOutput = ::Struct.new(
      :test_id,
      :test_config,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Integer] :timeout
    # @!attribute timeout
    #   @return [Integer]
    TestConfig = ::Struct.new(
      :timeout,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    # @!attribute test_id
    #   @return [String]
    TestNoPayloadInput = ::Struct.new(
      :test_id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    # @!attribute test_id
    #   @return [String]
    TestNoPayloadOutput = ::Struct.new(
      :test_id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :content_type
    #   @option params [String] :data
    # @!attribute content_type
    #   @return [String]
    # @!attribute data
    #   @return [String]
    TestPayloadBlobInput = ::Struct.new(
      :content_type,
      :data,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :content_type
    #   @option params [String] :data
    # @!attribute content_type
    #   @return [String]
    # @!attribute data
    #   @return [String]
    TestPayloadBlobOutput = ::Struct.new(
      :content_type,
      :data,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [PayloadConfig] :payload_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute payload_config
    #   @return [PayloadConfig]
    TestPayloadStructureInput = ::Struct.new(
      :test_id,
      :payload_config,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :test_id
    #   @option params [PayloadConfig] :payload_config
    # @!attribute test_id
    #   @return [String]
    # @!attribute payload_config
    #   @return [PayloadConfig]
    TestPayloadStructureOutput = ::Struct.new(
      :test_id,
      :payload_config,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    TimestampFormatHeadersInput = ::Struct.new(
      :member_epoch_seconds,
      :member_http_date,
      :member_date_time,
      :default_format,
      :target_epoch_seconds,
      :target_http_date,
      :target_date_time,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    TimestampFormatHeadersOutput = ::Struct.new(
      :member_epoch_seconds,
      :member_http_date,
      :member_date_time,
      :default_format,
      :target_epoch_seconds,
      :target_http_date,
      :target_date_time,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    Unit = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    UnitInputAndOutputInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    UnitInputAndOutputOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
