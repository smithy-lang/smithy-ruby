# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  # An API client for Weather
  # See {#initialize} for a full list of supported configuration options
  # Provides weather forecasts.
  #
  class Client
    include Hearth::ClientStubs

    @middleware = Hearth::MiddlewareBuilder.new

    def self.middleware
      @middleware
    end

    # @overload initialize(options)
    # @param [Hash] options
    # @option options [Boolean] :adaptive_retry_wait_to_fill (true)
    #   Used only in `adaptive` retry mode. When true, the request will sleep until there is sufficient client side capacity to retry the request. When false, the request will raise a `CapacityNotAvailableError` and will not retry instead of sleeping.
    #
    # @option options [Boolean] :disable_host_prefix (false)
    #   When `true`, does not perform host prefix injection using @endpoint's hostPrefix property.
    #
    # @option options [string] :endpoint
    #   Endpoint of the service
    #
    # @option options [bool] :http_wire_trace (false)
    #   Enable debug wire trace on http requests.
    #
    # @option options [symbol] :log_level (:info)
    #   Default log level to use
    #
    # @option options [Logger] :logger (stdout)
    #   Logger to use for output
    #
    # @option options [Integer] :max_attempts (3)
    #   An integer representing the maximum number of attempts that will be made for a single request, including the initial attempt.
    #
    # @option options [MiddlewareBuilder] :middleware
    #   Additional Middleware to be applied for every operation
    #
    # @option options [String] :retry_mode ('standard')
    #   Specifies which retry algorithm to use. Values are:
    #  * `standard` - A standardized set of retry rules across the AWS SDKs. This includes support for retry quotas, which limit the number of unsuccessful retries a client can make.
    #  * `adaptive` - An experimental retry mode that includes all the functionality of `standard` mode along with automatic client side throttling.  This is a provisional mode that may change behavior in the future.
    #
    # @option options [Boolean] :stub_responses (false)
    #   Enable response stubbing. See documentation for {#stub_responses}
    #
    # @option options [Boolean] :validate_input (true)
    #   When `true`, request parameters are validated using the modeled shapes.
    #
    def initialize(options = {})
      @adaptive_retry_wait_to_fill = options.fetch(:adaptive_retry_wait_to_fill, true)
      @client_rate_limiter = Hearth::Retry::ClientRateLimiter.new
      @disable_host_prefix = options.fetch(:disable_host_prefix, false)
      @endpoint = options.fetch(:endpoint, options[:stub_responses] ? 'http://localhost' : nil)
      @http_wire_trace = options.fetch(:http_wire_trace, false)
      @log_level = options.fetch(:log_level, :info)
      @logger = options.fetch(:logger, Logger.new($stdout, level: @log_level))
      @max_attempts = options.fetch(:max_attempts, 3)
      @middleware = Hearth::MiddlewareBuilder.new(options[:middleware])
      @retry_mode = options.fetch(:retry_mode, 'standard')
      @retry_quota = Hearth::Retry::RetryQuota.new
      @stub_responses = options.fetch(:stub_responses, false)
      @stubs = Hearth::Stubbing::Stubs.new
      @validate_input = options.fetch(:validate_input, true)

    end

    # @param [Hash] params
    #   See {Types::GetCityInput}.
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
      stack = Hearth::MiddlewareStack.new
      input = Params::GetCityInput.build(params)
      response_body = StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetCityInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetCity
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: options.fetch(:retry_mode, @retry_mode),
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: options.fetch(:retry_quota, @retry_quota),
        max_attempts: options.fetch(:max_attempts, @max_attempts),
        client_rate_limiter: options.fetch(:client_rate_limiter, @client_rate_limiter),
        adaptive_retry_wait_to_fill: options.fetch(:adaptive_retry_wait_to_fill, @adaptive_retry_wait_to_fill)
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: [Errors::NoSuchResource]),
        data_parser: Parsers::GetCity
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::GetCity,
        params_class: Params::GetCityOutput,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @logger,
          operation_name: :get_city
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::GetCityImageInput}.
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
    #     } # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::GetCityImageOutput
    #   resp.data.image #=> String
    #
    def get_city_image(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetCityImageInput.build(params)
      response_body = output_stream(options, &block)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetCityImageInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetCityImage
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: options.fetch(:retry_mode, @retry_mode),
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: options.fetch(:retry_quota, @retry_quota),
        max_attempts: options.fetch(:max_attempts, @max_attempts),
        client_rate_limiter: options.fetch(:client_rate_limiter, @client_rate_limiter),
        adaptive_retry_wait_to_fill: options.fetch(:adaptive_retry_wait_to_fill, @adaptive_retry_wait_to_fill)
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: [Errors::NoSuchResource]),
        data_parser: Parsers::GetCityImage
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::GetCityImage,
        params_class: Params::GetCityImageOutput,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @logger,
          operation_name: :get_city_image
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::GetCurrentTimeInput}.
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
      stack = Hearth::MiddlewareStack.new
      input = Params::GetCurrentTimeInput.build(params)
      response_body = StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetCurrentTimeInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetCurrentTime
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: options.fetch(:retry_mode, @retry_mode),
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: options.fetch(:retry_quota, @retry_quota),
        max_attempts: options.fetch(:max_attempts, @max_attempts),
        client_rate_limiter: options.fetch(:client_rate_limiter, @client_rate_limiter),
        adaptive_retry_wait_to_fill: options.fetch(:adaptive_retry_wait_to_fill, @adaptive_retry_wait_to_fill)
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::GetCurrentTime
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::GetCurrentTime,
        params_class: Params::GetCurrentTimeOutput,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @logger,
          operation_name: :get_current_time
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::GetForecastInput}.
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
    #   resp.data.precipitation #=> Precipitation
    #
    def get_forecast(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetForecastInput.build(params)
      response_body = StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetForecastInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetForecast
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: options.fetch(:retry_mode, @retry_mode),
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: options.fetch(:retry_quota, @retry_quota),
        max_attempts: options.fetch(:max_attempts, @max_attempts),
        client_rate_limiter: options.fetch(:client_rate_limiter, @client_rate_limiter),
        adaptive_retry_wait_to_fill: options.fetch(:adaptive_retry_wait_to_fill, @adaptive_retry_wait_to_fill)
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::GetForecast
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::GetForecast,
        params_class: Params::GetForecastOutput,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @logger,
          operation_name: :get_forecast
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::ListCitiesInput}.
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
      stack = Hearth::MiddlewareStack.new
      input = Params::ListCitiesInput.build(params)
      response_body = StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ListCitiesInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ListCities
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: options.fetch(:retry_mode, @retry_mode),
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: options.fetch(:retry_quota, @retry_quota),
        max_attempts: options.fetch(:max_attempts, @max_attempts),
        client_rate_limiter: options.fetch(:client_rate_limiter, @client_rate_limiter),
        adaptive_retry_wait_to_fill: options.fetch(:adaptive_retry_wait_to_fill, @adaptive_retry_wait_to_fill)
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::ListCities
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::ListCities,
        params_class: Params::ListCitiesOutput,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @logger,
          operation_name: :list_cities
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   See {Types::Struct____789BadNameInput}.
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
      stack = Hearth::MiddlewareStack.new
      input = Params::Struct____789BadNameInput.build(params)
      response_body = StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::Struct____789BadNameInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::Operation____789BadName
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: options.fetch(:retry_mode, @retry_mode),
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: options.fetch(:retry_quota, @retry_quota),
        max_attempts: options.fetch(:max_attempts, @max_attempts),
        client_rate_limiter: options.fetch(:client_rate_limiter, @client_rate_limiter),
        adaptive_retry_wait_to_fill: options.fetch(:adaptive_retry_wait_to_fill, @adaptive_retry_wait_to_fill)
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: [Errors::NoSuchResource]),
        data_parser: Parsers::Operation____789BadName
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::Operation____789BadName,
        params_class: Params::Struct____789BadNameOutput,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @logger,
          operation_name: :operation____789_bad_name
        )
      )
      raise resp.error if resp.error
      resp
    end

    private

    def apply_middleware(middleware_stack, middleware)
      Client.middleware.apply(middleware_stack)
      @middleware.apply(middleware_stack)
      Hearth::MiddlewareBuilder.new(middleware).apply(middleware_stack)
    end

    def output_stream(options = {}, &block)
      return options[:output_stream] if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      StringIO.new
    end
  end
end
