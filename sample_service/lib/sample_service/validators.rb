module SampleService
  # @api private
  module Validators

    class HighScoreParams
      def self.validate!(input:, context:)
        validator = Seahorse::Validator.new(input: input, context: context)
        validator.validate_length!(:game, min: 2) if input[:game]
      end
    end

    class GetHighScore
      def self.validate!(input:, context:)
        validator = Seahorse::Validator.new(input: input, context: context)
        validator.validate_required!(:id)
      end
    end

    class CreateHighScore
      def self.validate!(input:, context:)
        validator = Seahorse::Validator.new(input: input, context: context)
        validator.validate_required!(:high_score)
        HighScoreParams.validate!(input: input[:high_score], context: "#{context}[:high_score]")
      end
    end

    class UpdateHighScore
      def self.validate!(input:, context:)
        validator = Seahorse::Validator.new(input: input, context: context)
        validator.validate_required!(:id)
        HighScoreParams.validate!(input: input[:high_score], context: "#{context}[:high_score]")
      end
    end

    class DeleteHighScore
      def self.validate!(input:, context:)
        validator = Seahorse::Validator.new(input: input, context: context)
        validator.validate_required!(:id)
      end
    end

    class ListHighScores
      def self.validate!(input:, context:)
        validator = Seahorse::Validator.new(input: input, context: context)
      end
    end

  end
end
