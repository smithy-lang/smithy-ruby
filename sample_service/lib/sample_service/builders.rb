module SampleService
  # @api private
  module Builders

    class EventStream
      def self.build(input)
        json = {}
        case input
        when Types::EventStream::Start
          json[:start] = StructuredEvent.build(input)
        when Types::EventStream::End
          json[:end] = StructuredEvent.build(input)
        when Types::EventStream::Log
          json[:log] = input[:log]
        end
        json
      end
    end

    class StructuredEvent
      def self.build(input = Types::StructuredEvent.new)
        json = {}
        json[:message] = input[:message] unless input[:message].nil?
        json
      end
    end

    class HighScoreParams
      def self.build(input = Types::HighScoreParams.new)
        json = {}
        json[:game] = input[:game] unless input[:game].nil?
        json[:score] = input[:score] unless input[:score].nil?
        json
      end
    end

    class GetHighScore
      def self.build(http_req, input = Types::GetHighScoreInput.new)
        raise ArgumentError if input[:id].nil? || input[:id].empty?

        http_req.http_method = 'GET'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(input[:id])
        ))
      end
    end

    class CreateHighScore
      def self.build(http_req, input = Types::CreateHighScoreInput.new)
        http_req.http_method = 'POST'
        http_req.append_path('/high_scores')
        http_req.headers['Content-Type'] = 'application/json'
        json = {}
        json[:high_score] = HighScoreParams.build(input[:high_score])
        http_req.body = StringIO.new(Seahorse::JSON.dump(json))
      end
    end

    class UpdateHighScore
      def self.build(http_req, input = Types::UpdateHighScoreInput.new)
        raise ArgumentError if input[:id].nil? || input[:id].empty?

        http_req.http_method = 'PUT'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(input[:id])
        ))
        http_req.headers['Content-Type'] = 'application/json'
        json = {}
        json[:high_score] = HighScoreParams.build(input[:high_score])
        http_req.body = StringIO.new(Seahorse::JSON.dump(json))
      end
    end

    class DeleteHighScore
      def self.build(http_req, input = Types::DeleteHighScoreInput.new)
        raise ArgumentError if input[:id].nil? || input[:id].empty?

        http_req.http_method = 'DELETE'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(input[:id])
        ))
      end
    end

    class ListHighScores
      def self.build(http_req, input = Types::ListHighScoresInput.new)
        http_req.http_method = 'GET'
        http_req.append_path('/high_scores')
        http_req.append_query_param('maxResults', input[:max_results]) unless input[:max_results].nil?
        http_req.append_query_param('nextToken', input[:next_token]) unless input[:next_token].nil?
      end
    end

    class Stream
      def self.build(http_req, input = Types::Stream.new)
        http_req.http_method = 'POST'
        http_req.append_path('/stream')
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['StreamID'] = input[:stream_id] if input[:stream_id]
        unless input[:blob].respond_to?(:read) || input[:blob].respond_to?(:readpartial)
          input[:blob] = StringIO.new(input[:blob])
        end
        http_req.body = input[:blob]
      end
    end

  end
end
