# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  # @api private
  module Params

    class Events
      def self.build(params, context:)
        return params if params.is_a?(Types::Events)
        Hearth::Validator.validate_types!(params, ::Hash, Types::Events, context: context)
        unless params.size == 1
          raise ArgumentError,
                "Expected #{context} to have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :simple_event
          Types::Events::SimpleEvent.new(
            (SimpleEvent.build(params[:simple_event], context: "#{context}[:simple_event]") unless params[:simple_event].nil?)
          )
        when :nested_event
          Types::Events::NestedEvent.new(
            (NestedEvent.build(params[:nested_event], context: "#{context}[:nested_event]") unless params[:nested_event].nil?)
          )
        when :explicit_payload_event
          Types::Events::ExplicitPayloadEvent.new(
            (ExplicitPayloadEvent.build(params[:explicit_payload_event], context: "#{context}[:explicit_payload_event]") unless params[:explicit_payload_event].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :simple_event, :nested_event, :explicit_payload_event set"
        end
      end
    end

    class ExplicitPayloadEvent
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ExplicitPayloadEvent, context: context)
        type = Types::ExplicitPayloadEvent.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.header_a = params[:header_a] unless params[:header_a].nil?
        type.payload = NestedStructure.build(params[:payload], context: "#{context}[:payload]") unless params[:payload].nil?
        type
      end
    end

    class InitialStructure
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::InitialStructure, context: context)
        type = Types::InitialStructure.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.message = params[:message] unless params[:message].nil?
        type.nested = NestedStructure.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class NestedEvent
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NestedEvent, context: context)
        type = Types::NestedEvent.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = NestedStructure.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class NestedStructure
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NestedStructure, context: context)
        type = Types::NestedStructure.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.values = Values.build(params[:values], context: "#{context}[:values]") unless params[:values].nil?
        type
      end
    end

    class NonStreamingOperationInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NonStreamingOperationInput, context: context)
        type = Types::NonStreamingOperationInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.input_value = params[:input_value] unless params[:input_value].nil?
        type
      end
    end

    class NonStreamingOperationOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NonStreamingOperationOutput, context: context)
        type = Types::NonStreamingOperationOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.output_value = params[:output_value] unless params[:output_value].nil?
        type
      end
    end

    class SimpleEvent
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::SimpleEvent, context: context)
        type = Types::SimpleEvent.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.message = params[:message] unless params[:message].nil?
        type
      end
    end

    class StartEventStreamInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StartEventStreamInput, context: context)
        type = Types::StartEventStreamInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.event = Events.build(params[:event], context: "#{context}[:event]") unless params[:event].nil?
        type.initial_structure = InitialStructure.build(params[:initial_structure], context: "#{context}[:initial_structure]") unless params[:initial_structure].nil?
        type
      end
    end

    class StartEventStreamOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::StartEventStreamOutput, context: context)
        type = Types::StartEventStreamOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.event = Events.build(params[:event], context: "#{context}[:event]") unless params[:event].nil?
        type.initial_structure = InitialStructure.build(params[:initial_structure], context: "#{context}[:initial_structure]") unless params[:initial_structure].nil?
        type
      end
    end

    class Values
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

  end
end
