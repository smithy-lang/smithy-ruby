# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
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
        http_resp.status = 201
        http_resp.headers['Location'] = stub[:location].to_s unless stub[:location].nil?

        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        data ||= {}
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
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
          simple_list: Stubs::SimpleList.default(visited),
          complex_list: Stubs::ComplexList.default(visited),
          simple_map: Stubs::SimpleMap.default(visited),
          complex_map: Stubs::ComplexMap.default(visited),
          simple_set: Stubs::SimpleSet.default(visited),
          complex_set: Stubs::ComplexSet.default(visited),
          event_stream: Stubs::EventStream.default(visited),
        }
      end

      def self.stub(stub = {})
        data = {}
        data[:id] = stub[:id] unless stub[:id].nil?
        data[:game] = stub[:game] unless stub[:game].nil?
        data[:score] = stub[:score] unless stub[:score].nil?
        data[:created_at] = Seahorse::TimeHelper.to_date_time(stub[:created_at]) unless stub[:created_at].nil?
        data[:updated_at] = Seahorse::TimeHelper.to_date_time(stub[:updated_at]) unless stub[:updated_at].nil?
        data[:simple_list] = Stubs::SimpleList.stub(stub[:simple_list]) unless stub[:simple_list].nil?
        data[:complex_list] = Stubs::ComplexList.stub(stub[:complex_list]) unless stub[:complex_list].nil?
        data[:simple_map] = Stubs::SimpleMap.stub(stub[:simple_map]) unless stub[:simple_map].nil?
        data[:complex_map] = Stubs::ComplexMap.stub(stub[:complex_map]) unless stub[:complex_map].nil?
        data[:simple_set] = Stubs::SimpleSet.stub(stub[:simple_set]) unless stub[:simple_set].nil?
        data[:complex_set] = Stubs::ComplexSet.stub(stub[:complex_set]) unless stub[:complex_set].nil?
        data[:event_stream] = Stubs::EventStream.stub(stub[:event_stream]) unless stub[:event_stream].nil?
        data
      end
    end

    # Union Stubber for EventStream
    class EventStream

      def self.default(visited=[])
        return nil if visited.include?('EventStream')
        visited = visited + ['EventStream']
        {
          start: Stubs::StructuredEvent.default(visited),
        }
      end

      def self.stub(stub = {})
        data = {}
        data[:start] = Stubs::StructuredEvent.stub(stub[:start]) unless stub[:start].nil?
        data[:end] = Stubs::StructuredEvent.stub(stub[:end]) unless stub[:end].nil?
        data[:log] = stub[:log] unless stub[:log].nil?
        data[:simple_list] = Stubs::SimpleList.stub(stub[:simple_list]) unless stub[:simple_list].nil?
        data[:complex_list] = Stubs::ComplexList.stub(stub[:complex_list]) unless stub[:complex_list].nil?
        data
      end
    end

    # List Stubber for ComplexList

    class ComplexList

      def self.default(visited=[])
        return nil if visited.include?('ComplexList')
        visited = visited + ['ComplexList']
        [
          Stubs::HighScoreAttributes.default(visited)
        ]
      end
      def self.stub(stub = [])
        data = []
        stub.each do |element|
          data << Stubs::HighScoreAttributes.stub(element) unless element.nil?
        end
        data
      end
    end

    # List Stubber for SimpleList

    class SimpleList

      def self.default(visited=[])
        return nil if visited.include?('SimpleList')
        visited = visited + ['SimpleList']
        [
          'String'
        ]
      end
      def self.stub(stub = [])
        data = []
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    # Structure Stubber for StructuredEvent
    class StructuredEvent

      def self.default(visited=[])
        return nil if visited.include?('StructuredEvent')
        visited = visited + ['StructuredEvent']
        {
          message: 'message',
        }
      end

      def self.stub(stub = {})
        data = {}
        data[:message] = stub[:message] unless stub[:message].nil?
        data
      end
    end

    # Set Stubber for ComplexSet

    class ComplexSet

      def self.default(visited=[])
        return nil if visited.include?('ComplexSet')
        visited = visited + ['ComplexSet']
        [
          Stubs::HighScoreAttributes.default(visited)
        ]
      end
      def
      self.stub(stub = [])
        data = Set.new
        stub.each do |element|
          data << Stubs::HighScoreAttributes.stub(element) unless element.nil?
        end
        data
      end
    end

    # Set Stubber for SimpleSet

    class SimpleSet

      def self.default(visited=[])
        return nil if visited.include?('SimpleSet')
        visited = visited + ['SimpleSet']
        [
          'String'
        ]
      end
      def
      self.stub(stub = [])
        data = Set.new
        stub.each do |element|
          data << element unless element.nil?
        end
        data
      end
    end

    # Map Stubber for ComplexMap

    class ComplexMap

      def self.default(visited=[])
        return nil if visited.include?('ComplexMap')
        visited = visited + ['ComplexMap']
        {
          test_key: Stubs::HighScoreAttributes.default(visited)
        }
      end

      def self.stub(stub = {})
        data = {}
        stub.each do |key, value|
          data[key] = Stubs::HighScoreAttributes.stub(value) unless value.nil?
        end
        data
      end
    end

    # Map Stubber for SimpleMap

    class SimpleMap

      def self.default(visited=[])
        return nil if visited.include?('SimpleMap')
        visited = visited + ['SimpleMap']
        {
          test_key: 1
        }
      end

      def self.stub(stub = {})
        data = {}
        stub.each do |key, value|
          data[key] = value unless value.nil?
        end
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
        http_resp.status = 200

        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        data ||= {}
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end

    # Operation Stubber for ListHighScores
    class ListHighScores

      def self.default(visited=[])
        {
          next_token: 'next_token',
          high_scores: Stubs::HighScores.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200

        http_resp.headers['Content-Type'] = 'application/json'
        data = {}
        data[:next_token] = stub[:next_token] unless stub[:next_token].nil?
        data[:high_scores] = Stubs::HighScores.stub(stub[:high_scores]) unless stub[:high_scores].nil?
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
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
        http_resp.status = 200

        http_resp.headers['Content-Type'] = 'application/json'
        data = Stubs::HighScoreAttributes.stub(stub[:high_score]) unless stub[:high_score].nil?
        data ||= {}
        http_resp.body = StringIO.new(Seahorse::JSON.dump(data))
      end
    end
  end
end
