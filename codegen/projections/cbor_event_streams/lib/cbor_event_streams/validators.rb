# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  # @api private
  module Validators

    class Events
      def self.validate!(input, context:)
        case input
        when Types::Events::SimpleEvent
          SimpleEvent.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Events::NestedEvent
          NestedEvent.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Events::ExplicitPayloadEvent
          ExplicitPayloadEvent.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError, "Expected #{context} to be a union member of Types::Events, got #{input.class}."
        end
      end

      class SimpleEvent
        def self.validate!(input, context:)
          Validators::SimpleEvent.validate!(input, context: context) unless input.nil?
        end
      end

      class NestedEvent
        def self.validate!(input, context:)
          Validators::NestedEvent.validate!(input, context: context) unless input.nil?
        end
      end

      class ExplicitPayloadEvent
        def self.validate!(input, context:)
          Validators::ExplicitPayloadEvent.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class ExplicitPayloadEvent
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ExplicitPayloadEvent, context: context)
        Hearth::Validator.validate_types!(input.header_a, ::String, context: "#{context}[:header_a]")
        NestedStructure.validate!(input.payload, context: "#{context}[:payload]") unless input.payload.nil?
      end
    end

    class InitialStructure
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::InitialStructure, context: context)
        Hearth::Validator.validate_types!(input.message, ::String, context: "#{context}[:message]")
        NestedStructure.validate!(input.nested, context: "#{context}[:nested]") unless input.nested.nil?
      end
    end

    class NestedEvent
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NestedEvent, context: context)
        NestedStructure.validate!(input.nested, context: "#{context}[:nested]") unless input.nested.nil?
      end
    end

    class NestedStructure
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NestedStructure, context: context)
        Values.validate!(input.values, context: "#{context}[:values]") unless input.values.nil?
      end
    end

    class NonStreamingOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NonStreamingOperationInput, context: context)
        Hearth::Validator.validate_types!(input.input_value, ::String, context: "#{context}[:input_value]")
      end
    end

    class NonStreamingOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NonStreamingOperationOutput, context: context)
        Hearth::Validator.validate_types!(input.output_value, ::String, context: "#{context}[:output_value]")
      end
    end

    class SimpleEvent
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::SimpleEvent, context: context)
        Hearth::Validator.validate_types!(input.message, ::String, context: "#{context}[:message]")
      end
    end

    class StartEventStreamInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StartEventStreamInput, context: context)
        Events.validate!(input.event, context: "#{context}[:event]") unless input.event.nil?
        InitialStructure.validate!(input.initial_structure, context: "#{context}[:initial_structure]") unless input.initial_structure.nil?
      end
    end

    class StartEventStreamOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StartEventStreamOutput, context: context)
        Events.validate!(input.event, context: "#{context}[:event]") unless input.event.nil?
        InitialStructure.validate!(input.initial_structure, context: "#{context}[:initial_structure]") unless input.initial_structure.nil?
      end
    end

    class Values
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

  end
end
