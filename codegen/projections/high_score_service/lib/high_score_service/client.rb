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
  # Rails High Score example from their generator docs
  class Client
    include Hearth::ClientStubs

    # @api private
    @plugins = Hearth::PluginList.new

    # @return [Hearth::PluginList]
    def self.plugins
      @plugins
    end

    # @param [Hash] options
    #   Options used to construct an instance of {Config}
    def initialize(options = {})
      @config = initialize_config(options)
      @stubs = Hearth::Stubs.new
    end

    # @return [Config] config
    attr_reader :config

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::ApiKeyAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::ApiKeyAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.api_key_auth()
    # @example Response structure
    #   resp.data #=> Types::ApiKeyAuthOutput
    def api_key_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::ApiKeyAuthInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ApiKeyAuthInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ApiKeyAuth
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :api_key_auth),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::ApiKeyAuth
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [],
        stub_data_class: Stubs::ApiKeyAuth,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :api_key_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#api_key_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#api_key_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#api_key_auth] #{output.data}")
      output
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::BasicAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::BasicAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.basic_auth()
    # @example Response structure
    #   resp.data #=> Types::BasicAuthOutput
    def basic_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::BasicAuthInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::BasicAuthInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::BasicAuth
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :basic_auth),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::BasicAuth
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [],
        stub_data_class: Stubs::BasicAuth,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :basic_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#basic_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#basic_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#basic_auth] #{output.data}")
      output
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::BearerAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::BearerAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.bearer_auth()
    # @example Response structure
    #   resp.data #=> Types::BearerAuthOutput
    def bearer_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::BearerAuthInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::BearerAuthInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::BearerAuth
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :bearer_auth),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::BearerAuth
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [],
        stub_data_class: Stubs::BearerAuth,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :bearer_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#bearer_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#bearer_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#bearer_auth] #{output.data}")
      output
    end

    # Create a new high score
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::CreateHighScoreInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::CreateHighScoreOutput]
    # @example Request syntax with placeholder values
    #   resp = client.create_high_score(
    #     high_score: {
    #       game: 'game',
    #       score: 1
    #     } # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::CreateHighScoreOutput
    #   resp.data.high_score #=> Types::HighScoreAttributes
    #   resp.data.high_score.id #=> String
    #   resp.data.high_score.game #=> String
    #   resp.data.high_score.score #=> Integer
    #   resp.data.high_score.created_at #=> Time
    #   resp.data.high_score.updated_at #=> Time
    #   resp.data.location #=> String
    def create_high_score(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::CreateHighScoreInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::CreateHighScoreInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::CreateHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :create_high_score),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 201,
          errors: [Errors::UnprocessableEntityError]
        ),
        data_parser: Parsers::CreateHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [Stubs::UnprocessableEntityError],
        stub_data_class: Stubs::CreateHighScore,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :create_high_score,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#create_high_score] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#create_high_score] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#create_high_score] #{output.data}")
      output
    end

    # Delete a high score
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::DeleteHighScoreInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::DeleteHighScoreOutput]
    # @example Request syntax with placeholder values
    #   resp = client.delete_high_score(
    #     id: 'id' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::DeleteHighScoreOutput
    def delete_high_score(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::DeleteHighScoreInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::DeleteHighScoreInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::DeleteHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :delete_high_score),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::DeleteHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [],
        stub_data_class: Stubs::DeleteHighScore,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :delete_high_score,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#delete_high_score] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#delete_high_score] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#delete_high_score] #{output.data}")
      output
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::DigestAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::DigestAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.digest_auth()
    # @example Response structure
    #   resp.data #=> Types::DigestAuthOutput
    def digest_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::DigestAuthInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::DigestAuthInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::DigestAuth
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :digest_auth),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::DigestAuth
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [],
        stub_data_class: Stubs::DigestAuth,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :digest_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#digest_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#digest_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#digest_auth] #{output.data}")
      output
    end

    # Get a high score
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::GetHighScoreInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::GetHighScoreOutput]
    # @example Request syntax with placeholder values
    #   resp = client.get_high_score(
    #     id: 'id' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::GetHighScoreOutput
    #   resp.data.high_score #=> Types::HighScoreAttributes
    #   resp.data.high_score.id #=> String
    #   resp.data.high_score.game #=> String
    #   resp.data.high_score.score #=> Integer
    #   resp.data.high_score.created_at #=> Time
    #   resp.data.high_score.updated_at #=> Time
    def get_high_score(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::GetHighScoreInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GetHighScoreInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GetHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :get_high_score),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::GetHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [],
        stub_data_class: Stubs::GetHighScore,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :get_high_score,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#get_high_score] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#get_high_score] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#get_high_score] #{output.data}")
      output
    end

    # List all high scores
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::ListHighScoresInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::ListHighScoresOutput]
    # @example Request syntax with placeholder values
    #   resp = client.list_high_scores()
    # @example Response structure
    #   resp.data #=> Types::ListHighScoresOutput
    #   resp.data.high_scores #=> Array<HighScoreAttributes>
    #   resp.data.high_scores[0] #=> Types::HighScoreAttributes
    #   resp.data.high_scores[0].id #=> String
    #   resp.data.high_scores[0].game #=> String
    #   resp.data.high_scores[0].score #=> Integer
    #   resp.data.high_scores[0].created_at #=> Time
    #   resp.data.high_scores[0].updated_at #=> Time
    def list_high_scores(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::ListHighScoresInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ListHighScoresInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ListHighScores
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :list_high_scores),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::ListHighScores
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [],
        stub_data_class: Stubs::ListHighScores,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :list_high_scores,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#list_high_scores] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#list_high_scores] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#list_high_scores] #{output.data}")
      output
    end

    # Update a high score
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::UpdateHighScoreInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::UpdateHighScoreOutput]
    # @example Request syntax with placeholder values
    #   resp = client.update_high_score(
    #     id: 'id', # required
    #     high_score: {
    #       game: 'game',
    #       score: 1
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::UpdateHighScoreOutput
    #   resp.data.high_score #=> Types::HighScoreAttributes
    #   resp.data.high_score.id #=> String
    #   resp.data.high_score.game #=> String
    #   resp.data.high_score.score #=> Integer
    #   resp.data.high_score.created_at #=> Time
    #   resp.data.high_score.updated_at #=> Time
    def update_high_score(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::UpdateHighScoreInput.build(params, context: 'params')
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::UpdateHighScoreInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::UpdateHighScore
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_params: Auth::Params.new(operation_name: :update_high_score),
        auth_resolver: config.auth_resolver,
        auth_schemes: config.auth_schemes,
        Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
        Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
        Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: [Errors::UnprocessableEntityError]
        ),
        data_parser: Parsers::UpdateHighScore
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: config.http_client,
        stub_error_classes: [Stubs::UnprocessableEntityError],
        stub_data_class: Stubs::UpdateHighScore,
        stubs: @stubs
      )
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI(config.endpoint)),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :update_high_score,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#update_high_score] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#update_high_score] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#update_high_score] #{output.data}")
      output
    end

    private

    def initialize_config(options)
      client_interceptors = options.delete(:interceptors)
      config = Config.new(**options)
      Client.plugins.each { |p| p.call(config) }
      config.plugins.each { |p| p.call(config) }
      config.interceptors.concat(Hearth::InterceptorList.new(client_interceptors)) if client_interceptors
      config.validate!
      config.freeze
    end

    def operation_config(options)
      return @config if options.empty?

      operation_plugins = options.delete(:plugins)
      operation_interceptors = options.delete(:interceptors)
      config = @config.merge(options)
      Hearth::PluginList.new(operation_plugins).each { |p| p.call(config) } if operation_plugins
      config.interceptors.concat(Hearth::InterceptorList.new(operation_interceptors)) if operation_interceptors
      config.validate!
      config.freeze
    end
  end
end
