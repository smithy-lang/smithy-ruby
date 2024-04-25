# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Types

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :message
    # @!attribute message
    #   @return [String]
    ClientError = ::Struct.new(
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    CustomAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    CustomAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    DataplaneEndpointInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    DataplaneEndpointOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string
    #   @option params [Struct] :struct
    #   @option params [Integer] :un_required_number (0)
    #   @option params [Boolean] :un_required_bool (false)
    #   @option params [Integer] :number (0)
    #   @option params [Boolean] :bool (false)
    #   @option params [String] :hello
    #   @option params [String] :simple_enum
    #   @option params [String] :typed_enum
    #   @option params [Integer] :int_enum
    #   @option params [Hash, Array, String, Boolean, Numeric] :null_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :string_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :boolean_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :numbers_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :list_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :map_document
    #   @option params [Array<String>] :list_of_strings
    #   @option params [Hash<String, String>] :map_of_strings
    #   @option params [Time] :iso8601_timestamp
    #   @option params [Time] :epoch_timestamp
    # @!attribute string
    #   @return [String]
    # @!attribute struct
    #   This docstring should be different than KitchenSink struct member.
    #   @deprecated
    #     This structure is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @since today
    #   @return [Struct]
    # @!attribute un_required_number
    #   @return [Integer]
    # @!attribute un_required_bool
    #   @return [Boolean]
    # @!attribute number
    #   @return [Integer]
    # @!attribute bool
    #   @return [Boolean]
    # @!attribute hello
    #   @return [String]
    # @!attribute simple_enum
    #   @return [String]
    # @!attribute typed_enum
    #   @return [String]
    # @!attribute int_enum
    #   @return [Integer]
    # @!attribute null_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute string_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute boolean_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute numbers_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute list_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute map_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute list_of_strings
    #   @return [Array<String>]
    # @!attribute map_of_strings
    #   @return [Hash<String, String>]
    # @!attribute iso8601_timestamp
    #   @return [Time]
    # @!attribute epoch_timestamp
    #   @return [Time]
    DefaultsTestInput = ::Struct.new(
      :string,
      :struct,
      :un_required_number,
      :un_required_bool,
      :number,
      :bool,
      :hello,
      :simple_enum,
      :typed_enum,
      :int_enum,
      :null_document,
      :string_document,
      :boolean_document,
      :numbers_document,
      :list_document,
      :map_document,
      :list_of_strings,
      :map_of_strings,
      :iso8601_timestamp,
      :epoch_timestamp,
      keyword_init: true
    ) do
      include Hearth::Structure

      def initialize(*)
        super
        self.un_required_number = 0 if self.un_required_number.nil?
        self.un_required_bool = false if self.un_required_bool.nil?
        self.number = 0 if self.number.nil?
        self.bool = false if self.bool.nil?
      end

      def to_s
        "#<struct WhiteLabel::Types::DefaultsTestInput "\
          "string=#{string || 'nil'}, "\
          "struct=\"[SENSITIVE]\", "\
          "un_required_number=#{un_required_number || 'nil'}, "\
          "un_required_bool=#{un_required_bool || 'nil'}, "\
          "number=#{number || 'nil'}, "\
          "bool=#{bool || 'nil'}, "\
          "hello=#{hello || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "typed_enum=#{typed_enum || 'nil'}, "\
          "int_enum=#{int_enum || 'nil'}, "\
          "null_document=#{null_document || 'nil'}, "\
          "string_document=#{string_document || 'nil'}, "\
          "boolean_document=#{boolean_document || 'nil'}, "\
          "numbers_document=#{numbers_document || 'nil'}, "\
          "list_document=#{list_document || 'nil'}, "\
          "map_document=#{map_document || 'nil'}, "\
          "list_of_strings=#{list_of_strings || 'nil'}, "\
          "map_of_strings=#{map_of_strings || 'nil'}, "\
          "iso8601_timestamp=#{iso8601_timestamp || 'nil'}, "\
          "epoch_timestamp=#{epoch_timestamp || 'nil'}>"
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string
    #   @option params [Struct] :struct
    #   @option params [Integer] :un_required_number (0)
    #   @option params [Boolean] :un_required_bool (false)
    #   @option params [Integer] :number (0)
    #   @option params [Boolean] :bool (false)
    #   @option params [String] :hello
    #   @option params [String] :simple_enum
    #   @option params [String] :typed_enum
    #   @option params [Integer] :int_enum
    #   @option params [Hash, Array, String, Boolean, Numeric] :null_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :string_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :boolean_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :numbers_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :list_document
    #   @option params [Hash, Array, String, Boolean, Numeric] :map_document
    #   @option params [Array<String>] :list_of_strings
    #   @option params [Hash<String, String>] :map_of_strings
    #   @option params [Time] :iso8601_timestamp
    #   @option params [Time] :epoch_timestamp
    # @!attribute string
    #   @return [String]
    # @!attribute struct
    #   This docstring should be different than KitchenSink struct member.
    #   @deprecated
    #     This structure is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @since today
    #   @return [Struct]
    # @!attribute un_required_number
    #   @return [Integer]
    # @!attribute un_required_bool
    #   @return [Boolean]
    # @!attribute number
    #   @return [Integer]
    # @!attribute bool
    #   @return [Boolean]
    # @!attribute hello
    #   @return [String]
    # @!attribute simple_enum
    #   @return [String]
    # @!attribute typed_enum
    #   @return [String]
    # @!attribute int_enum
    #   @return [Integer]
    # @!attribute null_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute string_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute boolean_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute numbers_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute list_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute map_document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute list_of_strings
    #   @return [Array<String>]
    # @!attribute map_of_strings
    #   @return [Hash<String, String>]
    # @!attribute iso8601_timestamp
    #   @return [Time]
    # @!attribute epoch_timestamp
    #   @return [Time]
    DefaultsTestOutput = ::Struct.new(
      :string,
      :struct,
      :un_required_number,
      :un_required_bool,
      :number,
      :bool,
      :hello,
      :simple_enum,
      :typed_enum,
      :int_enum,
      :null_document,
      :string_document,
      :boolean_document,
      :numbers_document,
      :list_document,
      :map_document,
      :list_of_strings,
      :map_of_strings,
      :iso8601_timestamp,
      :epoch_timestamp,
      keyword_init: true
    ) do
      include Hearth::Structure

      def initialize(*)
        super
        self.un_required_number = 0 if self.un_required_number.nil?
        self.un_required_bool = false if self.un_required_bool.nil?
        self.number = 0 if self.number.nil?
        self.bool = false if self.bool.nil?
      end

      def to_s
        "#<struct WhiteLabel::Types::DefaultsTestOutput "\
          "string=#{string || 'nil'}, "\
          "struct=\"[SENSITIVE]\", "\
          "un_required_number=#{un_required_number || 'nil'}, "\
          "un_required_bool=#{un_required_bool || 'nil'}, "\
          "number=#{number || 'nil'}, "\
          "bool=#{bool || 'nil'}, "\
          "hello=#{hello || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "typed_enum=#{typed_enum || 'nil'}, "\
          "int_enum=#{int_enum || 'nil'}, "\
          "null_document=#{null_document || 'nil'}, "\
          "string_document=#{string_document || 'nil'}, "\
          "boolean_document=#{boolean_document || 'nil'}, "\
          "numbers_document=#{numbers_document || 'nil'}, "\
          "list_document=#{list_document || 'nil'}, "\
          "map_document=#{map_document || 'nil'}, "\
          "list_of_strings=#{list_of_strings || 'nil'}, "\
          "map_of_strings=#{map_of_strings || 'nil'}, "\
          "iso8601_timestamp=#{iso8601_timestamp || 'nil'}, "\
          "epoch_timestamp=#{epoch_timestamp || 'nil'}>"
      end
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

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :label_member
    # @!attribute label_member
    #   @return [String]
    HostLabelEndpointInput = ::Struct.new(
      :label_member,
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
    HttpApiKeyAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpApiKeyAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpBasicAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpBasicAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpBearerAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpBearerAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpDigestAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    HttpDigestAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Includes enum constants for IntEnumType
    module IntEnumType
      ONE = 1

      TWO = 2

      THREE = 3
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string
    #   @option params [String] :simple_enum
    #   @option params [String] :typed_enum
    #   @option params [Struct] :struct
    #   @option params [Hash, Array, String, Boolean, Numeric] :document
    #   @option params [Array<String>] :list_of_strings
    #   @option params [Array<Struct>] :list_of_structs
    #   @option params [Hash<String, String>] :map_of_strings
    #   @option params [Hash<String, Struct>] :map_of_structs
    #   @option params [Union] :union
    # @!attribute string
    #   This is some member
    #   documentation of String.
    #   @deprecated
    #     This structure member is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @note
    #     This shape is recommended.
    #     Reason: This structure member is
    #     cool AF.
    #   @since today
    #   @return [String]
    # @!attribute simple_enum
    #   @return [String]
    # @!attribute typed_enum
    #   @return [String]
    # @!attribute struct
    #   This is some member documentation of Struct.
    #   It should override Struct's documentation.
    #   @deprecated
    #     This structure is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @since today
    #   @return [Struct]
    # @!attribute document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute list_of_strings
    #   @return [Array<String>]
    # @!attribute list_of_structs
    #   @return [Array<Struct>]
    # @!attribute map_of_strings
    #   @return [Hash<String, String>]
    # @!attribute map_of_structs
    #   @return [Hash<String, Struct>]
    # @!attribute union
    #   This is some union documentation.
    #   It has some union members
    #   @deprecated
    #     This union is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @since today
    #   @return [Union]
    KitchenSinkInput = ::Struct.new(
      :string,
      :simple_enum,
      :typed_enum,
      :struct,
      :document,
      :list_of_strings,
      :list_of_structs,
      :map_of_strings,
      :map_of_structs,
      :union,
      keyword_init: true
    ) do
      include Hearth::Structure

      def to_s
        "#<struct WhiteLabel::Types::KitchenSinkInput "\
          "string=#{string || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "typed_enum=#{typed_enum || 'nil'}, "\
          "struct=\"[SENSITIVE]\", "\
          "document=#{document || 'nil'}, "\
          "list_of_strings=#{list_of_strings || 'nil'}, "\
          "list_of_structs=#{list_of_structs || 'nil'}, "\
          "map_of_strings=#{map_of_strings || 'nil'}, "\
          "map_of_structs=#{map_of_structs || 'nil'}, "\
          "union=\"[SENSITIVE]\">"
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string
    #   @option params [String] :simple_enum
    #   @option params [String] :typed_enum
    #   @option params [Struct] :struct
    #   @option params [Hash, Array, String, Boolean, Numeric] :document
    #   @option params [Array<String>] :list_of_strings
    #   @option params [Array<Struct>] :list_of_structs
    #   @option params [Hash<String, String>] :map_of_strings
    #   @option params [Hash<String, Struct>] :map_of_structs
    #   @option params [Union] :union
    # @!attribute string
    #   This is some member
    #   documentation of String.
    #   @deprecated
    #     This structure member is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @note
    #     This shape is recommended.
    #     Reason: This structure member is
    #     cool AF.
    #   @since today
    #   @return [String]
    # @!attribute simple_enum
    #   @return [String]
    # @!attribute typed_enum
    #   @return [String]
    # @!attribute struct
    #   This is some member documentation of Struct.
    #   It should override Struct's documentation.
    #   @deprecated
    #     This structure is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @since today
    #   @return [Struct]
    # @!attribute document
    #   @return [Hash, Array, String, Boolean, Numeric]
    # @!attribute list_of_strings
    #   @return [Array<String>]
    # @!attribute list_of_structs
    #   @return [Array<Struct>]
    # @!attribute map_of_strings
    #   @return [Hash<String, String>]
    # @!attribute map_of_structs
    #   @return [Hash<String, Struct>]
    # @!attribute union
    #   This is some union documentation.
    #   It has some union members
    #   @deprecated
    #     This union is
    #     deprecated.
    #     Since: today
    #   @note
    #     This shape is unstable and may change in the future.
    #   @see https://www.ruby-lang.org/en/ Homepage
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #   @note
    #     This shape is meant for internal use only.
    #   @since today
    #   @return [Union]
    KitchenSinkOutput = ::Struct.new(
      :string,
      :simple_enum,
      :typed_enum,
      :struct,
      :document,
      :list_of_strings,
      :list_of_structs,
      :map_of_strings,
      :map_of_structs,
      :union,
      keyword_init: true
    ) do
      include Hearth::Structure

      def to_s
        "#<struct WhiteLabel::Types::KitchenSinkOutput "\
          "string=#{string || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "typed_enum=#{typed_enum || 'nil'}, "\
          "struct=\"[SENSITIVE]\", "\
          "document=#{document || 'nil'}, "\
          "list_of_strings=#{list_of_strings || 'nil'}, "\
          "list_of_structs=#{list_of_structs || 'nil'}, "\
          "map_of_strings=#{map_of_strings || 'nil'}, "\
          "map_of_structs=#{map_of_structs || 'nil'}, "\
          "union=\"[SENSITIVE]\">"
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :user_id
    # @!attribute user_id
    #   @return [String]
    MixinTestInput = ::Struct.new(
      :user_id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :username
    #   @option params [String] :user_id
    # @!attribute username
    #   @return [String]
    # @!attribute user_id
    #   @return [String]
    MixinTestOutput = ::Struct.new(
      :username,
      :user_id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    NoAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    OptionalAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    OptionalAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    OrderedAuthInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    OrderedAuthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    # @!attribute next_token
    #   @return [String]
    PaginatorsTestOperationInput = ::Struct.new(
      :next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    #   @option params [Array<String>] :items
    # @!attribute next_token
    #   @return [String]
    # @!attribute items
    #   @return [Array<String>]
    PaginatorsTestOperationOutput = ::Struct.new(
      :next_token,
      :items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    # @!attribute next_token
    #   @return [String]
    PaginatorsTestWithItemsInput = ::Struct.new(
      :next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    #   @option params [Array<String>] :items
    # @!attribute next_token
    #   @return [String]
    # @!attribute items
    #   @return [Array<String>]
    PaginatorsTestWithItemsOutput = ::Struct.new(
      :next_token,
      :items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    RelativeMiddlewareInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    RelativeMiddlewareOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :body
    # @!attribute body
    #   @return [String]
    RequestCompressionInput = ::Struct.new(
      :body,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    RequestCompressionOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :body
    # @!attribute body
    #   @return [String]
    RequestCompressionStreamingInput = ::Struct.new(
      :body,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    RequestCompressionStreamingOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :resource_url
    # @!attribute resource_url
    #   @return [String]
    ResourceEndpointInput = ::Struct.new(
      :resource_url,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    ResourceEndpointOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :member___123next_token
    # @!attribute member___123next_token
    #   @return [String]
    ResultWrapper = ::Struct.new(
      :member___123next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    ServerError = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Enum constants for HttpApiKeyLocations
    module HttpApiKeyLocations
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for StructurallyExclusive
    module StructurallyExclusive
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for AppliesTo
    module AppliesTo
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for TraitChangeType
    module TraitChangeType
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for TypedEnum
    module TypedEnum
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for TraitChangeSeverity
    module TraitChangeSeverity
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for PathComparator
    module PathComparator
      # Defines a comparison to perform in a PathMatcher.
      HEADER = "header"

      # Defines a comparison to perform in a PathMatcher.
      QUERY = "query"

      # Defines a comparison to perform in a PathMatcher.
      MEMBER = "member"

      # Defines a comparison to perform in a PathMatcher.
      TARGET = "target"

      # Defines a comparison to perform in a PathMatcher.
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

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
      YES = "yes"

      # Defines a comparison to perform in a PathMatcher.
      NO = "no"

      # Defines a comparison to perform in a PathMatcher.
      NOTE = "NOTE"

      # Defines a comparison to perform in a PathMatcher.
      WARNING = "WARNING"

      # Defines a comparison to perform in a PathMatcher.
      DANGER = "DANGER"

      # Defines a comparison to perform in a PathMatcher.
      ERROR = "ERROR"

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
      STRING = "string"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN = "boolean"

      # Defines a comparison to perform in a PathMatcher.
      DATE_TIME = "date-time"

      # Defines a comparison to perform in a PathMatcher.
      EPOCH_SECONDS = "epoch-seconds"

      # Defines a comparison to perform in a PathMatcher.
      HTTP_DATE = "http-date"

      # Defines a comparison to perform in a PathMatcher.
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

      # Defines a comparison to perform in a PathMatcher.
      YES = "YES"

      # Defines a comparison to perform in a PathMatcher.
      NO = "NO"
    end

    # Enum constants for TestType
    module TestType
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for AcceptorState
    module AcceptorState
      # The transition state of a waiter.
      HEADER = "header"

      # The transition state of a waiter.
      QUERY = "query"

      # The transition state of a waiter.
      MEMBER = "member"

      # The transition state of a waiter.
      TARGET = "target"

      # The transition state of a waiter.
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

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
      YES = "yes"

      # The transition state of a waiter.
      NO = "no"

      # The transition state of a waiter.
      NOTE = "NOTE"

      # The transition state of a waiter.
      WARNING = "WARNING"

      # The transition state of a waiter.
      DANGER = "DANGER"

      # The transition state of a waiter.
      ERROR = "ERROR"

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
      STRING = "string"

      # The transition state of a waiter.
      BOOLEAN = "boolean"

      # The transition state of a waiter.
      DATE_TIME = "date-time"

      # The transition state of a waiter.
      EPOCH_SECONDS = "epoch-seconds"

      # The transition state of a waiter.
      HTTP_DATE = "http-date"

      # The transition state of a waiter.
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

      # The transition state of a waiter.
      YES = "YES"

      # The transition state of a waiter.
      NO = "NO"
    end

    # Enum constants for ShapeType
    module ShapeType
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
      MEMBER = "member"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      TARGET = "target"

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
      YES = "yes"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      NO = "no"

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
      STRING = "string"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BOOLEAN = "boolean"

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
      CLIENT = "client"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SERVER = "server"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      YES = "YES"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      NO = "NO"
    end

    # Enum constants for TimestampFormat
    module TimestampFormat
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for Error
    module Error
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
      YES = "yes"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      NO = "no"

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
      YES = "YES"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      NO = "NO"
    end

    # Enum constants for SimpleEnum
    module SimpleEnum
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :stream
    # @!attribute stream
    #   @return [String]
    StreamingInput = ::Struct.new(
      :stream,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :stream
    # @!attribute stream
    #   @return [String]
    StreamingOutput = ::Struct.new(
      :stream,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :stream
    # @!attribute stream
    #   @return [String]
    StreamingWithLengthInput = ::Struct.new(
      :stream,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    StreamingWithLengthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @api private
    class ::Struct; end

    # This docstring should be different than KitchenSink struct member.
    # @deprecated
    #   This structure is
    #   deprecated.
    #   Since: today
    # @note
    #   This shape is unstable and may change in the future.
    # @see https://www.ruby-lang.org/en/ Homepage
    # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    # @note
    #   This shape is meant for internal use only.
    # @since today
    # @note
    #   This shape is sensitive and must be handled with care.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    Struct = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure

      def to_s
        "#<struct WhiteLabel::Types::Struct [SENSITIVE]>"
      end
    end

    # Enum constants for HttpApiKeyLocations
    module HttpApiKeyLocations
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for StructurallyExclusive
    module StructurallyExclusive
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for AppliesTo
    module AppliesTo
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for TraitChangeType
    module TraitChangeType
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for TypedEnum
    module TypedEnum
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for TraitChangeSeverity
    module TraitChangeSeverity
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for PathComparator
    module PathComparator
      # Defines a comparison to perform in a PathMatcher.
      HEADER = "header"

      # Defines a comparison to perform in a PathMatcher.
      QUERY = "query"

      # Defines a comparison to perform in a PathMatcher.
      MEMBER = "member"

      # Defines a comparison to perform in a PathMatcher.
      TARGET = "target"

      # Defines a comparison to perform in a PathMatcher.
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

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
      YES = "yes"

      # Defines a comparison to perform in a PathMatcher.
      NO = "no"

      # Defines a comparison to perform in a PathMatcher.
      NOTE = "NOTE"

      # Defines a comparison to perform in a PathMatcher.
      WARNING = "WARNING"

      # Defines a comparison to perform in a PathMatcher.
      DANGER = "DANGER"

      # Defines a comparison to perform in a PathMatcher.
      ERROR = "ERROR"

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
      STRING = "string"

      # Defines a comparison to perform in a PathMatcher.
      BOOLEAN = "boolean"

      # Defines a comparison to perform in a PathMatcher.
      DATE_TIME = "date-time"

      # Defines a comparison to perform in a PathMatcher.
      EPOCH_SECONDS = "epoch-seconds"

      # Defines a comparison to perform in a PathMatcher.
      HTTP_DATE = "http-date"

      # Defines a comparison to perform in a PathMatcher.
      CLIENT = "client"

      # Defines a comparison to perform in a PathMatcher.
      SERVER = "server"

      # Defines a comparison to perform in a PathMatcher.
      YES = "YES"

      # Defines a comparison to perform in a PathMatcher.
      NO = "NO"
    end

    # Enum constants for TestType
    module TestType
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for AcceptorState
    module AcceptorState
      # The transition state of a waiter.
      HEADER = "header"

      # The transition state of a waiter.
      QUERY = "query"

      # The transition state of a waiter.
      MEMBER = "member"

      # The transition state of a waiter.
      TARGET = "target"

      # The transition state of a waiter.
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

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
      YES = "yes"

      # The transition state of a waiter.
      NO = "no"

      # The transition state of a waiter.
      NOTE = "NOTE"

      # The transition state of a waiter.
      WARNING = "WARNING"

      # The transition state of a waiter.
      DANGER = "DANGER"

      # The transition state of a waiter.
      ERROR = "ERROR"

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
      STRING = "string"

      # The transition state of a waiter.
      BOOLEAN = "boolean"

      # The transition state of a waiter.
      DATE_TIME = "date-time"

      # The transition state of a waiter.
      EPOCH_SECONDS = "epoch-seconds"

      # The transition state of a waiter.
      HTTP_DATE = "http-date"

      # The transition state of a waiter.
      CLIENT = "client"

      # The transition state of a waiter.
      SERVER = "server"

      # The transition state of a waiter.
      YES = "YES"

      # The transition state of a waiter.
      NO = "NO"
    end

    # Enum constants for ShapeType
    module ShapeType
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
      MEMBER = "member"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      TARGET = "target"

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
      YES = "yes"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      NO = "no"

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
      STRING = "string"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      BOOLEAN = "boolean"

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
      CLIENT = "client"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      SERVER = "server"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      YES = "YES"

      # An enum representing supported Smithy shape types.
      # @note
      #   This shape is unstable and may change in the future.
      NO = "NO"
    end

    # Enum constants for TimestampFormat
    module TimestampFormat
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # Enum constants for Error
    module Error
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
      YES = "yes"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      NO = "no"

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
      YES = "YES"

      # Indicates that a structure shape represents an error.
      #
      # All shapes referenced by the errors list of an operation MUST be targeted
      # with this trait.
      NO = "NO"
    end

    # Enum constants for SimpleEnum
    module SimpleEnum
      HEADER = "header"

      QUERY = "query"

      MEMBER = "member"

      TARGET = "target"

      CLIENT = "client"

      SERVER = "server"

      UPDATE = "update"

      ADD = "add"

      REMOVE = "remove"

      PRESENCE = "presence"

      ANY = "any"

      YES = "yes"

      NO = "no"

      NOTE = "NOTE"

      WARNING = "WARNING"

      DANGER = "DANGER"

      ERROR = "ERROR"

      STRING_EQUALS = "stringEquals"

      BOOLEAN_EQUALS = "booleanEquals"

      ALL_STRING_EQUALS = "allStringEquals"

      ANY_STRING_EQUALS = "anyStringEquals"

      REQUEST = "request"

      RESPONSE = "response"

      SUCCESS = "success"

      FAILURE = "failure"

      RETRY = "retry"

      STRING = "string"

      BOOLEAN = "boolean"

      DATE_TIME = "date-time"

      EPOCH_SECONDS = "epoch-seconds"

      HTTP_DATE = "http-date"

      CLIENT = "client"

      SERVER = "server"

      YES = "YES"

      NO = "NO"
    end

    # This is some union documentation.
    # It has some union members
    # @deprecated
    #   This union is
    #   deprecated.
    #   Since: today
    # @note
    #   This shape is unstable and may change in the future.
    # @see https://www.ruby-lang.org/en/ Homepage
    # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    # @note
    #   This shape is meant for internal use only.
    # @since today
    # @note
    #   This shape is sensitive and must be handled with care.
    class Union < Hearth::Union
      # This is a String member.
      # Struct should also be documented too because the structure is.
      # @deprecated
      #   This union member is
      #   deprecated.
      #   Since: today
      # @note
      #   This shape is unstable and may change in the future.
      # @see https://www.ruby-lang.org/en/ Homepage
      # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
      # @note
      #   This shape is meant for internal use only.
      # @since today
      class String < Union
        def to_h
          { string: super(__getobj__) }
        end

        def to_s
          "#<WhiteLabel::Types::String #{__getobj__ || 'nil'}>"
        end
      end

      # This docstring should be different than KitchenSink struct member.
      # @deprecated
      #   This structure is
      #   deprecated.
      #   Since: today
      # @note
      #   This shape is unstable and may change in the future.
      # @see https://www.ruby-lang.org/en/ Homepage
      # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
      # @note
      #   This shape is meant for internal use only.
      # @since today
      class Struct < Union
        def to_h
          { struct: super(__getobj__) }
        end

        def to_s
          "#<WhiteLabel::Types::Struct [SENSITIVE]>"
        end
      end

      class Unknown < Union
        def initialize(name:, value:)
          super({name: name, value: value})
        end

        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<WhiteLabel::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :status
    # @!attribute status
    #   @return [String]
    WaitersTestInput = ::Struct.new(
      :status,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :status
    # @!attribute status
    #   @return [String]
    WaitersTestOutput = ::Struct.new(
      :status,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :member___next_token
    # @!attribute member___next_token
    #   @return [String]
    Struct____PaginatorsTestWithBadNamesInput = ::Struct.new(
      :member___next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [ResultWrapper] :member___wrapper
    #   @option params [Array<String>] :member___items
    # @!attribute member___wrapper
    #   @return [ResultWrapper]
    # @!attribute member___items
    #   @return [Array<String>]
    Struct____PaginatorsTestWithBadNamesOutput = ::Struct.new(
      :member___wrapper,
      :member___items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
