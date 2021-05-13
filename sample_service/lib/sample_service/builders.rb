module SampleService
  # @api private
  module Builders

    class HighScoreParams
      def self.build(input:)
        json = {}
        json[:game] = input[:game] unless input[:game].nil?
        json[:score] = input[:score] unless input[:score].nil?
        json
      end
    end

    class GetHighScore
      def self.build(http_req, input:)
        raise ArgumentError if input[:id].nil? || input[:id].empty?

        http_req.http_method = 'GET'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(input[:id])
        ))
      end
    end

    class CreateHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/high_scores')
        http_req.headers['Content-Type'] = 'application/json'
        json = {}
        json[:high_score] = HighScoreParams.build(input: input[:high_score])
        http_req.body = StringIO.new(Seahorse::JSON.dump(json))
      end
    end

    class UpdateHighScore
      def self.build(http_req, input:)
        raise ArgumentError if input[:id].nil? || input[:id].empty?

        http_req.http_method = 'PUT'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(input[:id])
        ))
        http_req.headers['Content-Type'] = 'application/json'
        json = {}
        json[:high_score] = HighScoreParams.build(input: input[:high_score])
        http_req.body = StringIO.new(Seahorse::JSON.dump(json))
      end
    end

    class DeleteHighScore
      def self.build(http_req, input:)
        raise ArgumentError if input[:id].nil? || input[:id].empty?

        http_req.http_method = 'DELETE'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(input[:id])
        ))
      end
    end

    class ListHighScores
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/high_scores')
        http_req.append_query_param('maxResults', input[:max_results]) unless input[:max_results].nil?
        http_req.append_query_param('nextToken', input[:next_token]) unless input[:next_token].nil?
      end
    end

    class Stream
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/stream')
        http_req.headers['Transfer-Encoding'] = 'chunked'
        http_req.headers['StreamID'] = input[:stream_id] if input[:stream_id]
        http_req.body = input[:blob]
      end
    end

  end
end
