# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Validators

    class Document
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, ::String, ::Array, ::TrueClass, ::FalseClass, ::Numeric, context: context)
        case input
        when ::Hash
          input.each do |k,v|
            validate!(v, context: "#{context}[:#{k}]")
          end
        when ::Array
          input.each_with_index do |v, i|
            validate!(v, context: "#{context}[#{i}]")
          end
        end
      end
    end

    class KitchenSinkInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::KitchenSinkInput, context: context)
        Hearth::Validator.validate!(input[:string], ::String, context: "#{context}[:string]")
        Validators::Struct.validate!(input[:struct], context: "#{context}[:struct]") unless input[:struct].nil?
        Validators::Document.validate!(input[:document], context: "#{context}[:document]") unless input[:document].nil?
        Validators::ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        Validators::ListOfStructs.validate!(input[:list_of_structs], context: "#{context}[:list_of_structs]") unless input[:list_of_structs].nil?
        Validators::MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        Validators::MapOfStructs.validate!(input[:map_of_structs], context: "#{context}[:map_of_structs]") unless input[:map_of_structs].nil?
        Validators::SetOfStrings.validate!(input[:set_of_strings], context: "#{context}[:set_of_strings]") unless input[:set_of_strings].nil?
        Validators::SetOfStructs.validate!(input[:set_of_structs], context: "#{context}[:set_of_structs]") unless input[:set_of_structs].nil?
        Validators::Union.validate!(input[:union], context: "#{context}[:union]") unless input[:union].nil?
      end
    end

    class ListOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class ListOfStructs
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Validators::Struct.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class MapOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class MapOfStructs
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate!(key, ::String, ::Symbol, context: "#{context}.keys")
          Validators::Struct.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class PaginatorsTestOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::PaginatorsTestOperationInput, context: context)
        Hearth::Validator.validate!(input[:next_token], ::String, context: "#{context}[:next_token]")
      end
    end

    class PaginatorsTestWithItemsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::PaginatorsTestWithItemsInput, context: context)
        Hearth::Validator.validate!(input[:next_token], ::String, context: "#{context}[:next_token]")
      end
    end

    class SetOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Set, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class SetOfStructs
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, ::Set, context: context)
        input.each_with_index do |element, index|
          Validators::Struct.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class Struct
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct, context: context)
        Hearth::Validator.validate!(input[:value], ::String, context: "#{context}[:value]")
      end
    end

    class Union
      def self.validate!(input, context:)
        case input
        when Types::Union::String
          Hearth::Validator.validate!(input.__getobj__, ::String, context: context)
        when Types::Union::Struct
          Validators::Struct.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::Union, got #{input.class}."
        end
      end

      class String
        def self.validate!(input, context:)
          Hearth::Validator.validate!(input, ::String, context: context)
        end
      end

      class Struct
        def self.validate!(input, context:)
          Validators::Struct.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class WaitersTestInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::WaitersTestInput, context: context)
        Hearth::Validator.validate!(input[:status], ::String, context: "#{context}[:status]")
      end
    end

    class Struct____PaginatorsTestWithBadNamesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::Struct____PaginatorsTestWithBadNamesInput, context: context)
        Hearth::Validator.validate!(input[:member____next_token], ::String, context: "#{context}[:member____next_token]")
      end
    end

  end
end
