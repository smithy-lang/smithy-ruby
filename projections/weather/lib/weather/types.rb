# frozen_string_literal: true

# This is generated code!

module Weather
  # This module contains the types returned by client operations.
  module Types
    # This structure is nested within GetCityOutput.
    CityCoordinates = Struct.new(
      :latitude,
      :longitude,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    CitySummary = Struct.new(
      :city_id,
      :name,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    GetCityInput = Struct.new(
      :city_id,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    GetCityOutput = Struct.new(
      :name,
      :coordinates,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    GetCurrentTimeOutput = Struct.new(
      :time,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    GetForecastInput = Struct.new(
      :city_id,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    GetForecastOutput = Struct.new(
      :chance_of_rain,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    ListCitiesInput = Struct.new(
      :next_token,
      :page_size,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    ListCitiesOutput = Struct.new(
      :next_token,
      :items,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end

    NoSuchResource = Struct.new(
      :resource_type,
      keyword_init: true
    ) do
      include Smithy::Schema::Structure
    end
  end
end
