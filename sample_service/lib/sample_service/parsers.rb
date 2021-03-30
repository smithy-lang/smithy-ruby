module SampleService
  module Parsers

    class HighScoreAttributes
      def self.parse(json)
        data = Types::HighScoreAttributes.new
        data.id = json['id']
        data.game = json['game']
        data.score = json['score']
        data.time = Time.parse(json['time']) if json['time']
        data.created_at = Time.parse(json['created_at']) if json['created_at']
        data.updated_at = Time.parse(json['updated_at']) if json['updated_at']
        data
      end
    end

    class GetHighScore
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::GetHighScoreOutput.new
        data.high_score = HighScoreAttributes.parse(json)
        output.data = data
      end
    end

    class CreateHighScore
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::CreateHighScoreOutput.new
        data.location = http_resp.headers['location']
        data.high_score = HighScoreAttributes.parse(json)
        output.data = data
      end
    end

    class UpdateHighScore
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        data = Types::UpdateHighScoreOutput.new
        data.high_score = HighScoreAttributes.parse(json)
        output.data = data
      end
    end

    class DeleteHighScore
      def self.parse(http_resp, output:)
        output.data = Types::DeleteHighScoreOutput.new
      end
    end

    class ListHighScores
      def self.parse(http_resp, output:)
        json = Seahorse::JSON.load(http_resp.body)
        output.data = HighScores.parse(json)
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
