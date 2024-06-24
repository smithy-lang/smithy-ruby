# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  # @api private
  module Builders

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

    class DeleteHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'DELETE'
        if input[:id].to_s.empty?
          raise ArgumentError, "HTTP label :id cannot be empty."
        end
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Hearth::HTTP.uri_escape(input[:id].to_s)
          )
        )
      end
    end

    class GetHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        if input[:id].to_s.empty?
          raise ArgumentError, "HTTP label :id cannot be empty."
        end
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Hearth::HTTP.uri_escape(input[:id].to_s)
          )
        )
      end
    end

    class HighScoreParams
      def self.build(input)
        data = {}
        data[:game] = input[:game] unless input[:game].nil?
        data[:score] = input[:score] unless input[:score].nil?
        data
      end
    end

    class ListHighScores
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/high_scores')
      end
    end

    class UpdateHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        if input[:id].to_s.empty?
          raise ArgumentError, "HTTP label :id cannot be empty."
        end
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
