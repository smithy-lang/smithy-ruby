module SampleService
  # @api private
  module Validators

    class HighScoreParams
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        v.validate_type!(:id, String)
        v.validate_type!(:game, String)
        v.validate_type!(:score, Integer)
        v.validate_type!(:created_at, Time)
        v.validate_type!(:updated_at, Time)
      end
    end

    class GetHighScoreInput
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        v.validate_type!(:id, String)
      end
    end

    class CreateHighScoreInput
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]")
      end
    end

    class UpdateHighScoreInput
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        v.validate_type!(:id, String)
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]")
      end
    end

    class DeleteHighScoreInput
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        v.validate_type!(:id, String)
      end
    end

    class ListHighScoresInput
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        v.validate_type!(:max_results, Integer)
        v.validate_type!(:next_token, String)
      end
    end

    class StreamInputOutput
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        v.validate_type!(:stream_id, String)
        v.validate_type!(:blob, String)
      end
    end

  end
end
