# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Stubs

    # Operation Stubber for GetCity
    class GetCity

      def self.default(visited=[])
        {
          member_name: 'member_name',
          coordinates: Stubs::CityCoordinates.default(visited),
          city: Stubs::CitySummary.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200
      end
    end

    # Structure Stubber for CitySummary
    class CitySummary

      def self.default(visited=[])
        return nil if visited.include?('CitySummary')
        visited = visited + ['CitySummary']
        {
          city_id: 'city_id',
          member_name: 'member_name',
          number: 'number',
          case: 'case',
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Structure Stubber for CityCoordinates
    class CityCoordinates

      def self.default(visited=[])
        return nil if visited.include?('CityCoordinates')
        visited = visited + ['CityCoordinates']
        {
          latitude: 1.0,
          longitude: 1.0,
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Operation Stubber for GetCityAnnouncements
    class GetCityAnnouncements

      def self.default(visited=[])
        {
          last_updated: Time.now,
          announcements: Stubs::Announcements.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200
        http_resp.headers['x-last-updated'] = Seahorse::TimeHelper.to_http_date(stub[:last_updated]) unless stub[:last_updated].nil?
      end
    end

    # Union Stubber for Announcements
    class Announcements

      def self.default(visited=[])
        return nil if visited.include?('Announcements')
        visited = visited + ['Announcements']
        {
          police: Stubs::Message.default(visited),
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Structure Stubber for Message
    class Message

      def self.default(visited=[])
        return nil if visited.include?('Message')
        visited = visited + ['Message']
        {
          message: 'message',
          author: 'author',
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Operation Stubber for GetCityImage
    class GetCityImage

      def self.default(visited=[])
        {
          image: 'image',
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200
      end
    end

    # Operation Stubber for GetCurrentTime
    class GetCurrentTime

      def self.default(visited=[])
        {
          time: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200
      end
    end

    # Operation Stubber for GetForecast
    class GetForecast

      def self.default(visited=[])
        {
          chance_of_rain: 1.0,
          precipitation: Stubs::Precipitation.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200
      end
    end

    # Union Stubber for Precipitation
    class Precipitation

      def self.default(visited=[])
        return nil if visited.include?('Precipitation')
        visited = visited + ['Precipitation']
        {
          rain: false,
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Structure Stubber for Baz
    class Baz

      def self.default(visited=[])
        return nil if visited.include?('Baz')
        visited = visited + ['Baz']
        {
          baz: 'baz',
          bar: 'bar',
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Structure Stubber for Foo
    class Foo

      def self.default(visited=[])
        return nil if visited.include?('Foo')
        visited = visited + ['Foo']
        {
          baz: 'baz',
          bar: 'bar',
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Structure Stubber for OtherStructure
    class OtherStructure

      def self.default(visited=[])
        return nil if visited.include?('OtherStructure')
        visited = visited + ['OtherStructure']
        {
        }
      end

      def self.stub(stub = {})
        data
      end
    end

    # Map Stubber for StringMap
    class StringMap
      def self.default(visited=[])
        return nil if visited.include?('StringMap')
        visited = visited + ['StringMap']
        {
          test_key: 'value'
        }
      end

      def self.stub(stub = {})
        data = {}
        stub.each do |key, value|
        end
        data
      end
    end

    # Operation Stubber for ListCities
    class ListCities

      def self.default(visited=[])
        {
          next_token: 'next_token',
          some_enum: 'some_enum',
          a_string: 'a_string',
          default_bool: false,
          boxed_bool: false,
          default_number: 1,
          boxed_number: 1,
          items: Stubs::CitySummaries.default(visited),
          sparse_items: Stubs::SparseCitySummaries.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200
      end
    end

    # List Stubber for SparseCitySummaries
    class SparseCitySummaries
      def self.default(visited=[])
        return nil if visited.include?('SparseCitySummaries')
        visited = visited + ['SparseCitySummaries']
        [
          Stubs::CitySummary.default(visited)
        ]
      end
      def self.stub(stub = [])
        data = []
        stub.each do |element|
        end
        data
      end
    end

    # List Stubber for CitySummaries
    class CitySummaries
      def self.default(visited=[])
        return nil if visited.include?('CitySummaries')
        visited = visited + ['CitySummaries']
        [
          Stubs::CitySummary.default(visited)
        ]
      end
      def self.stub(stub = [])
        data = []
        stub.each do |element|
        end
        data
      end
    end

    # Operation Stubber for __789BadName
    class Operation__789BadName

      def self.default(visited=[])
        {
          member___123abc: 'member___123abc',
          member: Stubs::Struct__456efg.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        http_resp.status = 200
      end
    end

    # Structure Stubber for __456efg
    class Struct__456efg

      def self.default(visited=[])
        return nil if visited.include?('Struct__456efg')
        visited = visited + ['Struct__456efg']
        {
          member___123foo: 'member___123foo',
        }
      end

      def self.stub(stub = {})
        data
      end
    end
  end
end
