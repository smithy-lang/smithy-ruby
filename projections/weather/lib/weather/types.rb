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
      nil,
      :latitude,
      :longitude,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute city_id
    #   @return [String]
    # @!attribute name
    #   @return [String]
    class CitySummary < Struct.new(
      nil,
      :city_id,
      :name,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute city_id
    #   @return [String]
    class GetCityInput < Struct.new(
      nil,
      :city_id,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute name
    #   @return [String]
    # @!attribute coordinates
    #   @return [Types::CityCoordinates]
    class GetCityOutput < Struct.new(
      nil,
      :name,
      :coordinates,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute time
    #   @return [Time]
    class GetCurrentTimeOutput < Struct.new(
      nil,
      :time,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute city_id
    #   @return [String]
    class GetForecastInput < Struct.new(
      nil,
      :city_id,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute chance_of_rain
    #   @return [Float]
    class GetForecastOutput < Struct.new(
      nil,
      :chance_of_rain,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute next_token
    #   @return [String]
    # @!attribute page_size
    #   @return [Integer]
    class ListCitiesInput < Struct.new(
      nil,
      :next_token,
      :page_size,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute next_token
    #   @return [String]
    # @!attribute items
    #   @return [Array<Types::CitySummary>]
    class ListCitiesOutput < Struct.new(
      nil,
      :next_token,
      :items,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

    # @!attribute resource_type
    #   @return [String]
    class NoSuchResource < Struct.new(
      nil,
      :resource_type,
      keyword_init: true
    )
      include ::Smithy::Schema::Structure
    end

  end
end
