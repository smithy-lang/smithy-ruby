module SampleService
  # @api private
  module Parsers

    class EventStream
      def self.parse(json, data: Types::EventStream.new)
        key, value = json.flatten
        case key
        when 'start'
          data = Types::EventStream::Start.new(
            StructuredEvent.parse(value)
          )
        when 'end'
          data = Types::EventStream::End.new(
            StructuredEvent.parse(value)
          )
        when 'log'
          data = Types::EventStream::Log.new(value)
        else
          data = Types::EventStream::Unknown.new(json)
        end
        data
      end
    end

    class StructuredEvent
      def self.parse(json, data: Types::StructuredEvent.new)
        data.message = json['message']
        data
      end
    end

    class HighScoreAttributes
      def self.parse(json, data: Types::HighScoreAttributes.new)
        data.id = json['id']
        data.game = json['game']
        data.score = json['score']
        data.created_at = Time.parse(json['created_at']) if json['created_at']
        data.updated_at = Time.parse(json['updated_at']) if json['updated_at']
        data
      end
    end

    class GetHighScore
      def self.parse(http_resp, data: Types::GetHighScoreOutput.new)
        json = Seahorse::JSON.load(http_resp.body)
        data.high_score = HighScoreAttributes.parse(json)
        data
      end
    end

    class CreateHighScore
      def self.parse(http_resp, data: Types::CreateHighScoreOutput.new)
        json = Seahorse::JSON.load(http_resp.body)
        data.location = http_resp.headers['location']
        data.high_score = HighScoreAttributes.parse(json)
        data
      end
    end

    class UpdateHighScore
      def self.parse(http_resp, data: Types::UpdateHighScoreOutput.new)
        json = Seahorse::JSON.load(http_resp.body)
        data.high_score = HighScoreAttributes.parse(json)
        data
      end
    end

    class DeleteHighScore
      def self.parse(http_resp, data: Types::DeleteHighScoreOutput.new)
        data
      end
    end

    class ListHighScores
      def self.parse(http_resp, data: Types::ListHighScoresOutput.new)
        json = Seahorse::JSON.load(http_resp.body)
        data.next_token = json['next_token'] if json['next_token']
        data.high_scores = HighScores.parse(json['high_scores']) if json['high_scores']
        data
      end
    end

    class Stream
      def self.parse(http_resp, data: Types::StreamInputOutput.new)
        data.stream_id = http_resp.headers['streamid']
        data.blob = http_resp.body
        data
      end
    end

    class HighScores
      def self.parse(list)
        data = []
        list.each do |element|
          data << HighScoreAttributes.parse(element)
        end
        data
      end
    end

    class UnprocessableEntityError
      def self.parse(http_resp)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::UnprocessableEntityError.new
        data.errors = AttributeErrors.parse(json)
        data
      end
    end

    class AttributeErrors
      def self.parse(map)
        data = {}
        map.each do |key, value|
          data[key] = ErrorMessages.parse(value)
        end
        data
      end
    end

    class ErrorMessages
      def self.parse(list)
        data = []
        list.each do |element|
          data << element
        end
        data
      end
    end

  end
end
