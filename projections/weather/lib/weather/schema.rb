# frozen_string_literal: true

# This is generated code!

module Weather
  # This module contains a schema composed of shapes used by the client.
  module Schema

    CityCoordinates = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#CityCoordinates')
    CityId = Smithy::Schema::Shapes::StringShape.new(id: 'example.weather#CityId', traits: {"smithy.api#pattern" => "^[A-Za-z0-9 ]+$"})
    CitySummaries = Smithy::Schema::Shapes::ListShape.new(id: 'example.weather#CitySummaries')
    CitySummary = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#CitySummary', traits: {"smithy.api#references" => [{"resource" => "example.weather#City"}]})
    GetCityInput = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#GetCityInput', traits: {"smithy.api#input" => {}})
    GetCityOutput = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#GetCityOutput', traits: {"smithy.api#output" => {}})
    GetCurrentTimeOutput = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#GetCurrentTimeOutput', traits: {"smithy.api#output" => {}})
    GetForecastInput = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#GetForecastInput', traits: {"smithy.api#input" => {}})
    GetForecastOutput = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#GetForecastOutput', traits: {"smithy.api#output" => {}})
    ListCitiesInput = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#ListCitiesInput', traits: {"smithy.api#input" => {}})
    ListCitiesOutput = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#ListCitiesOutput', traits: {"smithy.api#output" => {}})
    NoSuchResource = Smithy::Schema::Shapes::StructureShape.new(id: 'example.weather#NoSuchResource', traits: {"smithy.api#error" => "client"})

    CityCoordinates.add_member(:latitude, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::Float, member_name: 'latitude', required: true))
    CityCoordinates.add_member(:longitude, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::Float, member_name: 'longitude', required: true))
    CityCoordinates.type = Types::CityCoordinates
    CitySummaries.member = Smithy::Schema::Shapes::ShapeRef.new(shape: CitySummary)
    CitySummary.add_member(:city_id, Smithy::Schema::Shapes::ShapeRef.new(shape: CityId, member_name: 'cityId', required: true))
    CitySummary.add_member(:name, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::String, member_name: 'name', required: true))
    CitySummary.type = Types::CitySummary
    GetCityInput.add_member(:city_id, Smithy::Schema::Shapes::ShapeRef.new(shape: CityId, member_name: 'cityId', required: true))
    GetCityInput.type = Types::GetCityInput
    GetCityOutput.add_member(:name, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::String, member_name: 'name', required: true, traits: {"smithy.api#notProperty" => {}}))
    GetCityOutput.add_member(:coordinates, Smithy::Schema::Shapes::ShapeRef.new(shape: CityCoordinates, member_name: 'coordinates', required: true))
    GetCityOutput.type = Types::GetCityOutput
    GetCurrentTimeOutput.add_member(:time, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::Timestamp, member_name: 'time', required: true))
    GetCurrentTimeOutput.type = Types::GetCurrentTimeOutput
    GetForecastInput.add_member(:city_id, Smithy::Schema::Shapes::ShapeRef.new(shape: CityId, member_name: 'cityId', required: true))
    GetForecastInput.type = Types::GetForecastInput
    GetForecastOutput.add_member(:chance_of_rain, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::Float, member_name: 'chanceOfRain'))
    GetForecastOutput.type = Types::GetForecastOutput
    ListCitiesInput.add_member(:next_token, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::String, member_name: 'nextToken'))
    ListCitiesInput.add_member(:page_size, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::Integer, member_name: 'pageSize'))
    ListCitiesInput.type = Types::ListCitiesInput
    ListCitiesOutput.add_member(:next_token, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::String, member_name: 'nextToken'))
    ListCitiesOutput.add_member(:items, Smithy::Schema::Shapes::ShapeRef.new(shape: CitySummaries, member_name: 'items', required: true))
    ListCitiesOutput.type = Types::ListCitiesOutput
    NoSuchResource.add_member(:resource_type, Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::String, member_name: 'resourceType', required: true))
    NoSuchResource.type = Types::NoSuchResource

    Weather = Smithy::Schema::Shapes::ServiceShape.new do |service|
      service.id = "example.weather#Weather"
      service.name = "Weather"
      service.version = "2006-03-01"
      service.traits = {}
      service.add_operation(:get_city, Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#GetCity"
        operation.name = "GetCity"
        operation.input = Smithy::Schema::Shapes::ShapeRef.new(shape: GetCityInput)
        operation.output = Smithy::Schema::Shapes::ShapeRef.new(shape: GetCityOutput)
        operation.errors << Smithy::Schema::Shapes::ShapeRef.new(shape: NoSuchResource)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_current_time, Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#GetCurrentTime"
        operation.name = "GetCurrentTime"
        operation.input = Smithy::Schema::Shapes::ShapeRef.new(shape: Smithy::Schema::Shapes::Prelude::Unit)
        operation.output = Smithy::Schema::Shapes::ShapeRef.new(shape: GetCurrentTimeOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_forecast, Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#GetForecast"
        operation.name = "GetForecast"
        operation.input = Smithy::Schema::Shapes::ShapeRef.new(shape: GetForecastInput)
        operation.output = Smithy::Schema::Shapes::ShapeRef.new(shape: GetForecastOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:list_cities, Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#ListCities"
        operation.name = "ListCities"
        operation.input = Smithy::Schema::Shapes::ShapeRef.new(shape: ListCitiesInput)
        operation.output = Smithy::Schema::Shapes::ShapeRef.new(shape: ListCitiesOutput)
        operation.traits = {"smithy.api#readonly" => {}}
        operation[:paginator] = Paginators::ListCities.new
      end)

    end

    class << self
      def type_registry
        return @type_registry if @type_registry

        shapes = constants.map { |sym| const_get(sym) }.select { |const| const.is_a?(Smithy::Schema::Shapes::StructureShape) }
        @type_registry = Smithy::Schema::TypeRegistry.new(shapes)
      end
    end
  end
end
