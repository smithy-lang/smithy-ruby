# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module RailsJson
  module Types

    # @!attribute query_string
    #
    #   @return [String]
    #
    # @!attribute query_string_list
    #
    #   @return [Array<String>]
    #
    # @!attribute query_string_set
    #
    #   @return [Set<String>]
    #
    # @!attribute query_byte
    #
    #   @return [Integer]
    #
    # @!attribute query_short
    #
    #   @return [Integer]
    #
    # @!attribute query_integer
    #
    #   @return [Integer]
    #
    # @!attribute query_integer_list
    #
    #   @return [Array<Integer>]
    #
    # @!attribute query_integer_set
    #
    #   @return [Set<Integer>]
    #
    # @!attribute query_long
    #
    #   @return [Integer]
    #
    # @!attribute query_float
    #
    #   @return [Float]
    #
    # @!attribute query_double
    #
    #   @return [Float]
    #
    # @!attribute query_double_list
    #
    #   @return [Array<Float>]
    #
    # @!attribute query_boolean
    #
    #   @return [Boolean]
    #
    # @!attribute query_boolean_list
    #
    #   @return [Array<Boolean>]
    #
    # @!attribute query_timestamp
    #
    #   @return [Time]
    #
    # @!attribute query_timestamp_list
    #
    #   @return [Array<Time>]
    #
    # @!attribute query_enum
    #
    #   @return [String]
    #
    # @!attribute query_enum_list
    #
    #   @return [Array<String>]
    #
    # @!attribute query_params_map_of_strings
    #
    #   @return [Hash<String, String>]
    #
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
      :query_params_map_of_strings,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    AllQueryStringTypesOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # This error is thrown when a request is invalid.
    #
    # @!attribute top_level
    #
    #   @return [String]
    #
    # @!attribute nested
    #
    #   @return [ComplexNestedErrorData]
    #
    ComplexError = ::Struct.new(
      :top_level,
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    ComplexNestedErrorData = ::Struct.new(
      :foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute baz
    #
    #   @return [String]
    #
    # @!attribute maybe_set
    #
    #   @return [String]
    #
    ConstantAndVariableQueryStringInput = ::Struct.new(
      :baz,
      :maybe_set,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    ConstantAndVariableQueryStringOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute hello
    #
    #   @return [String]
    #
    ConstantQueryStringInput = ::Struct.new(
      :hello,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    ConstantQueryStringOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute document_value
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    DocumentTypeAsPayloadInput = ::Struct.new(
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute document_value
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    DocumentTypeAsPayloadOutput = ::Struct.new(
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute string_value
    #
    #   @return [String]
    #
    # @!attribute document_value
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    DocumentTypeInput = ::Struct.new(
      :string_value,
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute string_value
    #
    #   @return [String]
    #
    # @!attribute document_value
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    DocumentTypeOutput = ::Struct.new(
      :string_value,
      :document_value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    EmptyOperationInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    EmptyOperationOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    EmptyStruct = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    EndpointOperationInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    EndpointOperationOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute label
    #
    #   @return [String]
    #
    EndpointWithHostLabelOperationInput = ::Struct.new(
      :label,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    EndpointWithHostLabelOperationOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute code
    #
    #   @return [String]
    #
    # @!attribute complex_data
    #
    #   @return [KitchenSink]
    #
    # @!attribute integer_field
    #
    #   @return [Integer]
    #
    # @!attribute list_field
    #
    #   @return [Array<String>]
    #
    # @!attribute map_field
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute message
    #
    #   @return [String]
    #
    # @!attribute string_field
    #   abc
    #
    #   @return [String]
    #
    ErrorWithMembers = ::Struct.new(
      :code,
      :complex_data,
      :integer_field,
      :list_field,
      :map_field,
      :message,
      :string_field,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    ErrorWithoutMembers = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute hi
    #
    #   @return [String]
    #
    GreetingStruct = ::Struct.new(
      :hi,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    GreetingWithErrorsInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute greeting
    #
    #   @return [String]
    #
    GreetingWithErrorsOutput = ::Struct.new(
      :greeting,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    # @!attribute blob
    #
    #   @return [String]
    #
    HttpPayloadTraitsInput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    # @!attribute blob
    #
    #   @return [String]
    #
    HttpPayloadTraitsOutput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    # @!attribute blob
    #
    #   @return [String]
    #
    HttpPayloadTraitsWithMediaTypeInput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    # @!attribute blob
    #
    #   @return [String]
    #
    HttpPayloadTraitsWithMediaTypeOutput = ::Struct.new(
      :foo,
      :blob,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute nested
    #
    #   @return [NestedPayload]
    #
    HttpPayloadWithStructureInput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute nested
    #
    #   @return [NestedPayload]
    #
    HttpPayloadWithStructureOutput = ::Struct.new(
      :nested,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    HttpPrefixHeadersInResponseInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute prefix_headers
    #
    #   @return [Hash<String, String>]
    #
    HttpPrefixHeadersInResponseOutput = ::Struct.new(
      :prefix_headers,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    # @!attribute foo_map
    #
    #   @return [Hash<String, String>]
    #
    HttpPrefixHeadersInput = ::Struct.new(
      :foo,
      :foo_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    # @!attribute foo_map
    #
    #   @return [Hash<String, String>]
    #
    HttpPrefixHeadersOutput = ::Struct.new(
      :foo,
      :foo_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute float
    #
    #   @return [Float]
    #
    # @!attribute double
    #
    #   @return [Float]
    #
    HttpRequestWithFloatLabelsInput = ::Struct.new(
      :float,
      :double,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    HttpRequestWithFloatLabelsOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo
    #
    #   @return [String]
    #
    # @!attribute baz
    #
    #   @return [String]
    #
    HttpRequestWithGreedyLabelInPathInput = ::Struct.new(
      :foo,
      :baz,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    HttpRequestWithGreedyLabelInPathOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member_epoch_seconds
    #
    #   @return [Time]
    #
    # @!attribute member_http_date
    #
    #   @return [Time]
    #
    # @!attribute member_date_time
    #
    #   @return [Time]
    #
    # @!attribute default_format
    #
    #   @return [Time]
    #
    # @!attribute target_epoch_seconds
    #
    #   @return [Time]
    #
    # @!attribute target_http_date
    #
    #   @return [Time]
    #
    # @!attribute target_date_time
    #
    #   @return [Time]
    #
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

    HttpRequestWithLabelsAndTimestampFormatOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute short
    #
    #   @return [Integer]
    #
    # @!attribute integer
    #
    #   @return [Integer]
    #
    # @!attribute long
    #
    #   @return [Integer]
    #
    # @!attribute float
    #
    #   @return [Float]
    #
    # @!attribute double
    #
    #   @return [Float]
    #
    # @!attribute boolean
    #   Serialized in the path as true or false.
    #
    #   @return [Boolean]
    #
    # @!attribute timestamp
    #   Note that this member has no format, so it's serialized as an RFC 3399 date-time.
    #
    #   @return [Time]
    #
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

    HttpRequestWithLabelsOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    HttpResponseCodeInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute status
    #
    #   @return [Integer]
    #
    HttpResponseCodeOutput = ::Struct.new(
      :status,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    IgnoreQueryParamsInResponseInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute baz
    #
    #   @return [String]
    #
    IgnoreQueryParamsInResponseOutput = ::Struct.new(
      :baz,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute header_string
    #
    #   @return [String]
    #
    # @!attribute header_byte
    #
    #   @return [Integer]
    #
    # @!attribute header_short
    #
    #   @return [Integer]
    #
    # @!attribute header_integer
    #
    #   @return [Integer]
    #
    # @!attribute header_long
    #
    #   @return [Integer]
    #
    # @!attribute header_float
    #
    #   @return [Float]
    #
    # @!attribute header_double
    #
    #   @return [Float]
    #
    # @!attribute header_true_bool
    #
    #   @return [Boolean]
    #
    # @!attribute header_false_bool
    #
    #   @return [Boolean]
    #
    # @!attribute header_string_list
    #
    #   @return [Array<String>]
    #
    # @!attribute header_string_set
    #
    #   @return [Set<String>]
    #
    # @!attribute header_integer_list
    #
    #   @return [Array<Integer>]
    #
    # @!attribute header_boolean_list
    #
    #   @return [Array<Boolean>]
    #
    # @!attribute header_timestamp_list
    #
    #   @return [Array<Time>]
    #
    # @!attribute header_enum
    #
    #   @return [String]
    #
    # @!attribute header_enum_list
    #
    #   @return [Array<String>]
    #
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
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute header_string
    #
    #   @return [String]
    #
    # @!attribute header_byte
    #
    #   @return [Integer]
    #
    # @!attribute header_short
    #
    #   @return [Integer]
    #
    # @!attribute header_integer
    #
    #   @return [Integer]
    #
    # @!attribute header_long
    #
    #   @return [Integer]
    #
    # @!attribute header_float
    #
    #   @return [Float]
    #
    # @!attribute header_double
    #
    #   @return [Float]
    #
    # @!attribute header_true_bool
    #
    #   @return [Boolean]
    #
    # @!attribute header_false_bool
    #
    #   @return [Boolean]
    #
    # @!attribute header_string_list
    #
    #   @return [Array<String>]
    #
    # @!attribute header_string_set
    #
    #   @return [Set<String>]
    #
    # @!attribute header_integer_list
    #
    #   @return [Array<Integer>]
    #
    # @!attribute header_boolean_list
    #
    #   @return [Array<Boolean>]
    #
    # @!attribute header_timestamp_list
    #
    #   @return [Array<Time>]
    #
    # @!attribute header_enum
    #
    #   @return [String]
    #
    # @!attribute header_enum_list
    #
    #   @return [Array<String>]
    #
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
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # This error is thrown when an invalid greeting value is provided.
    #
    # @!attribute message
    #
    #   @return [String]
    #
    InvalidGreeting = ::Struct.new(
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute foo_enum1
    #
    #   @return [String]
    #
    # @!attribute foo_enum2
    #
    #   @return [String]
    #
    # @!attribute foo_enum3
    #
    #   @return [String]
    #
    # @!attribute foo_enum_list
    #
    #   @return [Array<String>]
    #
    # @!attribute foo_enum_set
    #
    #   @return [Set<String>]
    #
    # @!attribute foo_enum_map
    #
    #   @return [Hash<String, String>]
    #
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

    # @!attribute foo_enum1
    #
    #   @return [String]
    #
    # @!attribute foo_enum2
    #
    #   @return [String]
    #
    # @!attribute foo_enum3
    #
    #   @return [String]
    #
    # @!attribute foo_enum_list
    #
    #   @return [Array<String>]
    #
    # @!attribute foo_enum_set
    #
    #   @return [Set<String>]
    #
    # @!attribute foo_enum_map
    #
    #   @return [Hash<String, String>]
    #
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

    # @!attribute dense_struct_map
    #
    #   @return [Hash<String, GreetingStruct>]
    #
    # @!attribute sparse_struct_map
    #
    #   @return [Hash<String, GreetingStruct>]
    #
    # @!attribute dense_number_map
    #
    #   @return [Hash<String, Integer>]
    #
    # @!attribute dense_boolean_map
    #
    #   @return [Hash<String, Boolean>]
    #
    # @!attribute dense_string_map
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute sparse_number_map
    #
    #   @return [Hash<String, Integer>]
    #
    # @!attribute sparse_boolean_map
    #
    #   @return [Hash<String, Boolean>]
    #
    # @!attribute sparse_string_map
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute dense_set_map
    #
    #   @return [Hash<String, Set<String>>]
    #
    # @!attribute sparse_set_map
    #
    #   @return [Hash<String, Set<String>>]
    #
    JsonMapsInput = ::Struct.new(
      :dense_struct_map,
      :sparse_struct_map,
      :dense_number_map,
      :dense_boolean_map,
      :dense_string_map,
      :sparse_number_map,
      :sparse_boolean_map,
      :sparse_string_map,
      :dense_set_map,
      :sparse_set_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute dense_struct_map
    #
    #   @return [Hash<String, GreetingStruct>]
    #
    # @!attribute sparse_struct_map
    #
    #   @return [Hash<String, GreetingStruct>]
    #
    # @!attribute dense_number_map
    #
    #   @return [Hash<String, Integer>]
    #
    # @!attribute dense_boolean_map
    #
    #   @return [Hash<String, Boolean>]
    #
    # @!attribute dense_string_map
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute sparse_number_map
    #
    #   @return [Hash<String, Integer>]
    #
    # @!attribute sparse_boolean_map
    #
    #   @return [Hash<String, Boolean>]
    #
    # @!attribute sparse_string_map
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute dense_set_map
    #
    #   @return [Hash<String, Set<String>>]
    #
    # @!attribute sparse_set_map
    #
    #   @return [Hash<String, Set<String>>]
    #
    JsonMapsOutput = ::Struct.new(
      :dense_struct_map,
      :sparse_struct_map,
      :dense_number_map,
      :dense_boolean_map,
      :dense_string_map,
      :sparse_number_map,
      :sparse_boolean_map,
      :sparse_string_map,
      :dense_set_map,
      :sparse_set_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # A shared structure that contains a single union member.
    #
    # @!attribute contents
    #   A union with a representative set of types for members.
    #
    #   @return [MyUnion]
    #
    JsonUnionsInput = ::Struct.new(
      :contents,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # A shared structure that contains a single union member.
    #
    # @!attribute contents
    #   A union with a representative set of types for members.
    #
    #   @return [MyUnion]
    #
    JsonUnionsOutput = ::Struct.new(
      :contents,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute blob
    #
    #   @return [String]
    #
    # @!attribute boolean
    #
    #   @return [Boolean]
    #
    # @!attribute double
    #
    #   @return [Float]
    #
    # @!attribute empty_struct
    #
    #   @return [EmptyStruct]
    #
    # @!attribute float
    #
    #   @return [Float]
    #
    # @!attribute httpdate_timestamp
    #
    #   @return [Time]
    #
    # @!attribute integer
    #
    #   @return [Integer]
    #
    # @!attribute iso8601_timestamp
    #
    #   @return [Time]
    #
    # @!attribute json_value
    #
    #   @return [String]
    #
    # @!attribute list_of_lists
    #
    #   @return [Array<Array<String>>]
    #
    # @!attribute list_of_maps_of_strings
    #
    #   @return [Array<Hash<String, String>>]
    #
    # @!attribute list_of_strings
    #
    #   @return [Array<String>]
    #
    # @!attribute list_of_structs
    #
    #   @return [Array<SimpleStruct>]
    #
    # @!attribute long
    #
    #   @return [Integer]
    #
    # @!attribute map_of_lists_of_strings
    #
    #   @return [Hash<String, Array<String>>]
    #
    # @!attribute map_of_maps
    #
    #   @return [Hash<String, Hash<String, String>>]
    #
    # @!attribute map_of_strings
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute map_of_structs
    #
    #   @return [Hash<String, SimpleStruct>]
    #
    # @!attribute recursive_list
    #
    #   @return [Array<KitchenSink>]
    #
    # @!attribute recursive_map
    #
    #   @return [Hash<String, KitchenSink>]
    #
    # @!attribute recursive_struct
    #
    #   @return [KitchenSink]
    #
    # @!attribute simple_struct
    #
    #   @return [SimpleStruct]
    #
    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute struct_with_location_name
    #
    #   @return [StructWithLocationName]
    #
    # @!attribute timestamp
    #
    #   @return [Time]
    #
    # @!attribute unix_timestamp
    #
    #   @return [Time]
    #
    KitchenSink = ::Struct.new(
      :blob,
      :boolean,
      :double,
      :empty_struct,
      :float,
      :httpdate_timestamp,
      :integer,
      :iso8601_timestamp,
      :json_value,
      :list_of_lists,
      :list_of_maps_of_strings,
      :list_of_strings,
      :list_of_structs,
      :long,
      :map_of_lists_of_strings,
      :map_of_maps,
      :map_of_strings,
      :map_of_structs,
      :recursive_list,
      :recursive_map,
      :recursive_struct,
      :simple_struct,
      :string,
      :struct_with_location_name,
      :timestamp,
      :unix_timestamp,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute blob
    #
    #   @return [String]
    #
    # @!attribute boolean
    #
    #   @return [Boolean]
    #
    # @!attribute double
    #
    #   @return [Float]
    #
    # @!attribute empty_struct
    #
    #   @return [EmptyStruct]
    #
    # @!attribute float
    #
    #   @return [Float]
    #
    # @!attribute httpdate_timestamp
    #
    #   @return [Time]
    #
    # @!attribute integer
    #
    #   @return [Integer]
    #
    # @!attribute iso8601_timestamp
    #
    #   @return [Time]
    #
    # @!attribute json_value
    #
    #   @return [String]
    #
    # @!attribute list_of_lists
    #
    #   @return [Array<Array<String>>]
    #
    # @!attribute list_of_maps_of_strings
    #
    #   @return [Array<Hash<String, String>>]
    #
    # @!attribute list_of_strings
    #
    #   @return [Array<String>]
    #
    # @!attribute list_of_structs
    #
    #   @return [Array<SimpleStruct>]
    #
    # @!attribute long
    #
    #   @return [Integer]
    #
    # @!attribute map_of_lists_of_strings
    #
    #   @return [Hash<String, Array<String>>]
    #
    # @!attribute map_of_maps
    #
    #   @return [Hash<String, Hash<String, String>>]
    #
    # @!attribute map_of_strings
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute map_of_structs
    #
    #   @return [Hash<String, SimpleStruct>]
    #
    # @!attribute recursive_list
    #
    #   @return [Array<KitchenSink>]
    #
    # @!attribute recursive_map
    #
    #   @return [Hash<String, KitchenSink>]
    #
    # @!attribute recursive_struct
    #
    #   @return [KitchenSink]
    #
    # @!attribute simple_struct
    #
    #   @return [SimpleStruct]
    #
    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute struct_with_location_name
    #
    #   @return [StructWithLocationName]
    #
    # @!attribute timestamp
    #
    #   @return [Time]
    #
    # @!attribute unix_timestamp
    #
    #   @return [Time]
    #
    KitchenSinkOperationInput = ::Struct.new(
      :blob,
      :boolean,
      :double,
      :empty_struct,
      :float,
      :httpdate_timestamp,
      :integer,
      :iso8601_timestamp,
      :json_value,
      :list_of_lists,
      :list_of_maps_of_strings,
      :list_of_strings,
      :list_of_structs,
      :long,
      :map_of_lists_of_strings,
      :map_of_maps,
      :map_of_strings,
      :map_of_structs,
      :recursive_list,
      :recursive_map,
      :recursive_struct,
      :simple_struct,
      :string,
      :struct_with_location_name,
      :timestamp,
      :unix_timestamp,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute blob
    #
    #   @return [String]
    #
    # @!attribute boolean
    #
    #   @return [Boolean]
    #
    # @!attribute double
    #
    #   @return [Float]
    #
    # @!attribute empty_struct
    #
    #   @return [EmptyStruct]
    #
    # @!attribute float
    #
    #   @return [Float]
    #
    # @!attribute httpdate_timestamp
    #
    #   @return [Time]
    #
    # @!attribute integer
    #
    #   @return [Integer]
    #
    # @!attribute iso8601_timestamp
    #
    #   @return [Time]
    #
    # @!attribute json_value
    #
    #   @return [String]
    #
    # @!attribute list_of_lists
    #
    #   @return [Array<Array<String>>]
    #
    # @!attribute list_of_maps_of_strings
    #
    #   @return [Array<Hash<String, String>>]
    #
    # @!attribute list_of_strings
    #
    #   @return [Array<String>]
    #
    # @!attribute list_of_structs
    #
    #   @return [Array<SimpleStruct>]
    #
    # @!attribute long
    #
    #   @return [Integer]
    #
    # @!attribute map_of_lists_of_strings
    #
    #   @return [Hash<String, Array<String>>]
    #
    # @!attribute map_of_maps
    #
    #   @return [Hash<String, Hash<String, String>>]
    #
    # @!attribute map_of_strings
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute map_of_structs
    #
    #   @return [Hash<String, SimpleStruct>]
    #
    # @!attribute recursive_list
    #
    #   @return [Array<KitchenSink>]
    #
    # @!attribute recursive_map
    #
    #   @return [Hash<String, KitchenSink>]
    #
    # @!attribute recursive_struct
    #
    #   @return [KitchenSink]
    #
    # @!attribute simple_struct
    #
    #   @return [SimpleStruct]
    #
    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute struct_with_location_name
    #
    #   @return [StructWithLocationName]
    #
    # @!attribute timestamp
    #
    #   @return [Time]
    #
    # @!attribute unix_timestamp
    #
    #   @return [Time]
    #
    KitchenSinkOperationOutput = ::Struct.new(
      :blob,
      :boolean,
      :double,
      :empty_struct,
      :float,
      :httpdate_timestamp,
      :integer,
      :iso8601_timestamp,
      :json_value,
      :list_of_lists,
      :list_of_maps_of_strings,
      :list_of_strings,
      :list_of_structs,
      :long,
      :map_of_lists_of_strings,
      :map_of_maps,
      :map_of_strings,
      :map_of_structs,
      :recursive_list,
      :recursive_map,
      :recursive_struct,
      :simple_struct,
      :string,
      :struct_with_location_name,
      :timestamp,
      :unix_timestamp,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute json
    #
    #   @return [String]
    #
    MediaTypeHeaderInput = ::Struct.new(
      :json,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute json
    #
    #   @return [String]
    #
    MediaTypeHeaderOutput = ::Struct.new(
      :json,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # A union with a representative set of types for members.
    #
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

      # Handles unknown future members
      #
      class Unknown < MyUnion
        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<RailsJson::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!attribute simple_struct
    #
    #   @return [SimpleStruct]
    #
    NestedAttributesOperationInput = ::Struct.new(
      :simple_struct,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute value
    #
    #   @return [String]
    #
    NestedAttributesOperationOutput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute greeting
    #
    #   @return [String]
    #
    # @!attribute member_name
    #
    #   @return [String]
    #
    NestedPayload = ::Struct.new(
      :greeting,
      :member_name,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute a
    #
    #   @return [String]
    #
    # @!attribute b
    #
    #   @return [String]
    #
    # @!attribute c
    #
    #   @return [Array<String>]
    #
    NullAndEmptyHeadersClientInput = ::Struct.new(
      :a,
      :b,
      :c,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute a
    #
    #   @return [String]
    #
    # @!attribute b
    #
    #   @return [String]
    #
    # @!attribute c
    #
    #   @return [Array<String>]
    #
    NullAndEmptyHeadersClientOutput = ::Struct.new(
      :a,
      :b,
      :c,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute sparse_string_list
    #
    #   @return [Array<String>]
    #
    # @!attribute sparse_string_map
    #
    #   @return [Hash<String, String>]
    #
    NullOperationInput = ::Struct.new(
      :string,
      :sparse_string_list,
      :sparse_string_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute sparse_string_list
    #
    #   @return [Array<String>]
    #
    # @!attribute sparse_string_map
    #
    #   @return [Hash<String, String>]
    #
    NullOperationOutput = ::Struct.new(
      :string,
      :sparse_string_list,
      :sparse_string_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute null_value
    #
    #   @return [String]
    #
    # @!attribute empty_string
    #
    #   @return [String]
    #
    OmitsNullSerializesEmptyStringInput = ::Struct.new(
      :null_value,
      :empty_string,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    OmitsNullSerializesEmptyStringOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute value
    #
    #   @return [String]
    #
    OperationWithOptionalInputOutputInput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute value
    #
    #   @return [String]
    #
    OperationWithOptionalInputOutputOutput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute token
    #
    #   @return [String]
    #
    QueryIdempotencyTokenAutoFillInput = ::Struct.new(
      :token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    QueryIdempotencyTokenAutoFillOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute qux
    #
    #   @return [String]
    #
    # @!attribute foo
    #
    #   @return [Hash<String, Array<String>>]
    #
    QueryParamsAsStringListMapInput = ::Struct.new(
      :qux,
      :foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    QueryParamsAsStringListMapOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute value
    #
    #   @return [String]
    #
    SimpleStruct = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute value
    #
    #   @return [String]
    #
    StructWithLocationName = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member_epoch_seconds
    #
    #   @return [Time]
    #
    # @!attribute member_http_date
    #
    #   @return [Time]
    #
    # @!attribute member_date_time
    #
    #   @return [Time]
    #
    # @!attribute default_format
    #
    #   @return [Time]
    #
    # @!attribute target_epoch_seconds
    #
    #   @return [Time]
    #
    # @!attribute target_http_date
    #
    #   @return [Time]
    #
    # @!attribute target_date_time
    #
    #   @return [Time]
    #
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

    # @!attribute member_epoch_seconds
    #
    #   @return [Time]
    #
    # @!attribute member_http_date
    #
    #   @return [Time]
    #
    # @!attribute member_date_time
    #
    #   @return [Time]
    #
    # @!attribute default_format
    #
    #   @return [Time]
    #
    # @!attribute target_epoch_seconds
    #
    #   @return [Time]
    #
    # @!attribute target_http_date
    #
    #   @return [Time]
    #
    # @!attribute target_date_time
    #
    #   @return [Time]
    #
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

    # @!attribute member____123foo
    #
    #   @return [String]
    #
    Struct____456efg = ::Struct.new(
      :member____123foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member____123abc
    #
    #   @return [String]
    #
    # @!attribute member
    #
    #   @return [Struct____456efg]
    #
    Struct____789BadNameInput = ::Struct.new(
      :member____123abc,
      :member,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member
    #
    #   @return [Struct____456efg]
    #
    Struct____789BadNameOutput = ::Struct.new(
      :member,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
