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
    end

    class CityCoordinates
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
    end

    class Message
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
    end

    class Baz
    end

    class Foo
    end

    class OtherStructure
    end

    class StringMap
    end

    # Operation Parser for ListCities
    class ListCities

      def self.parse(http_resp)
        data = Types::ListCitiesOutput.new
        data
      end
    end

    class SparseCitySummaries
    end

    class CitySummaries
    end

    # Operation Parser for __789BadName
    class Operation____789BadName

      def self.parse(http_resp)
        data = Types::Struct____789BadNameOutput.new
        data
      end
    end

    class Struct____456efg
    end
  end
end
