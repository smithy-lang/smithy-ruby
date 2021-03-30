module SampleService
  module Builders

    class HighScoreParams
      def self.build(params:)
        json = {}
        json[:game] = params[:game] unless params[:game].nil?
        json[:score] = params[:score] unless params[:score].nil?
        json[:time] = params[:time].to_s unless params[:time].nil?
        json
      end
    end

    class GetHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'GET'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(params[:id])
        ))
      end
    end

    class CreateHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'POST'
        http_req.append_path('/high_scores')
        http_req.headers['Content-Type'] = 'application/json'
        json = {}
        json[:high_score] = HighScoreParams.build(params: params[:high_score])
        http_req.body = StringIO.new(Seahorse::JSON.dump(json))
      end
    end

    class UpdateHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'PUT'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(params[:id])
        ))
        http_req.headers['Content-Type'] = 'application/json'
        json = {}
        json[:high_score] = HighScoreParams.build(params: params[:high_score])
        http_req.body = StringIO.new(Seahorse::JSON.dump(json))
      end
    end

    class DeleteHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'DELETE'
        http_req.append_path(format('/high_scores/%<id>s',
          id: Seahorse::HTTP.uri_escape(params[:id])
        ))
      end
    end

    class ListHighScores
      def self.build(http_req, params:)
        http_req.http_method = 'GET'
        http_req.append_path('/high_scores')
      end
    end

  end
end
