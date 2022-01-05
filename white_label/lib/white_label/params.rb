# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Params

    module KitchenSinkInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Hash, Types::KitchenSinkInput, context: context)
        type = Types::KitchenSinkInput.new
        type.string = params[:string]
        type.struct = Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?
        type.document = params[:document]
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.set_of_strings = SetOfStrings.build(params[:set_of_strings], context: "#{context}[:set_of_strings]") unless params[:set_of_strings].nil?
        type.set_of_structs = SetOfStructs.build(params[:set_of_structs], context: "#{context}[:set_of_structs]") unless params[:set_of_structs].nil?
        type.union = Union.build(params[:union], context: "#{context}[:union]") unless params[:union].nil?
        type
      end
    end

    module ListOfStrings
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module ListOfStructs
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << Struct.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module MapOfStrings
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module MapOfStructs
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = Struct.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module PaginatorsTestInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Hash, Types::PaginatorsTestInput, context: context)
        type = Types::PaginatorsTestInput.new
        type.next_token = params[:next_token]
        type
      end
    end

    module PaginatorsTestWithItemsInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Hash, Types::PaginatorsTestWithItemsInput, context: context)
        type = Types::PaginatorsTestWithItemsInput.new
        type.next_token = params[:next_token]
        type
      end
    end

    module SetOfStrings
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Set, ::Array, context: context)
        data = Set.new
        params.each_with_index do |element, index|
          data << element
        end
        data
      end
    end

    module SetOfStructs
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Set, ::Array, context: context)
        data = Set.new
        params.each_with_index do |element, index|
          data << Struct.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module Struct
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Hash, Types::Struct, context: context)
        type = Types::Struct.new
        type.value = params[:value]
        type
      end
    end

    module Union
      def self.build(params, context: '')
        return params if params.is_a?(Types::Union)
        Seahorse::Validator.validate!(params, ::Hash, Types::Union, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :string
          Types::Union::String.new(
            params[:string]
          )
        when :struct
          Types::Union::Struct.new(
            Struct.build(params[:struct], context: "#{context}[:struct]")
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :string, :struct set"
        end
      end
    end

    module WaitersTestInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, ::Hash, Types::WaitersTestInput, context: context)
        type = Types::WaitersTestInput.new
        type.status = params[:status]
        type
      end
    end

  end
end
