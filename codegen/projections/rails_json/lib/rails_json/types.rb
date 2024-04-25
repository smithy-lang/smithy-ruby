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
    EndpointInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    EndpointOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Enum constants for ShapeType
    module ShapeType
      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      STRING = "string"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BOOLEAN = "boolean"

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
      DATE_TIME = "date-time"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      EPOCH_SECONDS = "epoch-seconds"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SERVER = "server"

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
      US_WEST_2 = "us-west-2"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      REQUESTER = "requester"

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
      REQUEST = "request"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      RESPONSE = "response"

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
      UPDATE = "update"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ADD = "add"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      REMOVE = "remove"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      PRESENCE = "presence"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ANY = "any"

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
      URL = "url"

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
      HEADER = "header"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      QUERY = "query"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      V = "enumvalue"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      V = "enumvalue"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      NOTE = "NOTE"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      WARNING = "WARNING"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      DANGER = "DANGER"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ERROR = "ERROR"

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
      MEMBER = "member"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      TARGET = "target"

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
    end

    # Enum constants for EnumTraitString
    module EnumTraitString
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TimestampFormat
    module TimestampFormat
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for Data
    module Data
      # Designates the target as containing data of a known classification level.
      STRING = "string"

      # Designates the target as containing data of a known classification level.
      BOOLEAN = "boolean"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      GHI = "ghi"

      # Designates the target as containing data of a known classification level.
      DATE_TIME = "date-time"

      # Designates the target as containing data of a known classification level.
      EPOCH_SECONDS = "epoch-seconds"

      # Designates the target as containing data of a known classification level.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Designates the target as containing data of a known classification level.
      SERVER = "server"

      # Designates the target as containing data of a known classification level.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Designates the target as containing data of a known classification level.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Designates the target as containing data of a known classification level.
      REQUESTER = "requester"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      GHI = "ghi"

      # Designates the target as containing data of a known classification level.
      JKL = "jkl"

      # Designates the target as containing data of a known classification level.
      AUTO = "auto"

      # Designates the target as containing data of a known classification level.
      PATH = "path"

      # Designates the target as containing data of a known classification level.
      VIRTUAL = "virtual"

      # Designates the target as containing data of a known classification level.
      STRING_EQUALS = "stringEquals"

      # Designates the target as containing data of a known classification level.
      BOOLEAN_EQUALS = "booleanEquals"

      # Designates the target as containing data of a known classification level.
      ALL_STRING_EQUALS = "allStringEquals"

      # Designates the target as containing data of a known classification level.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Designates the target as containing data of a known classification level.
      REQUEST = "request"

      # Designates the target as containing data of a known classification level.
      RESPONSE = "response"

      # Designates the target as containing data of a known classification level.
      SUCCESS = "success"

      # Designates the target as containing data of a known classification level.
      FAILURE = "failure"

      # Designates the target as containing data of a known classification level.
      RETRY = "retry"

      # Designates the target as containing data of a known classification level.
      CRC32_C = "CRC32C"

      # Designates the target as containing data of a known classification level.
      CRC32 = "CRC32"

      # Designates the target as containing data of a known classification level.
      SHA1 = "SHA1"

      # Designates the target as containing data of a known classification level.
      SHA256 = "SHA256"

      # Designates the target as containing data of a known classification level.
      REGIONAL = "REGIONAL"

      # Designates the target as containing data of a known classification level.
      EDGE = "EDGE"

      # Designates the target as containing data of a known classification level.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Designates the target as containing data of a known classification level.
      BAR = "BAR"

      # Designates the target as containing data of a known classification level.
      BAZ = "BAZ"

      # Designates the target as containing data of a known classification level.
      UPDATE = "update"

      # Designates the target as containing data of a known classification level.
      ADD = "add"

      # Designates the target as containing data of a known classification level.
      REMOVE = "remove"

      # Designates the target as containing data of a known classification level.
      PRESENCE = "presence"

      # Designates the target as containing data of a known classification level.
      ANY = "any"

      # Designates the target as containing data of a known classification level.
      HEADER = "HEADER"

      # Designates the target as containing data of a known classification level.
      AUTHORIZER = "AUTHORIZER"

      # Designates the target as containing data of a known classification level.
      URL = "url"

      # Designates the target as containing data of a known classification level.
      CLIENT = "client"

      # Designates the target as containing data of a known classification level.
      SERVER = "server"

      # Designates the target as containing data of a known classification level.
      HEADER = "header"

      # Designates the target as containing data of a known classification level.
      QUERY = "query"

      # Designates the target as containing data of a known classification level.
      V = "enumvalue"

      # Designates the target as containing data of a known classification level.
      V = "enumvalue"

      # Designates the target as containing data of a known classification level.
      NOTE = "NOTE"

      # Designates the target as containing data of a known classification level.
      WARNING = "WARNING"

      # Designates the target as containing data of a known classification level.
      DANGER = "DANGER"

      # Designates the target as containing data of a known classification level.
      ERROR = "ERROR"

      # Designates the target as containing data of a known classification level.
      LEGACY = "legacy"

      # Designates the target as containing data of a known classification level.
      STANDARD = "standard"

      # Designates the target as containing data of a known classification level.
      ADAPTIVE = "adaptive"

      # Designates the target as containing data of a known classification level.
      MEMBER = "member"

      # Designates the target as containing data of a known classification level.
      TARGET = "target"

      # Designates the target as containing data of a known classification level.
      FOO = "FOO"

      # Designates the target as containing data of a known classification level.
      BAR = "BAR"

      # Designates the target as containing data of a known classification level.
      BAZ = "BAZ"

      # Designates the target as containing data of a known classification level.
      V = "enumvalue"
    end

    # Enum constants for Error
    module Error
      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STRING = "string"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BOOLEAN = "boolean"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ABC = "abc"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEF = "def"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      GHI = "ghi"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DATE_TIME = "date-time"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      EPOCH_SECONDS = "epoch-seconds"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      HTTP_DATE = "http-date"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CUSTOMER_CONTENT = "content"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SERVICE_ATTRIBUTES = "usage"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      TAG_DATA = "tagging"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PERMISSIONS_DATA = "permissions"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CLIENT = "client"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SERVER = "server"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ALGORITHM = "Algorithm"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STANDARD = "STANDARD"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      GLACIER = "GLACIER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STANDARD_IA = "STANDARD_IA"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ONEZONE_IA = "ONEZONE_IA"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      OUTPOSTS = "OUTPOSTS"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      US_WEST_2 = "us-west-2"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REQUESTER = "requester"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ABC = "abc"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEF = "def"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ABC = "abc"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEF = "def"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      GHI = "ghi"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      JKL = "jkl"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      AUTO = "auto"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PATH = "path"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      VIRTUAL = "virtual"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STRING_EQUALS = "stringEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BOOLEAN_EQUALS = "booleanEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ALL_STRING_EQUALS = "allStringEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REQUEST = "request"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      RESPONSE = "response"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SUCCESS = "success"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FAILURE = "failure"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      RETRY = "retry"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CRC32_C = "CRC32C"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CRC32 = "CRC32"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SHA1 = "SHA1"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SHA256 = "SHA256"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REGIONAL = "REGIONAL"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      EDGE = "EDGE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PRIVATE = "PRIVATE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FOO = "Foo"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAZ = "Baz"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAR = "Bar"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ONE = "1"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ZERO = "0"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FOO = "FOO"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAR = "BAR"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAZ = "BAZ"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      UPDATE = "update"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ADD = "add"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REMOVE = "remove"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PRESENCE = "presence"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ANY = "any"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      HEADER = "HEADER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      AUTHORIZER = "AUTHORIZER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      URL = "url"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CLIENT = "client"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SERVER = "server"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      HEADER = "header"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      QUERY = "query"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      V = "enumvalue"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      V = "enumvalue"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      NOTE = "NOTE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      WARNING = "WARNING"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DANGER = "DANGER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ERROR = "ERROR"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      LEGACY = "legacy"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STANDARD = "standard"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ADAPTIVE = "adaptive"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      MEMBER = "member"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      TARGET = "target"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FOO = "FOO"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAR = "BAR"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAZ = "BAZ"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      V = "enumvalue"
    end

    # Enum constants for DetailsAttributes
    module DetailsAttributes
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for ObjectStorageClass
    module ObjectStorageClass
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for BucketLocationConstraint
    module BucketLocationConstraint
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RequestPayer
    module RequestPayer
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RecursiveEnumString
    module RecursiveEnumString
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for EnumString
    module EnumString
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for S3AddressingStyle
    module S3AddressingStyle
      # Controls the S3 addressing bucket style.
      STRING = "string"

      # Controls the S3 addressing bucket style.
      BOOLEAN = "boolean"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      GHI = "ghi"

      # Controls the S3 addressing bucket style.
      DATE_TIME = "date-time"

      # Controls the S3 addressing bucket style.
      EPOCH_SECONDS = "epoch-seconds"

      # Controls the S3 addressing bucket style.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Controls the S3 addressing bucket style.
      SERVER = "server"

      # Controls the S3 addressing bucket style.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Controls the S3 addressing bucket style.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Controls the S3 addressing bucket style.
      REQUESTER = "requester"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      GHI = "ghi"

      # Controls the S3 addressing bucket style.
      JKL = "jkl"

      # Controls the S3 addressing bucket style.
      AUTO = "auto"

      # Controls the S3 addressing bucket style.
      PATH = "path"

      # Controls the S3 addressing bucket style.
      VIRTUAL = "virtual"

      # Controls the S3 addressing bucket style.
      STRING_EQUALS = "stringEquals"

      # Controls the S3 addressing bucket style.
      BOOLEAN_EQUALS = "booleanEquals"

      # Controls the S3 addressing bucket style.
      ALL_STRING_EQUALS = "allStringEquals"

      # Controls the S3 addressing bucket style.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Controls the S3 addressing bucket style.
      REQUEST = "request"

      # Controls the S3 addressing bucket style.
      RESPONSE = "response"

      # Controls the S3 addressing bucket style.
      SUCCESS = "success"

      # Controls the S3 addressing bucket style.
      FAILURE = "failure"

      # Controls the S3 addressing bucket style.
      RETRY = "retry"

      # Controls the S3 addressing bucket style.
      CRC32_C = "CRC32C"

      # Controls the S3 addressing bucket style.
      CRC32 = "CRC32"

      # Controls the S3 addressing bucket style.
      SHA1 = "SHA1"

      # Controls the S3 addressing bucket style.
      SHA256 = "SHA256"

      # Controls the S3 addressing bucket style.
      REGIONAL = "REGIONAL"

      # Controls the S3 addressing bucket style.
      EDGE = "EDGE"

      # Controls the S3 addressing bucket style.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Controls the S3 addressing bucket style.
      BAR = "BAR"

      # Controls the S3 addressing bucket style.
      BAZ = "BAZ"

      # Controls the S3 addressing bucket style.
      UPDATE = "update"

      # Controls the S3 addressing bucket style.
      ADD = "add"

      # Controls the S3 addressing bucket style.
      REMOVE = "remove"

      # Controls the S3 addressing bucket style.
      PRESENCE = "presence"

      # Controls the S3 addressing bucket style.
      ANY = "any"

      # Controls the S3 addressing bucket style.
      HEADER = "HEADER"

      # Controls the S3 addressing bucket style.
      AUTHORIZER = "AUTHORIZER"

      # Controls the S3 addressing bucket style.
      URL = "url"

      # Controls the S3 addressing bucket style.
      CLIENT = "client"

      # Controls the S3 addressing bucket style.
      SERVER = "server"

      # Controls the S3 addressing bucket style.
      HEADER = "header"

      # Controls the S3 addressing bucket style.
      QUERY = "query"

      # Controls the S3 addressing bucket style.
      V = "enumvalue"

      # Controls the S3 addressing bucket style.
      V = "enumvalue"

      # Controls the S3 addressing bucket style.
      NOTE = "NOTE"

      # Controls the S3 addressing bucket style.
      WARNING = "WARNING"

      # Controls the S3 addressing bucket style.
      DANGER = "DANGER"

      # Controls the S3 addressing bucket style.
      ERROR = "ERROR"

      # Controls the S3 addressing bucket style.
      LEGACY = "legacy"

      # Controls the S3 addressing bucket style.
      STANDARD = "standard"

      # Controls the S3 addressing bucket style.
      ADAPTIVE = "adaptive"

      # Controls the S3 addressing bucket style.
      MEMBER = "member"

      # Controls the S3 addressing bucket style.
      TARGET = "target"

      # Controls the S3 addressing bucket style.
      FOO = "FOO"

      # Controls the S3 addressing bucket style.
      BAR = "BAR"

      # Controls the S3 addressing bucket style.
      BAZ = "BAZ"

      # Controls the S3 addressing bucket style.
      V = "enumvalue"
    end

    # Enum constants for PathComparator
    module PathComparator
      # Defines a comparison to perform in a PathMatcher.
      STRING = "string"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN = "boolean"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      GHI = "ghi"

      # Defines a comparison to perform in a PathMatcher.
      DATE_TIME = "date-time"

      # Defines a comparison to perform in a PathMatcher.
      EPOCH_SECONDS = "epoch-seconds"

      # Defines a comparison to perform in a PathMatcher.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

      # Defines a comparison to perform in a PathMatcher.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Defines a comparison to perform in a PathMatcher.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Defines a comparison to perform in a PathMatcher.
      REQUESTER = "requester"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      GHI = "ghi"

      # Defines a comparison to perform in a PathMatcher.
      JKL = "jkl"

      # Defines a comparison to perform in a PathMatcher.
      AUTO = "auto"

      # Defines a comparison to perform in a PathMatcher.
      PATH = "path"

      # Defines a comparison to perform in a PathMatcher.
      VIRTUAL = "virtual"

      # Defines a comparison to perform in a PathMatcher.
      STRING_EQUALS = "stringEquals"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN_EQUALS = "booleanEquals"

      # Defines a comparison to perform in a PathMatcher.
      ALL_STRING_EQUALS = "allStringEquals"

      # Defines a comparison to perform in a PathMatcher.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Defines a comparison to perform in a PathMatcher.
      REQUEST = "request"

      # Defines a comparison to perform in a PathMatcher.
      RESPONSE = "response"

      # Defines a comparison to perform in a PathMatcher.
      SUCCESS = "success"

      # Defines a comparison to perform in a PathMatcher.
      FAILURE = "failure"

      # Defines a comparison to perform in a PathMatcher.
      RETRY = "retry"

      # Defines a comparison to perform in a PathMatcher.
      CRC32_C = "CRC32C"

      # Defines a comparison to perform in a PathMatcher.
      CRC32 = "CRC32"

      # Defines a comparison to perform in a PathMatcher.
      SHA1 = "SHA1"

      # Defines a comparison to perform in a PathMatcher.
      SHA256 = "SHA256"

      # Defines a comparison to perform in a PathMatcher.
      REGIONAL = "REGIONAL"

      # Defines a comparison to perform in a PathMatcher.
      EDGE = "EDGE"

      # Defines a comparison to perform in a PathMatcher.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Defines a comparison to perform in a PathMatcher.
      BAR = "BAR"

      # Defines a comparison to perform in a PathMatcher.
      BAZ = "BAZ"

      # Defines a comparison to perform in a PathMatcher.
      UPDATE = "update"

      # Defines a comparison to perform in a PathMatcher.
      ADD = "add"

      # Defines a comparison to perform in a PathMatcher.
      REMOVE = "remove"

      # Defines a comparison to perform in a PathMatcher.
      PRESENCE = "presence"

      # Defines a comparison to perform in a PathMatcher.
      ANY = "any"

      # Defines a comparison to perform in a PathMatcher.
      HEADER = "HEADER"

      # Defines a comparison to perform in a PathMatcher.
      AUTHORIZER = "AUTHORIZER"

      # Defines a comparison to perform in a PathMatcher.
      URL = "url"

      # Defines a comparison to perform in a PathMatcher.
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

      # Defines a comparison to perform in a PathMatcher.
      HEADER = "header"

      # Defines a comparison to perform in a PathMatcher.
      QUERY = "query"

      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"

      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"

      # Defines a comparison to perform in a PathMatcher.
      NOTE = "NOTE"

      # Defines a comparison to perform in a PathMatcher.
      WARNING = "WARNING"

      # Defines a comparison to perform in a PathMatcher.
      DANGER = "DANGER"

      # Defines a comparison to perform in a PathMatcher.
      ERROR = "ERROR"

      # Defines a comparison to perform in a PathMatcher.
      LEGACY = "legacy"

      # Defines a comparison to perform in a PathMatcher.
      STANDARD = "standard"

      # Defines a comparison to perform in a PathMatcher.
      ADAPTIVE = "adaptive"

      # Defines a comparison to perform in a PathMatcher.
      MEMBER = "member"

      # Defines a comparison to perform in a PathMatcher.
      TARGET = "target"

      # Defines a comparison to perform in a PathMatcher.
      FOO = "FOO"

      # Defines a comparison to perform in a PathMatcher.
      BAR = "BAR"

      # Defines a comparison to perform in a PathMatcher.
      BAZ = "BAZ"

      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"
    end

    # Enum constants for TestType
    module TestType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for AcceptorState
    module AcceptorState
      # The transition state of a waiter.
      STRING = "string"

      # The transition state of a waiter.
      BOOLEAN = "boolean"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      GHI = "ghi"

      # The transition state of a waiter.
      DATE_TIME = "date-time"

      # The transition state of a waiter.
      EPOCH_SECONDS = "epoch-seconds"

      # The transition state of a waiter.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

      # The transition state of a waiter.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # The transition state of a waiter.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # The transition state of a waiter.
      REQUESTER = "requester"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      GHI = "ghi"

      # The transition state of a waiter.
      JKL = "jkl"

      # The transition state of a waiter.
      AUTO = "auto"

      # The transition state of a waiter.
      PATH = "path"

      # The transition state of a waiter.
      VIRTUAL = "virtual"

      # The transition state of a waiter.
      STRING_EQUALS = "stringEquals"

      # The transition state of a waiter.
      BOOLEAN_EQUALS = "booleanEquals"

      # The transition state of a waiter.
      ALL_STRING_EQUALS = "allStringEquals"

      # The transition state of a waiter.
      ANY_STRING_EQUALS = "anyStringEquals"

      # The transition state of a waiter.
      REQUEST = "request"

      # The transition state of a waiter.
      RESPONSE = "response"

      # The transition state of a waiter.
      SUCCESS = "success"

      # The transition state of a waiter.
      FAILURE = "failure"

      # The transition state of a waiter.
      RETRY = "retry"

      # The transition state of a waiter.
      CRC32_C = "CRC32C"

      # The transition state of a waiter.
      CRC32 = "CRC32"

      # The transition state of a waiter.
      SHA1 = "SHA1"

      # The transition state of a waiter.
      SHA256 = "SHA256"

      # The transition state of a waiter.
      REGIONAL = "REGIONAL"

      # The transition state of a waiter.
      EDGE = "EDGE"

      # The transition state of a waiter.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # The transition state of a waiter.
      BAR = "BAR"

      # The transition state of a waiter.
      BAZ = "BAZ"

      # The transition state of a waiter.
      UPDATE = "update"

      # The transition state of a waiter.
      ADD = "add"

      # The transition state of a waiter.
      REMOVE = "remove"

      # The transition state of a waiter.
      PRESENCE = "presence"

      # The transition state of a waiter.
      ANY = "any"

      # The transition state of a waiter.
      HEADER = "HEADER"

      # The transition state of a waiter.
      AUTHORIZER = "AUTHORIZER"

      # The transition state of a waiter.
      URL = "url"

      # The transition state of a waiter.
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

      # The transition state of a waiter.
      HEADER = "header"

      # The transition state of a waiter.
      QUERY = "query"

      # The transition state of a waiter.
      V = "enumvalue"

      # The transition state of a waiter.
      V = "enumvalue"

      # The transition state of a waiter.
      NOTE = "NOTE"

      # The transition state of a waiter.
      WARNING = "WARNING"

      # The transition state of a waiter.
      DANGER = "DANGER"

      # The transition state of a waiter.
      ERROR = "ERROR"

      # The transition state of a waiter.
      LEGACY = "legacy"

      # The transition state of a waiter.
      STANDARD = "standard"

      # The transition state of a waiter.
      ADAPTIVE = "adaptive"

      # The transition state of a waiter.
      MEMBER = "member"

      # The transition state of a waiter.
      TARGET = "target"

      # The transition state of a waiter.
      FOO = "FOO"

      # The transition state of a waiter.
      BAR = "BAR"

      # The transition state of a waiter.
      BAZ = "BAZ"

      # The transition state of a waiter.
      V = "enumvalue"
    end

    # Enum constants for ChecksumAlgorithm
    module ChecksumAlgorithm
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for EndpointType
    module EndpointType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for FooEnum
    module FooEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RequiredEnum
    module RequiredEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TraitChangeType
    module TraitChangeType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for ApiKeySourceType
    module ApiKeySourceType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for EncodingType
    module EncodingType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for AppliesTo
    module AppliesTo
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for HttpApiKeyLocations
    module HttpApiKeyLocations
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for StringEnum
    module StringEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for StringEnum
    module StringEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TraitChangeSeverity
    module TraitChangeSeverity
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RetryMode
    module RetryMode
      # Controls the strategy used for retries.
      STRING = "string"

      # Controls the strategy used for retries.
      BOOLEAN = "boolean"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      GHI = "ghi"

      # Controls the strategy used for retries.
      DATE_TIME = "date-time"

      # Controls the strategy used for retries.
      EPOCH_SECONDS = "epoch-seconds"

      # Controls the strategy used for retries.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Controls the strategy used for retries.
      SERVER = "server"

      # Controls the strategy used for retries.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Controls the strategy used for retries.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Controls the strategy used for retries.
      REQUESTER = "requester"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      GHI = "ghi"

      # Controls the strategy used for retries.
      JKL = "jkl"

      # Controls the strategy used for retries.
      AUTO = "auto"

      # Controls the strategy used for retries.
      PATH = "path"

      # Controls the strategy used for retries.
      VIRTUAL = "virtual"

      # Controls the strategy used for retries.
      STRING_EQUALS = "stringEquals"

      # Controls the strategy used for retries.
      BOOLEAN_EQUALS = "booleanEquals"

      # Controls the strategy used for retries.
      ALL_STRING_EQUALS = "allStringEquals"

      # Controls the strategy used for retries.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Controls the strategy used for retries.
      REQUEST = "request"

      # Controls the strategy used for retries.
      RESPONSE = "response"

      # Controls the strategy used for retries.
      SUCCESS = "success"

      # Controls the strategy used for retries.
      FAILURE = "failure"

      # Controls the strategy used for retries.
      RETRY = "retry"

      # Controls the strategy used for retries.
      CRC32_C = "CRC32C"

      # Controls the strategy used for retries.
      CRC32 = "CRC32"

      # Controls the strategy used for retries.
      SHA1 = "SHA1"

      # Controls the strategy used for retries.
      SHA256 = "SHA256"

      # Controls the strategy used for retries.
      REGIONAL = "REGIONAL"

      # Controls the strategy used for retries.
      EDGE = "EDGE"

      # Controls the strategy used for retries.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Controls the strategy used for retries.
      BAR = "BAR"

      # Controls the strategy used for retries.
      BAZ = "BAZ"

      # Controls the strategy used for retries.
      UPDATE = "update"

      # Controls the strategy used for retries.
      ADD = "add"

      # Controls the strategy used for retries.
      REMOVE = "remove"

      # Controls the strategy used for retries.
      PRESENCE = "presence"

      # Controls the strategy used for retries.
      ANY = "any"

      # Controls the strategy used for retries.
      HEADER = "HEADER"

      # Controls the strategy used for retries.
      AUTHORIZER = "AUTHORIZER"

      # Controls the strategy used for retries.
      URL = "url"

      # Controls the strategy used for retries.
      CLIENT = "client"

      # Controls the strategy used for retries.
      SERVER = "server"

      # Controls the strategy used for retries.
      HEADER = "header"

      # Controls the strategy used for retries.
      QUERY = "query"

      # Controls the strategy used for retries.
      V = "enumvalue"

      # Controls the strategy used for retries.
      V = "enumvalue"

      # Controls the strategy used for retries.
      NOTE = "NOTE"

      # Controls the strategy used for retries.
      WARNING = "WARNING"

      # Controls the strategy used for retries.
      DANGER = "DANGER"

      # Controls the strategy used for retries.
      ERROR = "ERROR"

      # Controls the strategy used for retries.
      LEGACY = "legacy"

      # Controls the strategy used for retries.
      STANDARD = "standard"

      # Controls the strategy used for retries.
      ADAPTIVE = "adaptive"

      # Controls the strategy used for retries.
      MEMBER = "member"

      # Controls the strategy used for retries.
      TARGET = "target"

      # Controls the strategy used for retries.
      FOO = "FOO"

      # Controls the strategy used for retries.
      BAR = "BAR"

      # Controls the strategy used for retries.
      BAZ = "BAZ"

      # Controls the strategy used for retries.
      V = "enumvalue"
    end

    # Enum constants for StructurallyExclusive
    module StructurallyExclusive
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TestEnum
    module TestEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for StringEnum
    module StringEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
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
    #   @option params [String] :label
    # @!attribute label
    #   @return [String]
    HostLabelEndpointInput = ::Struct.new(
      :label,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HostLabelEndpointOutput = ::Struct.new(
      nil,
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

    # Enum constants for ShapeType
    module ShapeType
      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      STRING = "string"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BOOLEAN = "boolean"

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
      DATE_TIME = "date-time"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      EPOCH_SECONDS = "epoch-seconds"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SERVER = "server"

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
      US_WEST_2 = "us-west-2"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      REQUESTER = "requester"

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
      REQUEST = "request"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      RESPONSE = "response"

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
      UPDATE = "update"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ADD = "add"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      REMOVE = "remove"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      PRESENCE = "presence"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ANY = "any"

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
      URL = "url"

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
      HEADER = "header"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      QUERY = "query"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      V = "enumvalue"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      V = "enumvalue"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      NOTE = "NOTE"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      WARNING = "WARNING"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      DANGER = "DANGER"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      ERROR = "ERROR"

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
      MEMBER = "member"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      TARGET = "target"

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
    end

    # Enum constants for EnumTraitString
    module EnumTraitString
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TimestampFormat
    module TimestampFormat
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for Data
    module Data
      # Designates the target as containing data of a known classification level.
      STRING = "string"

      # Designates the target as containing data of a known classification level.
      BOOLEAN = "boolean"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      GHI = "ghi"

      # Designates the target as containing data of a known classification level.
      DATE_TIME = "date-time"

      # Designates the target as containing data of a known classification level.
      EPOCH_SECONDS = "epoch-seconds"

      # Designates the target as containing data of a known classification level.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Designates the target as containing data of a known classification level.
      SERVER = "server"

      # Designates the target as containing data of a known classification level.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Designates the target as containing data of a known classification level.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Designates the target as containing data of a known classification level.
      REQUESTER = "requester"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      ABC = "abc"

      # Designates the target as containing data of a known classification level.
      DEF = "def"

      # Designates the target as containing data of a known classification level.
      GHI = "ghi"

      # Designates the target as containing data of a known classification level.
      JKL = "jkl"

      # Designates the target as containing data of a known classification level.
      AUTO = "auto"

      # Designates the target as containing data of a known classification level.
      PATH = "path"

      # Designates the target as containing data of a known classification level.
      VIRTUAL = "virtual"

      # Designates the target as containing data of a known classification level.
      STRING_EQUALS = "stringEquals"

      # Designates the target as containing data of a known classification level.
      BOOLEAN_EQUALS = "booleanEquals"

      # Designates the target as containing data of a known classification level.
      ALL_STRING_EQUALS = "allStringEquals"

      # Designates the target as containing data of a known classification level.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Designates the target as containing data of a known classification level.
      REQUEST = "request"

      # Designates the target as containing data of a known classification level.
      RESPONSE = "response"

      # Designates the target as containing data of a known classification level.
      SUCCESS = "success"

      # Designates the target as containing data of a known classification level.
      FAILURE = "failure"

      # Designates the target as containing data of a known classification level.
      RETRY = "retry"

      # Designates the target as containing data of a known classification level.
      CRC32_C = "CRC32C"

      # Designates the target as containing data of a known classification level.
      CRC32 = "CRC32"

      # Designates the target as containing data of a known classification level.
      SHA1 = "SHA1"

      # Designates the target as containing data of a known classification level.
      SHA256 = "SHA256"

      # Designates the target as containing data of a known classification level.
      REGIONAL = "REGIONAL"

      # Designates the target as containing data of a known classification level.
      EDGE = "EDGE"

      # Designates the target as containing data of a known classification level.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Designates the target as containing data of a known classification level.
      BAR = "BAR"

      # Designates the target as containing data of a known classification level.
      BAZ = "BAZ"

      # Designates the target as containing data of a known classification level.
      UPDATE = "update"

      # Designates the target as containing data of a known classification level.
      ADD = "add"

      # Designates the target as containing data of a known classification level.
      REMOVE = "remove"

      # Designates the target as containing data of a known classification level.
      PRESENCE = "presence"

      # Designates the target as containing data of a known classification level.
      ANY = "any"

      # Designates the target as containing data of a known classification level.
      HEADER = "HEADER"

      # Designates the target as containing data of a known classification level.
      AUTHORIZER = "AUTHORIZER"

      # Designates the target as containing data of a known classification level.
      URL = "url"

      # Designates the target as containing data of a known classification level.
      CLIENT = "client"

      # Designates the target as containing data of a known classification level.
      SERVER = "server"

      # Designates the target as containing data of a known classification level.
      HEADER = "header"

      # Designates the target as containing data of a known classification level.
      QUERY = "query"

      # Designates the target as containing data of a known classification level.
      V = "enumvalue"

      # Designates the target as containing data of a known classification level.
      V = "enumvalue"

      # Designates the target as containing data of a known classification level.
      NOTE = "NOTE"

      # Designates the target as containing data of a known classification level.
      WARNING = "WARNING"

      # Designates the target as containing data of a known classification level.
      DANGER = "DANGER"

      # Designates the target as containing data of a known classification level.
      ERROR = "ERROR"

      # Designates the target as containing data of a known classification level.
      LEGACY = "legacy"

      # Designates the target as containing data of a known classification level.
      STANDARD = "standard"

      # Designates the target as containing data of a known classification level.
      ADAPTIVE = "adaptive"

      # Designates the target as containing data of a known classification level.
      MEMBER = "member"

      # Designates the target as containing data of a known classification level.
      TARGET = "target"

      # Designates the target as containing data of a known classification level.
      FOO = "FOO"

      # Designates the target as containing data of a known classification level.
      BAR = "BAR"

      # Designates the target as containing data of a known classification level.
      BAZ = "BAZ"

      # Designates the target as containing data of a known classification level.
      V = "enumvalue"
    end

    # Enum constants for Error
    module Error
      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STRING = "string"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BOOLEAN = "boolean"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ABC = "abc"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEF = "def"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      GHI = "ghi"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DATE_TIME = "date-time"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      EPOCH_SECONDS = "epoch-seconds"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      HTTP_DATE = "http-date"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CUSTOMER_CONTENT = "content"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CUSTOMER_ACCOUNT_INFORMATION = "account"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SERVICE_ATTRIBUTES = "usage"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      TAG_DATA = "tagging"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PERMISSIONS_DATA = "permissions"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CLIENT = "client"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SERVER = "server"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ALGORITHM = "Algorithm"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STANDARD = "STANDARD"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      GLACIER = "GLACIER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STANDARD_IA = "STANDARD_IA"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ONEZONE_IA = "ONEZONE_IA"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      OUTPOSTS = "OUTPOSTS"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      US_WEST_2 = "us-west-2"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REQUESTER = "requester"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ABC = "abc"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEF = "def"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ABC = "abc"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DEF = "def"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      GHI = "ghi"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      JKL = "jkl"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      AUTO = "auto"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PATH = "path"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      VIRTUAL = "virtual"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STRING_EQUALS = "stringEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BOOLEAN_EQUALS = "booleanEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ALL_STRING_EQUALS = "allStringEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REQUEST = "request"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      RESPONSE = "response"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SUCCESS = "success"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FAILURE = "failure"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      RETRY = "retry"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CRC32_C = "CRC32C"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CRC32 = "CRC32"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SHA1 = "SHA1"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SHA256 = "SHA256"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REGIONAL = "REGIONAL"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      EDGE = "EDGE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PRIVATE = "PRIVATE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FOO = "Foo"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAZ = "Baz"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAR = "Bar"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ONE = "1"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ZERO = "0"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FOO = "FOO"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAR = "BAR"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAZ = "BAZ"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      UPDATE = "update"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ADD = "add"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      REMOVE = "remove"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      PRESENCE = "presence"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ANY = "any"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      HEADER = "HEADER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      AUTHORIZER = "AUTHORIZER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      URL = "url"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      CLIENT = "client"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      SERVER = "server"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      HEADER = "header"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      QUERY = "query"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      V = "enumvalue"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      V = "enumvalue"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      NOTE = "NOTE"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      WARNING = "WARNING"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      DANGER = "DANGER"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ERROR = "ERROR"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      LEGACY = "legacy"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      STANDARD = "standard"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      ADAPTIVE = "adaptive"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      MEMBER = "member"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      TARGET = "target"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      FOO = "FOO"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAR = "BAR"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      BAZ = "BAZ"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      V = "enumvalue"
    end

    # Enum constants for DetailsAttributes
    module DetailsAttributes
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for ObjectStorageClass
    module ObjectStorageClass
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for BucketLocationConstraint
    module BucketLocationConstraint
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RequestPayer
    module RequestPayer
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RecursiveEnumString
    module RecursiveEnumString
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for EnumString
    module EnumString
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for S3AddressingStyle
    module S3AddressingStyle
      # Controls the S3 addressing bucket style.
      STRING = "string"

      # Controls the S3 addressing bucket style.
      BOOLEAN = "boolean"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      GHI = "ghi"

      # Controls the S3 addressing bucket style.
      DATE_TIME = "date-time"

      # Controls the S3 addressing bucket style.
      EPOCH_SECONDS = "epoch-seconds"

      # Controls the S3 addressing bucket style.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Controls the S3 addressing bucket style.
      SERVER = "server"

      # Controls the S3 addressing bucket style.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Controls the S3 addressing bucket style.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Controls the S3 addressing bucket style.
      REQUESTER = "requester"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      ABC = "abc"

      # Controls the S3 addressing bucket style.
      DEF = "def"

      # Controls the S3 addressing bucket style.
      GHI = "ghi"

      # Controls the S3 addressing bucket style.
      JKL = "jkl"

      # Controls the S3 addressing bucket style.
      AUTO = "auto"

      # Controls the S3 addressing bucket style.
      PATH = "path"

      # Controls the S3 addressing bucket style.
      VIRTUAL = "virtual"

      # Controls the S3 addressing bucket style.
      STRING_EQUALS = "stringEquals"

      # Controls the S3 addressing bucket style.
      BOOLEAN_EQUALS = "booleanEquals"

      # Controls the S3 addressing bucket style.
      ALL_STRING_EQUALS = "allStringEquals"

      # Controls the S3 addressing bucket style.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Controls the S3 addressing bucket style.
      REQUEST = "request"

      # Controls the S3 addressing bucket style.
      RESPONSE = "response"

      # Controls the S3 addressing bucket style.
      SUCCESS = "success"

      # Controls the S3 addressing bucket style.
      FAILURE = "failure"

      # Controls the S3 addressing bucket style.
      RETRY = "retry"

      # Controls the S3 addressing bucket style.
      CRC32_C = "CRC32C"

      # Controls the S3 addressing bucket style.
      CRC32 = "CRC32"

      # Controls the S3 addressing bucket style.
      SHA1 = "SHA1"

      # Controls the S3 addressing bucket style.
      SHA256 = "SHA256"

      # Controls the S3 addressing bucket style.
      REGIONAL = "REGIONAL"

      # Controls the S3 addressing bucket style.
      EDGE = "EDGE"

      # Controls the S3 addressing bucket style.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Controls the S3 addressing bucket style.
      BAR = "BAR"

      # Controls the S3 addressing bucket style.
      BAZ = "BAZ"

      # Controls the S3 addressing bucket style.
      UPDATE = "update"

      # Controls the S3 addressing bucket style.
      ADD = "add"

      # Controls the S3 addressing bucket style.
      REMOVE = "remove"

      # Controls the S3 addressing bucket style.
      PRESENCE = "presence"

      # Controls the S3 addressing bucket style.
      ANY = "any"

      # Controls the S3 addressing bucket style.
      HEADER = "HEADER"

      # Controls the S3 addressing bucket style.
      AUTHORIZER = "AUTHORIZER"

      # Controls the S3 addressing bucket style.
      URL = "url"

      # Controls the S3 addressing bucket style.
      CLIENT = "client"

      # Controls the S3 addressing bucket style.
      SERVER = "server"

      # Controls the S3 addressing bucket style.
      HEADER = "header"

      # Controls the S3 addressing bucket style.
      QUERY = "query"

      # Controls the S3 addressing bucket style.
      V = "enumvalue"

      # Controls the S3 addressing bucket style.
      V = "enumvalue"

      # Controls the S3 addressing bucket style.
      NOTE = "NOTE"

      # Controls the S3 addressing bucket style.
      WARNING = "WARNING"

      # Controls the S3 addressing bucket style.
      DANGER = "DANGER"

      # Controls the S3 addressing bucket style.
      ERROR = "ERROR"

      # Controls the S3 addressing bucket style.
      LEGACY = "legacy"

      # Controls the S3 addressing bucket style.
      STANDARD = "standard"

      # Controls the S3 addressing bucket style.
      ADAPTIVE = "adaptive"

      # Controls the S3 addressing bucket style.
      MEMBER = "member"

      # Controls the S3 addressing bucket style.
      TARGET = "target"

      # Controls the S3 addressing bucket style.
      FOO = "FOO"

      # Controls the S3 addressing bucket style.
      BAR = "BAR"

      # Controls the S3 addressing bucket style.
      BAZ = "BAZ"

      # Controls the S3 addressing bucket style.
      V = "enumvalue"
    end

    # Enum constants for PathComparator
    module PathComparator
      # Defines a comparison to perform in a PathMatcher.
      STRING = "string"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN = "boolean"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      GHI = "ghi"

      # Defines a comparison to perform in a PathMatcher.
      DATE_TIME = "date-time"

      # Defines a comparison to perform in a PathMatcher.
      EPOCH_SECONDS = "epoch-seconds"

      # Defines a comparison to perform in a PathMatcher.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

      # Defines a comparison to perform in a PathMatcher.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Defines a comparison to perform in a PathMatcher.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Defines a comparison to perform in a PathMatcher.
      REQUESTER = "requester"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      ABC = "abc"

      # Defines a comparison to perform in a PathMatcher.
      DEF = "def"

      # Defines a comparison to perform in a PathMatcher.
      GHI = "ghi"

      # Defines a comparison to perform in a PathMatcher.
      JKL = "jkl"

      # Defines a comparison to perform in a PathMatcher.
      AUTO = "auto"

      # Defines a comparison to perform in a PathMatcher.
      PATH = "path"

      # Defines a comparison to perform in a PathMatcher.
      VIRTUAL = "virtual"

      # Defines a comparison to perform in a PathMatcher.
      STRING_EQUALS = "stringEquals"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN_EQUALS = "booleanEquals"

      # Defines a comparison to perform in a PathMatcher.
      ALL_STRING_EQUALS = "allStringEquals"

      # Defines a comparison to perform in a PathMatcher.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Defines a comparison to perform in a PathMatcher.
      REQUEST = "request"

      # Defines a comparison to perform in a PathMatcher.
      RESPONSE = "response"

      # Defines a comparison to perform in a PathMatcher.
      SUCCESS = "success"

      # Defines a comparison to perform in a PathMatcher.
      FAILURE = "failure"

      # Defines a comparison to perform in a PathMatcher.
      RETRY = "retry"

      # Defines a comparison to perform in a PathMatcher.
      CRC32_C = "CRC32C"

      # Defines a comparison to perform in a PathMatcher.
      CRC32 = "CRC32"

      # Defines a comparison to perform in a PathMatcher.
      SHA1 = "SHA1"

      # Defines a comparison to perform in a PathMatcher.
      SHA256 = "SHA256"

      # Defines a comparison to perform in a PathMatcher.
      REGIONAL = "REGIONAL"

      # Defines a comparison to perform in a PathMatcher.
      EDGE = "EDGE"

      # Defines a comparison to perform in a PathMatcher.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Defines a comparison to perform in a PathMatcher.
      BAR = "BAR"

      # Defines a comparison to perform in a PathMatcher.
      BAZ = "BAZ"

      # Defines a comparison to perform in a PathMatcher.
      UPDATE = "update"

      # Defines a comparison to perform in a PathMatcher.
      ADD = "add"

      # Defines a comparison to perform in a PathMatcher.
      REMOVE = "remove"

      # Defines a comparison to perform in a PathMatcher.
      PRESENCE = "presence"

      # Defines a comparison to perform in a PathMatcher.
      ANY = "any"

      # Defines a comparison to perform in a PathMatcher.
      HEADER = "HEADER"

      # Defines a comparison to perform in a PathMatcher.
      AUTHORIZER = "AUTHORIZER"

      # Defines a comparison to perform in a PathMatcher.
      URL = "url"

      # Defines a comparison to perform in a PathMatcher.
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

      # Defines a comparison to perform in a PathMatcher.
      HEADER = "header"

      # Defines a comparison to perform in a PathMatcher.
      QUERY = "query"

      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"

      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"

      # Defines a comparison to perform in a PathMatcher.
      NOTE = "NOTE"

      # Defines a comparison to perform in a PathMatcher.
      WARNING = "WARNING"

      # Defines a comparison to perform in a PathMatcher.
      DANGER = "DANGER"

      # Defines a comparison to perform in a PathMatcher.
      ERROR = "ERROR"

      # Defines a comparison to perform in a PathMatcher.
      LEGACY = "legacy"

      # Defines a comparison to perform in a PathMatcher.
      STANDARD = "standard"

      # Defines a comparison to perform in a PathMatcher.
      ADAPTIVE = "adaptive"

      # Defines a comparison to perform in a PathMatcher.
      MEMBER = "member"

      # Defines a comparison to perform in a PathMatcher.
      TARGET = "target"

      # Defines a comparison to perform in a PathMatcher.
      FOO = "FOO"

      # Defines a comparison to perform in a PathMatcher.
      BAR = "BAR"

      # Defines a comparison to perform in a PathMatcher.
      BAZ = "BAZ"

      # Defines a comparison to perform in a PathMatcher.
      V = "enumvalue"
    end

    # Enum constants for TestType
    module TestType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for AcceptorState
    module AcceptorState
      # The transition state of a waiter.
      STRING = "string"

      # The transition state of a waiter.
      BOOLEAN = "boolean"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      GHI = "ghi"

      # The transition state of a waiter.
      DATE_TIME = "date-time"

      # The transition state of a waiter.
      EPOCH_SECONDS = "epoch-seconds"

      # The transition state of a waiter.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

      # The transition state of a waiter.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # The transition state of a waiter.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # The transition state of a waiter.
      REQUESTER = "requester"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      ABC = "abc"

      # The transition state of a waiter.
      DEF = "def"

      # The transition state of a waiter.
      GHI = "ghi"

      # The transition state of a waiter.
      JKL = "jkl"

      # The transition state of a waiter.
      AUTO = "auto"

      # The transition state of a waiter.
      PATH = "path"

      # The transition state of a waiter.
      VIRTUAL = "virtual"

      # The transition state of a waiter.
      STRING_EQUALS = "stringEquals"

      # The transition state of a waiter.
      BOOLEAN_EQUALS = "booleanEquals"

      # The transition state of a waiter.
      ALL_STRING_EQUALS = "allStringEquals"

      # The transition state of a waiter.
      ANY_STRING_EQUALS = "anyStringEquals"

      # The transition state of a waiter.
      REQUEST = "request"

      # The transition state of a waiter.
      RESPONSE = "response"

      # The transition state of a waiter.
      SUCCESS = "success"

      # The transition state of a waiter.
      FAILURE = "failure"

      # The transition state of a waiter.
      RETRY = "retry"

      # The transition state of a waiter.
      CRC32_C = "CRC32C"

      # The transition state of a waiter.
      CRC32 = "CRC32"

      # The transition state of a waiter.
      SHA1 = "SHA1"

      # The transition state of a waiter.
      SHA256 = "SHA256"

      # The transition state of a waiter.
      REGIONAL = "REGIONAL"

      # The transition state of a waiter.
      EDGE = "EDGE"

      # The transition state of a waiter.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # The transition state of a waiter.
      BAR = "BAR"

      # The transition state of a waiter.
      BAZ = "BAZ"

      # The transition state of a waiter.
      UPDATE = "update"

      # The transition state of a waiter.
      ADD = "add"

      # The transition state of a waiter.
      REMOVE = "remove"

      # The transition state of a waiter.
      PRESENCE = "presence"

      # The transition state of a waiter.
      ANY = "any"

      # The transition state of a waiter.
      HEADER = "HEADER"

      # The transition state of a waiter.
      AUTHORIZER = "AUTHORIZER"

      # The transition state of a waiter.
      URL = "url"

      # The transition state of a waiter.
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

      # The transition state of a waiter.
      HEADER = "header"

      # The transition state of a waiter.
      QUERY = "query"

      # The transition state of a waiter.
      V = "enumvalue"

      # The transition state of a waiter.
      V = "enumvalue"

      # The transition state of a waiter.
      NOTE = "NOTE"

      # The transition state of a waiter.
      WARNING = "WARNING"

      # The transition state of a waiter.
      DANGER = "DANGER"

      # The transition state of a waiter.
      ERROR = "ERROR"

      # The transition state of a waiter.
      LEGACY = "legacy"

      # The transition state of a waiter.
      STANDARD = "standard"

      # The transition state of a waiter.
      ADAPTIVE = "adaptive"

      # The transition state of a waiter.
      MEMBER = "member"

      # The transition state of a waiter.
      TARGET = "target"

      # The transition state of a waiter.
      FOO = "FOO"

      # The transition state of a waiter.
      BAR = "BAR"

      # The transition state of a waiter.
      BAZ = "BAZ"

      # The transition state of a waiter.
      V = "enumvalue"
    end

    # Enum constants for ChecksumAlgorithm
    module ChecksumAlgorithm
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for EndpointType
    module EndpointType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for FooEnum
    module FooEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RequiredEnum
    module RequiredEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TraitChangeType
    module TraitChangeType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for ApiKeySourceType
    module ApiKeySourceType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for EncodingType
    module EncodingType
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for AppliesTo
    module AppliesTo
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for HttpApiKeyLocations
    module HttpApiKeyLocations
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for StringEnum
    module StringEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for StringEnum
    module StringEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TraitChangeSeverity
    module TraitChangeSeverity
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for RetryMode
    module RetryMode
      # Controls the strategy used for retries.
      STRING = "string"

      # Controls the strategy used for retries.
      BOOLEAN = "boolean"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      GHI = "ghi"

      # Controls the strategy used for retries.
      DATE_TIME = "date-time"

      # Controls the strategy used for retries.
      EPOCH_SECONDS = "epoch-seconds"

      # Controls the strategy used for retries.
      HTTP_DATE = "http-date"

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
      CLIENT = "client"

      # Controls the strategy used for retries.
      SERVER = "server"

      # Controls the strategy used for retries.
      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      # Controls the strategy used for retries.
      ALGORITHM = "Algorithm"

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
      US_WEST_2 = "us-west-2"

      # Controls the strategy used for retries.
      REQUESTER = "requester"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      ABC = "abc"

      # Controls the strategy used for retries.
      DEF = "def"

      # Controls the strategy used for retries.
      GHI = "ghi"

      # Controls the strategy used for retries.
      JKL = "jkl"

      # Controls the strategy used for retries.
      AUTO = "auto"

      # Controls the strategy used for retries.
      PATH = "path"

      # Controls the strategy used for retries.
      VIRTUAL = "virtual"

      # Controls the strategy used for retries.
      STRING_EQUALS = "stringEquals"

      # Controls the strategy used for retries.
      BOOLEAN_EQUALS = "booleanEquals"

      # Controls the strategy used for retries.
      ALL_STRING_EQUALS = "allStringEquals"

      # Controls the strategy used for retries.
      ANY_STRING_EQUALS = "anyStringEquals"

      # Controls the strategy used for retries.
      REQUEST = "request"

      # Controls the strategy used for retries.
      RESPONSE = "response"

      # Controls the strategy used for retries.
      SUCCESS = "success"

      # Controls the strategy used for retries.
      FAILURE = "failure"

      # Controls the strategy used for retries.
      RETRY = "retry"

      # Controls the strategy used for retries.
      CRC32_C = "CRC32C"

      # Controls the strategy used for retries.
      CRC32 = "CRC32"

      # Controls the strategy used for retries.
      SHA1 = "SHA1"

      # Controls the strategy used for retries.
      SHA256 = "SHA256"

      # Controls the strategy used for retries.
      REGIONAL = "REGIONAL"

      # Controls the strategy used for retries.
      EDGE = "EDGE"

      # Controls the strategy used for retries.
      PRIVATE = "PRIVATE"

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
      FOO = "FOO"

      # Controls the strategy used for retries.
      BAR = "BAR"

      # Controls the strategy used for retries.
      BAZ = "BAZ"

      # Controls the strategy used for retries.
      UPDATE = "update"

      # Controls the strategy used for retries.
      ADD = "add"

      # Controls the strategy used for retries.
      REMOVE = "remove"

      # Controls the strategy used for retries.
      PRESENCE = "presence"

      # Controls the strategy used for retries.
      ANY = "any"

      # Controls the strategy used for retries.
      HEADER = "HEADER"

      # Controls the strategy used for retries.
      AUTHORIZER = "AUTHORIZER"

      # Controls the strategy used for retries.
      URL = "url"

      # Controls the strategy used for retries.
      CLIENT = "client"

      # Controls the strategy used for retries.
      SERVER = "server"

      # Controls the strategy used for retries.
      HEADER = "header"

      # Controls the strategy used for retries.
      QUERY = "query"

      # Controls the strategy used for retries.
      V = "enumvalue"

      # Controls the strategy used for retries.
      V = "enumvalue"

      # Controls the strategy used for retries.
      NOTE = "NOTE"

      # Controls the strategy used for retries.
      WARNING = "WARNING"

      # Controls the strategy used for retries.
      DANGER = "DANGER"

      # Controls the strategy used for retries.
      ERROR = "ERROR"

      # Controls the strategy used for retries.
      LEGACY = "legacy"

      # Controls the strategy used for retries.
      STANDARD = "standard"

      # Controls the strategy used for retries.
      ADAPTIVE = "adaptive"

      # Controls the strategy used for retries.
      MEMBER = "member"

      # Controls the strategy used for retries.
      TARGET = "target"

      # Controls the strategy used for retries.
      FOO = "FOO"

      # Controls the strategy used for retries.
      BAR = "BAR"

      # Controls the strategy used for retries.
      BAZ = "BAZ"

      # Controls the strategy used for retries.
      V = "enumvalue"
    end

    # Enum constants for StructurallyExclusive
    module StructurallyExclusive
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for TestEnum
    module TestEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      V = "enumvalue"
    end

    # Enum constants for StringEnum
    module StringEnum
      STRING = "string"

      BOOLEAN = "boolean"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CUSTOMER_CONTENT = "content"

      CUSTOMER_ACCOUNT_INFORMATION = "account"

      SERVICE_ATTRIBUTES = "usage"

      TAG_DATA = "tagging"

      PERMISSIONS_DATA = "permissions"

      CLIENT = "client"

      SERVER = "server"

      PREDICTIVE_MODEL_TYPE = "PredictiveModelType"

      ALGORITHM = "Algorithm"

      STANDARD = "STANDARD"

      REDUCED_REDUNDANCY = "REDUCED_REDUNDANCY"

      GLACIER = "GLACIER"

      STANDARD_IA = "STANDARD_IA"

      ONEZONE_IA = "ONEZONE_IA"

      INTELLIGENT_TIERING = "INTELLIGENT_TIERING"

      DEEP_ARCHIVE = "DEEP_ARCHIVE"

      OUTPOSTS = "OUTPOSTS"

      US_WEST_2 = "us-west-2"

      REQUESTER = "requester"

      ABC = "abc"

      DEF = "def"

      ABC = "abc"

      DEF = "def"

      GHI = "ghi"

      JKL = "jkl"

      AUTO = "auto"

      PATH = "path"

      VIRTUAL = "virtual"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      CRC32_C = "CRC32C"

      CRC32 = "CRC32"

      SHA1 = "SHA1"

      SHA256 = "SHA256"

      REGIONAL = "REGIONAL"

      EDGE = "EDGE"

      PRIVATE = "PRIVATE"

      FOO = "Foo"

      BAZ = "Baz"

      BAR = "Bar"

      ONE = "1"

      ZERO = "0"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      HEADER = "HEADER"

      AUTHORIZER = "AUTHORIZER"

      URL = "url"

      CLIENT = "client"

      SERVER = "server"

      HEADER = "header"

      QUERY = "query"

      V = "enumvalue"

      V = "enumvalue"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      LEGACY = "legacy"

      STANDARD = "standard"

      ADAPTIVE = "adaptive"

      MEMBER = "member"

      TARGET = "target"

      FOO = "FOO"

      BAR = "BAR"

      BAZ = "BAZ"

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
