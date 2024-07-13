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
    class ClientError
      include Hearth::Structure

      MEMBERS = %i[
        message
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class CustomAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class CustomAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class DataplaneEndpointInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class DataplaneEndpointOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
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
    #   @option params [String] :valued_enum
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
    #   Enum, one of: ["YES", "NO"]
    #   @return [String]
    # @!attribute valued_enum
    #   This is a YES and NO enum.
    #   Enum, one of: ["yes", "no"]
    #   @deprecated
    #     This enum is
    #     deprecated.
    #     Since: today
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
    class Defaults
      include Hearth::Structure

      MEMBERS = %i[
        string
        struct
        un_required_number
        un_required_bool
        number
        bool
        hello
        simple_enum
        valued_enum
        int_enum
        null_document
        string_document
        boolean_document
        numbers_document
        list_document
        map_document
        list_of_strings
        map_of_strings
        iso8601_timestamp
        epoch_timestamp
      ].freeze

      attr_accessor(*MEMBERS)

      def to_s
        "#<WhiteLabel::Types::Defaults "\
          "string=#{string || 'nil'}, "\
          "struct=\"[SENSITIVE]\", "\
          "un_required_number=#{un_required_number || 'nil'}, "\
          "un_required_bool=#{un_required_bool || 'nil'}, "\
          "number=#{number || 'nil'}, "\
          "bool=#{bool || 'nil'}, "\
          "hello=#{hello || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "valued_enum=#{valued_enum || 'nil'}, "\
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

      private

      def _defaults
        {
          un_required_number: 0,
          un_required_bool: false,
          number: 0,
          bool: false,
          hello: "world",
          simple_enum: "YES",
          valued_enum: "no",
          int_enum: 1,
          string_document: "some string document",
          boolean_document: true,
          numbers_document: 1.23,
          list_document: [],
          map_document: {},
          list_of_strings: [],
          map_of_strings: {},
          iso8601_timestamp: Time.parse("1985-04-12T23:20:50.52Z"),
          epoch_timestamp: Time.at(1.5155310811234E9)
        }
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Defaults] :defaults
    # @!attribute defaults
    #   @return [Defaults]
    class DefaultsTestInput
      include Hearth::Structure

      MEMBERS = %i[
        defaults
      ].freeze

      attr_accessor(*MEMBERS)
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
    #   @option params [String] :valued_enum
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
    #   Enum, one of: ["YES", "NO"]
    #   @return [String]
    # @!attribute valued_enum
    #   This is a YES and NO enum.
    #   Enum, one of: ["yes", "no"]
    #   @deprecated
    #     This enum is
    #     deprecated.
    #     Since: today
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
    class DefaultsTestOutput
      include Hearth::Structure

      MEMBERS = %i[
        string
        struct
        un_required_number
        un_required_bool
        number
        bool
        hello
        simple_enum
        valued_enum
        int_enum
        null_document
        string_document
        boolean_document
        numbers_document
        list_document
        map_document
        list_of_strings
        map_of_strings
        iso8601_timestamp
        epoch_timestamp
      ].freeze

      attr_accessor(*MEMBERS)

      def to_s
        "#<WhiteLabel::Types::DefaultsTestOutput "\
          "string=#{string || 'nil'}, "\
          "struct=\"[SENSITIVE]\", "\
          "un_required_number=#{un_required_number || 'nil'}, "\
          "un_required_bool=#{un_required_bool || 'nil'}, "\
          "number=#{number || 'nil'}, "\
          "bool=#{bool || 'nil'}, "\
          "hello=#{hello || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "valued_enum=#{valued_enum || 'nil'}, "\
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

      private

      def _defaults
        {
          un_required_number: 0,
          un_required_bool: false,
          number: 0,
          bool: false,
          hello: "world",
          simple_enum: "YES",
          valued_enum: "no",
          int_enum: 1,
          string_document: "some string document",
          boolean_document: true,
          numbers_document: 1.23,
          list_document: [],
          map_document: {},
          list_of_strings: [],
          map_of_strings: {},
          iso8601_timestamp: Time.parse("1985-04-12T23:20:50.52Z"),
          epoch_timestamp: Time.at(1.5155310811234E9)
        }
      end
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EndpointOperationInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EndpointOperationOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :label_member
    # @!attribute label_member
    #   @return [String]
    class EndpointWithHostLabelOperationInput
      include Hearth::Structure

      MEMBERS = %i[
        label_member
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class EndpointWithHostLabelOperationOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpApiKeyAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpApiKeyAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpBasicAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpBasicAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpBearerAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpBearerAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpDigestAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class HttpDigestAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # Enum constants for IntEnumType
    module IntEnumType
      ONE = 1

      TWO = 2

      THREE = 3
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :string
    #   @option params [String] :simple_enum
    #   @option params [String] :valued_enum
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
    #   Enum, one of: ["YES", "NO"]
    #   @return [String]
    # @!attribute valued_enum
    #   This is a YES and NO enum.
    #   Enum, one of: ["yes", "no"]
    #   @deprecated
    #     This enum is
    #     deprecated.
    #     Since: today
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
    class KitchenSinkInput
      include Hearth::Structure

      MEMBERS = %i[
        string
        simple_enum
        valued_enum
        struct
        document
        list_of_strings
        list_of_structs
        map_of_strings
        map_of_structs
        union
      ].freeze

      attr_accessor(*MEMBERS)

      def to_s
        "#<WhiteLabel::Types::KitchenSinkInput "\
          "string=#{string || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "valued_enum=#{valued_enum || 'nil'}, "\
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
    #   @option params [String] :valued_enum
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
    #   Enum, one of: ["YES", "NO"]
    #   @return [String]
    # @!attribute valued_enum
    #   This is a YES and NO enum.
    #   Enum, one of: ["yes", "no"]
    #   @deprecated
    #     This enum is
    #     deprecated.
    #     Since: today
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
    class KitchenSinkOutput
      include Hearth::Structure

      MEMBERS = %i[
        string
        simple_enum
        valued_enum
        struct
        document
        list_of_strings
        list_of_structs
        map_of_strings
        map_of_structs
        union
      ].freeze

      attr_accessor(*MEMBERS)

      def to_s
        "#<WhiteLabel::Types::KitchenSinkOutput "\
          "string=#{string || 'nil'}, "\
          "simple_enum=#{simple_enum || 'nil'}, "\
          "valued_enum=#{valued_enum || 'nil'}, "\
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
    class MixinTestInput
      include Hearth::Structure

      MEMBERS = %i[
        user_id
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :username
    #   @option params [String] :user_id
    # @!attribute username
    #   @return [String]
    # @!attribute user_id
    #   @return [String]
    class MixinTestOutput
      include Hearth::Structure

      MEMBERS = %i[
        username
        user_id
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class NoAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class OptionalAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class OptionalAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class OrderedAuthInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class OrderedAuthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    # @!attribute next_token
    #   @return [String]
    class PaginatorsTestOperationInput
      include Hearth::Structure

      MEMBERS = %i[
        next_token
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    #   @option params [Array<String>] :items
    # @!attribute next_token
    #   @return [String]
    # @!attribute items
    #   @return [Array<String>]
    class PaginatorsTestOperationOutput
      include Hearth::Structure

      MEMBERS = %i[
        next_token
        items
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    # @!attribute next_token
    #   @return [String]
    class PaginatorsTestWithItemsInput
      include Hearth::Structure

      MEMBERS = %i[
        next_token
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    #   @option params [Array<String>] :items
    # @!attribute next_token
    #   @return [String]
    # @!attribute items
    #   @return [Array<String>]
    class PaginatorsTestWithItemsOutput
      include Hearth::Structure

      MEMBERS = %i[
        next_token
        items
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class RelativeMiddlewareInput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class RelativeMiddlewareOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :body
    # @!attribute body
    #   @return [String]
    class RequestCompressionInput
      include Hearth::Structure

      MEMBERS = %i[
        body
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class RequestCompressionOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :body
    # @!attribute body
    #   @return [String]
    class RequestCompressionStreamingInput
      include Hearth::Structure

      MEMBERS = %i[
        body
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class RequestCompressionStreamingOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :resource_url
    # @!attribute resource_url
    #   @return [String]
    class ResourceEndpointInput
      include Hearth::Structure

      MEMBERS = %i[
        resource_url
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class ResourceEndpointOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :member___123next_token
    # @!attribute member___123next_token
    #   @return [String]
    class ResultWrapper
      include Hearth::Structure

      MEMBERS = %i[
        member___123next_token
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class ServerError
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # Enum constants for SimpleEnum
    module SimpleEnum
      YES = "YES"

      NO = "NO"
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :stream
    # @!attribute stream
    #   @return [String]
    class StreamingInput
      include Hearth::Structure

      MEMBERS = %i[
        stream
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :stream
    # @!attribute stream
    #   @return [String]
    class StreamingOutput
      include Hearth::Structure

      MEMBERS = %i[
        stream
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :stream
    # @!attribute stream
    #   @return [String]
    class StreamingWithLengthInput
      include Hearth::Structure

      MEMBERS = %i[
        stream
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    class StreamingWithLengthOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
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
    # @note
    #   This shape is sensitive and must be handled with care.
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :value
    # @!attribute value
    #   @return [String]
    class Struct
      include Hearth::Structure

      MEMBERS = %i[
        value
      ].freeze

      attr_accessor(*MEMBERS)

      def to_s
        "#<WhiteLabel::Types::Struct [SENSITIVE]>"
      end
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

    # Enum constants for ValuedEnum
    # This is a YES and NO enum.
    # @deprecated
    #   This enum is
    #   deprecated.
    #   Since: today
    module ValuedEnum
      YES = "yes"

      NO = "no"
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :status
    # @!attribute status
    #   @return [String]
    class WaitersTestInput
      include Hearth::Structure

      MEMBERS = %i[
        status
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :status
    # @!attribute status
    #   @return [String]
    class WaitersTestOutput
      include Hearth::Structure

      MEMBERS = %i[
        status
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :member___next_token
    # @!attribute member___next_token
    #   @return [String]
    class Struct____PaginatorsTestWithBadNamesInput
      include Hearth::Structure

      MEMBERS = %i[
        member___next_token
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [ResultWrapper] :member___wrapper
    #   @option params [Array<String>] :member___items
    # @!attribute member___wrapper
    #   @return [ResultWrapper]
    # @!attribute member___items
    #   @return [Array<String>]
    class Struct____PaginatorsTestWithBadNamesOutput
      include Hearth::Structure

      MEMBERS = %i[
        member___wrapper
        member___items
      ].freeze

      attr_accessor(*MEMBERS)
    end

  end
end
