# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Stubs

    # Operation Stubber for CreateHighScore
    class CreateHighScore

      def self.default(visited=[])
        {
          high_score: Stubs::HighScoreAttributes.default(visited),
          location: 'location',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 201
        http_resp.headers['Location'] = stub[:location] unless stub[:location].nil? || stub[:location].empty?
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Structure Stubber for HighScoreAttributes
    class HighScoreAttributes

      def self.default(visited=[])
        return nil if visited.include?('HighScoreAttributes')
        visited = visited + ['HighScoreAttributes']
        {
          id: 'id',
          game: 'game',
          score: 1,
          created_at: Time.now,
          updated_at: Time.now,
        }
      end

      def self.stub(stub = {})
        stub ||= {}
        data = {}
        data[:id] = stub[:id] unless stub[:id].nil?
        data[:game] = stub[:game] unless stub[:game].nil?
        data[:score] = stub[:score] unless stub[:score].nil?
        data[:created_at] = Hearth::TimeHelper.to_date_time(stub[:created_at]) unless stub[:created_at].nil?
        data[:updated_at] = Hearth::TimeHelper.to_date_time(stub[:updated_at]) unless stub[:updated_at].nil?
        data
      end
    end

    # Operation Stubber for DeleteHighScore
    class DeleteHighScore

      def self.default(visited=[])
        {
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    # Operation Stubber for GetHighScore
    class GetHighScore

      def self.default(visited=[])
        {
          high_score: Stubs::HighScoreAttributes.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # Operation Stubber for ListHighScores
    class ListHighScores

      def self.default(visited=[])
        {
          high_scores: Stubs::HighScores.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScores.stub(stub[:high_scores]) unless stub[:high_scores].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end

    # List Stubber for HighScores
    class HighScores
      def self.default(visited=[])
        return nil if visited.include?('HighScores')
        visited = visited + ['HighScores']
        [
          Stubs::HighScoreAttributes.default(visited)
        ]
      end

      def self.stub(stub = [])
        stub ||= []
        data = []
        stub.each do |element|
          data << Stubs::HighScoreAttributes.stub(element) unless element.nil?
        end
        data
      end
    end

    # Operation Stubber for UpdateHighScore
    class UpdateHighScore

      def self.default(visited=[])
        {
          high_score: Stubs::HighScoreAttributes.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        http_resp.body = StringIO.new(Hearth::JSON.dump(data))
      end
    end
  end
end
