module SampleService
  # @api private
  module Validators

    class HighScoreParams
      def self.validate!(params:, context:)
        input = Seahorse::Validator.new(params: params, context: context)
        input.validate_length!(:game, min: 2) if params[:game]
      end
    end

    class GetHighScore
      def self.validate!(params:, context:)
        input = Seahorse::Validator.new(params: params, context: context)
        input.validate_required!(:id)
      end
    end

    class CreateHighScore
      def self.validate!(params:, context:)
        input = Seahorse::Validator.new(params: params, context: context)
        input.validate_required!(:high_score)
        HighScoreParams.validate!(params: params[:high_score], context: "#{context}[:high_score]")
      end
    end

    class UpdateHighScore
      def self.validate!(params:, context:)
        input = Seahorse::Validator.new(params: params, context: context)
        input.validate_required!(:id)
        HighScoreParams.validate!(params: params[:high_score], context: "#{context}[:high_score]")
      end
    end

    class DeleteHighScore
      def self.validate!(params:, context:)
        input = Seahorse::Validator.new(params: params, context: context)
        input.validate_required!(:id)
      end
    end

    class ListHighScores
      def self.validate!(params:, context:)
        input = Seahorse::Validator.new(params: params, context: context)
      end
    end

  end
end
