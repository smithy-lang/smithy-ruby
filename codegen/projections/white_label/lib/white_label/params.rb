# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  # @api private
  module Params

    module ClientError
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ClientError, context: context)
        type = Types::ClientError.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.message = params[:message]
        type
      end
    end

    module CustomAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::CustomAuthInput, context: context)
        type = Types::CustomAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module CustomAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::CustomAuthOutput, context: context)
        type = Types::CustomAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module DataplaneOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DataplaneOperationInput, context: context)
        type = Types::DataplaneOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module DataplaneOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DataplaneOperationOutput, context: context)
        type = Types::DataplaneOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module DefaultsTestInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DefaultsTestInput, context: context)
        type = Types::DefaultsTestInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string = params[:string]
        type.struct = Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?
        type.un_required_number = params[:un_required_number]
        type.un_required_bool = params[:un_required_bool]
        type.number = params.fetch(:number, 0)
        type.bool = params.fetch(:bool, false)
        type.hello = params.fetch(:hello, "world")
        type.simple_enum = params.fetch(:simple_enum, "YES")
        type.typed_enum = params.fetch(:typed_enum, "NO")
        type.int_enum = params.fetch(:int_enum, 1)
        type.null_document = params[:null_document]
        type.string_document = params.fetch(:string_document, "some string document")
        type.boolean_document = params.fetch(:boolean_document, true)
        type.numbers_document = params.fetch(:numbers_document, 1.23)
        type.list_document = params.fetch(:list_document, [])
        type.map_document = params.fetch(:map_document, {})
        type.list_of_strings = ListOfStrings.build(params.fetch(:list_of_strings, []), context: "#{context}[:list_of_strings]")
        type.map_of_strings = MapOfStrings.build(params.fetch(:map_of_strings, {}), context: "#{context}[:map_of_strings]")
        type.iso8601_timestamp = params.fetch(:iso8601_timestamp, "1985-04-12T23:20:50.52Z")
        type.epoch_timestamp = params.fetch(:epoch_timestamp, 1.5155310811234E9)
        type
      end
    end

    module DefaultsTestOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DefaultsTestOutput, context: context)
        type = Types::DefaultsTestOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string = params[:string]
        type.struct = Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?
        type.un_required_number = params[:un_required_number]
        type.un_required_bool = params[:un_required_bool]
        type.number = params.fetch(:number, 0)
        type.bool = params.fetch(:bool, false)
        type.hello = params.fetch(:hello, "world")
        type.simple_enum = params.fetch(:simple_enum, "YES")
        type.typed_enum = params.fetch(:typed_enum, "NO")
        type.int_enum = params.fetch(:int_enum, 1)
        type.null_document = params[:null_document]
        type.string_document = params.fetch(:string_document, "some string document")
        type.boolean_document = params.fetch(:boolean_document, true)
        type.numbers_document = params.fetch(:numbers_document, 1.23)
        type.list_document = params.fetch(:list_document, [])
        type.map_document = params.fetch(:map_document, {})
        type.list_of_strings = ListOfStrings.build(params.fetch(:list_of_strings, []), context: "#{context}[:list_of_strings]")
        type.map_of_strings = MapOfStrings.build(params.fetch(:map_of_strings, {}), context: "#{context}[:map_of_strings]")
        type.iso8601_timestamp = params.fetch(:iso8601_timestamp, "1985-04-12T23:20:50.52Z")
        type.epoch_timestamp = params.fetch(:epoch_timestamp, 1.5155310811234E9)
        type
      end
    end

    module EndpointOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointOperationInput, context: context)
        type = Types::EndpointOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module EndpointOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointOperationOutput, context: context)
        type = Types::EndpointOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module EndpointOperationWithResourceInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointOperationWithResourceInput, context: context)
        type = Types::EndpointOperationWithResourceInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.resource_url = params[:resource_url]
        type
      end
    end

    module EndpointOperationWithResourceOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointOperationWithResourceOutput, context: context)
        type = Types::EndpointOperationWithResourceOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module EndpointWithHostLabelOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointWithHostLabelOperationInput, context: context)
        type = Types::EndpointWithHostLabelOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.label_member = params[:label_member]
        type
      end
    end

    module EndpointWithHostLabelOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EndpointWithHostLabelOperationOutput, context: context)
        type = Types::EndpointWithHostLabelOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpApiKeyAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpApiKeyAuthInput, context: context)
        type = Types::HttpApiKeyAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpApiKeyAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpApiKeyAuthOutput, context: context)
        type = Types::HttpApiKeyAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpBasicAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpBasicAuthInput, context: context)
        type = Types::HttpBasicAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpBasicAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpBasicAuthOutput, context: context)
        type = Types::HttpBasicAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpBearerAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpBearerAuthInput, context: context)
        type = Types::HttpBearerAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpBearerAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpBearerAuthOutput, context: context)
        type = Types::HttpBearerAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpDigestAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpDigestAuthInput, context: context)
        type = Types::HttpDigestAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module HttpDigestAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HttpDigestAuthOutput, context: context)
        type = Types::HttpDigestAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module Items
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    module KitchenSinkInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::KitchenSinkInput, context: context)
        type = Types::KitchenSinkInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string = params[:string]
        type.simple_enum = params[:simple_enum]
        type.typed_enum = params[:typed_enum]
        type.struct = Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?
        type.document = params[:document]
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.union = Union.build(params[:union], context: "#{context}[:union]") unless params[:union].nil?
        type
      end
    end

    module KitchenSinkOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::KitchenSinkOutput, context: context)
        type = Types::KitchenSinkOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.string = params[:string]
        type.simple_enum = params[:simple_enum]
        type.typed_enum = params[:typed_enum]
        type.struct = Struct.build(params[:struct], context: "#{context}[:struct]") unless params[:struct].nil?
        type.document = params[:document]
        type.list_of_strings = ListOfStrings.build(params[:list_of_strings], context: "#{context}[:list_of_strings]") unless params[:list_of_strings].nil?
        type.list_of_structs = ListOfStructs.build(params[:list_of_structs], context: "#{context}[:list_of_structs]") unless params[:list_of_structs].nil?
        type.map_of_strings = MapOfStrings.build(params[:map_of_strings], context: "#{context}[:map_of_strings]") unless params[:map_of_strings].nil?
        type.map_of_structs = MapOfStructs.build(params[:map_of_structs], context: "#{context}[:map_of_structs]") unless params[:map_of_structs].nil?
        type.union = Union.build(params[:union], context: "#{context}[:union]") unless params[:union].nil?
        type
      end
    end

    module ListOfStrings
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    module ListOfStructs
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << Struct.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module MapOfStrings
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = value
        end
        data
      end
    end

    module MapOfStructs
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = Struct.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module MixinTestInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::MixinTestInput, context: context)
        type = Types::MixinTestInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.user_id = params[:user_id]
        type
      end
    end

    module MixinTestOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::MixinTestOutput, context: context)
        type = Types::MixinTestOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.username = params[:username]
        type.user_id = params[:user_id]
        type
      end
    end

    module NoAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NoAuthInput, context: context)
        type = Types::NoAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module NoAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NoAuthOutput, context: context)
        type = Types::NoAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module OptionalAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OptionalAuthInput, context: context)
        type = Types::OptionalAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module OptionalAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OptionalAuthOutput, context: context)
        type = Types::OptionalAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module OrderedAuthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OrderedAuthInput, context: context)
        type = Types::OrderedAuthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module OrderedAuthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::OrderedAuthOutput, context: context)
        type = Types::OrderedAuthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module PaginatorsTestOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PaginatorsTestOperationInput, context: context)
        type = Types::PaginatorsTestOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.next_token = params[:next_token]
        type
      end
    end

    module PaginatorsTestOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PaginatorsTestOperationOutput, context: context)
        type = Types::PaginatorsTestOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.next_token = params[:next_token]
        type.items = Items.build(params[:items], context: "#{context}[:items]") unless params[:items].nil?
        type
      end
    end

    module PaginatorsTestWithItemsInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PaginatorsTestWithItemsInput, context: context)
        type = Types::PaginatorsTestWithItemsInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.next_token = params[:next_token]
        type
      end
    end

    module PaginatorsTestWithItemsOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::PaginatorsTestWithItemsOutput, context: context)
        type = Types::PaginatorsTestWithItemsOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.next_token = params[:next_token]
        type.items = Items.build(params[:items], context: "#{context}[:items]") unless params[:items].nil?
        type
      end
    end

    module RelativeMiddlewareOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RelativeMiddlewareOperationInput, context: context)
        type = Types::RelativeMiddlewareOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module RelativeMiddlewareOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RelativeMiddlewareOperationOutput, context: context)
        type = Types::RelativeMiddlewareOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module RequestCompressionOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RequestCompressionOperationInput, context: context)
        type = Types::RequestCompressionOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.body = params[:body]
        type
      end
    end

    module RequestCompressionOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RequestCompressionOperationOutput, context: context)
        type = Types::RequestCompressionOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module RequestCompressionStreamingOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RequestCompressionStreamingOperationInput, context: context)
        type = Types::RequestCompressionStreamingOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        io = params[:body] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.body = io
        type
      end
    end

    module RequestCompressionStreamingOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::RequestCompressionStreamingOperationOutput, context: context)
        type = Types::RequestCompressionStreamingOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module ResultWrapper
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ResultWrapper, context: context)
        type = Types::ResultWrapper.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.member___123next_token = params[:member___123next_token]
        type
      end
    end

    module ServerError
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ServerError, context: context)
        type = Types::ServerError.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module StreamingOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingOperationInput, context: context)
        type = Types::StreamingOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        io = params[:stream] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.stream = io
        type
      end
    end

    module StreamingOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingOperationOutput, context: context)
        type = Types::StreamingOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        io = params[:stream] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.stream = io
        type
      end
    end

    module StreamingWithLengthInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingWithLengthInput, context: context)
        type = Types::StreamingWithLengthInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        io = params[:stream] || StringIO.new
        unless io.respond_to?(:read) || io.respond_to?(:readpartial)
          io = StringIO.new(io)
        end
        type.stream = io
        type
      end
    end

    module StreamingWithLengthOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StreamingWithLengthOutput, context: context)
        type = Types::StreamingWithLengthOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    module Struct
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Struct, context: context)
        type = Types::Struct.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.value = params[:value]
        type
      end
    end

    module Union
      def self.build(params, context:)
        return params if params.is_a?(Types::Union)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Union, context: context)
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
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::WaitersTestInput, context: context)
        type = Types::WaitersTestInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.status = params[:status]
        type
      end
    end

    module WaitersTestOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::WaitersTestOutput, context: context)
        type = Types::WaitersTestOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.status = params[:status]
        type
      end
    end

    module Struct____PaginatorsTestWithBadNamesInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Struct____PaginatorsTestWithBadNamesInput, context: context)
        type = Types::Struct____PaginatorsTestWithBadNamesInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.member___next_token = params[:member___next_token]
        type
      end
    end

    module Struct____PaginatorsTestWithBadNamesOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Struct____PaginatorsTestWithBadNamesOutput, context: context)
        type = Types::Struct____PaginatorsTestWithBadNamesOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.member___wrapper = ResultWrapper.build(params[:member___wrapper], context: "#{context}[:member___wrapper]") unless params[:member___wrapper].nil?
        type.member___items = Items.build(params[:member___items], context: "#{context}[:member___items]") unless params[:member___items].nil?
        type
      end
    end

  end
end
