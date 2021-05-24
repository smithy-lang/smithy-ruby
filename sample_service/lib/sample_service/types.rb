module SampleService
  module Types

    StructuredEvent = Struct.new(
      :message,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.message = params[:message]
        type
      end
    end

    class EventStream < SimpleDelegator
      class Start < EventStream; end
      class End < EventStream; end
      class Log < EventStream; end
      class Unknown < EventStream; end

      def self.build(params)
        return params if params.is_a?(EventStream)

        if params.compact.size > 1
          raise ArgumentError,
                "EventStream must have exactly one member, got: #{params}"
        end
        key, value = params.flatten
        case key
        when :start
          Start.new(
            StructuredEvent.build(params[:start])
          )
        when :end
          End.new(
            StructuredEvent.build(params[:end])
          )
        when :log
          Log.new(value)
        end
      end
    end

    # Permitted params for a High Score
    #
    # @!attribute game
    #   The game for the high score
    #   @return [String]
    #
    # @!attribute score
    #   The high score for the game
    #   @return [Integer]
    #
    HighScoreParams = Struct.new(
      :game,
      :score,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.game = params[:game]
        type.score = params[:score]
        type
      end
    end

    # Modeled attributes for a High Score
    #
    # @!attribute id
    #   The high score id
    #   @return [String]
    #
    # @!attribute game
    #   The game for the high score
    #   @return [String]
    #
    # @!attribute score
    #   The high score for the game
    #   @return [Integer]
    #
    # @!attribute created_at
    #   The time the high score was created at
    #   @return [Time]
    #
    # @!attribute updated_at
    #   The time the high score was updated at
    #   @return [Time]
    #
    HighScoreAttributes = Struct.new(
      :id,
      :game,
      :score,
      :created_at,
      :updated_at,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.id = params[:id]
        type.game = params[:game]
        type.score = params[:score]
        type.created_at = params[:created_at]
        type.updated_at = params[:updated_at]
        type
      end
    end

    # Input structure for GetHighScore
    #
    # @!attribute id
    #   The high score id
    #   @return [String]
    #
    GetHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.id = params[:id]
        type
      end
    end

    # Output structure for GetHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    GetHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.high_score = HighScoreAttributes.new(params[:high_score]) if params[:high_score]
        type
      end
    end

    # Input structure for CreateHighScore
    #
    # @!attribute high_score
    #   The high score params
    #   @return [HighScoreParams]
    #
    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.high_score = HighScoreParams.build(params[:high_score]) if params[:high_score]
        type
      end
    end

    # Output structure for CreateHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    # @!attribute location
    #   The location of the high score
    #   @return [HighScoreAttributes]
    #
    CreateHighScoreOutput = Struct.new(
      :high_score,
      :location,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.high_score = HighScoreAttributes.new(params[:high_score]) if params[:high_score]
        type.location = params[:location]
        type
      end
    end

    # Input structure for UpdateHighScore
    #
    # @!attribute id
    #   The high score id
    #   @return [String]
    #
    # @!attribute high_score
    #   The high score params
    #   @return [HighScoreParams]
    #
    UpdateHighScoreInput = Struct.new(
      :id,
      :high_score,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.id = params[:id]
        type.high_score = HighScoreParams.build(params[:high_score]) if params[:high_score]
        type
      end
    end

    # Output structure for UpdateHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    UpdateHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.high_score = HighScoreAttributes.new(params[:high_score]) if params[:high_score]
        type
      end
    end

    # Input structure for DeleteHighScore
    #
    # @!attribute id
    #   The high score id
    #   @return [String]
    #
    DeleteHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.id = params[:id]
        type
      end
    end

    # Output structure for DeleteHighScore
    DeleteHighScoreOutput = Struct.new(
      nil,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type
      end
    end

    # Input structure for ListHighScores
    ListHighScoresInput = Struct.new(
      :max_results,
      :next_token,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.next_token = params[:next_token]
        type.max_results = params[:max_results]
        type
      end
    end

    # Output structure for ListHighScores
    #
    # @!attribute high_scores
    #   A list of high scores
    #   @return [Array<HighScoreAttributes>]
    #
    ListHighScoresOutput = Struct.new(
      :next_token,
      :high_scores,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.next_token = params[:next_token]
        type.high_scores = params[:high_scores].map do |high_score|
          HighScoreAttributes.build(high_score)
        end
        type
      end
    end

    # Input and Output structure for Stream
    StreamInputOutput = Struct.new(
      :stream_id,
      :blob
    ) do
      def self.build(params)
        type = new
        type.stream_id = params[:stream_id]
        type.blob = params[:blob]
        type
      end
    end

    # Raised when high score is invalid
    UnprocessableEntityError = Struct.new(
      :errors,
      keyword_init: true
    ) do
      def self.build(params)
        type = new
        type.errors = Hash[params[:errors].map { |k, v| [k, v] }]
        type
      end
    end

  end
end
