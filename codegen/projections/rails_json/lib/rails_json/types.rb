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
    #   @option params [Hash<String, String>] :query_params_map_of_strings
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
    # @!attribute query_params_map_of_strings
    #   @return [Hash<String, String>]
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
    EmptyOperationInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EmptyOperationOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EmptyStruct = ::Struct.new(
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
    #   @option params [String] :label_member
    # @!attribute label_member
    #   @return [String]
    EndpointWithHostLabelOperationInput = ::Struct.new(
      :label_member,
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :code
    #   @option params [KitchenSink] :complex_data
    #   @option params [Integer] :integer_field
    #   @option params [Array<String>] :list_field
    #   @option params [Hash<String, String>] :map_field
    #   @option params [String] :message
    #   @option params [String] :string_field
    # @!attribute code
    #   @return [String]
    # @!attribute complex_data
    #   @return [KitchenSink]
    # @!attribute integer_field
    #   @return [Integer]
    # @!attribute list_field
    #   @return [Array<String>]
    # @!attribute map_field
    #   @return [Hash<String, String>]
    # @!attribute message
    #   @return [String]
    # @!attribute string_field
    #   abc
    #   @return [String]
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    ErrorWithoutMembers = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Enum constants for StringEnum
    module StringEnum
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for RequiredEnum
    module RequiredEnum
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for ObjectStorageClass
    module ObjectStorageClass
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for ApiKeySourceType
    module ApiKeySourceType
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for FooEnum
    module FooEnum
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for DetailsAttributes
    module DetailsAttributes
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for Data
    module Data
      # Designates the target as containing data of a known classification level.
      V = "enumvalue"

      # Designates the target as containing data of a known classification level.
      FOO = "FOO"

      # Designates the target as containing data of a known classification level.
      BAR = "BAR"

      # Designates the target as containing data of a known classification level.
      BAZ = "BAZ"

      # Designates the target as containing data of a known classification level.
      STANDARD = "STANDARD"

      # Designates the target as containing data of a known classification level.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # Designates the target as containing data of a known classification level.
      GLACIER = "GLACIER"

      # Designates the target as containing data of a known classification level.
      STANDARD_IA = "STANDARD_IA"

      # Designates the target as containing data of a known classification level.
      ONEZONE_IA = "ONEZONE_IA"

      # Designates the target as containing data of a known classification level.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # Designates the target as containing data of a known classification level.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # Designates the target as containing data of a known classification level.
      OUTPOSTS = "OUTPOSTS"

      # Designates the target as containing data of a known classification level.
      HEADER = "HEADER"

      # Designates the target as containing data of a known classification level.
      AUTHORIZER = "AUTHORIZER"

      # Designates the target as containing data of a known classification level.
      FOO = "Foo"

      # Designates the target as containing data of a known classification level.
      BAZ = "Baz"

      # Designates the target as containing data of a known classification level.
      BAR = "Bar"

      # Designates the target as containing data of a known classification level.
      ONE = "1"

      # Designates the target as containing data of a known classification level.
      ZERO = "0"

      # Designates the target as containing data of a known classification level.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Designates the target as containing data of a known classification level.
      ALGORITHM = "Algorithm"

      # Designates the target as containing data of a known classification level.
      CUSTOMER_CONTENT = "content"

      # Designates the target as containing data of a known classification level.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # Designates the target as containing data of a known classification level.
      SERVICE_ATTRIBUTES = "usage"

      # Designates the target as containing data of a known classification level.
      TAG_DATA = "tagging"

      # Designates the target as containing data of a known classification level.
      PERMISSIONS_DATA = "permissions"

      # Designates the target as containing data of a known classification level.
      FOO = "FOO"

      # Designates the target as containing data of a known classification level.
      BAR = "BAR"

      # Designates the target as containing data of a known classification level.
      BAZ = "BAZ"

      # Designates the target as containing data of a known classification level.
      V = "enumvalue"

      # Designates the target as containing data of a known classification level.
      REGIONAL = "REGIONAL"

      # Designates the target as containing data of a known classification level.
      EDGE = "EDGE"

      # Designates the target as containing data of a known classification level.
      PRIVATE = "PRIVATE"

      # Designates the target as containing data of a known classification level.
      SUCCESS = "success"

      # Designates the target as containing data of a known classification level.
      FAILURE = "failure"

      # Designates the target as containing data of a known classification level.
      RETRY = "retry"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      CRC32_C = "CRC32C"

      # Designates the target as containing data of a known classification level.
      CRC32 = "CRC32"

      # Designates the target as containing data of a known classification level.
      SHA1 = "SHA1"

      # Designates the target as containing data of a known classification level.
      SHA256 = "SHA256"

      # Designates the target as containing data of a known classification level.
      US_WEST_2 = "us-west-2"

      # Designates the target as containing data of a known classification level.
      LEGACY = "legacy"

      # Designates the target as containing data of a known classification level.
      STANDARD = "standard"

      # Designates the target as containing data of a known classification level.
      ADAPTIVE = "adaptive"

      # Designates the target as containing data of a known classification level.
      URL = "url"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      GHI = "ghi"

      # Designates the target as containing data of a known classification level.
      JKL = "jkl"

      # Designates the target as containing data of a known classification level.
      STRING_EQUALS = "stringEquals"

      # Designates the target as containing data of a known classification level.
      BOOLEAN_EQUALS = "booleanEquals"

      # Designates the target as containing data of a known classification level.
      ALL_STRING_EQUALS = "allStringEquals"

      # Designates the target as containing data of a known classification level.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Designates the target as containing data of a known classification level.
      AUTO = "auto"

      # Designates the target as containing data of a known classification level.
      PATH = "path"

      # Designates the target as containing data of a known classification level.
      VIRTUAL = "virtual"

      # Designates the target as containing data of a known classification level.
      CLIENT = "client"

      # Designates the target as containing data of a known classification level.
      SERVER = "server"

      # Designates the target as containing data of a known classification level.
      REQUESTER = "requester"

      # Designates the target as containing data of a known classification level.
      STRING = "string"

      # Designates the target as containing data of a known classification level.
      BOOLEAN = "boolean"
    end

    # Enum constants for TestEnum
    module TestEnum
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for StringEnum
    module StringEnum
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for EndpointType
    module EndpointType
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for AcceptorState
    module AcceptorState
      # The transition state of a waiter.
      V = "enumvalue"

      # The transition state of a waiter.
      FOO = "FOO"

      # The transition state of a waiter.
      BAR = "BAR"

      # The transition state of a waiter.
      BAZ = "BAZ"

      # The transition state of a waiter.
      STANDARD = "STANDARD"

      # The transition state of a waiter.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # The transition state of a waiter.
      GLACIER = "GLACIER"

      # The transition state of a waiter.
      STANDARD_IA = "STANDARD_IA"

      # The transition state of a waiter.
      ONEZONE_IA = "ONEZONE_IA"

      # The transition state of a waiter.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # The transition state of a waiter.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # The transition state of a waiter.
      OUTPOSTS = "OUTPOSTS"

      # The transition state of a waiter.
      HEADER = "HEADER"

      # The transition state of a waiter.
      AUTHORIZER = "AUTHORIZER"

      # The transition state of a waiter.
      FOO = "Foo"

      # The transition state of a waiter.
      BAZ = "Baz"

      # The transition state of a waiter.
      BAR = "Bar"

      # The transition state of a waiter.
      ONE = "1"

      # The transition state of a waiter.
      ZERO = "0"

      # The transition state of a waiter.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # The transition state of a waiter.
      ALGORITHM = "Algorithm"

      # The transition state of a waiter.
      CUSTOMER_CONTENT = "content"

      # The transition state of a waiter.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # The transition state of a waiter.
      SERVICE_ATTRIBUTES = "usage"

      # The transition state of a waiter.
      TAG_DATA = "tagging"

      # The transition state of a waiter.
      PERMISSIONS_DATA = "permissions"

      # The transition state of a waiter.
      FOO = "FOO"

      # The transition state of a waiter.
      BAR = "BAR"

      # The transition state of a waiter.
      BAZ = "BAZ"

      # The transition state of a waiter.
      V = "enumvalue"

      # The transition state of a waiter.
      REGIONAL = "REGIONAL"

      # The transition state of a waiter.
      EDGE = "EDGE"

      # The transition state of a waiter.
      PRIVATE = "PRIVATE"

      # The transition state of a waiter.
      SUCCESS = "success"

      # The transition state of a waiter.
      FAILURE = "failure"

      # The transition state of a waiter.
      RETRY = "retry"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      CRC32_C = "CRC32C"

      # The transition state of a waiter.
      CRC32 = "CRC32"

      # The transition state of a waiter.
      SHA1 = "SHA1"

      # The transition state of a waiter.
      SHA256 = "SHA256"

      # The transition state of a waiter.
      US_WEST_2 = "us-west-2"

      # The transition state of a waiter.
      LEGACY = "legacy"

      # The transition state of a waiter.
      STANDARD = "standard"

      # The transition state of a waiter.
      ADAPTIVE = "adaptive"

      # The transition state of a waiter.
      URL = "url"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      GHI = "ghi"

      # The transition state of a waiter.
      JKL = "jkl"

      # The transition state of a waiter.
      STRING_EQUALS = "stringEquals"

      # The transition state of a waiter.
      BOOLEAN_EQUALS = "booleanEquals"

      # The transition state of a waiter.
      ALL_STRING_EQUALS = "allStringEquals"

      # The transition state of a waiter.
      ANY_STRING_EQUALS = "anyStringEquals"

      # The transition state of a waiter.
      AUTO = "auto"

      # The transition state of a waiter.
      PATH = "path"

      # The transition state of a waiter.
      VIRTUAL = "virtual"

      # The transition state of a waiter.
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

      # The transition state of a waiter.
      REQUESTER = "requester"

      # The transition state of a waiter.
      STRING = "string"

      # The transition state of a waiter.
      BOOLEAN = "boolean"
    end

    # Enum constants for RecursiveEnumString
    module RecursiveEnumString
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for ChecksumAlgorithm
    module ChecksumAlgorithm
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for BucketLocationConstraint
    module BucketLocationConstraint
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for RetryMode
    module RetryMode
      # Controls the strategy used for retries.
      V = "enumvalue"

      # Controls the strategy used for retries.
      FOO = "FOO"

      # Controls the strategy used for retries.
      BAR = "BAR"

      # Controls the strategy used for retries.
      BAZ = "BAZ"

      # Controls the strategy used for retries.
      STANDARD = "STANDARD"

      # Controls the strategy used for retries.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # Controls the strategy used for retries.
      GLACIER = "GLACIER"

      # Controls the strategy used for retries.
      STANDARD_IA = "STANDARD_IA"

      # Controls the strategy used for retries.
      ONEZONE_IA = "ONEZONE_IA"

      # Controls the strategy used for retries.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # Controls the strategy used for retries.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # Controls the strategy used for retries.
      OUTPOSTS = "OUTPOSTS"

      # Controls the strategy used for retries.
      HEADER = "HEADER"

      # Controls the strategy used for retries.
      AUTHORIZER = "AUTHORIZER"

      # Controls the strategy used for retries.
      FOO = "Foo"

      # Controls the strategy used for retries.
      BAZ = "Baz"

      # Controls the strategy used for retries.
      BAR = "Bar"

      # Controls the strategy used for retries.
      ONE = "1"

      # Controls the strategy used for retries.
      ZERO = "0"

      # Controls the strategy used for retries.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Controls the strategy used for retries.
      ALGORITHM = "Algorithm"

      # Controls the strategy used for retries.
      CUSTOMER_CONTENT = "content"

      # Controls the strategy used for retries.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # Controls the strategy used for retries.
      SERVICE_ATTRIBUTES = "usage"

      # Controls the strategy used for retries.
      TAG_DATA = "tagging"

      # Controls the strategy used for retries.
      PERMISSIONS_DATA = "permissions"

      # Controls the strategy used for retries.
      FOO = "FOO"

      # Controls the strategy used for retries.
      BAR = "BAR"

      # Controls the strategy used for retries.
      BAZ = "BAZ"

      # Controls the strategy used for retries.
      V = "enumvalue"

      # Controls the strategy used for retries.
      REGIONAL = "REGIONAL"

      # Controls the strategy used for retries.
      EDGE = "EDGE"

      # Controls the strategy used for retries.
      PRIVATE = "PRIVATE"

      # Controls the strategy used for retries.
      SUCCESS = "success"

      # Controls the strategy used for retries.
      FAILURE = "failure"

      # Controls the strategy used for retries.
      RETRY = "retry"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      CRC32_C = "CRC32C"

      # Controls the strategy used for retries.
      CRC32 = "CRC32"

      # Controls the strategy used for retries.
      SHA1 = "SHA1"

      # Controls the strategy used for retries.
      SHA256 = "SHA256"

      # Controls the strategy used for retries.
      US_WEST_2 = "us-west-2"

      # Controls the strategy used for retries.
      LEGACY = "legacy"

      # Controls the strategy used for retries.
      STANDARD = "standard"

      # Controls the strategy used for retries.
      ADAPTIVE = "adaptive"

      # Controls the strategy used for retries.
      URL = "url"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      GHI = "ghi"

      # Controls the strategy used for retries.
      JKL = "jkl"

      # Controls the strategy used for retries.
      STRING_EQUALS = "stringEquals"

      # Controls the strategy used for retries.
      BOOLEAN_EQUALS = "booleanEquals"

      # Controls the strategy used for retries.
      ALL_STRING_EQUALS = "allStringEquals"

      # Controls the strategy used for retries.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Controls the strategy used for retries.
      AUTO = "auto"

      # Controls the strategy used for retries.
      PATH = "path"

      # Controls the strategy used for retries.
      VIRTUAL = "virtual"

      # Controls the strategy used for retries.
      CLIENT = "client"

      # Controls the strategy used for retries.
      SERVER = "server"

      # Controls the strategy used for retries.
      REQUESTER = "requester"

      # Controls the strategy used for retries.
      STRING = "string"

      # Controls the strategy used for retries.
      BOOLEAN = "boolean"
    end

    # Enum constants for EncodingType
    module EncodingType
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for EnumString
    module EnumString
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for PathComparator
    module PathComparator
      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"

      # Defines a comparison to perform in a PathMatcher.
      FOO = "FOO"

      # Defines a comparison to perform in a PathMatcher.
      BAR = "BAR"

      # Defines a comparison to perform in a PathMatcher.
      BAZ = "BAZ"

      # Defines a comparison to perform in a PathMatcher.
      STANDARD = "STANDARD"

      # Defines a comparison to perform in a PathMatcher.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # Defines a comparison to perform in a PathMatcher.
      GLACIER = "GLACIER"

      # Defines a comparison to perform in a PathMatcher.
      STANDARD_IA = "STANDARD_IA"

      # Defines a comparison to perform in a PathMatcher.
      ONEZONE_IA = "ONEZONE_IA"

      # Defines a comparison to perform in a PathMatcher.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # Defines a comparison to perform in a PathMatcher.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # Defines a comparison to perform in a PathMatcher.
      OUTPOSTS = "OUTPOSTS"

      # Defines a comparison to perform in a PathMatcher.
      HEADER = "HEADER"

      # Defines a comparison to perform in a PathMatcher.
      AUTHORIZER = "AUTHORIZER"

      # Defines a comparison to perform in a PathMatcher.
      FOO = "Foo"

      # Defines a comparison to perform in a PathMatcher.
      BAZ = "Baz"

      # Defines a comparison to perform in a PathMatcher.
      BAR = "Bar"

      # Defines a comparison to perform in a PathMatcher.
      ONE = "1"

      # Defines a comparison to perform in a PathMatcher.
      ZERO = "0"

      # Defines a comparison to perform in a PathMatcher.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Defines a comparison to perform in a PathMatcher.
      ALGORITHM = "Algorithm"

      # Defines a comparison to perform in a PathMatcher.
      CUSTOMER_CONTENT = "content"

      # Defines a comparison to perform in a PathMatcher.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # Defines a comparison to perform in a PathMatcher.
      SERVICE_ATTRIBUTES = "usage"

      # Defines a comparison to perform in a PathMatcher.
      TAG_DATA = "tagging"

      # Defines a comparison to perform in a PathMatcher.
      PERMISSIONS_DATA = "permissions"

      # Defines a comparison to perform in a PathMatcher.
      FOO = "FOO"

      # Defines a comparison to perform in a PathMatcher.
      BAR = "BAR"

      # Defines a comparison to perform in a PathMatcher.
      BAZ = "BAZ"

      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"

      # Defines a comparison to perform in a PathMatcher.
      REGIONAL = "REGIONAL"

      # Defines a comparison to perform in a PathMatcher.
      EDGE = "EDGE"

      # Defines a comparison to perform in a PathMatcher.
      PRIVATE = "PRIVATE"

      # Defines a comparison to perform in a PathMatcher.
      SUCCESS = "success"

      # Defines a comparison to perform in a PathMatcher.
      FAILURE = "failure"

      # Defines a comparison to perform in a PathMatcher.
      RETRY = "retry"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      CRC32_C = "CRC32C"

      # Defines a comparison to perform in a PathMatcher.
      CRC32 = "CRC32"

      # Defines a comparison to perform in a PathMatcher.
      SHA1 = "SHA1"

      # Defines a comparison to perform in a PathMatcher.
      SHA256 = "SHA256"

      # Defines a comparison to perform in a PathMatcher.
      US_WEST_2 = "us-west-2"

      # Defines a comparison to perform in a PathMatcher.
      LEGACY = "legacy"

      # Defines a comparison to perform in a PathMatcher.
      STANDARD = "standard"

      # Defines a comparison to perform in a PathMatcher.
      ADAPTIVE = "adaptive"

      # Defines a comparison to perform in a PathMatcher.
      URL = "url"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      GHI = "ghi"

      # Defines a comparison to perform in a PathMatcher.
      JKL = "jkl"

      # Defines a comparison to perform in a PathMatcher.
      STRING_EQUALS = "stringEquals"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN_EQUALS = "booleanEquals"

      # Defines a comparison to perform in a PathMatcher.
      ALL_STRING_EQUALS = "allStringEquals"

      # Defines a comparison to perform in a PathMatcher.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Defines a comparison to perform in a PathMatcher.
      AUTO = "auto"

      # Defines a comparison to perform in a PathMatcher.
      PATH = "path"

      # Defines a comparison to perform in a PathMatcher.
      VIRTUAL = "virtual"

      # Defines a comparison to perform in a PathMatcher.
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

      # Defines a comparison to perform in a PathMatcher.
      REQUESTER = "requester"

      # Defines a comparison to perform in a PathMatcher.
      STRING = "string"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN = "boolean"
    end

    # Enum constants for S3AddressingStyle
    module S3AddressingStyle
      # Controls the S3 addressing bucket style.
      V = "enumvalue"

      # Controls the S3 addressing bucket style.
      FOO = "FOO"

      # Controls the S3 addressing bucket style.
      BAR = "BAR"

      # Controls the S3 addressing bucket style.
      BAZ = "BAZ"

      # Controls the S3 addressing bucket style.
      STANDARD = "STANDARD"

      # Controls the S3 addressing bucket style.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # Controls the S3 addressing bucket style.
      GLACIER = "GLACIER"

      # Controls the S3 addressing bucket style.
      STANDARD_IA = "STANDARD_IA"

      # Controls the S3 addressing bucket style.
      ONEZONE_IA = "ONEZONE_IA"

      # Controls the S3 addressing bucket style.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # Controls the S3 addressing bucket style.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # Controls the S3 addressing bucket style.
      OUTPOSTS = "OUTPOSTS"

      # Controls the S3 addressing bucket style.
      HEADER = "HEADER"

      # Controls the S3 addressing bucket style.
      AUTHORIZER = "AUTHORIZER"

      # Controls the S3 addressing bucket style.
      FOO = "Foo"

      # Controls the S3 addressing bucket style.
      BAZ = "Baz"

      # Controls the S3 addressing bucket style.
      BAR = "Bar"

      # Controls the S3 addressing bucket style.
      ONE = "1"

      # Controls the S3 addressing bucket style.
      ZERO = "0"

      # Controls the S3 addressing bucket style.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Controls the S3 addressing bucket style.
      ALGORITHM = "Algorithm"

      # Controls the S3 addressing bucket style.
      CUSTOMER_CONTENT = "content"

      # Controls the S3 addressing bucket style.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # Controls the S3 addressing bucket style.
      SERVICE_ATTRIBUTES = "usage"

      # Controls the S3 addressing bucket style.
      TAG_DATA = "tagging"

      # Controls the S3 addressing bucket style.
      PERMISSIONS_DATA = "permissions"

      # Controls the S3 addressing bucket style.
      FOO = "FOO"

      # Controls the S3 addressing bucket style.
      BAR = "BAR"

      # Controls the S3 addressing bucket style.
      BAZ = "BAZ"

      # Controls the S3 addressing bucket style.
      V = "enumvalue"

      # Controls the S3 addressing bucket style.
      REGIONAL = "REGIONAL"

      # Controls the S3 addressing bucket style.
      EDGE = "EDGE"

      # Controls the S3 addressing bucket style.
      PRIVATE = "PRIVATE"

      # Controls the S3 addressing bucket style.
      SUCCESS = "success"

      # Controls the S3 addressing bucket style.
      FAILURE = "failure"

      # Controls the S3 addressing bucket style.
      RETRY = "retry"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      CRC32_C = "CRC32C"

      # Controls the S3 addressing bucket style.
      CRC32 = "CRC32"

      # Controls the S3 addressing bucket style.
      SHA1 = "SHA1"

      # Controls the S3 addressing bucket style.
      SHA256 = "SHA256"

      # Controls the S3 addressing bucket style.
      US_WEST_2 = "us-west-2"

      # Controls the S3 addressing bucket style.
      LEGACY = "legacy"

      # Controls the S3 addressing bucket style.
      STANDARD = "standard"

      # Controls the S3 addressing bucket style.
      ADAPTIVE = "adaptive"

      # Controls the S3 addressing bucket style.
      URL = "url"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      GHI = "ghi"

      # Controls the S3 addressing bucket style.
      JKL = "jkl"

      # Controls the S3 addressing bucket style.
      STRING_EQUALS = "stringEquals"

      # Controls the S3 addressing bucket style.
      BOOLEAN_EQUALS = "booleanEquals"

      # Controls the S3 addressing bucket style.
      ALL_STRING_EQUALS = "allStringEquals"

      # Controls the S3 addressing bucket style.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Controls the S3 addressing bucket style.
      AUTO = "auto"

      # Controls the S3 addressing bucket style.
      PATH = "path"

      # Controls the S3 addressing bucket style.
      VIRTUAL = "virtual"

      # Controls the S3 addressing bucket style.
      CLIENT = "client"

      # Controls the S3 addressing bucket style.
      SERVER = "server"

      # Controls the S3 addressing bucket style.
      REQUESTER = "requester"

      # Controls the S3 addressing bucket style.
      STRING = "string"

      # Controls the S3 addressing bucket style.
      BOOLEAN = "boolean"
    end

    # Enum constants for AppliesTo
    module AppliesTo
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for RequestPayer
    module RequestPayer
      V = "enumvalue"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      ABC = "abc"

      DEF = "def"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      US_WEST_2 = "us-west-2"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      URL = "url"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      CLIENT = "client"

      SERVER = "server"

      REQUESTER = "requester"

      STRING = "string"

      BOOLEAN = "boolean"
    end

    # Enum constants for ShapeType
    module ShapeType
      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      V = "enumvalue"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      FOO = "FOO"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BAR = "BAR"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BAZ = "BAZ"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      STANDARD = "STANDARD"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      GLACIER = "GLACIER"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      STANDARD_IA = "STANDARD_IA"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ONEZONE_IA = "ONEZONE_IA"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      OUTPOSTS = "OUTPOSTS"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      HEADER = "HEADER"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      AUTHORIZER = "AUTHORIZER"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      FOO = "Foo"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BAZ = "Baz"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BAR = "Bar"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ONE = "1"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ZERO = "0"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ALGORITHM = "Algorithm"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      CUSTOMER_CONTENT = "content"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SERVICE_ATTRIBUTES = "usage"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      TAG_DATA = "tagging"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      PERMISSIONS_DATA = "permissions"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      FOO = "FOO"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BAR = "BAR"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BAZ = "BAZ"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      V = "enumvalue"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      REGIONAL = "REGIONAL"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      EDGE = "EDGE"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      PRIVATE = "PRIVATE"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SUCCESS = "success"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      FAILURE = "failure"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      RETRY = "retry"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ABC = "abc"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      DEF = "def"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      CRC32_C = "CRC32C"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      CRC32 = "CRC32"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SHA1 = "SHA1"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SHA256 = "SHA256"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      US_WEST_2 = "us-west-2"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      LEGACY = "legacy"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      STANDARD = "standard"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ADAPTIVE = "adaptive"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      URL = "url"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ABC = "abc"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      DEF = "def"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      GHI = "ghi"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      JKL = "jkl"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      STRING_EQUALS = "stringEquals"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BOOLEAN_EQUALS = "booleanEquals"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ALL_STRING_EQUALS = "allStringEquals"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ANY_STRING_EQUALS = "anyStringEquals"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      AUTO = "auto"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      PATH = "path"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      VIRTUAL = "virtual"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      CLIENT = "client"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SERVER = "server"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      REQUESTER = "requester"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      STRING = "string"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BOOLEAN = "boolean"
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
    #   @option params [Hash<String, GreetingStruct>] :dense_struct_map
    #   @option params [Hash<String, GreetingStruct>] :sparse_struct_map
    #   @option params [Hash<String, Integer>] :dense_number_map
    #   @option params [Hash<String, Boolean>] :dense_boolean_map
    #   @option params [Hash<String, String>] :dense_string_map
    #   @option params [Hash<String, Integer>] :sparse_number_map
    #   @option params [Hash<String, Boolean>] :sparse_boolean_map
    #   @option params [Hash<String, String>] :sparse_string_map
    #   @option params [Hash<String, Array<String>>] :dense_set_map
    #   @option params [Hash<String, Array<String>>] :sparse_set_map
    # @!attribute dense_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute sparse_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute dense_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute dense_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute dense_string_map
    #   @return [Hash<String, String>]
    # @!attribute sparse_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute sparse_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    # @!attribute dense_set_map
    #   @return [Hash<String, Array<String>>]
    # @!attribute sparse_set_map
    #   @return [Hash<String, Array<String>>]
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, GreetingStruct>] :dense_struct_map
    #   @option params [Hash<String, GreetingStruct>] :sparse_struct_map
    #   @option params [Hash<String, Integer>] :dense_number_map
    #   @option params [Hash<String, Boolean>] :dense_boolean_map
    #   @option params [Hash<String, String>] :dense_string_map
    #   @option params [Hash<String, Integer>] :sparse_number_map
    #   @option params [Hash<String, Boolean>] :sparse_boolean_map
    #   @option params [Hash<String, String>] :sparse_string_map
    #   @option params [Hash<String, Array<String>>] :dense_set_map
    #   @option params [Hash<String, Array<String>>] :sparse_set_map
    # @!attribute dense_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute sparse_struct_map
    #   @return [Hash<String, GreetingStruct>]
    # @!attribute dense_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute dense_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute dense_string_map
    #   @return [Hash<String, String>]
    # @!attribute sparse_number_map
    #   @return [Hash<String, Integer>]
    # @!attribute sparse_boolean_map
    #   @return [Hash<String, Boolean>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    # @!attribute dense_set_map
    #   @return [Hash<String, Array<String>>]
    # @!attribute sparse_set_map
    #   @return [Hash<String, Array<String>>]
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
    #   @option params [String] :blob
    #   @option params [Boolean] :boolean
    #   @option params [Float] :double
    #   @option params [EmptyStruct] :empty_struct
    #   @option params [Float] :float
    #   @option params [Time] :httpdate_timestamp
    #   @option params [Integer] :integer
    #   @option params [Time] :iso8601_timestamp
    #   @option params [String] :json_value
    #   @option params [Array<Array<String>>] :list_of_lists
    #   @option params [Array<Hash<String, String>>] :list_of_maps_of_strings
    #   @option params [Array<String>] :list_of_strings
    #   @option params [Array<SimpleStruct>] :list_of_structs
    #   @option params [Integer] :long
    #   @option params [Hash<String, Array<String>>] :map_of_lists_of_strings
    #   @option params [Hash<String, Hash<String, String>>] :map_of_maps
    #   @option params [Hash<String, String>] :map_of_strings
    #   @option params [Hash<String, SimpleStruct>] :map_of_structs
    #   @option params [Array<KitchenSink>] :recursive_list
    #   @option params [Hash<String, KitchenSink>] :recursive_map
    #   @option params [KitchenSink] :recursive_struct
    #   @option params [SimpleStruct] :simple_struct
    #   @option params [String] :string
    #   @option params [StructWithLocationName] :struct_with_location_name
    #   @option params [Time] :timestamp
    #   @option params [Time] :unix_timestamp
    # @!attribute blob
    #   @return [String]
    # @!attribute boolean
    #   @return [Boolean]
    # @!attribute double
    #   @return [Float]
    # @!attribute empty_struct
    #   @return [EmptyStruct]
    # @!attribute float
    #   @return [Float]
    # @!attribute httpdate_timestamp
    #   @return [Time]
    # @!attribute integer
    #   @return [Integer]
    # @!attribute iso8601_timestamp
    #   @return [Time]
    # @!attribute json_value
    #   @return [String]
    # @!attribute list_of_lists
    #   @return [Array<Array<String>>]
    # @!attribute list_of_maps_of_strings
    #   @return [Array<Hash<String, String>>]
    # @!attribute list_of_strings
    #   @return [Array<String>]
    # @!attribute list_of_structs
    #   @return [Array<SimpleStruct>]
    # @!attribute long
    #   @return [Integer]
    # @!attribute map_of_lists_of_strings
    #   @return [Hash<String, Array<String>>]
    # @!attribute map_of_maps
    #   @return [Hash<String, Hash<String, String>>]
    # @!attribute map_of_strings
    #   @return [Hash<String, String>]
    # @!attribute map_of_structs
    #   @return [Hash<String, SimpleStruct>]
    # @!attribute recursive_list
    #   @return [Array<KitchenSink>]
    # @!attribute recursive_map
    #   @return [Hash<String, KitchenSink>]
    # @!attribute recursive_struct
    #   @return [KitchenSink]
    # @!attribute simple_struct
    #   @return [SimpleStruct]
    # @!attribute string
    #   @return [String]
    # @!attribute struct_with_location_name
    #   @return [StructWithLocationName]
    # @!attribute timestamp
    #   @return [Time]
    # @!attribute unix_timestamp
    #   @return [Time]
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :blob
    #   @option params [Boolean] :boolean
    #   @option params [Float] :double
    #   @option params [EmptyStruct] :empty_struct
    #   @option params [Float] :float
    #   @option params [Time] :httpdate_timestamp
    #   @option params [Integer] :integer
    #   @option params [Time] :iso8601_timestamp
    #   @option params [String] :json_value
    #   @option params [Array<Array<String>>] :list_of_lists
    #   @option params [Array<Hash<String, String>>] :list_of_maps_of_strings
    #   @option params [Array<String>] :list_of_strings
    #   @option params [Array<SimpleStruct>] :list_of_structs
    #   @option params [Integer] :long
    #   @option params [Hash<String, Array<String>>] :map_of_lists_of_strings
    #   @option params [Hash<String, Hash<String, String>>] :map_of_maps
    #   @option params [Hash<String, String>] :map_of_strings
    #   @option params [Hash<String, SimpleStruct>] :map_of_structs
    #   @option params [Array<KitchenSink>] :recursive_list
    #   @option params [Hash<String, KitchenSink>] :recursive_map
    #   @option params [KitchenSink] :recursive_struct
    #   @option params [SimpleStruct] :simple_struct
    #   @option params [String] :string
    #   @option params [StructWithLocationName] :struct_with_location_name
    #   @option params [Time] :timestamp
    #   @option params [Time] :unix_timestamp
    # @!attribute blob
    #   @return [String]
    # @!attribute boolean
    #   @return [Boolean]
    # @!attribute double
    #   @return [Float]
    # @!attribute empty_struct
    #   @return [EmptyStruct]
    # @!attribute float
    #   @return [Float]
    # @!attribute httpdate_timestamp
    #   @return [Time]
    # @!attribute integer
    #   @return [Integer]
    # @!attribute iso8601_timestamp
    #   @return [Time]
    # @!attribute json_value
    #   @return [String]
    # @!attribute list_of_lists
    #   @return [Array<Array<String>>]
    # @!attribute list_of_maps_of_strings
    #   @return [Array<Hash<String, String>>]
    # @!attribute list_of_strings
    #   @return [Array<String>]
    # @!attribute list_of_structs
    #   @return [Array<SimpleStruct>]
    # @!attribute long
    #   @return [Integer]
    # @!attribute map_of_lists_of_strings
    #   @return [Hash<String, Array<String>>]
    # @!attribute map_of_maps
    #   @return [Hash<String, Hash<String, String>>]
    # @!attribute map_of_strings
    #   @return [Hash<String, String>]
    # @!attribute map_of_structs
    #   @return [Hash<String, SimpleStruct>]
    # @!attribute recursive_list
    #   @return [Array<KitchenSink>]
    # @!attribute recursive_map
    #   @return [Hash<String, KitchenSink>]
    # @!attribute recursive_struct
    #   @return [KitchenSink]
    # @!attribute simple_struct
    #   @return [SimpleStruct]
    # @!attribute string
    #   @return [String]
    # @!attribute struct_with_location_name
    #   @return [StructWithLocationName]
    # @!attribute timestamp
    #   @return [Time]
    # @!attribute unix_timestamp
    #   @return [Time]
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :blob
    #   @option params [Boolean] :boolean
    #   @option params [Float] :double
    #   @option params [EmptyStruct] :empty_struct
    #   @option params [Float] :float
    #   @option params [Time] :httpdate_timestamp
    #   @option params [Integer] :integer
    #   @option params [Time] :iso8601_timestamp
    #   @option params [String] :json_value
    #   @option params [Array<Array<String>>] :list_of_lists
    #   @option params [Array<Hash<String, String>>] :list_of_maps_of_strings
    #   @option params [Array<String>] :list_of_strings
    #   @option params [Array<SimpleStruct>] :list_of_structs
    #   @option params [Integer] :long
    #   @option params [Hash<String, Array<String>>] :map_of_lists_of_strings
    #   @option params [Hash<String, Hash<String, String>>] :map_of_maps
    #   @option params [Hash<String, String>] :map_of_strings
    #   @option params [Hash<String, SimpleStruct>] :map_of_structs
    #   @option params [Array<KitchenSink>] :recursive_list
    #   @option params [Hash<String, KitchenSink>] :recursive_map
    #   @option params [KitchenSink] :recursive_struct
    #   @option params [SimpleStruct] :simple_struct
    #   @option params [String] :string
    #   @option params [StructWithLocationName] :struct_with_location_name
    #   @option params [Time] :timestamp
    #   @option params [Time] :unix_timestamp
    # @!attribute blob
    #   @return [String]
    # @!attribute boolean
    #   @return [Boolean]
    # @!attribute double
    #   @return [Float]
    # @!attribute empty_struct
    #   @return [EmptyStruct]
    # @!attribute float
    #   @return [Float]
    # @!attribute httpdate_timestamp
    #   @return [Time]
    # @!attribute integer
    #   @return [Integer]
    # @!attribute iso8601_timestamp
    #   @return [Time]
    # @!attribute json_value
    #   @return [String]
    # @!attribute list_of_lists
    #   @return [Array<Array<String>>]
    # @!attribute list_of_maps_of_strings
    #   @return [Array<Hash<String, String>>]
    # @!attribute list_of_strings
    #   @return [Array<String>]
    # @!attribute list_of_structs
    #   @return [Array<SimpleStruct>]
    # @!attribute long
    #   @return [Integer]
    # @!attribute map_of_lists_of_strings
    #   @return [Hash<String, Array<String>>]
    # @!attribute map_of_maps
    #   @return [Hash<String, Hash<String, String>>]
    # @!attribute map_of_strings
    #   @return [Hash<String, String>]
    # @!attribute map_of_structs
    #   @return [Hash<String, SimpleStruct>]
    # @!attribute recursive_list
    #   @return [Array<KitchenSink>]
    # @!attribute recursive_map
    #   @return [Hash<String, KitchenSink>]
    # @!attribute recursive_struct
    #   @return [KitchenSink]
    # @!attribute simple_struct
    #   @return [SimpleStruct]
    # @!attribute string
    #   @return [String]
    # @!attribute struct_with_location_name
    #   @return [StructWithLocationName]
    # @!attribute timestamp
    #   @return [Time]
    # @!attribute unix_timestamp
    #   @return [Time]
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
    #   @option params [SimpleStruct] :simple_struct
    # @!attribute simple_struct
    #   @return [SimpleStruct]
    NestedAttributesOperationInput = ::Struct.new(
      :simple_struct,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    NestedAttributesOperationOutput = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
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
    #   @option params [String] :string
    #   @option params [Array<String>] :sparse_string_list
    #   @option params [Hash<String, String>] :sparse_string_map
    # @!attribute string
    #   @return [String]
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    NullOperationInput = ::Struct.new(
      :string,
      :sparse_string_list,
      :sparse_string_map,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string
    #   @option params [Array<String>] :sparse_string_list
    #   @option params [Hash<String, String>] :sparse_string_map
    # @!attribute string
    #   @return [String]
    # @!attribute sparse_string_list
    #   @return [Array<String>]
    # @!attribute sparse_string_map
    #   @return [Hash<String, String>]
    NullOperationOutput = ::Struct.new(
      :string,
      :sparse_string_list,
      :sparse_string_map,
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
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    OperationWithOptionalInputOutputInput = ::Struct.new(
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
    OperationWithOptionalInputOutputOutput = ::Struct.new(
      :value,
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
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    SimpleStruct = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :output
    # @!attribute output
    #   @return [String]
    StreamingOperationInput = ::Struct.new(
      :output,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :output
    # @!attribute output
    #   @return [String]
    StreamingOperationOutput = ::Struct.new(
      :output,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    StructWithLocationName = ::Struct.new(
      :value,
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :member___123foo
    # @!attribute member___123foo
    #   @return [String]
    Struct____456efg = ::Struct.new(
      :member___123foo,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :member___123abc
    #   @option params [Struct____456efg] :member
    # @!attribute member___123abc
    #   @return [String]
    # @!attribute member
    #   @return [Struct____456efg]
    Struct____789BadNameInput = ::Struct.new(
      :member___123abc,
      :member,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Struct____456efg] :member
    # @!attribute member
    #   @return [Struct____456efg]
    Struct____789BadNameOutput = ::Struct.new(
      :member,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
