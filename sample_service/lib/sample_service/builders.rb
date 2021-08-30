# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Builders

    # Operation Builder for UpdateHighScore
    class UpdateHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'PUT'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Seahorse::HTTP.uri_escape(params[:id].to_str)
          )
        )

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:high_score] = Builders::HighScoreParams.build(params[:high_score]) unless params[:high_score].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Structure Builder for HighScoreParams
    class HighScoreParams
      def self.build(params)
        data = {}
        data[:game] = params[:game] unless params[:game].nil?
        data[:score] = params[:score] unless params[:score].nil?
        data[:simple_list] = Builders::SimpleList.build(params[:simple_list]) unless params[:simple_list].nil?
        data[:complex_list] = Builders::ComplexList.build(params[:complex_list]) unless params[:complex_list].nil?
        data[:simple_map] = Builders::SimpleMap.build(params[:simple_map]) unless params[:simple_map].nil?
        data[:complex_map] = Builders::ComplexMap.build(params[:complex_map]) unless params[:complex_map].nil?
        data[:event_stream] = Builders::EventStream.build(params[:event_stream]) unless params[:event_stream].nil?
        data
      end
    end

    # Structure Builder for StructuredEvent
    class StructuredEvent
      def self.build(params)
        data = {}
        data[:message] = params[:message] unless params[:message].nil?
        data
      end
    end

    # Structure Builder for HighScoreAttributes
    class HighScoreAttributes
      def self.build(params)
        data = {}
        data[:id] = params[:id] unless params[:id].nil?
        data[:game] = params[:game] unless params[:game].nil?
        data[:score] = params[:score] unless params[:score].nil?
        data[:created_at] = params[:created_at].to_s unless params[:created_at].nil?
        data[:updated_at] = params[:updated_at].to_s unless params[:updated_at].nil?
        data
      end
    end

    # List Builder for ComplexList

    class ComplexList
      def self.build(params)
        data = []
        params.each do |p|
          data << p
        end
      end
    end

    # List Builder for SimpleList

    class SimpleList
      def self.build(params)
        data = []
        params.each do |p|
          data << p
        end
      end
    end

    # Operation Builder for ListHighScores
    class ListHighScores
      def self.build(http_req, params:)
        http_req.http_method = 'GET'
        http_req.append_path('/high_scores')
        http_req.append_query_param('maxResults', params[:max_results].to_str) if params.key?(:max_results)
        http_req.append_query_param('nextToken', params[:next_token].to_str) if params.key?(:next_token)
      end
    end

    # Operation Builder for DeleteHighScore
    class DeleteHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'DELETE'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Seahorse::HTTP.uri_escape(params[:id].to_str)
          )
        )
      end
    end

    # Operation Builder for CreateHighScore
    class CreateHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'POST'
        http_req.append_path('/high_scores')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:high_score] = Builders::HighScoreParams.build(params[:high_score]) unless params[:high_score].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Operation Builder for GetHighScore
    class GetHighScore
      def self.build(http_req, params:)
        http_req.http_method = 'GET'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Seahorse::HTTP.uri_escape(params[:id].to_str)
          )
        )
      end
    end

    # Operation Builder for Stream
    class Stream
      def self.build(http_req, params:)
        http_req.http_method = 'POST'
        http_req.append_path('/stream')
        http_req.headers['StreamID'] = params[:stream_id].to_str if params.key?(:stream_id)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end
  end
end
