# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

require_relative 'middleware/request_id'

module HighScoreService
  # An API client for HighScoreService
  # See {#initialize} for a full list of supported configuration options
  # Rails High Score example from their generator docs
  #
  class Client
    include Hearth::ClientStubs

    @middleware = Hearth::MiddlewareBuilder.new

    def self.middleware
      @middleware
    end

    # @param [Config] config
    #   An instance of {Config}
    #
    def initialize(config = HighScoreService::Config.new, options = {})
      @config = config
      @middleware = Hearth::MiddlewareBuilder.new(options[:middleware])
      @stubs = Hearth::Stubbing::Stubs.new
      @retry_quota = Hearth::Retry::RetryQuota.new
      @client_rate_limiter = Hearth::Retry::ClientRateLimiter.new
    end

    # Create a new high score
    #
    # @param [Hash] params
    #   See {Types::CreateHighScoreInput}.
    #
    # @option params [HighScoreParams] :high_score
    #   The high score params
    #
    # @return [Types::CreateHighScoreOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.create_high_score(
    #     high_score: {
    #       game: 'game',
    #       score: 1
    #     } # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::CreateHighScoreOutput
    #   resp.data.high_score #=> Types::HighScoreAttributes
    #   resp.data.high_score.id #=> String
    #   resp.data.high_score.game #=> String
    #   resp.data.high_score.score #=> Integer
    #   resp.data.high_score.created_at #=> Time
    #   resp.data.high_score.updated_at #=> Time
    #   resp.data.location #=> String
    #
    def create_high_score(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::CreateHighScoreInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::CreateHighScoreInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::CreateHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 201, errors: [Errors::UnprocessableEntityError]),
        data_parser: Parsers::CreateHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::CreateHighScore,
        stubs: @stubs,
        params_class: Params::CreateHighScoreOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, @config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :create_high_score
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Delete a high score
    #
    # @param [Hash] params
    #   See {Types::DeleteHighScoreInput}.
    #
    # @option params [String] :id
    #   The high score id
    #
    # @return [Types::DeleteHighScoreOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.delete_high_score(
    #     id: 'id' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::DeleteHighScoreOutput
    #
    def delete_high_score(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::DeleteHighScoreInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::DeleteHighScoreInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::DeleteHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::DeleteHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::DeleteHighScore,
        stubs: @stubs,
        params_class: Params::DeleteHighScoreOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, @config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :delete_high_score
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Get a high score
    #
    # @param [Hash] params
    #   See {Types::GetHighScoreInput}.
    #
    # @option params [String] :id
    #   The high score id
    #
    # @return [Types::GetHighScoreOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.get_high_score(
    #     id: 'id' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::GetHighScoreOutput
    #   resp.data.high_score #=> Types::HighScoreAttributes
    #   resp.data.high_score.id #=> String
    #   resp.data.high_score.game #=> String
    #   resp.data.high_score.score #=> Integer
    #   resp.data.high_score.created_at #=> Time
    #   resp.data.high_score.updated_at #=> Time
    #
    def get_high_score(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetHighScoreInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetHighScoreInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::GetHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::GetHighScore,
        stubs: @stubs,
        params_class: Params::GetHighScoreOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, @config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :get_high_score
        )
      )
      raise resp.error if resp.error
      resp
    end

    # List all high scores
    #
    # @param [Hash] params
    #   See {Types::ListHighScoresInput}.
    #
    # @return [Types::ListHighScoresOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.list_high_scores()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::ListHighScoresOutput
    #   resp.data.high_scores #=> Array<HighScoreAttributes>
    #   resp.data.high_scores[0] #=> Types::HighScoreAttributes
    #   resp.data.high_scores[0].id #=> String
    #   resp.data.high_scores[0].game #=> String
    #   resp.data.high_scores[0].score #=> Integer
    #   resp.data.high_scores[0].created_at #=> Time
    #   resp.data.high_scores[0].updated_at #=> Time
    #
    def list_high_scores(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::ListHighScoresInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ListHighScoresInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ListHighScores
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::ListHighScores
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::ListHighScores,
        stubs: @stubs,
        params_class: Params::ListHighScoresOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, @config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
          operation_name: :list_high_scores
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Update a high score
    #
    # @param [Hash] params
    #   See {Types::UpdateHighScoreInput}.
    #
    # @option params [String] :id
    #   The high score id
    #
    # @option params [HighScoreParams] :high_score
    #   The high score params
    #
    # @return [Types::UpdateHighScoreOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.update_high_score(
    #     id: 'id', # required
    #     high_score: {
    #       game: 'game',
    #       score: 1
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::UpdateHighScoreOutput
    #   resp.data.high_score #=> Types::HighScoreAttributes
    #   resp.data.high_score.id #=> String
    #   resp.data.high_score.game #=> String
    #   resp.data.high_score.score #=> Integer
    #   resp.data.high_score.created_at #=> Time
    #   resp.data.high_score.updated_at #=> Time
    #
    def update_high_score(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::UpdateHighScoreInput.build(params)
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::UpdateHighScoreInput,
        validate_input: @config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::UpdateHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_mode: @config.retry_mode,
        error_inspector_class: Hearth::Retry::ErrorInspector,
        retry_quota: @retry_quota,
        max_attempts: @config.max_attempts,
        client_rate_limiter: @client_rate_limiter,
        adaptive_retry_wait_to_fill: @config.adaptive_retry_wait_to_fill
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: [Errors::UnprocessableEntityError]),
        data_parser: Parsers::UpdateHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: @config.stub_responses,
        client: Hearth::HTTP::Client.new(logger: @config.logger, http_wire_trace: options.fetch(:http_wire_trace, @config.http_wire_trace)),
        stub_class: Stubs::UpdateHighScore,
        stubs: @stubs,
        params_class: Params::UpdateHighScoreOutput
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, @config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: @config.logger,
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
      Hearth::MiddlewareBuilder.new(middleware).apply(middleware_stack)
    end
  end
end
