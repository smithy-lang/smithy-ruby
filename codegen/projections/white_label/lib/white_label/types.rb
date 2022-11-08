# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Types

    # @!attribute message
    #
    #   @return [String]
    #
    ClientError = ::Struct.new(
      :message,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute hello
    #
    #   @return [String]
    #
    # @!attribute simple_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute typed_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute int_enum
    #
    #   @return [Integer]
    #
    # @!attribute null_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute string_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute boolean_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute numbers_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute list_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute map_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute list_of_strings
    #
    #   @return [Array<String>]
    #
    # @!attribute map_of_strings
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute iso8601_timestamp
    #
    #   @return [Time]
    #
    # @!attribute epoch_timestamp
    #
    #   @return [Time]
    #
    DefaultKitchenSinkInput = ::Struct.new(
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
    end

    # @!attribute hello
    #
    #   @return [String]
    #
    # @!attribute simple_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute typed_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute int_enum
    #
    #   @return [Integer]
    #
    # @!attribute null_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute string_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute boolean_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute numbers_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute list_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute map_document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute list_of_strings
    #
    #   @return [Array<String>]
    #
    # @!attribute map_of_strings
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute iso8601_timestamp
    #
    #   @return [Time]
    #
    # @!attribute epoch_timestamp
    #
    #   @return [Time]
    #
    DefaultKitchenSinkOutput = ::Struct.new(
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
    end

    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute boxed_number
    #
    #   @return [Integer]
    #
    # @!attribute default_number
    #
    #   @return [Integer]
    #
    # @!attribute default_bool
    #
    #   @return [Boolean]
    #
    DefaultsTestInput = ::Struct.new(
      :string,
      :boxed_number,
      :default_number,
      :default_bool,
      keyword_init: true
    ) do
      include Hearth::Structure

      def initialize(*)
        super
        self.default_number ||= 0
        self.default_bool ||= false
      end
    end

    # @!attribute string
    #
    #   @return [String]
    #
    # @!attribute boxed_number
    #
    #   @return [Integer]
    #
    # @!attribute default_number
    #
    #   @return [Integer]
    #
    # @!attribute default_bool
    #
    #   @return [Boolean]
    #
    DefaultsTestOutput = ::Struct.new(
      :string,
      :boxed_number,
      :default_number,
      :default_bool,
      keyword_init: true
    ) do
      include Hearth::Structure

      def initialize(*)
        super
        self.default_number ||= 0
        self.default_bool ||= false
      end
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

    # @!attribute label_member
    #
    #   @return [String]
    #
    EndpointWithHostLabelOperationInput = ::Struct.new(
      :label_member,
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

    # Includes enum constants for IntEnumType
    #
    module IntEnumType
      ONE = 1

      TWO = 2

      THREE = 3
    end

    # @!attribute string
    #   This is some member
    #   documentation of String.
    #
    #   @deprecated
    #     This structure member is
    #     deprecated.
    #     Since: today
    #
    #   @note
    #     This shape is unstable and may change in the future.
    #
    #   @see https://www.ruby-lang.org/en/ Homepage
    #
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    #   @note
    #     This shape is meant for internal use only.
    #
    #   @since today
    #
    #   @return [String]
    #
    # @!attribute simple_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute typed_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute struct
    #   This is some member documentation of Struct.
    #   It should override Struct's documentation.
    #
    #   @deprecated
    #     This structure is
    #     deprecated.
    #     Since: today
    #
    #   @note
    #     This shape is unstable and may change in the future.
    #
    #   @see https://www.ruby-lang.org/en/ Homepage
    #
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    #   @note
    #     This shape is meant for internal use only.
    #
    #   @since today
    #
    #   @return [Struct]
    #
    # @!attribute document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute list_of_strings
    #
    #   @return [Array<String>]
    #
    # @!attribute list_of_structs
    #
    #   @return [Array<Struct>]
    #
    # @!attribute map_of_strings
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute map_of_structs
    #
    #   @return [Hash<String, Struct>]
    #
    # @!attribute union
    #   This is some union documentation.
    #   It has some union members
    #
    #   @deprecated
    #     This union is
    #     deprecated.
    #     Since: today
    #
    #   @note
    #     This shape is unstable and may change in the future.
    #
    #   @see https://www.ruby-lang.org/en/ Homepage
    #
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    #   @note
    #     This shape is meant for internal use only.
    #
    #   @since today
    #
    #   @return [Union]
    #
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

    # @!attribute string
    #   This is some member
    #   documentation of String.
    #
    #   @deprecated
    #     This structure member is
    #     deprecated.
    #     Since: today
    #
    #   @note
    #     This shape is unstable and may change in the future.
    #
    #   @see https://www.ruby-lang.org/en/ Homepage
    #
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    #   @note
    #     This shape is meant for internal use only.
    #
    #   @since today
    #
    #   @return [String]
    #
    # @!attribute simple_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute typed_enum
    #   Enum, one of: ["YES", "NO", "MAYBE"]
    #
    #   @return [String]
    #
    # @!attribute struct
    #   This is some member documentation of Struct.
    #   It should override Struct's documentation.
    #
    #   @deprecated
    #     This structure is
    #     deprecated.
    #     Since: today
    #
    #   @note
    #     This shape is unstable and may change in the future.
    #
    #   @see https://www.ruby-lang.org/en/ Homepage
    #
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    #   @note
    #     This shape is meant for internal use only.
    #
    #   @since today
    #
    #   @return [Struct]
    #
    # @!attribute document
    #
    #   @return [Hash,Array,String,Boolean,Numeric]
    #
    # @!attribute list_of_strings
    #
    #   @return [Array<String>]
    #
    # @!attribute list_of_structs
    #
    #   @return [Array<Struct>]
    #
    # @!attribute map_of_strings
    #
    #   @return [Hash<String, String>]
    #
    # @!attribute map_of_structs
    #
    #   @return [Hash<String, Struct>]
    #
    # @!attribute union
    #   This is some union documentation.
    #   It has some union members
    #
    #   @deprecated
    #     This union is
    #     deprecated.
    #     Since: today
    #
    #   @note
    #     This shape is unstable and may change in the future.
    #
    #   @see https://www.ruby-lang.org/en/ Homepage
    #
    #   @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    #   @note
    #     This shape is meant for internal use only.
    #
    #   @since today
    #
    #   @return [Union]
    #
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

    # @!attribute next_token
    #
    #   @return [String]
    #
    PaginatorsTestOperationInput = ::Struct.new(
      :next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute next_token
    #
    #   @return [String]
    #
    # @!attribute items
    #
    #   @return [Array<String>]
    #
    PaginatorsTestOperationOutput = ::Struct.new(
      :next_token,
      :items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute next_token
    #
    #   @return [String]
    #
    PaginatorsTestWithItemsInput = ::Struct.new(
      :next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute next_token
    #
    #   @return [String]
    #
    # @!attribute items
    #
    #   @return [Array<String>]
    #
    PaginatorsTestWithItemsOutput = ::Struct.new(
      :next_token,
      :items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member___123next_token
    #
    #   @return [String]
    #
    ResultWrapper = ::Struct.new(
      :member___123next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    ServerError = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute stream
    #
    #   @return [String]
    #
    StreamingOperationInput = ::Struct.new(
      :stream,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute stream
    #
    #   @return [String]
    #
    StreamingOperationOutput = ::Struct.new(
      :stream,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute stream
    #
    #   @return [String]
    #
    StreamingWithLengthInput = ::Struct.new(
      :stream,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    StreamingWithLengthOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # This docstring should be different than KitchenSink struct member.
    #
    # @deprecated
    #   This structure is
    #   deprecated.
    #   Since: today
    #
    # @note
    #   This shape is unstable and may change in the future.
    #
    # @see https://www.ruby-lang.org/en/ Homepage
    #
    # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    # @note
    #   This shape is meant for internal use only.
    #
    # @since today
    #
    # @note
    #   This shape is sensitive and must be handled with care.
    #
    # @!attribute value
    #
    #   @return [String]
    #
    Struct = ::Struct.new(
      :value,
      keyword_init: true
    ) do
      include Hearth::Structure

      def to_s
        "#<struct WhiteLabel::Types::Struct [SENSITIVE]>"
      end
    end

    # Includes enum constants for TypedEnum
    #
    module TypedEnum
      # No documentation available.
      #
      YES = "YES"

      # No documentation available.
      #
      NO = "NO"

      # This documentation should be applied.
      #
      # @deprecated
      #   This enum value is deprecated.
      #
      # Tags: ["Test"]
      #
      MAYBE = "MAYBE"
    end

    # This is some union documentation.
    # It has some union members
    #
    # @deprecated
    #   This union is
    #   deprecated.
    #   Since: today
    #
    # @note
    #   This shape is unstable and may change in the future.
    #
    # @see https://www.ruby-lang.org/en/ Homepage
    #
    # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    # @note
    #   This shape is meant for internal use only.
    #
    # @since today
    #
    # @note
    #   This shape is sensitive and must be handled with care.
    #
    class Union < Hearth::Union
      # This is a String member.
      # Struct should also be documented too because the structure is.
      #
      # @deprecated
      #   This union member is
      #   deprecated.
      #   Since: today
      #
      # @note
      #   This shape is unstable and may change in the future.
      #
      # @see https://www.ruby-lang.org/en/ Homepage
      #
      # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
      #
      # @note
      #   This shape is meant for internal use only.
      #
      # @since today
      #
      class String < Union
        def to_h
          { string: super(__getobj__) }
        end

        def to_s
          "#<WhiteLabel::Types::String #{__getobj__ || 'nil'}>"
        end
      end

      # This docstring should be different than KitchenSink struct member.
      #
      # @deprecated
      #   This structure is
      #   deprecated.
      #   Since: today
      #
      # @note
      #   This shape is unstable and may change in the future.
      #
      # @see https://www.ruby-lang.org/en/ Homepage
      #
      # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
      #
      # @note
      #   This shape is meant for internal use only.
      #
      # @since today
      #
      class Struct < Union
        def to_h
          { struct: super(__getobj__) }
        end

        def to_s
          "#<WhiteLabel::Types::Struct [SENSITIVE]>"
        end
      end

      # Handles unknown future members
      #
      class Unknown < Union
        def to_h
          { unknown: super(__getobj__) }
        end

        def to_s
          "#<WhiteLabel::Types::Unknown #{__getobj__ || 'nil'}>"
        end
      end
    end

    # @!attribute status
    #
    #   @return [String]
    #
    WaitersTestInput = ::Struct.new(
      :status,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute status
    #
    #   @return [String]
    #
    WaitersTestOutput = ::Struct.new(
      :status,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member___next_token
    #
    #   @return [String]
    #
    Struct____PaginatorsTestWithBadNamesInput = ::Struct.new(
      :member___next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member___wrapper
    #
    #   @return [ResultWrapper]
    #
    # @!attribute member___items
    #
    #   @return [Array<String>]
    #
    Struct____PaginatorsTestWithBadNamesOutput = ::Struct.new(
      :member___wrapper,
      :member___items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
