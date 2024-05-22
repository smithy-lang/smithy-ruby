# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # @api private
  module Params

    class AttributeErrors
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, context: context)
        data = {}
        params.each do |key, value|
          data[key] = ErrorMessages.build(value, context: "#{context}[:#{key}]") unless value.nil?
        end
        data
      end
    end

    class CreateHighScoreInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::CreateHighScoreInput, context: context)
        type = Types::CreateHighScoreInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.high_score = HighScoreParams.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

    class CreateHighScoreOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::CreateHighScoreOutput, context: context)
        type = Types::CreateHighScoreOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.high_score = HighScoreAttributes.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type.location = params[:location]
        type
      end
    end

    class DeleteHighScoreInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DeleteHighScoreInput, context: context)
        type = Types::DeleteHighScoreInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.id = params[:id]
        type
      end
    end

    class DeleteHighScoreOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::DeleteHighScoreOutput, context: context)
        type = Types::DeleteHighScoreOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class ErrorMessages
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each do |element|
          data << element
        end
        data
      end
    end

    class GetHighScoreInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetHighScoreInput, context: context)
        type = Types::GetHighScoreInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.id = params[:id]
        type
      end
    end

    class GetHighScoreOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::GetHighScoreOutput, context: context)
        type = Types::GetHighScoreOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.high_score = HighScoreAttributes.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

    class HighScoreAttributes
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HighScoreAttributes, context: context)
        type = Types::HighScoreAttributes.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.id = params[:id]
        type.game = params[:game]
        type.score = params[:score]
        type.created_at = params[:created_at]
        type.updated_at = params[:updated_at]
        type
      end
    end

    class HighScoreParams
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::HighScoreParams, context: context)
        type = Types::HighScoreParams.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.game = params[:game]
        type.score = params[:score]
        type
      end
    end

    class HighScores
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Array, context: context)
        data = []
        params.each_with_index do |element, index|
          data << HighScoreAttributes.build(element, context: "#{context}[#{index}]") unless element.nil?
        end
        data
      end
    end

    class ListHighScoresInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ListHighScoresInput, context: context)
        type = Types::ListHighScoresInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type
      end
    end

    class ListHighScoresOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::ListHighScoresOutput, context: context)
        type = Types::ListHighScoresOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.high_scores = HighScores.build(params[:high_scores], context: "#{context}[:high_scores]") unless params[:high_scores].nil?
        type
      end
    end

    class UnprocessableEntityError
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::UnprocessableEntityError, context: context)
        type = Types::UnprocessableEntityError.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.errors = AttributeErrors.build(params[:errors], context: "#{context}[:errors]") unless params[:errors].nil?
        type
      end
    end

    class UpdateHighScoreInput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::UpdateHighScoreInput, context: context)
        type = Types::UpdateHighScoreInput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.id = params[:id]
        type.high_score = HighScoreParams.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

    class UpdateHighScoreOutput
      def self.build(params, context:)
        Hearth::Validator.validate_types!(params, ::Hash, Types::UpdateHighScoreOutput, context: context)
        type = Types::UpdateHighScoreOutput.new
        Hearth::Validator.validate_unknown!(type, params, context: context) if params.is_a?(Hash)
        type.high_score = HighScoreAttributes.build(params[:high_score], context: "#{context}[:high_score]") unless params[:high_score].nil?
        type
      end
    end

  end
end
