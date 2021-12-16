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
    ) { include Seahorse::Structure }

    UnprocessableEntityError = Struct.new(
      :errors,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Input structure for CreateHighScore
    #
    # @!attribute high_score
    #   The high score params
    #   @return [HighScoreParams]
    #
    CreateHighScoreInput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Output structure for CreateHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    # @!attribute location
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
    # @!attribute id
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
    # @!attribute id
    #   The high score id
    #   @return [String]
    #
    GetHighScoreInput = Struct.new(
      :id,
      keyword_init: true
    ) { include Seahorse::Structure }

    # Output structure for GetHighScore
    #
    # @!attribute high_score
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
    # @!attribute high_scores
    #   A list of high scores
    #   @return [Array<HighScoreAttributes>]
    #
    ListHighScoresOutput = Struct.new(
      :high_scores,
      keyword_init: true
    ) { include Seahorse::Structure }

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
    ) { include Seahorse::Structure }

    # Output structure for UpdateHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    #
    UpdateHighScoreOutput = Struct.new(
      :high_score,
      keyword_init: true
    ) { include Seahorse::Structure }

  end
end
