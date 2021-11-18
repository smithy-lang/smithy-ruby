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
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") if input[:high_score]
      end
    end

    class DeleteHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
      end
    end

    class GetHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
      end
    end

    class HighScoreParams
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:game], String, context: "#{context}[:game]")
        Seahorse::Validator.validate!(input[:score], Integer, context: "#{context}[:score]")
      end
    end

    class ListHighScoresInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:max_results], Integer, context: "#{context}[:max_results]")
        Seahorse::Validator.validate!(input[:next_token], String, context: "#{context}[:next_token]")
      end
    end

    class UpdateHighScoreInput
      def self.validate!(input, context:)
        Seahorse::Validator.validate!(input[:id], String, context: "#{context}[:id]")
        HighScoreParams.validate!(input[:high_score], context: "#{context}[:high_score]") if input[:high_score]
      end
    end
  end
end
