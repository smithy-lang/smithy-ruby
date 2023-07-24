# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  # @api private
  module Stubs

    class Announcements
      def self.default(visited = Set.new)
        return nil if visited.include?('Announcements')
        visited.add('Announcements')
        {
          police: Message.default(visited),
        }
      end

    end

    class Baz
      def self.default(visited = Set.new)
        return nil if visited.include?('Baz')
        visited.add('Baz')
        {
          baz: 'baz',
          bar: 'bar',
        }
      end

    end

    class CityCoordinates
      def self.default(visited = Set.new)
        return nil if visited.include?('CityCoordinates')
        visited.add('CityCoordinates')
        {
          latitude: 1.0,
          longitude: 1.0,
        }
      end

    end

    class CitySummaries
      def self.default(visited = Set.new)
        return nil if visited.include?('CitySummaries')
        visited.add('CitySummaries')
        [
          CitySummary.default(visited)
        ]
      end

    end

    class CitySummary
      def self.default(visited = Set.new)
        return nil if visited.include?('CitySummary')
        visited.add('CitySummary')
        {
          city_id: 'city_id',
          name: 'name',
          number: 'number',
          case: 'case',
        }
      end

    end

    class Foo
      def self.default(visited = Set.new)
        return nil if visited.include?('Foo')
        visited.add('Foo')
        {
          baz: 'baz',
          bar: 'bar',
        }
      end

    end

    class GetCity
      PARAMS_CLASS = Params::GetCityOutput

      def self.default(visited = Set.new)
        {
          name: 'name',
          coordinates: CityCoordinates.default(visited),
          city: CitySummary.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class GetCityAnnouncements
      PARAMS_CLASS = Params::GetCityAnnouncementsOutput

      def self.default(visited = Set.new)
        {
          last_updated: Time.now,
          announcements: Announcements.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        http_resp.headers['x-last-updated'] = Hearth::TimeHelper.to_date_time(stub[:last_updated]) unless stub[:last_updated].nil?
        IO.copy_stream(stub[:announcements], http_resp.body)
      end
    end

    class GetCityImage
      PARAMS_CLASS = Params::GetCityImageOutput

      def self.default(visited = Set.new)
        {
          image: 'image',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
        IO.copy_stream(stub[:image], http_resp.body)
      end
    end

    class GetCurrentTime
      PARAMS_CLASS = Params::GetCurrentTimeOutput

      def self.default(visited = Set.new)
        {
          time: Time.now,
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class GetForecast
      PARAMS_CLASS = Params::GetForecastOutput

      def self.default(visited = Set.new)
        {
          chance_of_rain: 1.0,
          precipitation: Precipitation.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class ListCities
      PARAMS_CLASS = Params::ListCitiesOutput

      def self.default(visited = Set.new)
        {
          next_token: 'next_token',
          some_enum: 'some_enum',
          a_string: 'a_string',
          default_bool: false,
          boxed_bool: false,
          default_number: 1,
          boxed_number: 1,
          items: CitySummaries.default(visited),
          sparse_items: SparseCitySummaries.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end

    class Message
      def self.default(visited = Set.new)
        return nil if visited.include?('Message')
        visited.add('Message')
        {
          message: 'message',
          author: 'author',
        }
      end

    end

    class NoSuchResource
      ERROR_CLASS = Errors::NoSuchResource
      PARAMS_CLASS = Params::NoSuchResource

      def self.default(visited = Set.new)
        return nil if visited.include?('NoSuchResource')
        visited.add('NoSuchResource')
        {
          resource_type: 'resource_type',
          message: 'message',
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 404
      end
    end

    class OtherStructure
      def self.default(visited = Set.new)
        return nil if visited.include?('OtherStructure')
        visited.add('OtherStructure')
        {
        }
      end

    end

    class Precipitation
      def self.default(visited = Set.new)
        return nil if visited.include?('Precipitation')
        visited.add('Precipitation')
        {
          rain: false,
        }
      end

    end

    class SparseCitySummaries
      def self.default(visited = Set.new)
        return nil if visited.include?('SparseCitySummaries')
        visited.add('SparseCitySummaries')
        [
          CitySummary.default(visited)
        ]
      end

    end

    class StringMap
      def self.default(visited = Set.new)
        return nil if visited.include?('StringMap')
        visited.add('StringMap')
        {
          key: 'value'
        }
      end

    end

    class Struct____456efg
      def self.default(visited = Set.new)
        return nil if visited.include?('Struct____456efg')
        visited.add('Struct____456efg')
        {
          member___123foo: 'member___123foo',
        }
      end

    end

    class Operation____789BadName
      PARAMS_CLASS = Params::Struct____789BadNameOutput

      def self.default(visited = Set.new)
        {
          member___123abc: 'member___123abc',
          member: Struct____456efg.default(visited),
        }
      end

      def self.stub(http_resp, stub:)
        data = {}
        http_resp.status = 200
      end
    end
  end
end
