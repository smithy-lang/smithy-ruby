# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Types

    # Modeled attributes for a High Score
    #
    # @!attribute [rw] id
    #   The high score id
    #   @return [String]
    #
    # @!attribute [rw] game
    #   The game for the high score
    #   @return [String]
    #
    # @!attribute [rw] score
    #   The high score for the game
    #   @return [Integer]
    #
    # @!attribute [rw] created_at
    #   @return [Time]
    #
    # @!attribute [rw] updated_at
    #   @return [Time]
    #
    HighScoreAttributes = Struct.new(
      :id,
      :game,
      :score,
      :created_at,
      :updated_at,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Permitted params for a High Score
    #
    # @!attribute [rw] game
    #   The game for the high score
    #   @return [String]
    #
    # @!attribute [rw] score
    #   The high score for the game
    #   @return [Integer]
    #
    HighScoreParams = Struct.new(
      :game,
      :score,
      keyword_init: true
    ) { include Seahorse::Structure }

    # @!attribute [rw] errors
    #   @return [Hash[String, Array[String]]]
    #
    UnprocessableEntityError = Struct.new(
      :errors,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Input structure for CreateHighScore
    #
    # @!attribute [rw] high_score
    #   The high score params
    #   @return [HighScoreParams]
    #
    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Output structure for CreateHighScore
    #
    # @!attribute [rw] high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    # @!attribute [rw] location
    #   The location of the high score
    #   @return [String]
    #
    CreateHighScoreOutput = Struct.new(
      :high_score,
      :location,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Input structure for DeleteHighScore
    #
    # @!attribute [rw] id
    #   The high score id
    #   @return [String]
    #
    DeleteHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Output structure for DeleteHighScore
    #
    DeleteHighScoreOutput = Struct.new(
      nil,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Input structure for GetHighScore
    #
    # @!attribute [rw] id
    #   The high score id
    #   @return [String]
    #
    GetHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Output structure for GetHighScore
    #
    # @!attribute [rw] high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    GetHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

    ListHighScoresInput = Struct.new(
      nil,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Output structure for ListHighScores
    #
    # @!attribute [rw] high_scores
    #   A list of high scores
    #   @return [Array[HighScoreAttributes]]
    #
    ListHighScoresOutput = Struct.new(
      :high_scores,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Input structure for UpdateHighScore
    #
    # @!attribute [rw] id
    #   The high score id
    #   @return [String]
    #
    # @!attribute [rw] high_score
    #   The high score params
    #   @return [HighScoreParams]
    #
    UpdateHighScoreInput = Struct.new(
      :id,
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Output structure for UpdateHighScore
    #
    # @!attribute [rw] high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    UpdateHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

  end
end
