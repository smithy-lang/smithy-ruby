# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module HighScoreService
  module Builders

    # Operation Builder for CreateHighScore
    class CreateHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/high_scores')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:high_score] = Builders::HighScoreParams.build(input[:high_score]) unless input[:high_score].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Structure Builder for HighScoreParams
    class HighScoreParams
      def self.build(input)
        data = {}
        data[:game] = input[:game] unless input[:game].nil?
        data[:score] = input[:score] unless input[:score].nil?
        data
      end
    end

    # Operation Builder for DeleteHighScore
    class DeleteHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'DELETE'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Hearth::HTTP.uri_escape(input[:id].to_s)
          )
        )
      end
    end

    # Operation Builder for GetHighScore
    class GetHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Hearth::HTTP.uri_escape(input[:id].to_s)
          )
        )
      end
    end

    # Operation Builder for ListHighScores
    class ListHighScores
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/high_scores')
      end
    end

    # Operation Builder for UpdateHighScore
    class UpdateHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Hearth::HTTP.uri_escape(input[:id].to_s)
          )
        )

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:high_score] = Builders::HighScoreParams.build(input[:high_score]) unless input[:high_score].nil?
        http_req.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end
  end
end
