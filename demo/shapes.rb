# frozen_string_literal: true

# This is generated code!

module Weather
  module Shapes
    include Smithy::Client::Shapes

    CityCoordinates = StructureShape.new(
      shape_id: "example.weather#CityCoordinates",
      type: Types::CityCoordinates,
    )
    CityId = StringShape.new(
      shape_id: "example.weather#CityId",
      traits: {"smithy.api#pattern"=>"^[A-Za-z0-9 ]+$"}
    )
    CitySummaries = ListShape.new(
      shape_id: "example.weather#CitySummaries",
    )
    CitySummary = StructureShape.new(
      shape_id: "example.weather#CitySummary",
      type: Types::CitySummary,
      traits: {"smithy.api#references"=>[{"resource"=>"example.weather#City"}]}
    )
    GetCityInput = StructureShape.new(
      shape_id: "example.weather#GetCityInput",
      type: Types::GetCityInput,
      traits: {"smithy.api#input"=>{}}
    )
    GetCityOutput = StructureShape.new(
      shape_id: "example.weather#GetCityOutput",
      type: Types::GetCityOutput,
      traits: {"smithy.api#output"=>{}}
    )
    GetCurrentTimeOutput = StructureShape.new(
      shape_id: "example.weather#GetCurrentTimeOutput",
      type: Types::GetCurrentTimeOutput,
      traits: {"smithy.api#output"=>{}}
    )
    GetForecastInput = StructureShape.new(
      shape_id: "example.weather#GetForecastInput",
      type: Types::GetForecastInput,
      traits: {"smithy.api#input"=>{}}
    )
    GetForecastOutput = StructureShape.new(
      shape_id: "example.weather#GetForecastOutput",
      type: Types::GetForecastOutput,
      traits: {"smithy.api#output"=>{}}
    )
    ListCitiesInput = StructureShape.new(
      shape_id: "example.weather#ListCitiesInput",
      type: Types::ListCitiesInput,
      traits: {"smithy.api#input"=>{}}
    )
    ListCitiesOutput = StructureShape.new(
      shape_id: "example.weather#ListCitiesOutput",
      type: Types::ListCitiesOutput,
      traits: {"smithy.api#output"=>{}}
    )
    NoSuchResource = StructureShape.new(
      shape_id: "example.weather#NoSuchResource",
      type: Types::NoSuchResource,
      traits: {"smithy.api#error"=>"client"}
    )

    CityCoordinates.add_member(
      "latitude",
      PreludeShapes::Float,
      traits: {"smithy.api#required"=>{}}
    )
    CityCoordinates.add_member(
      "longitude",
      PreludeShapes::Float,
      traits: {"smithy.api#required"=>{}}
    )
    CitySummary.add_member(
      "city_id",
      CityId,
      traits: {"smithy.api#required"=>{}}
    )
    CitySummary.add_member(
      "name",
      PreludeShapes::String,
      traits: {"smithy.api#required"=>{}}
    )
    GetCityInput.add_member(
      "city_id",
      CityId,
      traits: {"smithy.api#required"=>{}}
    )
    GetCityOutput.add_member(
      "name",
      PreludeShapes::String,
      traits: {"smithy.api#notProperty"=>{}, "smithy.api#required"=>{}}
    )
    GetCityOutput.add_member(
      "coordinates",
      CityCoordinates,
      traits: {"smithy.api#required"=>{}}
    )
    GetCurrentTimeOutput.add_member(
      "time",
      PreludeShapes::Timestamp,
      traits: {"smithy.api#required"=>{}}
    )
    GetForecastInput.add_member(
      "city_id",
      CityId,
      traits: {"smithy.api#required"=>{}}
    )
    GetForecastOutput.add_member(
      "chance_of_rain",
      PreludeShapes::Float,
    )
    ListCitiesInput.add_member(
      "next_token",
      PreludeShapes::String,
    )
    ListCitiesInput.add_member(
      "page_size",
      PreludeShapes::Integer,
    )
    ListCitiesOutput.add_member(
      "next_token",
      PreludeShapes::String,
    )
    ListCitiesOutput.add_member(
      "items",
      CitySummaries,
      traits: {"smithy.api#required"=>{}}
    )
    NoSuchResource.add_member(
      "resource_type",
      PreludeShapes::String,
      traits: {"smithy.api#required"=>{}}
    )

    GetCity = OperationShape.new(
      shape_id: "example.weather#GetCity",
      input: GetCityInput,
      output: GetCityOutput,
      errors: [
        NoSuchResource
      ],
    )
    GetCurrentTime = OperationShape.new(
      shape_id: "example.weather#GetCurrentTime",
      input: PreludeShapes::Unit,
      output: GetCurrentTimeOutput,
    )
    GetForecast = OperationShape.new(
      shape_id: "example.weather#GetForecast",
      input: GetForecastInput,
      output: GetForecastOutput,
    )
    ListCities = OperationShape.new(
      shape_id: "example.weather#ListCities",
      input: ListCitiesInput,
      output: ListCitiesOutput,
    )

    WEATHER = ServiceShape.new(
      shape_id: "example.weather#Weather",
      version: "2006-03-01",
    ).tap do | service |
      service.add_operation("example.weather#GetCity", GetCity)
      service.add_operation("example.weather#GetCurrentTime", GetCurrentTime)
      service.add_operation("example.weather#GetForecast", GetForecast)
      service.add_operation("example.weather#ListCities", ListCities)
    end
  end
end
