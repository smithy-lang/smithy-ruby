# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  # An API client for SampleService
  # See {#initialize} for a full list of supported configuration options
  class Client
    include Seahorse::ClientStubs

    @middleware = Seahorse::MiddlewareBuilder.new

    def self.middleware
      @middleware
    end

    # @overload initialize(options)
    # @param [Hash] options
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
    # @option options [MiddlewareBuilder] :middleware
    #   Additional Middleware to be applied for every operation
    #
    # @option options [Bool] :stub_responses (false)
    #   Enable response stubbing. See documentation for {#stub_responses}
    #
    # @option options [Boolean] :validate_input (true)
    #   When `true`, request parameters are validated using the modeled shapes.
    #
    def initialize(options = {})
      @endpoint = options[:endpoint]
      @http_wire_trace = options.fetch(:http_wire_trace, false)
      @log_level = options.fetch(:log_level, :info)
      @logger = options.fetch(:logger, Logger.new($stdout, level: @log_level))
      @middleware = Seahorse::MiddlewareBuilder.new(options[:middleware])
      @stub_responses = options.fetch(:stub_responses, false)
      @stubs = Seahorse::Stubbing::Stubs.new
      @validate_input = options.fetch(:validate_input, true)

    end

    # Create a new high score
    #
    # @param [Hash] params - See also: {Types::CreateHighScoreInput}
    # @options param[STRUCTURE] :high_score
    #   The high score params
    #
    def create_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      input = Types::CreateHighScoreInput.build(params)
      stack.use(Seahorse::Middleware::Validate,
        validator: Validators::CreateHighScoreInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Seahorse::Middleware::Build,
        builder: Builders::CreateHighScore
      )
      stack.use(Seahorse::HTTP::Middleware::ContentLength)
      stack.use(Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::CreateHighScore
      )
      stack.use(Seahorse::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_class: Builders::CreateHighScore,
        stubs: options.fetch(:stubs, @stubs)
      )
      @middleware.apply(stack)
      resp = stack.run(
        input: input,
        context: Seahorse::Context.new(
          request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Seahorse::HTTP::Response.new(body: output_stream),
          params: params,
          logger: @logger,
          operation_name: :create_high_score
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Delete a high score
    #
    # @param [Hash] params - See also: {Types::DeleteHighScoreInput}
    # @options param[STRING] :id
    #   The high score id
    #
    def delete_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      input = Types::DeleteHighScoreInput.build(params)
      stack.use(Seahorse::Middleware::Validate,
        validator: Validators::DeleteHighScoreInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Seahorse::Middleware::Build,
        builder: Builders::DeleteHighScore
      )
      stack.use(Seahorse::HTTP::Middleware::ContentLength)
      stack.use(Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::DeleteHighScore
      )
      stack.use(Seahorse::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_class: Builders::DeleteHighScore,
        stubs: options.fetch(:stubs, @stubs)
      )
      @middleware.apply(stack)
      resp = stack.run(
        input: input,
        context: Seahorse::Context.new(
          request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Seahorse::HTTP::Response.new(body: output_stream),
          params: params,
          logger: @logger,
          operation_name: :delete_high_score
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Get a high score
    #
    # @param [Hash] params - See also: {Types::GetHighScoreInput}
    # @options param[STRING] :id
    #   The high score id
    #
    def get_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      input = Types::GetHighScoreInput.build(params)
      stack.use(Seahorse::Middleware::Validate,
        validator: Validators::GetHighScoreInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Seahorse::Middleware::Build,
        builder: Builders::GetHighScore
      )
      stack.use(Seahorse::HTTP::Middleware::ContentLength)
      stack.use(Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::GetHighScore
      )
      stack.use(Seahorse::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_class: Builders::GetHighScore,
        stubs: options.fetch(:stubs, @stubs)
      )
      @middleware.apply(stack)
      resp = stack.run(
        input: input,
        context: Seahorse::Context.new(
          request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Seahorse::HTTP::Response.new(body: output_stream),
          params: params,
          logger: @logger,
          operation_name: :get_high_score
        )
      )
      raise resp.error if resp.error
      resp
    end

    # List all high scores
    #
    # @param [Hash] params - See also: {Types::ListHighScoresInput}
    # @options param[INTEGER] :max_results
    #
    # @options param[STRING] :next_token
    #
    def list_high_scores(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      input = Types::ListHighScoresInput.build(params)
      stack.use(Seahorse::Middleware::Validate,
        validator: Validators::ListHighScoresInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Seahorse::Middleware::Build,
        builder: Builders::ListHighScores
      )
      stack.use(Seahorse::HTTP::Middleware::ContentLength)
      stack.use(Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::ListHighScores
      )
      stack.use(Seahorse::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_class: Builders::ListHighScores,
        stubs: options.fetch(:stubs, @stubs)
      )
      @middleware.apply(stack)
      resp = stack.run(
        input: input,
        context: Seahorse::Context.new(
          request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Seahorse::HTTP::Response.new(body: output_stream),
          params: params,
          logger: @logger,
          operation_name: :list_high_scores
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Update a high score
    #
    # @param [Hash] params - See also: {Types::UpdateHighScoreInput}
    # @options param[STRING] :id
    #   The high score id
    #
    # @options param[STRUCTURE] :high_score
    #   The high score params
    #
    def update_high_score(params = {}, options = {})
      stack = Seahorse::MiddlewareStack.new
      input = Types::UpdateHighScoreInput.build(params)
      stack.use(Seahorse::Middleware::Validate,
        validator: Validators::UpdateHighScoreInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Seahorse::Middleware::Build,
        builder: Builders::UpdateHighScore
      )
      stack.use(Seahorse::HTTP::Middleware::ContentLength)
      stack.use(Seahorse::Middleware::Parse,
        error_parser: Seahorse::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::UpdateHighScore
      )
      stack.use(Seahorse::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Seahorse::HTTP::Client.new(logger: @logger, http_wire_trace: @http_wire_trace),
        stub_class: Builders::UpdateHighScore,
        stubs: options.fetch(:stubs, @stubs)
      )
      @middleware.apply(stack)
      resp = stack.run(
        input: input,
        context: Seahorse::Context.new(
          request: Seahorse::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Seahorse::HTTP::Response.new(body: output_stream),
          params: params,
          logger: @logger,
          operation_name: :update_high_score
        )
      )
      raise resp.error if resp.error
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
