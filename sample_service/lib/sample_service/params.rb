module SampleService
  # @api private
  module Params

    class HighScoreParams
      def self.build(params:)
        type = Types::HighScoreParams.new
        type.game = params[:game]
        type.score = params[:score]
        type
      end
    end

    class GetHighScoreInput
      def self.build(params:)
        type = Types::GetHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    class CreateHighScoreInput
      def self.build(params:)
        type = Types::CreateHighScoreInput.new
        type.high_score = HighScoreParams.build(params: params[:high_score]) if params[:high_score]
        type
      end
    end

    class UpdateHighScoreInput
      def self.build(params:)
        type = Types::UpdateHighScoreInput.new
        type.id = params[:id]
        type.high_score = HighScoreParams.build(params: params[:high_score]) if params[:high_score]
        type
      end
    end

    class DeleteHighScoreInput
      def self.build(params:)
        type = Types::DeleteHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    class ListHighScoresInput
      def self.build(params:)
        type = Types::ListHighScoresInput.new
        type
      end
    end

  end
end
