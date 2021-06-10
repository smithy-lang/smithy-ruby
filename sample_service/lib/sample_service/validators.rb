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

    class ThingWithListAndMap
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        List.validate!(input[:list], context: "#{context}[:list]")
        Map.validate!(input[:map], context: "#{context}[:map]")
      end
    end

    class List
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        input.each_with_index do |element, index|
          # if it's a simple type
          v.validate_type!(element, String)
          # or if it's a structure/ complex type
          SomeOtherType.validate!(element, context: "#{context}[#{index}]")
        end
      end
    end

    class Map
      def self.validate!(input, context:)
        v = Seahorse::Validator.new(input, context: context)
        input.each do |key, value|
          v.validate_type!(key, String, Symbol)
          # if it's a simple type
          v.validate_type!(value, String)
          # if it's a complex type
          SomeOtherType.validate!(value, context: "#{context}[#{key}]")
        end
      end
    end

  end
end
