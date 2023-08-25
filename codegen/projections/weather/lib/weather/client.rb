# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

module Weather
  # An API client for Weather
  # See {#initialize} for a full list of supported configuration options
  # Provides weather forecasts.
  #
  class Client
    include Hearth::ClientStubs
    @plugins = Hearth::PluginList.new

    def self.plugins
      @plugins
    end

    # @param [Config] config
    #   An instance of {Config}
    #
    def initialize(config = Weather::Config.new, options = {})
      @config = initialize_config(config)
      @stubs = Hearth::Stubs.new
    end

    # @return [Config] config
    attr_reader :config

    # @param [Hash] params
    #   Request parameters for this operation. See {Types::GetCityInput#initialize} for available parameters.
    #
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    #
    # @return [Types::GetCityOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.get_city(
    #     city_id: 'cityId' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::GetCityOutput
    #   resp.data.name #=> String
    #   resp.data.coordinates #=> Types::CityCoordinates
    #   resp.data.coordinates.latitude #=> Float
    #   resp.data.coordinates.longitude #=> Float
    #   resp.data.city #=> Types::CitySummary
    #   resp.data.city.city_id #=> String
    #   resp.data.city.name #=> String
    #   resp.data.city.number #=> String
    #   resp.data.city.case #=> String
    #
    def get_city(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetCityInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetCityInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetCity
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :get_city)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: [Errors::NoSuchResource]
        ),
        data_parser: Parsers::GetCity
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [Stubs::NoSuchResource],
        stub_data_class: Stubs::GetCity,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :get_city,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation. See {Types::GetCityImageInput#initialize} for available parameters.
    #
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    #
    # @return [Types::GetCityImageOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.get_city_image(
    #     city_id: 'cityId', # required
    #     image_type: {
    #       # One of:
    #       raw: false,
    #       png: {
    #         height: 1, # required
    #         width: 1 # required
    #       }
    #     }, # required
    #     resolution: 1 # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::GetCityImageOutput
    #   resp.data.image #=> String
    #
    def get_city_image(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetCityImageInput.build(params, context: 'params')
      response_body = output_stream(options, &block)
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetCityImageInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetCityImage
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :get_city_image)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: [Errors::NoSuchResource]
        ),
        data_parser: Parsers::GetCityImage
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [Stubs::NoSuchResource],
        stub_data_class: Stubs::GetCityImage,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :get_city_image,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation. See {Types::GetCurrentTimeInput#initialize} for available parameters.
    #
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    #
    # @return [Types::GetCurrentTimeOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.get_current_time()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::GetCurrentTimeOutput
    #   resp.data.time #=> Time
    #
    def get_current_time(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetCurrentTimeInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetCurrentTimeInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetCurrentTime
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :get_current_time)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::GetCurrentTime
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::GetCurrentTime,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :get_current_time,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation. See {Types::GetForecastInput#initialize} for available parameters.
    #
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    #
    # @return [Types::GetForecastOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.get_forecast(
    #     city_id: 'cityId' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::GetForecastOutput
    #   resp.data.chance_of_rain #=> Float
    #   resp.data.precipitation #=> Types::Precipitation, one of [Rain, Sleet, Hail, Snow, Mixed, Other, Blob, Foo, Baz]
    #   resp.data.precipitation.rain #=> Boolean
    #   resp.data.precipitation.sleet #=> Boolean
    #   resp.data.precipitation.hail #=> Hash<String, String>
    #   resp.data.precipitation.hail['key'] #=> String
    #   resp.data.precipitation.snow #=> String, one of ["YES", "NO"]
    #   resp.data.precipitation.mixed #=> String, one of ["YES", "NO"]
    #   resp.data.precipitation.other #=> Types::OtherStructure
    #   resp.data.precipitation.blob #=> String
    #   resp.data.precipitation.foo #=> Types::Foo
    #   resp.data.precipitation.foo.baz #=> String
    #   resp.data.precipitation.foo.bar #=> String
    #   resp.data.precipitation.baz #=> Types::Baz
    #   resp.data.precipitation.baz.baz #=> String
    #   resp.data.precipitation.baz.bar #=> String
    #
    def get_forecast(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetForecastInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetForecastInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetForecast
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :get_forecast)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::GetForecast
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::GetForecast,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :get_forecast,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation. See {Types::ListCitiesInput#initialize} for available parameters.
    #
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    #
    # @return [Types::ListCitiesOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.list_cities(
    #     next_token: 'nextToken',
    #     a_string: 'aString',
    #     default_bool: false,
    #     boxed_bool: false,
    #     default_number: 1,
    #     boxed_number: 1,
    #     some_enum: 'YES', # accepts ["YES", "NO"]
    #     page_size: 1
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::ListCitiesOutput
    #   resp.data.next_token #=> String
    #   resp.data.some_enum #=> String, one of ["YES", "NO"]
    #   resp.data.a_string #=> String
    #   resp.data.default_bool #=> Boolean
    #   resp.data.boxed_bool #=> Boolean
    #   resp.data.default_number #=> Integer
    #   resp.data.boxed_number #=> Integer
    #   resp.data.items #=> Array<CitySummary>
    #   resp.data.items[0] #=> Types::CitySummary
    #   resp.data.items[0].city_id #=> String
    #   resp.data.items[0].name #=> String
    #   resp.data.items[0].number #=> String
    #   resp.data.items[0].case #=> String
    #   resp.data.sparse_items #=> Array<CitySummary>
    #
    def list_cities(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::ListCitiesInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ListCitiesInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ListCities
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :list_cities)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::ListCities
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::ListCities,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :list_cities,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation. See {Types::Struct____789BadNameInput#initialize} for available parameters.
    #
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    #
    # @return [Types::Struct____789BadNameOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.operation____789_bad_name(
    #     member___123abc: '__123abc', # required
    #     member: {
    #       member___123foo: '__123foo'
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::Struct____789BadNameOutput
    #   resp.data.member___123abc #=> String
    #   resp.data.member #=> Types::Struct____456efg
    #   resp.data.member.member___123foo #=> String
    #
    def operation____789_bad_name(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::Struct____789BadNameInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::Struct____789BadNameInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::Operation____789BadName
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :operation____789_bad_name)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: [Errors::NoSuchResource]
        ),
        data_parser: Parsers::Operation____789BadName
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [Stubs::NoSuchResource],
        stub_data_class: Stubs::Operation____789BadName,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :operation____789_bad_name,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    private

    def initialize_config(config)
      config = config.dup
      client_interceptors = config.interceptors
      config.interceptors = Hearth::InterceptorList.new
      Client.plugins.apply(config)
      Hearth::PluginList.new(config.plugins).apply(config)
      config.interceptors << client_interceptors
      config.freeze
    end

    def operation_config(options)
      return @config unless options[:plugins] || options[:interceptors]

      config = @config.dup
      Hearth::PluginList.new(options[:plugins]).apply(config) if options[:plugins]
      config.interceptors << options[:interceptors] if options[:interceptors]
      config.freeze
    end

    def output_stream(options = {}, &block)
      return options[:output_stream] if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      ::StringIO.new
    end
  end
end
