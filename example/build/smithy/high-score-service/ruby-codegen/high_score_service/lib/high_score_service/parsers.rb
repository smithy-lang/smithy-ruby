# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # @api private
  module Parsers

    class AttributeErrors
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::ErrorMessages.parse(value) unless value.nil?
        end
        data
      end
    end

    class CreateHighScore
      def self.parse(http_resp)
        data = Types::CreateHighScoreOutput.new
        data.location = http_resp.headers['Location']
        map = Hearth::JSON.parse(http_resp.body.read)
        data.high_score = Parsers::HighScoreAttributes.parse(map)
        data
      end
    end

    class DeleteHighScore
      def self.parse(http_resp)
        data = Types::DeleteHighScoreOutput.new
        data
      end
    end

    class ErrorMessages
      def self.parse(list)
        list.map do |value|
          value unless value.nil?
        end
      end
    end

    class GetHighScore
      def self.parse(http_resp)
        data = Types::GetHighScoreOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.high_score = Parsers::HighScoreAttributes.parse(map)
        data
      end
    end

    class HighScoreAttributes
      def self.parse(map)
        data = Types::HighScoreAttributes.new
        data.id = map['id'] unless map['id'].nil?
        data.game = map['game'] unless map['game'].nil?
        data.score = map['score'] unless map['score'].nil?
        data.created_at = Time.parse(map['created_at']) if map['created_at']
        data.updated_at = Time.parse(map['updated_at']) if map['updated_at']
        data
      end
    end

    class HighScores
      def self.parse(list)
        list.map do |value|
          Parsers::HighScoreAttributes.parse(value) unless value.nil?
        end
      end
    end

    class ListHighScores
      def self.parse(http_resp)
        data = Types::ListHighScoresOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.high_scores = Parsers::HighScores.parse(map)
        data
      end
    end

    # Error Parser for UnprocessableEntityError
    class UnprocessableEntityError
      def self.parse(http_resp)
        data = Types::UnprocessableEntityError.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.errors = Parsers::AttributeErrors.parse(map)
        data
      end
    end

    class UpdateHighScore
      def self.parse(http_resp)
        data = Types::UpdateHighScoreOutput.new
        map = Hearth::JSON.parse(http_resp.body.read)
        data.high_score = Parsers::HighScoreAttributes.parse(map)
        data
      end
    end
  end
end
