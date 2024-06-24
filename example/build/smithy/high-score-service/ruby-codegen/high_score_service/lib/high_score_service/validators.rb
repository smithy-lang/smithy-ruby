# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'time'

module HighScoreService
  # @api private
  module Validators

    class AttributeErrors
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Hash, context: context)
        input.each do |key, value|
          Hearth::Validator.validate_types!(key, ::String, ::Symbol, context: "#{context}.keys")
          ErrorMessages.validate!(value, context: "#{context}[:#{key}]") unless value.nil?
        end
      end
    end

    class CreateHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::CreateHighScoreInput, context: context)
        Hearth::Validator.validate_required!(input[:high_score], context: "#{context}[:high_score]")
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
      end
    end

    class CreateHighScoreOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::CreateHighScoreOutput, context: context)
        HighScoreAttributes.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
        Hearth::Validator.validate_types!(input[:location], ::String, context: "#{context}[:location]")
      end
    end

    class DeleteHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DeleteHighScoreInput, context: context)
        Hearth::Validator.validate_required!(input[:id], context: "#{context}[:id]")
        Hearth::Validator.validate_types!(input[:id], ::String, context: "#{context}[:id]")
      end
    end

    class DeleteHighScoreOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DeleteHighScoreOutput, context: context)
      end
    end

    class ErrorMessages
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          Hearth::Validator.validate_types!(element, ::String, context: "#{context}[#{index}]")
        end
      end
    end

    class GetHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetHighScoreInput, context: context)
        Hearth::Validator.validate_required!(input[:id], context: "#{context}[:id]")
        Hearth::Validator.validate_types!(input[:id], ::String, context: "#{context}[:id]")
      end
    end

    class GetHighScoreOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetHighScoreOutput, context: context)
        HighScoreAttributes.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
      end
    end

    class HighScoreAttributes
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HighScoreAttributes, context: context)
        Hearth::Validator.validate_types!(input[:id], ::String, context: "#{context}[:id]")
        Hearth::Validator.validate_types!(input[:game], ::String, context: "#{context}[:game]")
        Hearth::Validator.validate_types!(input[:score], ::Integer, context: "#{context}[:score]")
        Hearth::Validator.validate_types!(input[:created_at], ::Time, context: "#{context}[:created_at]")
        Hearth::Validator.validate_types!(input[:updated_at], ::Time, context: "#{context}[:updated_at]")
      end
    end

    class HighScoreParams
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HighScoreParams, context: context)
        Hearth::Validator.validate_types!(input[:game], ::String, context: "#{context}[:game]")
        Hearth::Validator.validate_types!(input[:score], ::Integer, context: "#{context}[:score]")
      end
    end

    class HighScores
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, ::Array, context: context)
        input.each_with_index do |element, index|
          HighScoreAttributes.validate!(element, context: "#{context}[#{index}]") unless element.nil?
        end
      end
    end

    class ListHighScoresInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ListHighScoresInput, context: context)
      end
    end

    class ListHighScoresOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ListHighScoresOutput, context: context)
        HighScores.validate!(input[:high_scores], context: "#{context}[:high_scores]") unless input[:high_scores].nil?
      end
    end

    class UnprocessableEntityError
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::UnprocessableEntityError, context: context)
        AttributeErrors.validate!(input[:errors], context: "#{context}[:errors]") unless input[:errors].nil?
      end
    end

    class UpdateHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::UpdateHighScoreInput, context: context)
        Hearth::Validator.validate_required!(input[:id], context: "#{context}[:id]")
        Hearth::Validator.validate_types!(input[:id], ::String, context: "#{context}[:id]")
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
      end
    end

    class UpdateHighScoreOutput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::UpdateHighScoreOutput, context: context)
        HighScoreAttributes.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
      end
    end

  end
end
