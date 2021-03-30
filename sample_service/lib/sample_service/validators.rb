module SampleService
  module Validators

    class HighScoreParams
      def self.validate(params:, context:)
        input = Seahorse::Input.new(context: context, params: params)
        input.validate_params!(Types::HighScoreParams)
        input.validate_type!(:game, String)
        input.validate_type!(:score, Integer)
        input.validate_type!(:time, Time)
        input.validate_unexpected!(Types::HighScoreParams)
      end
    end

    class GetHighScoreInput
      def self.validate(params:, context:)
        input = Seahorse::Input.new(params: params, context: context)
        input.validate_params!(Types::GetHighScoreInput)
        input.validate_type!(:id, String)
        input.validate_required!(:id)
        input.validate_unexpected!(Types::GetHighScoreInput)
      end
    end

    class CreateHighScoreInput
      def self.validate(params:, context:)
        input = Seahorse::Input.new(context: context, params: params)
        input.validate_params!(Types::CreateHighScoreInput)
        HighScoreParams.validate(params: params[:high_score], context: 'params[:high_score]')
        input.validate_unexpected!(Types::CreateHighScoreInput)
      end
    end

    class UpdateHighScoreInput
      def self.validate(params:, context:)
        input = Seahorse::Input.new(context: context, params: params)
        input.validate_params!(Types::UpdateHighScoreInput)
        input.validate_type!(:id, String)
        input.validate_required!(:id)
        HighScoreParams.validate(params: params[:high_score], context: 'params[:high_score]')
        input.validate_unexpected!(Types::UpdateHighScoreInput)
      end
    end

    class DeleteHighScoreInput
      def self.validate(params:, context:)
        input = Seahorse::Input.new(context: context, params: params)
        input.validate_params!(Types::DeleteHighScoreInput)
        input.validate_type!(:id, String)
        input.validate_required!(:id)
        input.validate_unexpected!(Types::DeleteHighScoreInput)
      end
    end

    class ListHighScoresInput
      def self.validate(params:, context:)
        input = Seahorse::Input.new(context: context, params: params)
        input.validate_params!(Types::ListHighScoresInput)
        input.validate_unexpected!(Types::ListHighScoresInput)
      end
    end

  end
end
