# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Builders

    # Operation Builder for GetHighScore
    class GetHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Seahorse::HTTP.uri_escape(input[:id].to_str)
          )
        )
      end
    end

    # Operation Builder for DeleteHighScore
    class DeleteHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'DELETE'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Seahorse::HTTP.uri_escape(input[:id].to_str)
          )
        )
      end
    end

    # Operation Builder for Stream
    class Stream
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/stream')
        http_req.headers['StreamID'] = input[:stream_id].to_str if input.key?(:stream_id)

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:blob] = input[:blob] unless input[:blob].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Operation Builder for UpdateHighScore
    class UpdateHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'PUT'
        http_req.append_path(format(
            '/high_scores/%<id>s',
            id: Seahorse::HTTP.uri_escape(input[:id].to_str)
          )
        )

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:high_score] = Builders::HighScoreParams.build(input[:high_score]) unless input[:high_score].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Structure Builder for HighScoreParams
    class HighScoreParams
      def self.build(input)
        data = {}
        data[:game] = input[:game] unless input[:game].nil?
        data[:score] = input[:score] unless input[:score].nil?
        data[:simple_list] = Builders::SimpleList.build(input[:simple_list]) unless input[:simple_list].nil?
        data[:complex_list] = Builders::ComplexList.build(input[:complex_list]) unless input[:complex_list].nil?
        data[:simple_map] = Builders::SimpleMap.build(input[:simple_map]) unless input[:simple_map].nil?
        data[:complex_map] = Builders::ComplexMap.build(input[:complex_map]) unless input[:complex_map].nil?
        data[:simple_set] = Builders::SimpleSet.build(input[:simple_set]) unless input[:simple_set].nil?
        data[:complex_set] = Builders::ComplexSet.build(input[:complex_set]) unless input[:complex_set].nil?
        data[:event_stream] = Builders::EventStream.build(input[:event_stream]) unless input[:event_stream].nil?
        data
      end
    end

    # Structure Builder for StructuredEvent
    class StructuredEvent
      def self.build(input)
        data = {}
        data[:message] = input[:message] unless input[:message].nil?
        data
      end
    end

    # Set Builder for ComplexSet

    class ComplexSet
      def self.build(input)
        input.map do |element|
          Builders::HighScoreAttributes.build(element) unless element.nil?
        end
      end
    end

    # Structure Builder for HighScoreAttributes
    class HighScoreAttributes
      def self.build(input)
        data = {}
        data[:id] = input[:id] unless input[:id].nil?
        data[:game] = input[:game] unless input[:game].nil?
        data[:score] = input[:score] unless input[:score].nil?
        data[:created_at] = Seahorse::TimeHelper.to_date_time(input[:created_at]) unless input[:created_at].nil?
        data[:updated_at] = Seahorse::TimeHelper.to_date_time(input[:updated_at]) unless input[:updated_at].nil?
        data
      end
    end

    # Set Builder for SimpleSet

    class SimpleSet
      def self.build(input)
        input.map do |element|
          element unless element.nil?
        end
      end
    end

    # Map Builder for ComplexMap

    class ComplexMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = Builders::HighScoreAttributes.build(value) unless value.nil?
        end
        data
      end
    end

    # Map Builder for SimpleMap

    class SimpleMap
      def self.build(input)
        data = {}
        input.each do |key, value|
          data[key] = value unless value.nil?
        end
        data
      end
    end

    # List Builder for ComplexList

    class ComplexList
      def self.build(input)
        input.map do |element|
          Builders::HighScoreAttributes.build(element) unless element.nil?
        end
      end
    end

    # List Builder for SimpleList

    class SimpleList
      def self.build(input)
        input.map do |element|
          element unless element.nil?
        end
      end
    end

    # Operation Builder for ListHighScores
    class ListHighScores
      def self.build(http_req, input:)
        http_req.http_method = 'GET'
        http_req.append_path('/high_scores')
        http_req.append_query_param('maxResults', input[:max_results].to_str) if input.key?(:max_results)
        http_req.append_query_param('nextToken', input[:next_token].to_str) if input.key?(:next_token)
      end
    end

    # Operation Builder for CreateHighScore
    class CreateHighScore
      def self.build(http_req, input:)
        http_req.http_method = 'POST'
        http_req.append_path('/high_scores')

        http_req.headers['Content-Type'] = 'application/json'
        data = {}
        data[:high_score] = Builders::HighScoreParams.build(input[:high_score]) unless input[:high_score].nil?
        http_req.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end
  end
end
