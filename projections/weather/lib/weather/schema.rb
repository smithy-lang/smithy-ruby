# frozen_string_literal: true

# This is generated code!

module Weather
  # This module contains a schema composed of shapes used by the client.
  module Schema
    include Smithy::Schema::Shapes

    CityCoordinates = StructureShape.new(id: 'example.weather#CityCoordinates')
    CityId = StringShape.new(id: 'example.weather#CityId', traits: {"smithy.api#pattern"=>"^[A-Za-z0-9 ]+$"})
    CitySummaries = ListShape.new(id: 'example.weather#CitySummaries')
    CitySummary = StructureShape.new(id: 'example.weather#CitySummary', traits: {"smithy.api#references"=>[{"resource"=>"example.weather#City"}]})
    GetCityInput = StructureShape.new(id: 'example.weather#GetCityInput', traits: {"smithy.api#input"=>{}})
    GetCityOutput = StructureShape.new(id: 'example.weather#GetCityOutput', traits: {"smithy.api#output"=>{}})
    GetCurrentTimeOutput = StructureShape.new(id: 'example.weather#GetCurrentTimeOutput', traits: {"smithy.api#output"=>{}})
    GetForecastInput = StructureShape.new(id: 'example.weather#GetForecastInput', traits: {"smithy.api#input"=>{}})
    GetForecastOutput = StructureShape.new(id: 'example.weather#GetForecastOutput', traits: {"smithy.api#output"=>{}})
    ListCitiesInput = StructureShape.new(id: 'example.weather#ListCitiesInput', traits: {"smithy.api#input"=>{}})
    ListCitiesOutput = StructureShape.new(id: 'example.weather#ListCitiesOutput', traits: {"smithy.api#output"=>{}})
    NoSuchResource = StructureShape.new(id: 'example.weather#NoSuchResource', traits: {"smithy.api#error"=>"client"})

    CityCoordinates.add_member(:latitude, 'latitude', Prelude::Float, traits: {"smithy.api#required"=>{}})
    CityCoordinates.add_member(:longitude, 'longitude', Prelude::Float, traits: {"smithy.api#required"=>{}})
    CityCoordinates.type = Types::CityCoordinates

    CitySummaries.set_member(CitySummary)

    CitySummary.add_member(:city_id, 'cityId', CityId, traits: {"smithy.api#required"=>{}})
    CitySummary.add_member(:name, 'name', Prelude::String, traits: {"smithy.api#required"=>{}})
    CitySummary.type = Types::CitySummary

    GetCityInput.add_member(:city_id, 'cityId', CityId, traits: {"smithy.api#required"=>{}})
    GetCityInput.type = Types::GetCityInput

    GetCityOutput.add_member(:name, 'name', Prelude::String, traits: {"smithy.api#notProperty"=>{}, "smithy.api#required"=>{}})
    GetCityOutput.add_member(:coordinates, 'coordinates', CityCoordinates, traits: {"smithy.api#required"=>{}})
    GetCityOutput.type = Types::GetCityOutput

    GetCurrentTimeOutput.add_member(:time, 'time', Prelude::Timestamp, traits: {"smithy.api#required"=>{}})
    GetCurrentTimeOutput.type = Types::GetCurrentTimeOutput

    GetForecastInput.add_member(:city_id, 'cityId', CityId, traits: {"smithy.api#required"=>{}})
    GetForecastInput.type = Types::GetForecastInput

    GetForecastOutput.add_member(:chance_of_rain, 'chanceOfRain', Prelude::Float)
    GetForecastOutput.add_member(:status_property, 'statusProperty', Prelude::String)
    GetForecastOutput.type = Types::GetForecastOutput

    ListCitiesInput.add_member(:next_token, 'nextToken', Prelude::String)
    ListCitiesInput.add_member(:page_size, 'pageSize', Prelude::Integer)
    ListCitiesInput.type = Types::ListCitiesInput

    ListCitiesOutput.add_member(:next_token, 'nextToken', Prelude::String)
    ListCitiesOutput.add_member(:items, 'items', CitySummaries, traits: {"smithy.api#required"=>{}})
    ListCitiesOutput.type = Types::ListCitiesOutput

    NoSuchResource.add_member(:resource_type, 'resourceType', Prelude::String, traits: {"smithy.api#required"=>{}})
    NoSuchResource.type = Types::NoSuchResource

    SERVICE = ServiceShape.new do |service|
      service.id = "example.weather#Weather"
      service.name = "Weather"
      service.version = "2006-03-01"
      service.traits = {}
      service.add_operation(:get_city, OperationShape.new do |operation|
        operation.id = "example.weather#GetCity"
        operation.name = "GetCity"
        operation.input = GetCityInput
        operation.output = GetCityOutput
        operation.traits = {"smithy.api#readonly"=>{}, "smithy.waiters#waitable"=>{"CityExists"=>{"documentation"=>"Waits until city exists", "acceptors"=>[{"state"=>"success", "matcher"=>{"success"=>true}}]}, "CityDeleted"=>{"documentation"=>"Waits until city is deleted", "acceptors"=>[{"state"=>"success", "matcher"=>{"errorType"=>"NoSuchResource"}}]}}}
        operation.errors << NoSuchResource
      end)
      service.add_operation(:get_current_time, OperationShape.new do |operation|
        operation.id = "example.weather#GetCurrentTime"
        operation.name = "GetCurrentTime"
        operation.input = Prelude::Unit
        operation.output = GetCurrentTimeOutput
        operation.traits = {"smithy.api#readonly"=>{}}
      end)
      service.add_operation(:get_forecast, OperationShape.new do |operation|
        operation.id = "example.weather#GetForecast"
        operation.name = "GetForecast"
        operation.input = GetForecastInput
        operation.output = GetForecastOutput
        operation.traits = {"smithy.api#readonly"=>{}, "smithy.waiters#waitable"=>{"ForecastExists"=>{"documentation"=>"Waits until forecast is created", "acceptors"=>[{"state"=>"failure", "matcher"=>{"output"=>{"path"=>"statusProperty", "comparator"=>"stringEquals", "expected"=>"failed"}}}, {"state"=>"success", "matcher"=>{"output"=>{"path"=>"statusProperty", "comparator"=>"stringEquals", "expected"=>"success"}}}], "minDelay"=>5, "maxDelay"=>20, "deprecated"=>true}}}
      end)
      service.add_operation(:list_cities, OperationShape.new do |operation|
        operation.id = "example.weather#ListCities"
        operation.name = "ListCities"
        operation.input = ListCitiesInput
        operation.output = ListCitiesOutput
        operation.traits = {"smithy.api#readonly"=>{}}
        operation[:paginator] = Paginators::ListCities.new
      end)
    end
  end
end
