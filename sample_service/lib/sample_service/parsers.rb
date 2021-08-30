# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Parsers

    # Operation Parser for UpdateHighScore
    class UpdateHighScore
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::UpdateHighScoreOutput.new
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        output.data = data
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

    # Operation Parser for ListHighScores
    class ListHighScores
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::ListHighScoresOutput.new
        data.next_token = json['next_token']
        data.high_scores = Parsers::HighScores.parse(json['high_scores']) if json.key?('high_scores')
        output.data = data
      end
    end

    class HighScores
      def self.parse(json)
        json.map do |entry|
          HighScoreAttributes.parse(entry)
        end
      end
    end

    # Operation Parser for DeleteHighScore
    class DeleteHighScore
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::DeleteHighScoreOutput.new
        output.data = data
      end
    end

    # Operation Parser for CreateHighScore
    class CreateHighScore
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::CreateHighScoreOutput.new
        resp.data.location = http_resp.headers['Location']
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        output.data = data
      end
    end

    # Operation Parser for GetHighScore
    class GetHighScore
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::GetHighScoreOutput.new
        data.high_score = Parsers::HighScoreAttributes.parse(json)
        output.data = data
      end
    end

    # Operation Parser for Stream
    class Stream
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::StreamInputOutput.new
        resp.data.stream_id = http_resp.headers['StreamID']
        data.blob = Parsers::StreamingBlob.parse(json)
        output.data = data
      end
    end
  end
end
