# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'securerandom'

module HighScoreService
  module Params

    module AttributeErrors
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = ErrorMessages.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    module CreateHighScoreInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::CreateHighScoreInput, context: context)
        type = Types::CreateHighScoreInput.new
        type.high_score = HighScoreParams.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

    module CreateHighScoreOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::CreateHighScoreOutput, context: context)
        type = Types::CreateHighScoreOutput.new
        type.high_score = HighScoreAttributes.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type.location = params[:location]
        type
      end
    end

    module DeleteHighScoreInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DeleteHighScoreInput, context: context)
        type = Types::DeleteHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    module DeleteHighScoreOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::DeleteHighScoreOutput, context: context)
        type = Types::DeleteHighScoreOutput.new
        type
      end
    end

    module ErrorMessages
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    module GetHighScoreInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::GetHighScoreInput, context: context)
        type = Types::GetHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    module GetHighScoreOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::GetHighScoreOutput, context: context)
        type = Types::GetHighScoreOutput.new
        type.high_score = HighScoreAttributes.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

    module HighScoreAttributes
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HighScoreAttributes, context: context)
        type = Types::HighScoreAttributes.new
        type.id = params[:id]
        type.game = params[:game]
        type.score = params[:score] unless params[:score].nil?
        type.created_at = params[:created_at] unless params[:created_at].nil?
        type.updated_at = params[:updated_at] unless params[:updated_at].nil?
        type
      end
    end

    module HighScoreParams
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::HighScoreParams, context: context)
        type = Types::HighScoreParams.new
        type.game = params[:game]
        type.score = params[:score] unless params[:score].nil?
        type
      end
    end

    module HighScores
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << HighScoreAttributes.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    module ListHighScoresInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ListHighScoresInput, context: context)
        type = Types::ListHighScoresInput.new
        type
      end
    end

    module ListHighScoresOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::ListHighScoresOutput, context: context)
        type = Types::ListHighScoresOutput.new
        type.high_scores = HighScores.build(params[:high_scores], context: "#{context}[:high_scores]") unless params[:high_scores].nil?
        type
      end
    end

    module UnprocessableEntityError
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::UnprocessableEntityError, context: context)
        type = Types::UnprocessableEntityError.new
        type.errors = AttributeErrors.build(params[:errors], context: "#{context}[:errors]") unless params[:errors].nil?
        type
      end
    end

    module UpdateHighScoreInput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::UpdateHighScoreInput, context: context)
        type = Types::UpdateHighScoreInput.new
        type.id = params[:id]
        type.high_score = HighScoreParams.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

    module UpdateHighScoreOutput
      def self.build(params, context: '')
        Hearth::Validator.validate!(params, ::Hash, Types::UpdateHighScoreOutput, context: context)
        type = Types::UpdateHighScoreOutput.new
        type.high_score = HighScoreAttributes.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

  end
end
