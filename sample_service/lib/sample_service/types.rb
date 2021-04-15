module SampleService
  module Types

    # Permitted params for a High Score
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

    GetHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    )

    GetHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    )

    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    )

    CreateHighScoreOutput = Struct.new(
      :high_score,
      :location,
      keyword_init: true
    )

    UpdateHighScoreInput = Struct.new(
      :id,
      :high_score,
      keyword_init: true
    )

    UpdateHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    )

    DeleteHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    )

    DeleteHighScoreOutput = Struct.new(
      nil,
      keyword_init: true
    )

    ListHighScoresInput = Struct.new(
      nil,
      keyword_init: true
    )

    ListHighScoresOutput = Struct.new(
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
