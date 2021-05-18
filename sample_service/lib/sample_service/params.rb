module SampleService
  # @api private
  module Params

    class HighScoreParams
      def self.build(params)
        type = Types::HighScoreParams.new
        type.game = params[:game]
        type.score = params[:score]
        type
      end
    end

  class EventStream
    def self.build(params)
      return params if params.is_a?(Types::EventStream)

      if params.compact.size > 1
        raise ArgumentError,
              "EventStream must have exactly one member, got: #{params}"
      end
      key, value = params.flatten
      case key
      when :start
        Types::EventStream::Start.new(
          StructuredEvent.build(params)
        )
      when :end
        Types::EventStream::End.new(
          StructuredEvent.build(params)
        )
      when :log
        Types::EventStream::Log.new(value)
      end
    end
  end

  class StructuredEvent
    def self.build(params)
      type = Types::StructuredEvent.new
      type.message = params[:message]
      type
    end
  end

    class GetHighScoreInput
      def self.build(params)
        type = Types::GetHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    class CreateHighScoreInput
      def self.build(params)
        type = Types::CreateHighScoreInput.new
        type.high_score = HighScoreParams.build(params[:high_score]) if params[:high_score]
        type
      end
    end

    class UpdateHighScoreInput
      def self.build(params)
        type = Types::UpdateHighScoreInput.new
        type.id = params[:id]
        type.high_score = HighScoreParams.build(params[:high_score]) if params[:high_score]
        type
      end
    end

    class DeleteHighScoreInput
      def self.build(params)
        type = Types::DeleteHighScoreInput.new
        type.id = params[:id]
        type
      end
    end

    class ListHighScoresInput
      def self.build(params)
        type = Types::ListHighScoresInput.new
        type.next_token = params[:next_token]
        type.max_results = params[:max_results]
        type
      end
    end

    class StreamInputOutput
      def self.build(params)
        type = Types::StreamInputOutput.new
        type.stream_id = params[:stream_id]
        type.blob = params[:blob]
        type
      end
    end

  end
end
