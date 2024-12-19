# frozen_string_literal: true

# This is generated code!

module Weather
  class Client < Smithy::Client::Base
    self.service_shape = Shapes::WEATHER

    add_plugin(Smithy::Client::Plugins::NetHTTP)


    # TODO
    def initialize(*args)
      super(*args)
    end

    # TODO!
    def get_city(params = {}, options = {})
      input = build_input(:get_city, "example.weather#GetCity", params)
      input.send_request(options)
    end

    # TODO!
    def get_current_time(params = {}, options = {})
      input = build_input(:get_current_time, "example.weather#GetCurrentTime", params)
      input.send_request(options)
    end

    # TODO!
    def get_forecast(params = {}, options = {})
      input = build_input(:get_forecast, "example.weather#GetForecast", params)
      input.send_request(options)
    end

    # TODO!
    def list_cities(params = {}, options = {})
      input = build_input(:list_cities, "example.weather#ListCities", params)
      input.send_request(options)
    end

    private

    def build_input(operation_name, operation_id, params)
      handlers = @handlers.for(operation_name)
      context = Smithy::Client::HandlerContext.new(
        operation_name: operation_name,
        operation: config.service_shape.operation(operation_id),
        client: self,
        params: params,
        config: config
      )
      context[:gem_name] = 'weather'
      context[:gem_version] = '1.0.0'
      Smithy::Client::Input.new(handlers, context)
    end
  end
end
