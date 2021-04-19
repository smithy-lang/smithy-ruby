module SampleService
  class Client
    include Seahorse::ClientStubs

    @middleware = Seahorse::MiddlewareBuilder.new

    def self.middleware
      @middleware
    end

    def initialize(options = {})
      @endpoint = options[:endpoint]
      @stub_responses = options.fetch(:stub_responses, false)
      @max_attempts = options.fetch(:max_attempts, 4)
      @max_delay = options.fetch(:max_delay, 8)
      @raise_api_errors = options.fetch(:raise_api_errors, true)
      @http_wire_trace = options.fetch(:http_wire_trace, false)
      @validate_params = options.fetch(:validate_params, true)
      @middleware = Seahorse::MiddlewareBuilder.new(options[:middleware])
      @stubs = Seahorse::Stubbing::Stubs.new
      @log_level = options.fetch(:log_level, :info)
      @logger = options.fetch(:logger, Logger.new($stdout, level: @log_level))
    end

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

      # codegen based on traits
      if resp.next_page?
        resp.pager.request_next_page = proc do
          next_page_params = params.merge(next_token: resp.pager.next_token)

          self.list_high_scores(next_page_params, options)
        end
      end

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
