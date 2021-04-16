module SampleService
  class Client
    include Seahorse::ClientStubs

    @middleware = Seahorse::MiddlewareBuilder.new

    # Allows you to register middleware handlers that invoke for
    # every request sent by every instance of {Client}. You can register
    # request, response and around handlers. For more information,
    # See {Seahorse::MiddlewareBuilder}.
    #
    # @example Register a handler which is invoked before
    #   sending each request.
    #
    #     SampleService::Client.middleware.before_send do |request, response, context|
    #       # request.endpoint
    #       # request.headers
    #       # request.body
    #     end
    #
    # @note Using this method to register middleware is global for
    #   all instances of {Client}. You should considering registering
    #   middleware directly on an instance of {Client} instead.
    #
    # @note It is not thread-safe to register middleware while
    #   requests are being made. **You must register middleware
    #   before you make concurrent requests.** Failure
    #   to do so may result in exceptions.
    #
    # @return [Seahorse::MiddlewareBuilder]
    def self.middleware
      @middleware
    end

    # @option options [String] :endpoint
    #   The HTTP url to send requests to. You should normally
    #   not configure the `:endpoint` directly except in testing
    #   scenarios. The `:endpoint` will be constructed from other
    #   options, including `:region`, `:secure`, `:dualstack`,
    #   and `:accelerate`.
    #
    # @option options [Integer] :max_attempts (4)
    #   The maximum number of attempts to make when sending a
    #   request. By default, networking and throttling errors are
    #   retried. No other errors returned from the service are
    #   retried.
    #
    # @option options [Integer] :max_delay (8)
    #   The maximum number of seconds to wait between attempts.
    #   Exponential backoff with jitter is applied between each
    #   attempt. The formula used is:
    #
    #       rand_between(0, min(max_delay, 2^num_of_attempts))
    #
    # @option options [Boolean] :raise_api_errors (true)
    #   When `true`, errors returned from the API in the HTTP
    #   response will be raised. When `false`, API errors can
    #   be accessed by calling `#error` on the response
    #   object returned.
    #
    # @option options [Boolean] :http_wire_trace (false) When `true`,
    #   HTTP debug output will be sent to the `:logger`.
    #
    # @option options [Boolean] :validate_params (true)
    #   When `true`, request parameters are validated before
    #   sending the request.
    #
    # @option options [Proc, Seahorse::MiddlewareBuilder] :middleware
    #   Middleware to apply to each request sent by this
    #   instance of {Client}.
    #
    # @option options [Boolean] :stub_responses (false)
    #   Causes the client to return stubbed responses. By default
    #   fake responses are generated and returned. You can specify
    #   the response data to return or errors to raise by calling
    #   {Seahorse::ClientStubs#stub_responses}.
    #
    # @option options [Symbol] :log_level (:info)
    #   The log level used to create a logger if none has been provided.
    #
    # @option options [Logger] :logger (Logger.new($stdout))
    #   The Logger instance to send log messages to. If this option
    #   is not set, a default Ruby Logger is used.
    #
    def initialize(options = {})
      @endpoint = options[:endpoint]
      @max_attempts = options.fetch(:max_attempts, 4)
      @max_delay = options.fetch(:max_delay, 8)
      @raise_api_errors = options.fetch(:raise_api_errors, true)
      @http_wire_trace = options.fetch(:http_wire_trace, false)
      @validate_params = options.fetch(:validate_params, true)
      @middleware = Seahorse::MiddlewareBuilder.new(options[:middleware])
      @stub_responses = options.fetch(:stub_responses, false)
      @stubs = Seahorse::Stubbing::Stubs.new
      @log_level = options.fetch(:log_level, :info)
      @logger = options.fetch(:logger, Logger.new($stdout, level: @log_level))
    end

    # Get a high score
    #
    # @option params [required, String] :id
    #   The high score id
    #
    # @return [Seahorse::Output] Returns an {Seahorse::Output output}
    #   object with {Types::GetHighScoreOutput} as the data.
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.get_high_score(
    #     id: 'id'
    #   )
    #
    def get_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      stack.use(
        Seahorse::Middleware::Validate,
        validator: Validators::GetHighScoreInput,
        params: params,
        validate_params: options.fetch(:validate_params, @validate_params)
      )
      stack.use(
        Seahorse::Middleware::Build,
        builder: Builders::GetHighScore,
        params: params
      )
      stack.use(
        Seahorse::HTTP::Middleware::ContentLength
      )
      stack.use(
        Seahorse::Middleware::Retry,
        max_delay: options.fetch(:max_delay, @max_delay),
        max_attempts: options.fetch(:max_attempts, @max_attempts)
      )
      stack.use(
        Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status_code: 200, errors: [],
          error_code_fn: Errors.method(:error_code)),
        data_parser: Parsers::GetHighScore
      )
      stack.use(
        Seahorse::Middleware::Sign,
        signer: @signer
      )
      stack.use(
        Seahorse::Middleware::Send,
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_responses: @stub_responses,
        stub_class: Stubs::GetHighScore,
        stubs: @stubs
      )
      apply_middleware(stack, options[:middleware])
      resp = stack.run(
        request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
        response: Seahorse::HTTP::Response.new(body: output_stream),
        context: {
          api_method: :get_high_score,
          api_name: 'GetHighScore',
          params: params,
          logger: @logger
        }
      )
      raise resp.error if resp.error && options.fetch(:raise_api_errors, @raise_api_errors)
      resp
    end

    # Create a new high score
    #
    # @option params [required, Hash, Types::HighScoreParams] :high_score
    #   The high score params
    #
    # @return [Seahorse::Output] Returns an {Seahorse::Output output}
    #   object with {Types::CreateHighScoreOutput} as the data.
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.create_high_score(
    #     high_score: {
    #       game: 'Game',
    #       score: 42
    #     }
    #   )
    #
    def create_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      stack.use(
        Seahorse::Middleware::Validate,
        validator: Validators::CreateHighScoreInput,
        params: params,
        validate_params: options.fetch(:validate_params, @validate_params)
      )
      stack.use(
        Seahorse::Middleware::Build,
        builder: Builders::CreateHighScore,
        params: params
      )
      stack.use(
        Seahorse::HTTP::Middleware::ContentLength
      )
      stack.use(
        Seahorse::Middleware::Retry,
        max_delay: options.fetch(:max_delay, @max_delay),
        max_attempts: options.fetch(:max_attempts, @max_attempts)
      )
      stack.use(
        Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status_code: 201, errors: [Errors::UnprocessableEntityError],
          error_code_fn: Errors.method(:error_code)),
        data_parser: Parsers::CreateHighScore
      )
      stack.use(
        Seahorse::Middleware::Sign,
        signer: @signer
      )
      stack.use(
        Seahorse::Middleware::Send,
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_responses: @stub_responses,
        stub_class: Stubs::CreateHighScore
      )
      apply_middleware(stack, options[:middleware])
      resp = stack.run(
        request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
        response: Seahorse::HTTP::Response.new(body: output_stream),
        context: {
          api_method: :create_high_score,
          api_name: 'CreateHighScore',
          params: params,
          logger: @logger
        }
      )
      raise resp.error if resp.error && options.fetch(:raise_api_errors, @raise_api_errors)
      resp
    end

    # Update a high score
    #
    # @option params [required, Hash, Types::HighScoreParams] :high_score
    #   The high score params
    #
    # @return [Seahorse::Output] Returns an {Seahorse::Output output}
    #   object with {Types::UpdateHighScoreOutput} as the data.
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.update_high_score(
    #     id: 'id',
    #     high_score: {
    #       game: 'Game',
    #       score: 42
    #     }
    #   )
    #
    def update_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      stack.use(
        Seahorse::Middleware::Validate,
        validator: Validators::UpdateHighScoreInput,
        params: params,
        validate_params: options.fetch(:validate_params, @validate_params)
      )
      stack.use(
        Seahorse::Middleware::Build,
        builder: Builders::UpdateHighScore,
        params: params
      )
      stack.use(
        Seahorse::HTTP::Middleware::ContentLength
      )
      stack.use(
        Seahorse::Middleware::Retry,
        max_delay: options.fetch(:max_delay, @max_delay),
        max_attempts: options.fetch(:max_attempts, @max_attempts)
      )
      stack.use(
        Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status_code: 200, errors: [Errors::UnprocessableEntityError],
          error_code_fn: Errors.method(:error_code)),
        data_parser: Parsers::UpdateHighScore
      )
      stack.use(
        Seahorse::Middleware::Sign,
        signer: @signer
      )
      stack.use(
        Seahorse::Middleware::Send,
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_responses: @stub_responses,
        stub_class: Stubs::UpdateHighScore
      )
      apply_middleware(stack, options[:middleware])
      resp = stack.run(
        request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
        response: Seahorse::HTTP::Response.new(body: output_stream),
        context: {
          api_method: :update_high_score,
          api_name: 'UpdateHighScore',
          params: params,
          logger: @logger
        }
      )
      raise resp.error if resp.error && options.fetch(:raise_api_errors, @raise_api_errors)
      resp
    end

    # Delete a high score
    #
    # @option params [required, String] :id
    #   The high score id
    #
    # @return [Seahorse::Output] Returns an {Seahorse::Output output}
    #   object with {Types::DeleteHighScoreOutput} as the data.
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.delete_high_score(
    #     id: 'id'
    #   )
    #
    def delete_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      stack.use(
        Seahorse::Middleware::Validate,
        validator: Validators::DeleteHighScoreInput,
        params: params,
        validate_params: options.fetch(:validate_params, @validate_params)
      )
      stack.use(
        Seahorse::Middleware::Build,
        builder: Builders::DeleteHighScore,
        params: params
      )
      stack.use(
        Seahorse::HTTP::Middleware::ContentLength
      )
      stack.use(
        Seahorse::Middleware::Retry,
        max_delay: options.fetch(:max_delay, @max_delay),
        max_attempts: options.fetch(:max_attempts, @max_attempts)
      )
      stack.use(
        Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status_code: 200, errors: [],
          error_code_fn: Errors.method(:error_code)),
        data_parser: Parsers::DeleteHighScore
      )
      stack.use(
        Seahorse::Middleware::Sign,
        signer: @signer
      )
      stack.use(
        Seahorse::Middleware::Send,
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_responses: @stub_responses,
        stub_class: Stubs::DeleteHighScore
      )
      apply_middleware(stack, options[:middleware])
      resp = stack.run(
        request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
        response: Seahorse::HTTP::Response.new(body: output_stream),
        context: {
          api_method: :delete_high_score,
          api_name: 'DeleteHighScore',
          params: params,
          logger: @logger
        }
      )
      raise resp.error if resp.error && options.fetch(:raise_api_errors, @raise_api_errors)
      resp
    end

    # List all high scores
    #
    # @return [Seahorse::Output] Returns an {Seahorse::Output output}
    #   object with {Types::ListHighScoresOutput} as the data.
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.list_high_scores
    #
    def list_high_scores(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      stack.use(
        Seahorse::Middleware::Validate,
        validator: Validators::ListHighScoresInput,
        params: params,
        validate_params: options.fetch(:validate_params, @validate_params)
      )
      stack.use(
        Seahorse::Middleware::Build,
        builder: Builders::ListHighScores,
        params: params
      )
      stack.use(
        Seahorse::HTTP::Middleware::ContentLength
      )
      stack.use(
        Seahorse::Middleware::Retry,
        max_delay: options.fetch(:max_delay, @max_delay),
        max_attempts: options.fetch(:max_attempts, @max_attempts)
      )
      stack.use(
        Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status_code: 200, errors: [],
          error_code_fn: Errors.method(:error_code)),
        data_parser: Parsers::ListHighScores
      )
      stack.use(
        Seahorse::Middleware::Sign,
        signer: @signer
      )
      stack.use(
        Seahorse::Middleware::Send,
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_responses: @stub_responses,
        stub_class: Stubs::ListHighScores
      )
      apply_middleware(stack, options[:middleware])
      resp = stack.run(
        request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
        response: Seahorse::HTTP::Response.new(body: output_stream),
        context: {
          api_method: :list_high_scores,
          api_name: 'ListHighScores',
          params: params,
          logger: @logger
        }
      )
      raise resp.error if resp.error && options.fetch(:raise_api_errors, @raise_api_errors)
      resp
    end

    private

    def apply_middleware(middleware_stack, middleware)
      Client.middleware.apply(middleware_stack)
      @middleware.apply(middleware_stack)
      Seahorse::MiddlewareBuilder.new(middleware).apply(middleware_stack)
    end

    def output_stream(options = {}, block = nil)
      return options[:output_stream] if options[:output_stream]
      return Seahorse::BlockIO.new(block) if block

      StringIO.new
    end
  end
end
