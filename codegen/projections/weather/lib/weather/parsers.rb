# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  # @api private
  module Parsers

    class Baz
    end

    class CityCoordinates
    end

    class CitySummaries
    end

    class CitySummary
    end

    class Foo
    end

    class GetCity
      def self.parse(http_resp)
        data = Types::GetCityOutput.new
        data
      end
    end

    class GetCityImage
      def self.parse(http_resp)
        data = Types::GetCityImageOutput.new
        data.image = http_resp.body
        data
      end
    end

    class GetCurrentTime
      def self.parse(http_resp)
        data = Types::GetCurrentTimeOutput.new
        data
      end
    end

    class GetForecast
      def self.parse(http_resp)
        data = Types::GetForecastOutput.new
        data
      end
    end

    class ListCities
      def self.parse(http_resp)
        data = Types::ListCitiesOutput.new
        data
      end
    end

    # Error Parser for NoSuchResource
    class NoSuchResource
      def self.parse(http_resp)
        data = Types::NoSuchResource.new
        data
      end
    end

    class OtherStructure
    end

    class Precipitation
    end

    class SparseCitySummaries
    end

    class StringMap
    end

    class Struct____456efg
    end

    class Operation____789BadName
      def self.parse(http_resp)
        data = Types::Struct____789BadNameOutput.new
        data
      end
    end
  end
end
