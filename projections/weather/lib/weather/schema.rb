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

    CityCoordinates.add_member(:latitude, ShapeRef.new(shape: Prelude::Float, member_name: 'latitude', traits: {"smithy.api#required" => {}}))
    CityCoordinates.add_member(:longitude, ShapeRef.new(shape: Prelude::Float, member_name: 'longitude', traits: {"smithy.api#required" => {}}))
    CityCoordinates.type = Types::CityCoordinates
    CitySummaries.member = ShapeRef.new(shape: CitySummary)
    CitySummary.add_member(:city_id, ShapeRef.new(shape: CityId, member_name: 'cityId', traits: {"smithy.api#required" => {}}))
    CitySummary.add_member(:name, ShapeRef.new(shape: Prelude::String, member_name: 'name', traits: {"smithy.api#required" => {}}))
    CitySummary.type = Types::CitySummary
    GetCityInput.add_member(:city_id, ShapeRef.new(shape: CityId, member_name: 'cityId', traits: {"smithy.api#required" => {}}))
    GetCityInput.type = Types::GetCityInput
    GetCityOutput.add_member(:name, ShapeRef.new(shape: Prelude::String, member_name: 'name', traits: {"smithy.api#notProperty" => {}, "smithy.api#required" => {}}))
    GetCityOutput.add_member(:coordinates, ShapeRef.new(shape: CityCoordinates, member_name: 'coordinates', traits: {"smithy.api#required" => {}}))
    GetCityOutput.type = Types::GetCityOutput
    GetCurrentTimeOutput.add_member(:time, ShapeRef.new(shape: Prelude::Timestamp, member_name: 'time', traits: {"smithy.api#required" => {}}))
    GetCurrentTimeOutput.type = Types::GetCurrentTimeOutput
    GetForecastInput.add_member(:city_id, ShapeRef.new(shape: CityId, member_name: 'cityId', traits: {"smithy.api#required" => {}}))
    GetForecastInput.type = Types::GetForecastInput
    GetForecastOutput.add_member(:chance_of_rain, ShapeRef.new(shape: Prelude::Float, member_name: 'chanceOfRain'))
    GetForecastOutput.type = Types::GetForecastOutput
    ListCitiesInput.add_member(:next_token, ShapeRef.new(shape: Prelude::String, member_name: 'nextToken'))
    ListCitiesInput.add_member(:page_size, ShapeRef.new(shape: Prelude::Integer, member_name: 'pageSize'))
    ListCitiesInput.type = Types::ListCitiesInput
    ListCitiesOutput.add_member(:next_token, ShapeRef.new(shape: Prelude::String, member_name: 'nextToken'))
    ListCitiesOutput.add_member(:items, ShapeRef.new(shape: CitySummaries, member_name: 'items', traits: {"smithy.api#required" => {}}))
    ListCitiesOutput.type = Types::ListCitiesOutput
    NoSuchResource.add_member(:resource_type, ShapeRef.new(shape: Prelude::String, member_name: 'resourceType', traits: {"smithy.api#required" => {}}))
    NoSuchResource.type = Types::NoSuchResource

    Weather = ServiceShape.new do |service|
      service.id = "example.weather#Weather"
      service.name = "Weather"
      service.version = "2006-03-01"
      service.traits = {}
      service.add_operation(:get_city, OperationShape.new do |operation|
        operation.id = "example.weather#GetCity"
        operation.name = "GetCity"
        operation.input = ShapeRef.new(shape: GetCityInput)
        operation.output = ShapeRef.new(shape: GetCityOutput)
        operation.errors << ShapeRef.new(shape: NoSuchResource)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_current_time, OperationShape.new do |operation|
        operation.id = "example.weather#GetCurrentTime"
        operation.name = "GetCurrentTime"
        operation.input = ShapeRef.new(shape: Prelude::Unit)
        operation.output = ShapeRef.new(shape: GetCurrentTimeOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_forecast, OperationShape.new do |operation|
        operation.id = "example.weather#GetForecast"
        operation.name = "GetForecast"
        operation.input = ShapeRef.new(shape: GetForecastInput)
        operation.output = ShapeRef.new(shape: GetForecastOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:list_cities, OperationShape.new do |operation|
        operation.id = "example.weather#ListCities"
        operation.name = "ListCities"
        operation.input = ShapeRef.new(shape: ListCitiesInput)
        operation.output = ShapeRef.new(shape: ListCitiesOutput)
        operation.traits = {"smithy.api#readonly" => {}}
        operation[:paginator] = Paginators::ListCities.new
      end)
    end

    class << self
      def type_registry
        Smithy::Schema::TypeRegistry.new([CityCoordinates, CitySummary, GetCityInput, GetCityOutput, GetCurrentTimeOutput, GetForecastInput, GetForecastOutput, ListCitiesInput, ListCitiesOutput, NoSuchResource])
      end
    end
  end
end
