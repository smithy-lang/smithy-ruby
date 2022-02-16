# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Types

    # Input structure for CreateHighScore
    #
    # @!attribute high_score
    #   The high score params
    #
    #   @return [HighScoreParams]
    #
    CreateHighScoreInput = ::Struct.new(
      :high_score,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Output structure for CreateHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #
    #   @return [HighScoreAttributes]
    #
    # @!attribute location
    #   The location of the high score
    #
    #   @return [String]
    #
    CreateHighScoreOutput = ::Struct.new(
      :high_score,
      :location,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Input structure for DeleteHighScore
    #
    # @!attribute id
    #   The high score id
    #
    #   @return [String]
    #
    DeleteHighScoreInput = ::Struct.new(
      :id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Output structure for DeleteHighScore
    #
    DeleteHighScoreOutput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Input structure for GetHighScore
    #
    # @!attribute id
    #   The high score id
    #
    #   @return [String]
    #
    GetHighScoreInput = ::Struct.new(
      :id,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Output structure for GetHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #
    #   @return [HighScoreAttributes]
    #
    GetHighScoreOutput = ::Struct.new(
      :high_score,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Modeled attributes for a High Score
    #
    # @!attribute id
    #   The high score id
    #
    #   @return [String]
    #
    # @!attribute game
    #   The game for the high score
    #
    #   @return [String]
    #
    # @!attribute score
    #   The high score for the game
    #
    #   @return [Integer]
    #
    # @!attribute created_at
    #
    #   @return [Time]
    #
    # @!attribute updated_at
    #
    #   @return [Time]
    #
    HighScoreAttributes = ::Struct.new(
      :id,
      :game,
      :score,
      :created_at,
      :updated_at,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Permitted params for a High Score
    #
    # @!attribute game
    #   The game for the high score
    #
    #   @return [String]
    #
    # @!attribute score
    #   The high score for the game
    #
    #   @return [Integer]
    #
    HighScoreParams = ::Struct.new(
      :game,
      :score,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    ListHighScoresInput = ::Struct.new(
      nil,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Output structure for ListHighScores
    #
    # @!attribute high_scores
    #   A list of high scores
    #
    #   @return [Array<HighScoreAttributes>]
    #
    ListHighScoresOutput = ::Struct.new(
      :high_scores,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # @!attribute errors
    #
    #   @return [Hash<String, Array<String>>]
    #
    UnprocessableEntityError = ::Struct.new(
      :errors,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Input structure for UpdateHighScore
    #
    # @!attribute id
    #   The high score id
    #
    #   @return [String]
    #
    # @!attribute high_score
    #   The high score params
    #
    #   @return [HighScoreParams]
    #
    UpdateHighScoreInput = ::Struct.new(
      :id,
      :high_score,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

    # Output structure for UpdateHighScore
    #
    # @!attribute high_score
    #   The high score attributes
    #
    #   @return [HighScoreAttributes]
    #
    UpdateHighScoreOutput = ::Struct.new(
      :high_score,
      keyword_init: true
    ) do
      include Hearth::Structure
    end

  end
end
