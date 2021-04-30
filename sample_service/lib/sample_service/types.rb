module SampleService
  module Types

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
    )

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
    )

    # Input structure for GetHighScore
    #
    # @!attribute id
    #   The high score id
    #   @return [String]
    #
    GetHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    )

    # Output structure for GetHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    GetHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    )

    # Input structure for CreateHighScore
    #
    # @!attribute high_score
    #   The high score params
    #   @return [HighScoreParams]
    #
    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    )

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
    )

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
    )

    # Output structure for UpdateHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    UpdateHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    )

    # Input structure for DeleteHighScore
    #
    # @!attribute id
    #   The high score id
    #   @return [String]
    #
    DeleteHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    )

    # Output structure for DeleteHighScore
    DeleteHighScoreOutput = Struct.new(
      nil,
      keyword_init: true
    )

    # Input structure for ListHighScores
    ListHighScoresInput = Struct.new(
      :max_results,
      :next_token,
      keyword_init: true
    )

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
    )

    # Raised when high score is invalid
    UnprocessableEntityError = Struct.new(
      :errors,
      keyword_init: true
    )

  end
end
