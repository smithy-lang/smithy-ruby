# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

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
        data.created_at = Time.parse(json['created_at']) if json['created_at']
        data.updated_at = Time.parse(json['updated_at']) if json['updated_at']
        data.simple_list = Parsers::SimpleList.parse(json['simple_list']) if json['simple_list']
        data.complex_list = Parsers::ComplexList.parse(json['complex_list']) if json['complex_list']
        data.simple_map = Parsers::SimpleMap.parse(json['simple_map']) if json['simple_map']
        data.complex_map = Parsers::ComplexMap.parse(json['complex_map']) if json['complex_map']
        data.simple_set = json['simple_set']
        data.complex_set = json['complex_set']
        data.event_stream = Parsers::EventStream.parse(json['event_stream']) if json['event_stream']
        data.inline_document = json['inline_document']
        return data
      end
    end

    class EventStream
      def self.parse(json)
        key, value = json.flatten
        case key
        when 'start'
          value = Parsers::StructuredEvent.parse(value) if value
          Types::EventStream::Start.new(value) if value
        when 'end'
          value = Parsers::StructuredEvent.parse(value) if value
          Types::EventStream::End.new(value) if value
        when 'log'
          value = value
          Types::EventStream::Log.new(value) if value
        when 'simple_list'
          value = Parsers::SimpleList.parse(value) if value
          Types::EventStream::SimpleList.new(value) if value
        when 'complex_list'
          value = Parsers::ComplexList.parse(value) if value
          Types::EventStream::ComplexList.new(value) if value
        else
          Types::EventStream::Unknown.new({name: key, value: value})
        end
      end
    end

    class ComplexList
      def self.parse(json)
        json.map do |value|
          Parsers::HighScoreAttributes.parse(value) if value
        end
      end
    end

    class SimpleList
      def self.parse(json)
        json.map do |value|
          value
        end
      end
    end

    class StructuredEvent
      def self.parse(json)
        data = Types::StructuredEvent.new
        data.message = json['message']
        return data
      end
    end

    class ComplexSet
      def self.parse(json)
        data = json.map do |value|
          Parsers::HighScoreAttributes.parse(value) if value
        end
        Set.new(data)
      end
    end

    class SimpleSet
      def self.parse(json)
        data = json.map do |value|
          value
        end
        Set.new(data)
      end
    end

    class ComplexMap
      def self.parse(json)
        data = {}
        json.map do |key, value|
          data[key] = Parsers::HighScoreAttributes.parse(value) if value
        end
        data
      end
    end

    class SimpleMap
      def self.parse(json)
        data = {}
        json.map do |key, value|
          data[key] = value
        end
        data
      end
    end

    # Error Parser for UnprocessableEntityError
    class UnprocessableEntityError
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::UnprocessableEntityError.new
        data.errors = Parsers::AttributeErrors.parse(json['errors']) if json['errors']
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
