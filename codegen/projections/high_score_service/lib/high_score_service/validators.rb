# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Validators

    class CreateHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::CreateHighScoreInput, context: context)
        Validators::HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
      end
    end

    class DeleteHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::DeleteHighScoreInput, context: context)
        Hearth::Validator.validate!(input[:id], ::String, context: "#{context}[:id]")
      end
    end

    class GetHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::GetHighScoreInput, context: context)
        Hearth::Validator.validate!(input[:id], ::String, context: "#{context}[:id]")
      end
    end

    class HighScoreParams
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::HighScoreParams, context: context)
        Hearth::Validator.validate!(input[:game], ::String, context: "#{context}[:game]")
        Hearth::Validator.validate!(input[:score], ::Integer, context: "#{context}[:score]")
      end
    end

    class ListHighScoresInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::ListHighScoresInput, context: context)
      end
    end

    class UpdateHighScoreInput
      def self.validate!(input, context:)
        Hearth::Validator.validate!(input, Types::UpdateHighScoreInput, context: context)
        Hearth::Validator.validate!(input[:id], ::String, context: "#{context}[:id]")
        Validators::HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") unless input[:high_score].nil?
      end
    end

  end
end
