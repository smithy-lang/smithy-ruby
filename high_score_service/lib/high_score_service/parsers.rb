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
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::CreateHighScoreOutput.new
        data.location = http_resp.headers['Location']
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        data
      end
    end

    class HighScoreAttributes
      def self.parse(json)
        data = Types::HighScoreAttributes.new
        data.id = json['id']
        data.game = json['game']
        data.score = json['score']
        data.created_at = Time.parse(json['created_at']) if json['created_at']
        data.updated_at = Time.parse(json['updated_at']) if json['updated_at']
        return data
      end
    end

    # Error Parser for UnprocessableEntityError
    class UnprocessableEntityError
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::UnprocessableEntityError.new
        data.errors = Parsers::AttributeErrors.parse(json)
        data
      end
    end

    class AttributeErrors
      def self.parse(json)
        data = {}
        json.map do |key, value|
          data[key] = Parsers::ErrorMessages.parse(value) if value
        end
        data
      end
    end

    class ErrorMessages
      def self.parse(json)
        json.map do |value|
          value
        end
      end
    end

    # Operation Parser for DeleteHighScore
    class DeleteHighScore
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::DeleteHighScoreOutput.new
        data
      end
    end

    # Operation Parser for GetHighScore
    class GetHighScore
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::GetHighScoreOutput.new
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        data
      end
    end

    # Operation Parser for ListHighScores
    class ListHighScores
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::ListHighScoresOutput.new
        data.high_scores = Parsers::HighScores.parse(json)
        data
      end
    end

    class HighScores
      def self.parse(json)
        json.map do |value|
          Parsers::HighScoreAttributes.parse(value) if value
        end
      end
    end

    # Operation Parser for UpdateHighScore
    class UpdateHighScore
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::UpdateHighScoreOutput.new
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        data
      end
    end
  end
end
