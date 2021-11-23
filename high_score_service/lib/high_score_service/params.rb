# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Params

    module CreateHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, Types::CreateHighScoreInput, context: context)
        type = Types::CreateHighScoreInput.new
        type.high_score = HighScoreParams.build(params[:high_score], context: "#{context}[:high_score]") if params[:high_score]
        type
      end
    end

    module DeleteHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, Types::DeleteHighScoreInput, context: context)
        type = Types::DeleteHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    module GetHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, Types::GetHighScoreInput, context: context)
        type = Types::GetHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    module HighScoreParams
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, Types::HighScoreParams, context: context)
        type = Types::HighScoreParams.new
        type.game = params[:game]
        type.score = params[:score]
        type
      end
    end

    module ListHighScoresInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, Types::ListHighScoresInput, context: context)
        type = Types::ListHighScoresInput.new
        type.max_results = params[:max_results]
        type.next_token = params[:next_token]
        type
      end
    end

    module UpdateHighScoreInput
      def self.build(params, context: '')
        Seahorse::Validator.validate!(params, Hash, Types::UpdateHighScoreInput, context: context)
        type = Types::UpdateHighScoreInput.new
        type.id = params[:id]
        type.high_score = HighScoreParams.build(params[:high_score], context: "#{context}[:high_score]") if params[:high_score]
        type
      end
    end

  end
end
