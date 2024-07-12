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

    class EventA
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EventA, context: context)
        Hearth::Validator.validate_types!(input[:message], ::String, context: "#{context}[:message]")
      end
    end

    class EventB
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::EventB, context: context)
        NestedEvent.validate!(input[:nested], context: "#{context}[:nested]") unless input[:nested].nil?
      end
    end

    class EventValues
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class Events
      def self.validate!(input, context:)
        case input
        when Types::Events::EventA
          EventA.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        when Types::Events::EventB
          EventB.validate!(input.__getobj__, context: context) unless input.__getobj__.nil?
        else
          raise ArgumentError,
                "Expected #{context} to be a union member of "\
                "Types::Events, got #{input.class}."
        end
      end

      class EventA
        def self.validate!(input, context:)
          Validators::EventA.validate!(input, context: context) unless input.nil?
        end
      end

      class EventB
        def self.validate!(input, context:)
          Validators::EventB.validate!(input, context: context) unless input.nil?
        end
      end
    end

    class NestedEvent
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NestedEvent, context: context)
        EventValues.validate!(input[:member_values], context: "#{context}[:member_values]") unless input[:member_values].nil?
      end
    end

    class NonStreamingOperationInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NonStreamingOperationInput, context: context)
        Hearth::Validator.validate_types!(input[:input_value], ::String, context: "#{context}[:input_value]")
      end
    end

    class NonStreamingOperationOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::NonStreamingOperationOutput, context: context)
        Hearth::Validator.validate_types!(input[:output_value], ::String, context: "#{context}[:output_value]")
      end
    end

    class StartEventStreamInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StartEventStreamInput, context: context)
        Events.validate!(input[:event], context: "#{context}[:event]") unless input[:event].nil?
      end
    end

    class StartEventStreamOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::StartEventStreamOutput, context: context)
        Events.validate!(input[:event], context: "#{context}[:event]") unless input[:event].nil?
      end
    end

  end
end
