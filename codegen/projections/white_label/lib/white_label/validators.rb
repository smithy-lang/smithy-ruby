# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'time'

module WhiteLabel
  # @api private
  module Validators

    class ClientError
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ClientError, context: context)
        Hearth::Validator.validate_types!(input[:message], ::String, context: "#{context}[:message]")
      end
    end

    class DefaultsTestInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DefaultsTestInput, context: context)
        Hearth::Validator.validate_types!(input[:string], ::String, context: "#{context}[:string]")
        Struct.validate!(input[:struct], context: "#{context}[:struct]") unless input[:struct].nil?
        Hearth::Validator.validate_types!(input[:un_required_number], ::Integer, context: "#{context}[:un_required_number]")
        Hearth::Validator.validate_types!(input[:un_required_bool], ::TrueClass, ::FalseClass, context: "#{context}[:un_required_bool]")
        Hearth::Validator.validate_required!(input[:number], context: "#{context}[:number]")
        Hearth::Validator.validate_types!(input[:number], ::Integer, context: "#{context}[:number]")
        Hearth::Validator.validate_required!(input[:bool], context: "#{context}[:bool]")
        Hearth::Validator.validate_types!(input[:bool], ::TrueClass, ::FalseClass, context: "#{context}[:bool]")
        Hearth::Validator.validate_required!(input[:hello], context: "#{context}[:hello]")
        Hearth::Validator.validate_types!(input[:hello], ::String, context: "#{context}[:hello]")
        Hearth::Validator.validate_required!(input[:simple_enum], context: "#{context}[:simple_enum]")
        Hearth::Validator.validate_types!(input[:simple_enum], ::String, context: "#{context}[:simple_enum]")
        Hearth::Validator.validate_required!(input[:typed_enum], context: "#{context}[:typed_enum]")
        Hearth::Validator.validate_types!(input[:typed_enum], ::String, context: "#{context}[:typed_enum]")
        Hearth::Validator.validate_required!(input[:int_enum], context: "#{context}[:int_enum]")
        Hearth::Validator.validate_types!(input[:int_enum], ::Integer, context: "#{context}[:int_enum]")
        Hearth::Validator.validate_required!(input[:null_document], context: "#{context}[:null_document]")
        Document.validate!(input[:null_document], context: "#{context}[:null_document]") unless input[:null_document].nil?
        Hearth::Validator.validate_required!(input[:string_document], context: "#{context}[:string_document]")
        Document.validate!(input[:string_document], context: "#{context}[:string_document]") unless input[:string_document].nil?
        Hearth::Validator.validate_required!(input[:boolean_document], context: "#{context}[:boolean_document]")
        Document.validate!(input[:boolean_document], context: "#{context}[:boolean_document]") unless input[:boolean_document].nil?
        Hearth::Validator.validate_required!(input[:numbers_document], context: "#{context}[:numbers_document]")
        Document.validate!(input[:numbers_document], context: "#{context}[:numbers_document]") unless input[:numbers_document].nil?
        Hearth::Validator.validate_required!(input[:list_document], context: "#{context}[:list_document]")
        Document.validate!(input[:list_document], context: "#{context}[:list_document]") unless input[:list_document].nil?
        Hearth::Validator.validate_required!(input[:map_document], context: "#{context}[:map_document]")
        Document.validate!(input[:map_document], context: "#{context}[:map_document]") unless input[:map_document].nil?
        Hearth::Validator.validate_required!(input[:list_of_strings], context: "#{context}[:list_of_strings]")
        ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        Hearth::Validator.validate_required!(input[:map_of_strings], context: "#{context}[:map_of_strings]")
        MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        Hearth::Validator.validate_required!(input[:iso8601_timestamp], context: "#{context}[:iso8601_timestamp]")
        Hearth::Validator.validate_types!(input[:iso8601_timestamp], ::Time, context: "#{context}[:iso8601_timestamp]")
        Hearth::Validator.validate_required!(input[:epoch_timestamp], context: "#{context}[:epoch_timestamp]")
        Hearth::Validator.validate_types!(input[:epoch_timestamp], ::Time, context: "#{context}[:epoch_timestamp]")
      end
    end

    class DefaultsTestOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DefaultsTestOutput, context: context)
        Hearth::Validator.validate_types!(input[:string], ::String, context: "#{context}[:string]")
        Struct.validate!(input[:struct], context: "#{context}[:struct]") unless input[:struct].nil?
        Hearth::Validator.validate_types!(input[:un_required_number], ::Integer, context: "#{context}[:un_required_number]")
        Hearth::Validator.validate_types!(input[:un_required_bool], ::TrueClass, ::FalseClass, context: "#{context}[:un_required_bool]")
        Hearth::Validator.validate_required!(input[:number], context: "#{context}[:number]")
        Hearth::Validator.validate_types!(input[:number], ::Integer, context: "#{context}[:number]")
        Hearth::Validator.validate_required!(input[:bool], context: "#{context}[:bool]")
        Hearth::Validator.validate_types!(input[:bool], ::TrueClass, ::FalseClass, context: "#{context}[:bool]")
        Hearth::Validator.validate_required!(input[:hello], context: "#{context}[:hello]")
        Hearth::Validator.validate_types!(input[:hello], ::String, context: "#{context}[:hello]")
        Hearth::Validator.validate_required!(input[:simple_enum], context: "#{context}[:simple_enum]")
        Hearth::Validator.validate_types!(input[:simple_enum], ::String, context: "#{context}[:simple_enum]")
        Hearth::Validator.validate_required!(input[:typed_enum], context: "#{context}[:typed_enum]")
        Hearth::Validator.validate_types!(input[:typed_enum], ::String, context: "#{context}[:typed_enum]")
        Hearth::Validator.validate_required!(input[:int_enum], context: "#{context}[:int_enum]")
        Hearth::Validator.validate_types!(input[:int_enum], ::Integer, context: "#{context}[:int_enum]")
        Hearth::Validator.validate_required!(input[:null_document], context: "#{context}[:null_document]")
        Document.validate!(input[:null_document], context: "#{context}[:null_document]") unless input[:null_document].nil?
        Hearth::Validator.validate_required!(input[:string_document], context: "#{context}[:string_document]")
        Document.validate!(input[:string_document], context: "#{context}[:string_document]") unless input[:string_document].nil?
        Hearth::Validator.validate_required!(input[:boolean_document], context: "#{context}[:boolean_document]")
        Document.validate!(input[:boolean_document], context: "#{context}[:boolean_document]") unless input[:boolean_document].nil?
        Hearth::Validator.validate_required!(input[:numbers_document], context: "#{context}[:numbers_document]")
        Document.validate!(input[:numbers_document], context: "#{context}[:numbers_document]") unless input[:numbers_document].nil?
        Hearth::Validator.validate_required!(input[:list_document], context: "#{context}[:list_document]")
        Document.validate!(input[:list_document], context: "#{context}[:list_document]") unless input[:list_document].nil?
        Hearth::Validator.validate_required!(input[:map_document], context: "#{context}[:map_document]")
        Document.validate!(input[:map_document], context: "#{context}[:map_document]") unless input[:map_document].nil?
        Hearth::Validator.validate_required!(input[:list_of_strings], context: "#{context}[:list_of_strings]")
        ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        Hearth::Validator.validate_required!(input[:map_of_strings], context: "#{context}[:map_of_strings]")
        MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        Hearth::Validator.validate_required!(input[:iso8601_timestamp], context: "#{context}[:iso8601_timestamp]")
        Hearth::Validator.validate_types!(input[:iso8601_timestamp], ::Time, context: "#{context}[:iso8601_timestamp]")
        Hearth::Validator.validate_required!(input[:epoch_timestamp], context: "#{context}[:epoch_timestamp]")
        Hearth::Validator.validate_types!(input[:epoch_timestamp], ::Time, context: "#{context}[:epoch_timestamp]")
      end
    end

    class Document
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, ::String, ::Array, ::TrueClass, ::FalseClass, ::Numeric, context: context)
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

    class EndpointOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointOperationInput, context: context)
      end
    end

    class EndpointOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointOperationOutput, context: context)
      end
    end

    class EndpointWithHostLabelOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointWithHostLabelOperationInput, context: context)
        Hearth::Validator.validate_required!(input[:label_member], context: "#{context}[:label_member]")
        Hearth::Validator.validate_types!(input[:label_member], ::String, context: "#{context}[:label_member]")
      end
    end

    class EndpointWithHostLabelOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EndpointWithHostLabelOperationOutput, context: context)
      end
    end

    class HttpApiKeyAuthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpApiKeyAuthInput, context: context)
      end
    end

    class HttpApiKeyAuthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpApiKeyAuthOutput, context: context)
      end
    end

    class HttpBasicAuthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpBasicAuthInput, context: context)
      end
    end

    class HttpBasicAuthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpBasicAuthOutput, context: context)
      end
    end

    class HttpBearerAuthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpBearerAuthInput, context: context)
      end
    end

    class HttpBearerAuthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpBearerAuthOutput, context: context)
      end
    end

    class HttpDigestAuthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpDigestAuthInput, context: context)
      end
    end

    class HttpDigestAuthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HttpDigestAuthOutput, context: context)
      end
    end

    class Items
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class KitchenSinkInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::KitchenSinkInput, context: context)
        Hearth::Validator.validate_types!(input[:string], ::String, context: "#{context}[:string]")
        Hearth::Validator.validate_types!(input[:simple_enum], ::String, context: "#{context}[:simple_enum]")
        Hearth::Validator.validate_types!(input[:typed_enum], ::String, context: "#{context}[:typed_enum]")
        Struct.validate!(input[:struct], context: "#{context}[:struct]") unless input[:struct].nil?
        Document.validate!(input[:document], context: "#{context}[:document]") unless input[:document].nil?
        ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        ListOfStructs.validate!(input[:list_of_structs], context: "#{context}[:list_of_structs]") unless input[:list_of_structs].nil?
        MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        MapOfStructs.validate!(input[:map_of_structs], context: "#{context}[:map_of_structs]") unless input[:map_of_structs].nil?
        Union.validate!(input[:union], context: "#{context}[:union]") unless input[:union].nil?
      end
    end

    class KitchenSinkOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::KitchenSinkOutput, context: context)
        Hearth::Validator.validate_types!(input[:string], ::String, context: "#{context}[:string]")
        Hearth::Validator.validate_types!(input[:simple_enum], ::String, context: "#{context}[:simple_enum]")
        Hearth::Validator.validate_types!(input[:typed_enum], ::String, context: "#{context}[:typed_enum]")
        Struct.validate!(input[:struct], context: "#{context}[:struct]") unless input[:struct].nil?
        Document.validate!(input[:document], context: "#{context}[:document]") unless input[:document].nil?
        ListOfStrings.validate!(input[:list_of_strings], context: "#{context}[:list_of_strings]") unless input[:list_of_strings].nil?
        ListOfStructs.validate!(input[:list_of_structs], context: "#{context}[:list_of_structs]") unless input[:list_of_structs].nil?
        MapOfStrings.validate!(input[:map_of_strings], context: "#{context}[:map_of_strings]") unless input[:map_of_strings].nil?
        MapOfStructs.validate!(input[:map_of_structs], context: "#{context}[:map_of_structs]") unless input[:map_of_structs].nil?
        Union.validate!(input[:union], context: "#{context}[:union]") unless input[:union].nil?
      end
    end

    class ListOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class ListOfStructs
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Struct.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class MapOfStrings
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Hearth::Validator.validate_types!(value, ::String, context: "#{context}[:#{key}]")
        end
      end
    end

    class MapOfStructs
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          Struct.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class MixinTestInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::MixinTestInput, context: context)
        Hearth::Validator.validate_types!(input[:user_id], ::String, context: "#{context}[:user_id]")
      end
    end

    class MixinTestOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::MixinTestOutput, context: context)
        Hearth::Validator.validate_types!(input[:username], ::String, context: "#{context}[:username]")
        Hearth::Validator.validate_types!(input[:user_id], ::String, context: "#{context}[:user_id]")
      end
    end

    class NoAuthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoAuthInput, context: context)
      end
    end

    class NoAuthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NoAuthOutput, context: context)
      end
    end

    class OptionalAuthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OptionalAuthInput, context: context)
      end
    end

    class OptionalAuthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OptionalAuthOutput, context: context)
      end
    end

    class OrderedAuthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OrderedAuthInput, context: context)
      end
    end

    class OrderedAuthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::OrderedAuthOutput, context: context)
      end
    end

    class PaginatorsTestOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PaginatorsTestOperationInput, context: context)
        Hearth::Validator.validate_types!(input[:next_token], ::String, context: "#{context}[:next_token]")
      end
    end

    class PaginatorsTestOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PaginatorsTestOperationOutput, context: context)
        Hearth::Validator.validate_types!(input[:next_token], ::String, context: "#{context}[:next_token]")
        Items.validate!(input[:items], context: "#{context}[:items]") unless input[:items].nil?
      end
    end

    class PaginatorsTestWithItemsInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PaginatorsTestWithItemsInput, context: context)
        Hearth::Validator.validate_types!(input[:next_token], ::String, context: "#{context}[:next_token]")
      end
    end

    class PaginatorsTestWithItemsOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::PaginatorsTestWithItemsOutput, context: context)
        Hearth::Validator.validate_types!(input[:next_token], ::String, context: "#{context}[:next_token]")
        Items.validate!(input[:items], context: "#{context}[:items]") unless input[:items].nil?
      end
    end

    class RelativeMiddlewareOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RelativeMiddlewareOperationInput, context: context)
      end
    end

    class RelativeMiddlewareOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RelativeMiddlewareOperationOutput, context: context)
      end
    end

    class RequestCompressionOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RequestCompressionOperationInput, context: context)
        Hearth::Validator.validate_types!(input[:body], ::String, context: "#{context}[:body]")
      end
    end

    class RequestCompressionOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RequestCompressionOperationOutput, context: context)
      end
    end

    class RequestCompressionStreamingOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RequestCompressionStreamingOperationInput, context: context)
        unless input[:body].respond_to?(:read) || input[:body].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:body].class}"
        end
      end
    end

    class RequestCompressionStreamingOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::RequestCompressionStreamingOperationOutput, context: context)
      end
    end

    class ResultWrapper
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ResultWrapper, context: context)
        Hearth::Validator.validate_types!(input[:member___123next_token], ::String, context: "#{context}[:member___123next_token]")
      end
    end

    class ServerError
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ServerError, context: context)
      end
    end

    class StreamingOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingOperationInput, context: context)
        unless input[:stream].respond_to?(:read) || input[:stream].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:stream].class}"
        end
      end
    end

    class StreamingOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingOperationOutput, context: context)
        unless input[:stream].respond_to?(:read) || input[:stream].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:stream].class}"
        end
      end
    end

    class StreamingWithLengthInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingWithLengthInput, context: context)
        unless input[:stream].respond_to?(:read) || input[:stream].respond_to?(:readpartial)
          raise ArgumentError, "Expected #{context} to be an IO like object, got #{input[:stream].class}"
        end

        unless input[:stream].respond_to?(:size)
          raise ArgumentError, "Expected #{context} to respond_to(:size)"
        end
      end
    end

    class StreamingWithLengthOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StreamingWithLengthOutput, context: context)
      end
    end

    class Struct
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Struct, context: context)
        Hearth::Validator.validate_types!(input[:value], ::String, context: "#{context}[:value]")
      end
    end

    class Union
      def self.validate!(input, context:)
        case input
        when Types::Union::String
          Hearth::Validator.validate_types!(input.__getobj__, ::String, context: context)
        when Types::Union::Struct
          Struct.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::Union, got #{input.class}."
        end
      end

      class String
        def self.validate!(input, context:)
          Hearth::Validator.validate_types!(input, ::String, context: context)
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
        Hearth::Validator.validate_types!(input, Types::WaitersTestInput, context: context)
        Hearth::Validator.validate_types!(input[:status], ::String, context: "#{context}[:status]")
      end
    end

    class WaitersTestOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::WaitersTestOutput, context: context)
        Hearth::Validator.validate_types!(input[:status], ::String, context: "#{context}[:status]")
      end
    end

    class Struct____PaginatorsTestWithBadNamesInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Struct____PaginatorsTestWithBadNamesInput, context: context)
        Hearth::Validator.validate_types!(input[:member___next_token], ::String, context: "#{context}[:member___next_token]")
      end
    end

    class Struct____PaginatorsTestWithBadNamesOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::Struct____PaginatorsTestWithBadNamesOutput, context: context)
        ResultWrapper.validate!(input[:member___wrapper], context: "#{context}[:member___wrapper]") unless input[:member___wrapper].nil?
        Items.validate!(input[:member___items], context: "#{context}[:member___items]") unless input[:member___items].nil?
      end
    end

  end
end
