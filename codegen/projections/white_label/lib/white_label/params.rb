# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'securerandom'

module WhiteLabel
  module Params

    module ClientError
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ClientError, context: context)
        type = Types::ClientError.new
        type.message = params[:message]
        type
      end
    end

    module DefaultsTestInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DefaultsTestInput, context: context)
        type = Types::DefaultsTestInput.new
        type.string = params[:string]
        type.boxed_number = params[:boxed_number]
        type.default_number = params[:default_number]
        type.default_bool = params[:default_bool]
        type
      end
    end

    module DefaultsTestOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DefaultsTestOutput, context: context)
        type = Types::DefaultsTestOutput.new
        type.string = params[:string]
        type.boxed_number = params[:boxed_number]
        type.default_number = params[:default_number]
        type.default_bool = params[:default_bool]
        type
      end
    end

    module Items
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    module KitchenSinkInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::KitchenSinkInput, context: context)
        type = Types::KitchenSinkInput.new
        type.string = params[:string]
        type.simple_enum = params[:simple_enum]
        type.typed_enum = params[:typed_enum]
        type.struct = Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?
        type.document = params[:document]
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.set_of_strings = SetOfStrings.build(params[:set_of_strings], context: "#{context}[:set_of_strings]") unless params[:set_of_strings].nil?
        type.union = Union.build(params[:union], context: "#{context}[:union]") unless params[:union].nil?
        type
      end
    end

    module KitchenSinkOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::KitchenSinkOutput, context: context)
        type = Types::KitchenSinkOutput.new
        type.string = params[:string]
        type.simple_enum = params[:simple_enum]
        type.typed_enum = params[:typed_enum]
        type.struct = Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?
        type.document = params[:document]
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.set_of_strings = SetOfStrings.build(params[:set_of_strings], context: "#{context}[:set_of_strings]") unless params[:set_of_strings].nil?
        type.union = Union.build(params[:union], context: "#{context}[:union]") unless params[:union].nil?
        type
      end
    end

    module ListOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    module ListOfStructs
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << Struct.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module MapOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module MapOfStructs
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = Struct.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module PaginatorsTestOperationInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::PaginatorsTestOperationInput, context: context)
        type = Types::PaginatorsTestOperationInput.new
        type.next_token = params[:next_token]
        type
      end
    end

    module PaginatorsTestOperationOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::PaginatorsTestOperationOutput, context: context)
        type = Types::PaginatorsTestOperationOutput.new
        type.next_token = params[:next_token]
        type.items = Items.build(params[:items], context: "#{context}[:items]") unless params[:items].nil?
        type
      end
    end

    module PaginatorsTestWithItemsInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::PaginatorsTestWithItemsInput, context: context)
        type = Types::PaginatorsTestWithItemsInput.new
        type.next_token = params[:next_token]
        type
      end
    end

    module PaginatorsTestWithItemsOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::PaginatorsTestWithItemsOutput, context: context)
        type = Types::PaginatorsTestWithItemsOutput.new
        type.next_token = params[:next_token]
        type.items = Items.build(params[:items], context: "#{context}[:items]") unless params[:items].nil?
        type
      end
    end

    module ResultWrapper
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ResultWrapper, context: context)
        type = Types::ResultWrapper.new
        type.member___123next_token = params[:member___123next_token]
        type
      end
    end

    module ServerError
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ServerError, context: context)
        type = Types::ServerError.new
        type
      end
    end

    module SetOfStrings
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Set, ::Array, context: context)
        data = Set.new
        params.each do |element|
          data << element
        end
        data
      end
    end

    module Struct
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::Struct, context: context)
        type = Types::Struct.new
        type.value = params[:value]
        type
      end
    end

    module Union
      def self.build(params, context: '')
        return params if params.is_a?(Types::Union)
        Hearth::Validator.validate!(params, ::Hash, Types::Union, context: context)
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
            (Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :string, :struct set"
        end
      end
    end

    module WaitersTestInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::WaitersTestInput, context: context)
        type = Types::WaitersTestInput.new
        type.status = params[:status]
        type
      end
    end

    module WaitersTestOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::WaitersTestOutput, context: context)
        type = Types::WaitersTestOutput.new
        type.status = params[:status]
        type
      end
    end

    module Struct____PaginatorsTestWithBadNamesInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::Struct____PaginatorsTestWithBadNamesInput, context: context)
        type = Types::Struct____PaginatorsTestWithBadNamesInput.new
        type.member___next_token = params[:member___next_token]
        type
      end
    end

    module Struct____PaginatorsTestWithBadNamesOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::Struct____PaginatorsTestWithBadNamesOutput, context: context)
        type = Types::Struct____PaginatorsTestWithBadNamesOutput.new
        type.member___wrapper = ResultWrapper.build(params[:member___wrapper], context: "#{context}[:member___wrapper]") unless params[:member___wrapper].nil?
        type.member___items = Items.build(params[:member___items], context: "#{context}[:member___items]") unless params[:member___items].nil?
        type
      end
    end

  end
end
