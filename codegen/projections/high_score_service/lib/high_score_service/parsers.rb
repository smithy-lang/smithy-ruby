# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module HighScoreService
  module Parsers

    # Operation Parser for CreateHighScore
    class CreateHighScore

      def self.parse(http_resp)
        data = Types::CreateHighScoreOutput.new
        data.location = http_resp.headers['Location']
        json = Hearth::JSON.load(http_resp.body)
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        data
      end
    end

    class HighScoreAttributes
      def self.parse(map)
        data = Types::HighScoreAttributes.new
        data.id = map['id']
        data.game = map['game']
        data.score = map['score']
        data.created_at = Time.parse(map['created_at']) if map['created_at']
        data.updated_at = Time.parse(map['updated_at']) if map['updated_at']
        return data
      end
    end

    # Error Parser for UnprocessableEntityError
    class UnprocessableEntityError

      def self.parse(http_resp)
        data = Types::UnprocessableEntityError.new
        json = Hearth::JSON.load(http_resp.body)
        data.errors = Parsers::AttributeErrors.parse(json)
        data
      end
    end

    class AttributeErrors
      def self.parse(map)
        data = {}
        map.map do |key, value|
          data[key] = Parsers::ErrorMessages.parse(value) unless value.nil?
        end
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

    # Operation Parser for DeleteHighScore
    class DeleteHighScore

      def self.parse(http_resp)
        data = Types::DeleteHighScoreOutput.new
        map = Hearth::JSON.load(http_resp.body)
        data
      end
    end

    # Operation Parser for GetHighScore
    class GetHighScore

      def self.parse(http_resp)
        data = Types::GetHighScoreOutput.new
        json = Hearth::JSON.load(http_resp.body)
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        data
      end
    end

    # Operation Parser for ListHighScores
    class ListHighScores

      def self.parse(http_resp)
        data = Types::ListHighScoresOutput.new
        json = Hearth::JSON.load(http_resp.body)
        data.high_scores = Parsers::HighScores.parse(json)
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

    # Operation Parser for UpdateHighScore
    class UpdateHighScore

      def self.parse(http_resp)
        data = Types::UpdateHighScoreOutput.new
        json = Hearth::JSON.load(http_resp.body)
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        data
      end
    end
  end
end
