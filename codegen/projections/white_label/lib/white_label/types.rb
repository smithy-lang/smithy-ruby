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
    #   @note
    #     This shape is recommended.
    #     Reason: This structure member is
    #     cool AF.
    #
    #   @since today
    #
    #   @note
    #     This shape is sensitive and must be handled with care.
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
    #   @note
    #     This shape is sensitive and must be handled with care.
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
    # @!attribute set_of_strings
    #
    #   @return [Set<String>]
    #
    # @!attribute set_of_structs
    #
    #   @return [Set<Struct>]
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
    #   @note
    #     This shape is sensitive and must be handled with care.
    #
    #   @return [Union]
    #
    KitchenSinkInput = ::Struct.new(
      :string,
      :struct,
      :document,
      :list_of_strings,
      :list_of_structs,
      :map_of_strings,
      :map_of_structs,
      :set_of_strings,
      :set_of_structs,
      :union,
      keyword_init: true
    ) do
      include Hearth::Structure

      def to_s
        "#<struct WhiteLabel::Types::KitchenSinkInput "\
          "string=\"[SENSITIVE]\", "\
          "struct=\"[SENSITIVE]\", "\
          "document=#{document || 'nil'}, "\
          "list_of_strings=#{list_of_strings || 'nil'}, "\
          "list_of_structs=#{list_of_structs || 'nil'}, "\
          "map_of_strings=#{map_of_strings || 'nil'}, "\
          "map_of_structs=#{map_of_structs || 'nil'}, "\
          "set_of_strings=#{set_of_strings || 'nil'}, "\
          "set_of_structs=#{set_of_structs || 'nil'}, "\
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
    #   @note
    #     This shape is recommended.
    #     Reason: This structure member is
    #     cool AF.
    #
    #   @since today
    #
    #   @note
    #     This shape is sensitive and must be handled with care.
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
    #   @note
    #     This shape is sensitive and must be handled with care.
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
    # @!attribute set_of_strings
    #
    #   @return [Set<String>]
    #
    # @!attribute set_of_structs
    #
    #   @return [Set<Struct>]
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
    #   @note
    #     This shape is sensitive and must be handled with care.
    #
    #   @return [Union]
    #
    KitchenSinkOutput = ::Struct.new(
      :string,
      :struct,
      :document,
      :list_of_strings,
      :list_of_structs,
      :map_of_strings,
      :map_of_structs,
      :set_of_strings,
      :set_of_structs,
      :union,
      keyword_init: true
    ) do
      include Hearth::Structure

      def to_s
        "#<struct WhiteLabel::Types::KitchenSinkOutput "\
          "string=\"[SENSITIVE]\", "\
          "struct=\"[SENSITIVE]\", "\
          "document=#{document || 'nil'}, "\
          "list_of_strings=#{list_of_strings || 'nil'}, "\
          "list_of_structs=#{list_of_structs || 'nil'}, "\
          "map_of_strings=#{map_of_strings || 'nil'}, "\
          "map_of_structs=#{map_of_structs || 'nil'}, "\
          "set_of_strings=#{set_of_strings || 'nil'}, "\
          "set_of_structs=#{set_of_structs || 'nil'}, "\
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

    # @!attribute member____123next_token
    #
    #   @return [String]
    #
    ResultWrapper = ::Struct.new(
      :member____123next_token,
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
      # @note
      #   This shape is sensitive and must be handled with care.
      #
      class String < Union
        def to_h
          { string: super(__getobj__) }
        end

        def to_s
          "#<WhiteLabel::Types::String [SENSITIVE]>"
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
      # @note
      #   This shape is sensitive and must be handled with care.
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

    # @!attribute member____next_token
    #
    #   @return [String]
    #
    Struct____PaginatorsTestWithBadNamesInput = ::Struct.new(
      :member____next_token,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute member____wrapper
    #
    #   @return [ResultWrapper]
    #
    # @!attribute member____items
    #
    #   @return [Array<String>]
    #
    Struct____PaginatorsTestWithBadNamesOutput = ::Struct.new(
      :member____wrapper,
      :member____items,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
