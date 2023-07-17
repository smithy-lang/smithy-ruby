# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # @api private
  module Validators

    class CreateHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::CreateHighScoreInput, context: context)
        Hearth::Validator.validate_required!(input[:high_score], context: "#{context}[:high_score]")
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
      end
    end

    class DeleteHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::DeleteHighScoreInput, context: context)
        Hearth::Validator.validate_required!(input[:id], context: "#{context}[:id]")
        Hearth::Validator.validate_types!(input[:id], ::String, context: "#{context}[:id]")
      end
    end

    class GetHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::GetHighScoreInput, context: context)
        Hearth::Validator.validate_required!(input[:id], context: "#{context}[:id]")
        Hearth::Validator.validate_types!(input[:id], ::String, context: "#{context}[:id]")
      end
    end

    class HighScoreParams
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::HighScoreParams, context: context)
        Hearth::Validator.validate_types!(input[:game], ::String, context: "#{context}[:game]")
        Hearth::Validator.validate_types!(input[:score], ::Integer, context: "#{context}[:score]")
      end
    end

    class ListHighScoresInput
      def self.validate!(input, context:)
        Hearth::Validator.validate_types!(input, Types::ListHighScoresInput, context: context)
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

  end
end
