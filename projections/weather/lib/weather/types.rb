# frozen_string_literal: true

# This is generated code!

module Weather
  # This module contains the types returned by client operations.
  module Types

    # @!attribute latitude
    #   @return [Float]
    # @!attribute longitude
    #   @return [Float]
    class CityCoordinates < Struct.new(
      :latitude,
      :longitude,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute city_id
    #   @return [String]
    # @!attribute name
    #   @return [String]
    class CitySummary < Struct.new(
      :city_id,
      :name,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute city_id
    #   @return [String]
    class GetCityInput < Struct.new(
      :city_id,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute name
    #   @return [String]
    # @!attribute coordinates
    #   @return [Types::CityCoordinates]
    class GetCityOutput < Struct.new(
      :name,
      :coordinates,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute time
    #   @return [Time]
    class GetCurrentTimeOutput < Struct.new(
      :time,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute city_id
    #   @return [String]
    class GetForecastInput < Struct.new(
      :city_id,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute chance_of_rain
    #   @return [Float]
    class GetForecastOutput < Struct.new(
      :chance_of_rain,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute next_token
    #   @return [String]
    # @!attribute page_size
    #   @return [Integer]
    class ListCitiesInput < Struct.new(
      :next_token,
      :page_size,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute next_token
    #   @return [String]
    # @!attribute items
    #   @return [Array<Types::CitySummary>]
    class ListCitiesOutput < Struct.new(
      :next_token,
      :items,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

    # @!attribute resource_type
    #   @return [String]
    class NoSuchResource < Struct.new(
      :resource_type,
      keyword_init: true)
      include Smithy::Schema::Structure
    end

  end
end
