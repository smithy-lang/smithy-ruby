# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Parsers

    # Operation Parser for CreateHighScore
    class CreateHighScore
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::CreateHighScoreOutput.new
        resp.data.location = http_resp.headers['Location']
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
        data.created_at = json['created_at']
        data.updated_at = json['updated_at']
        return data
      end
    end

    class UnprocessableEntityError
      def self.parse(json)
        data = Types::UnprocessableEntityError.new
        data.errors = Parsers::AttributeErrors.parse(json['errors']) if json['errors']
        return data
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
        data.next_token = json['next_token']
        data.high_scores = Parsers::HighScores.parse(json['high_scores']) if json['high_scores']
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
