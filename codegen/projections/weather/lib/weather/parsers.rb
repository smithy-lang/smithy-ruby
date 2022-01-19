# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'base64'

module Weather
  module Parsers

    # Operation Parser for GetCity
    class GetCity
      def self.parse(http_resp)
        data = Types::GetCityOutput.new
        data
      end
    end

    class CitySummary
      def self.parse(map)
        data = Types::CitySummary.new
        return data
      end
    end

    class CityCoordinates
      def self.parse(map)
        data = Types::CityCoordinates.new
        return data
      end
    end

    # Error Parser for NoSuchResource
    class NoSuchResource
      def self.parse(http_resp)
        data = Types::NoSuchResource.new
        data
      end
    end

    # Operation Parser for GetCityAnnouncements
    class GetCityAnnouncements
      def self.parse(http_resp)
        data = Types::GetCityAnnouncementsOutput.new
        data.last_updated = Time.parse(http_resp.headers['x-last-updated']) if http_resp.headers['x-last-updated']
        data
      end
    end

    class Announcements
      def self.parse(map)
        key, value = map.flatten
        case key
        when 'police'
          Types::Announcements::Police.new(value) if value
        when 'fire'
          Types::Announcements::Fire.new(value) if value
        when 'health'
          Types::Announcements::Health.new(value) if value
        else
          Types::Announcements::Unknown.new({name: key, value: value})
        end
      end
    end

    class Message
      def self.parse(map)
        data = Types::Message.new
        return data
      end
    end

    # Operation Parser for GetCityImage
    class GetCityImage
      def self.parse(http_resp)
        data = Types::GetCityImageOutput.new
        data
      end
    end

    # Operation Parser for GetCurrentTime
    class GetCurrentTime
      def self.parse(http_resp)
        data = Types::GetCurrentTimeOutput.new
        data
      end
    end

    # Operation Parser for GetForecast
    class GetForecast
      def self.parse(http_resp)
        data = Types::GetForecastOutput.new
        data
      end
    end

    class Precipitation
      def self.parse(map)
        key, value = map.flatten
        case key
        when 'rain'
          Types::Precipitation::Rain.new(value) if value
        when 'sleet'
          Types::Precipitation::Sleet.new(value) if value
        when 'hail'
          Types::Precipitation::Hail.new(value) if value
        when 'snow'
          Types::Precipitation::Snow.new(value) if value
        when 'mixed'
          Types::Precipitation::Mixed.new(value) if value
        when 'other'
          Types::Precipitation::Other.new(value) if value
        when 'blob'
          Types::Precipitation::Blob.new(value) if value
        when 'foo'
          Types::Precipitation::Foo.new(value) if value
        when 'baz'
          Types::Precipitation::Baz.new(value) if value
        else
          Types::Precipitation::Unknown.new({name: key, value: value})
        end
      end
    end

    class Baz
      def self.parse(map)
        data = Types::Baz.new
        return data
      end
    end

    class Foo
      def self.parse(map)
        data = Types::Foo.new
        return data
      end
    end

    class OtherStructure
      def self.parse(map)
        data = Types::OtherStructure.new
        return data
      end
    end

    class StringMap
      def self.parse(map)
        data = {}
        map.map do |key, value|
        end
        data
      end
    end

    # Operation Parser for ListCities
    class ListCities
      def self.parse(http_resp)
        data = Types::ListCitiesOutput.new
        data
      end
    end

    class SparseCitySummaries
      def self.parse(list)
        list.map do |value|
        end
      end
    end

    class CitySummaries
      def self.parse(list)
        list.map do |value|
        end
      end
    end

    # Operation Parser for __789BadName
    class Operation____789BadName
      def self.parse(http_resp)
        data = Types::Struct____789BadNameOutput.new
        data
      end
    end

    class Struct____456efg
      def self.parse(map)
        data = Types::Struct____456efg.new
        return data
      end
    end
  end
end
