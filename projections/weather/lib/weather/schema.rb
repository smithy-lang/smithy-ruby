# frozen_string_literal: true

# This is generated code!

module Weather
  # This module contains a schema composed of shapes used by the client.
  module Schema

    CityCoordinates = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#CityCoordinates", name: "CityCoordinates")
    CityId = ::Smithy::Schema::Shapes::StringShape.new(id: "example.weather#CityId", name: "CityId", traits: {"smithy.api#pattern" => "^[A-Za-z0-9 ]+$"})
    CitySummaries = ::Smithy::Schema::Shapes::ListShape.new(id: "example.weather#CitySummaries", name: "CitySummaries")
    CitySummary = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#CitySummary", name: "CitySummary", traits: {"smithy.api#references" => [{"resource" => "example.weather#City"}]})
    GetCityInput = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#GetCityInput", name: "GetCityInput")
    GetCityOutput = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#GetCityOutput", name: "GetCityOutput")
    GetCurrentTimeOutput = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#GetCurrentTimeOutput", name: "GetCurrentTimeOutput")
    GetForecastInput = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#GetForecastInput", name: "GetForecastInput")
    GetForecastOutput = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#GetForecastOutput", name: "GetForecastOutput")
    ListCitiesInput = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#ListCitiesInput", name: "ListCitiesInput")
    ListCitiesOutput = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#ListCitiesOutput", name: "ListCitiesOutput")
    NoSuchResource = ::Smithy::Schema::Shapes::StructureShape.new(id: "example.weather#NoSuchResource", name: "NoSuchResource", traits: {"smithy.api#error" => "client"})

    CityCoordinates.add_member(:latitude, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Float, location_name: "latitude", traits: {"smithy.api#required" => {}}))
    CityCoordinates.add_member(:longitude, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Float, location_name: "longitude", traits: {"smithy.api#required" => {}}))
    CityCoordinates.type = Types::CityCoordinates
    CitySummaries.member = ::Smithy::Schema::Shapes::MemberShape.new(target: CitySummary)
    CitySummary.add_member(:city_id, ::Smithy::Schema::Shapes::MemberShape.new(target: CityId, location_name: "cityId", traits: {"smithy.api#required" => {}}))
    CitySummary.add_member(:name, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::String, location_name: "name", traits: {"smithy.api#required" => {}}))
    CitySummary.type = Types::CitySummary
    GetCityInput.add_member(:city_id, ::Smithy::Schema::Shapes::MemberShape.new(target: CityId, location_name: "cityId", traits: {"smithy.api#required" => {}}))
    GetCityInput.type = Types::GetCityInput
    GetCityOutput.add_member(:name, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::String, location_name: "name", traits: {"smithy.api#notProperty" => {}, "smithy.api#required" => {}}))
    GetCityOutput.add_member(:coordinates, ::Smithy::Schema::Shapes::MemberShape.new(target: CityCoordinates, location_name: "coordinates", traits: {"smithy.api#required" => {}}))
    GetCityOutput.type = Types::GetCityOutput
    GetCurrentTimeOutput.add_member(:time, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Timestamp, location_name: "time", traits: {"smithy.api#required" => {}}))
    GetCurrentTimeOutput.type = Types::GetCurrentTimeOutput
    GetForecastInput.add_member(:city_id, ::Smithy::Schema::Shapes::MemberShape.new(target: CityId, location_name: "cityId", traits: {"smithy.api#required" => {}}))
    GetForecastInput.type = Types::GetForecastInput
    GetForecastOutput.add_member(:chance_of_rain, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Float, location_name: "chanceOfRain"))
    GetForecastOutput.type = Types::GetForecastOutput
    ListCitiesInput.add_member(:next_token, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::String, location_name: "nextToken"))
    ListCitiesInput.add_member(:page_size, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Integer, location_name: "pageSize"))
    ListCitiesInput.type = Types::ListCitiesInput
    ListCitiesOutput.add_member(:next_token, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::String, location_name: "nextToken"))
    ListCitiesOutput.add_member(:items, ::Smithy::Schema::Shapes::MemberShape.new(target: CitySummaries, location_name: "items", traits: {"smithy.api#required" => {}}))
    ListCitiesOutput.type = Types::ListCitiesOutput
    NoSuchResource.add_member(:resource_type, ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::String, location_name: "resourceType", traits: {"smithy.api#required" => {}}))
    NoSuchResource.type = Types::NoSuchResource

    Weather = ::Smithy::Schema::Shapes::ServiceShape.new do |service|
      service.id = "example.weather#Weather"
      service.name = "Weather"
      service.version = "2006-03-01"
      service.traits = {}
      service.add_operation(:get_city, ::Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#GetCity"
        operation.name = "GetCity"
        operation.input = ::Smithy::Schema::Shapes::MemberShape.new(target: GetCityInput)
        operation.output = ::Smithy::Schema::Shapes::MemberShape.new(target: GetCityOutput)
        operation.errors << ::Smithy::Schema::Shapes::MemberShape.new(target: NoSuchResource)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_current_time, ::Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#GetCurrentTime"
        operation.name = "GetCurrentTime"
        operation.input = ::Smithy::Schema::Shapes::MemberShape.new(target: ::Smithy::Schema::Shapes::Prelude::Unit)
        operation.output = ::Smithy::Schema::Shapes::MemberShape.new(target: GetCurrentTimeOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:get_forecast, ::Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#GetForecast"
        operation.name = "GetForecast"
        operation.input = ::Smithy::Schema::Shapes::MemberShape.new(target: GetForecastInput)
        operation.output = ::Smithy::Schema::Shapes::MemberShape.new(target: GetForecastOutput)
        operation.traits = {"smithy.api#readonly" => {}}
      end)
      service.add_operation(:list_cities, ::Smithy::Schema::Shapes::OperationShape.new do |operation|
        operation.id = "example.weather#ListCities"
        operation.name = "ListCities"
        operation.input = ::Smithy::Schema::Shapes::MemberShape.new(target: ListCitiesInput)
        operation.output = ::Smithy::Schema::Shapes::MemberShape.new(target: ListCitiesOutput)
        operation.traits = {"smithy.api#readonly" => {}}
        operation[:paginator] = Paginators::ListCities.new
      end)
    end

    class << self
      def type_registry
        return @type_registry if @type_registry

        shapes = constants.map { |sym| const_get(sym) }.select { |const| const.is_a?(::Smithy::Schema::Shapes::StructureShape) }
        @type_registry = ::Smithy::Schema::TypeRegistry.new(shapes)
      end
    end
  end
end
