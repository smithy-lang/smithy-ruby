# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Types

    # Input structure for CreateHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [HighScoreParams] :high_score
    # @!attribute high_score
    #   The high score params
    #   @return [HighScoreParams]
    class CreateHighScoreInput
      include Hearth::Structure

      MEMBERS = %i[
        high_score
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Output structure for CreateHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [HighScoreAttributes] :high_score
    #   @option params [String] :location
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    # @!attribute location
    #   The location of the high score
    #   @return [String]
    class CreateHighScoreOutput
      include Hearth::Structure

      MEMBERS = %i[
        high_score
        location
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Input structure for DeleteHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :id
    # @!attribute id
    #   The high score id
    #   @return [String]
    class DeleteHighScoreInput
      include Hearth::Structure

      MEMBERS = %i[
        id
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Output structure for DeleteHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    class DeleteHighScoreOutput
      include Hearth::Structure

      MEMBERS = [].freeze

      attr_accessor(*MEMBERS)
    end

    # Input structure for GetHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :id
    # @!attribute id
    #   The high score id
    #   @return [String]
    class GetHighScoreInput
      include Hearth::Structure

      MEMBERS = %i[
        id
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Output structure for GetHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [HighScoreAttributes] :high_score
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    class GetHighScoreOutput
      include Hearth::Structure

      MEMBERS = %i[
        high_score
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Modeled attributes for a High Score
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :id
    #   @option params [String] :game
    #   @option params [Integer] :score
    #   @option params [Time] :created_at
    #   @option params [Time] :updated_at
    # @!attribute id
    #   The high score id
    #   @return [String]
    # @!attribute game
    #   The game for the high score
    #   @return [String]
    # @!attribute score
    #   The high score for the game
    #   @return [Integer]
    # @!attribute created_at
    #   @return [Time]
    # @!attribute updated_at
    #   @return [Time]
    class HighScoreAttributes
      include Hearth::Structure

      MEMBERS = %i[
        id
        game
        score
        created_at
        updated_at
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Permitted params for a High Score
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :game
    #   @option params [Integer] :score
    # @!attribute game
    #   The game for the high score
    #   @return [String]
    # @!attribute score
    #   The high score for the game
    #   @return [Integer]
    class HighScoreParams
      include Hearth::Structure

      MEMBERS = %i[
        game
        score
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :next_token
    #   @option params [Integer] :max_results
    # @!attribute next_token
    #   The next token to use for pagination
    #   @return [String]
    # @!attribute max_results
    #   The maximum number of results to return
    #   @return [Integer]
    class ListHighScoresInput
      include Hearth::Structure

      MEMBERS = %i[
        next_token
        max_results
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Output structure for ListHighScores
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Array<HighScoreAttributes>] :high_scores
    #   @option params [String] :next_token
    # @!attribute high_scores
    #   A list of high scores
    #   @return [Array<HighScoreAttributes>]
    # @!attribute next_token
    #   The next token to use for pagination
    #   @return [String]
    class ListHighScoresOutput
      include Hearth::Structure

      MEMBERS = %i[
        high_scores
        next_token
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Hash<String, Array<String>>] :errors
    # @!attribute errors
    #   @return [Hash<String, Array<String>>]
    class UnprocessableEntityError
      include Hearth::Structure

      MEMBERS = %i[
        errors
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Input structure for UpdateHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :id
    #   @option params [HighScoreParams] :high_score
    # @!attribute id
    #   The high score id
    #   @return [String]
    # @!attribute high_score
    #   The high score params
    #   @return [HighScoreParams]
    class UpdateHighScoreInput
      include Hearth::Structure

      MEMBERS = %i[
        id
        high_score
      ].freeze

      attr_accessor(*MEMBERS)
    end

    # Output structure for UpdateHighScore
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [HighScoreAttributes] :high_score
    # @!attribute high_score
    #   The high score attributes
    #   @return [HighScoreAttributes]
    class UpdateHighScoreOutput
      include Hearth::Structure

      MEMBERS = %i[
        high_score
      ].freeze

      attr_accessor(*MEMBERS)
    end

  end
end
