# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'middleware/request_id'

module HighScoreService
  module Middleware

    class ApiKeyAuth
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::ApiKeyAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::ApiKeyAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :api_key_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::ApiKeyAuth,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class BasicAuth
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::BasicAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::BasicAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :basic_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::BasicAuth,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class BearerAuth
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::BearerAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::BearerAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :bearer_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::BearerAuth,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class CreateHighScore
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::CreateHighScoreInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::CreateHighScore
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :create_high_score),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::CreateHighScore,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class DeleteHighScore
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::DeleteHighScoreInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DeleteHighScore
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :delete_high_score),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::DeleteHighScore,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class DigestAuth
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::DigestAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DigestAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :digest_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::DigestAuth,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class GetHighScore
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::GetHighScoreInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::GetHighScore
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :get_high_score),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::GetHighScore,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class ListHighScores
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::ListHighScoresInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::ListHighScores
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :list_high_scores),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::ListHighScores,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

    class UpdateHighScore
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::UpdateHighScoreInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::UpdateHighScore
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :update_high_score),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_identity_resolver,
          Hearth::Identities::HTTPBearer => config.http_bearer_identity_resolver,
          Hearth::Identities::HTTPApiKey => config.http_api_key_identity_resolver
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          param_builder: Endpoint::Parameters::UpdateHighScore,
          endpoint: config.endpoint,
          endpoint_provider: config.endpoint_provider
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
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
          stubs: stubs
        )
        stack
      end
    end

  end
end
