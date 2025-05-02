# frozen_string_literal: true

# This is generated code!

module Weather
  # This module contains a schema composed of shapes used by the client.
  module Schema
    include Smithy::Schema::Shapes

    CityCoordinates = StructureShape.new(id: 'example.weather#CityCoordinates')
    CityId = StringShape.new(id: 'example.weather#CityId', traits: {"smithy.api#pattern" => "^[A-Za-z0-9 ]+$"})
    CitySummaries = ListShape.new(id: 'example.weather#CitySummaries')
    CitySummary = StructureShape.new(id: 'example.weather#CitySummary', traits: {"smithy.api#references" => [{"resource" => "example.weather#City"}]})
    GetCityInput = StructureShape.new(id: 'example.weather#GetCityInput', traits: {"smithy.api#input" => {}})
    GetCityOutput = StructureShape.new(id: 'example.weather#GetCityOutput', traits: {"smithy.api#output" => {}})
    GetCurrentTimeOutput = StructureShape.new(id: 'example.weather#GetCurrentTimeOutput', traits: {"smithy.api#output" => {}})
    GetForecastInput = StructureShape.new(id: 'example.weather#GetForecastInput', traits: {"smithy.api#input" => {}})
    GetForecastOutput = StructureShape.new(id: 'example.weather#GetForecastOutput', traits: {"smithy.api#output" => {}})
    ListCitiesInput = StructureShape.new(id: 'example.weather#ListCitiesInput', traits: {"smithy.api#input" => {}})
    ListCitiesOutput = StructureShape.new(id: 'example.weather#ListCitiesOutput', traits: {"smithy.api#output" => {}})
    NoSuchResource = StructureShape.new(id: 'example.weather#NoSuchResource', traits: {"smithy.api#error" => "client"})

    CityCoordinates.add_member(:latitude, ShapeRef.new(target: Prelude::Float, location: 'latitude', traits: {"smithy.api#required" => {}}))
    CityCoordinates.add_member(:longitude, ShapeRef.new(target: Prelude::Float, location: 'longitude', traits: {"smithy.api#required" => {}}))
    CityCoordinates.type = Types::CityCoordinates
    CitySummaries.member = ShapeRef.new(target: CitySummary)
    CitySummary.add_member(:city_id, ShapeRef.new(target: CityId, location: 'cityId', traits: {"smithy.api#required" => {}}))
    CitySummary.add_member(:name, ShapeRef.new(target: Prelude::String, location: 'name', traits: {"smithy.api#required" => {}}))
    CitySummary.type = Types::CitySummary
    GetCityInput.add_member(:city_id, ShapeRef.new(target: CityId, location: 'cityId', traits: {"smithy.api#required" => {}}))
    GetCityInput.type = Types::GetCityInput
    GetCityOutput.add_member(:name, ShapeRef.new(target: Prelude::String, location: 'name', traits: {"smithy.api#notProperty" => {}, "smithy.api#required" => {}}))
    GetCityOutput.add_member(:coordinates, ShapeRef.new(target: CityCoordinates, location: 'coordinates', traits: {"smithy.api#required" => {}}))
    GetCityOutput.type = Types::GetCityOutput
    GetCurrentTimeOutput.add_member(:time, ShapeRef.new(target: Prelude::Timestamp, location: 'time', traits: {"smithy.api#required" => {}}))
    GetCurrentTimeOutput.type = Types::GetCurrentTimeOutput
    GetForecastInput.add_member(:city_id, ShapeRef.new(target: CityId, location: 'cityId', traits: {"smithy.api#required" => {}}))
    GetForecastInput.type = Types::GetForecastInput
    GetForecastOutput.add_member(:chance_of_rain, ShapeRef.new(target: Prelude::Float, location: 'chanceOfRain'))
    GetForecastOutput.type = Types::GetForecastOutput
    ListCitiesInput.add_member(:next_token, ShapeRef.new(target: Prelude::String, location: 'nextToken'))
    ListCitiesInput.add_member(:page_size, ShapeRef.new(target: Prelude::Integer, location: 'pageSize'))
    ListCitiesInput.type = Types::ListCitiesInput
    ListCitiesOutput.add_member(:next_token, ShapeRef.new(target: Prelude::String, location: 'nextToken'))
    ListCitiesOutput.add_member(:items, ShapeRef.new(target: CitySummaries, location: 'items', traits: {"smithy.api#required" => {}}))
    ListCitiesOutput.type = Types::ListCitiesOutput
    NoSuchResource.add_member(:resource_type, ShapeRef.new(target: Prelude::String, location: 'resourceType', traits: {"smithy.api#required" => {}}))
    NoSuchResource.type = Types::NoSuchResource

    SERVICE = ServiceShape.new do |service|
      service.id = "example.weather#Weather"
      service.name = "Weather"
      service.version = "2006-03-01"
      service.traits = {}
      service.add_operation(:get_city, OperationShape.new do |operation|
        operation.id = "example.weather#GetCity"
        operation.name = "GetCity"
        operation.input = ShapeRef.new(target: GetCityInput)
        operation.output = ShapeRef.new(target: GetCityOutput)
        operation.errors << ShapeRef.new(target: NoSuchResource)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_current_time, OperationShape.new do |operation|
        operation.id = "example.weather#GetCurrentTime"
        operation.name = "GetCurrentTime"
        operation.input = ShapeRef.new(target: Prelude::Unit)
        operation.output = ShapeRef.new(target: GetCurrentTimeOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_forecast, OperationShape.new do |operation|
        operation.id = "example.weather#GetForecast"
        operation.name = "GetForecast"
        operation.input = ShapeRef.new(target: GetForecastInput)
        operation.output = ShapeRef.new(target: GetForecastOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:list_cities, OperationShape.new do |operation|
        operation.id = "example.weather#ListCities"
        operation.name = "ListCities"
        operation.input = ShapeRef.new(target: ListCitiesInput)
        operation.output = ShapeRef.new(target: ListCitiesOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
    end
  end
end
