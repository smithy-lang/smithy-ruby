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

    class EventA
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EventA, context: context)
        type = Types::EventA.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.message = params[:message] unless params[:message].nil?
        type
      end
    end

    class EventB
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::EventB, context: context)
        type = Types::EventB.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.nested = NestedEvent.build(params[:nested], context: "#{context}[:nested]") unless params[:nested].nil?
        type
      end
    end

    class EventValues
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

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
        when :event_a
          Types::Events::EventA.new(
            (EventA.build(params[:event_a], context: "#{context}[:event_a]") unless params[:event_a].nil?)
          )
        when :event_b
          Types::Events::EventB.new(
            (EventB.build(params[:event_b], context: "#{context}[:event_b]") unless params[:event_b].nil?)
          )
        else
          raise ArgumentError,
                "Expected #{context} to have one of :event_a, :event_b set"
        end
      end
    end

    class InitialStructure
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::InitialStructure, context: context)
        type = Types::InitialStructure.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.message = params[:message] unless params[:message].nil?
        type
      end
    end

    class NestedEvent
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::NestedEvent, context: context)
        type = Types::NestedEvent.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.member_values = EventValues.build(params[:member_values], context: "#{context}[:member_values]") unless params[:member_values].nil?
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

  end
end
