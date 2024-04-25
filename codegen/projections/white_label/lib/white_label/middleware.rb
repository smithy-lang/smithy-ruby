# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'middleware/relative_middleware'
require_relative 'middleware/test_middleware'

module WhiteLabel
  # @api private
  module Middleware

    class CustomAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::CustomAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::CustomAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :custom_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::CustomAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::CustomAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::CustomAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class DataplaneEndpoint
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::DataplaneEndpointInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DataplaneEndpoint
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :dataplane_endpoint),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::DataplaneEndpoint,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::DataplaneEndpoint
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::DataplaneEndpoint,
          stubs: config.stubs
        )
        stack
      end
    end

    class DefaultsTest
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::DefaultsTestInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DefaultsTest
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :defaults_test),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::DefaultsTest,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::DefaultsTest
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::DefaultsTest,
          stubs: config.stubs
        )
        stack
      end
    end

    class EndpointOperation
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::EndpointOperationInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::EndpointOperation
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :endpoint_operation),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::EndpointOperation,
          endpoint_resolver: config.endpoint_resolver
        )
        stack.use(Hearth::Middleware::HostPrefix,
          host_prefix: "foo.",
          disable_host_prefix: config.disable_host_prefix
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
          data_parser: Parsers::EndpointOperation
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::EndpointOperation,
          stubs: config.stubs
        )
        stack
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::EndpointWithHostLabelOperationInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::EndpointWithHostLabelOperation
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :endpoint_with_host_label_operation),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::EndpointWithHostLabelOperation,
          endpoint_resolver: config.endpoint_resolver
        )
        stack.use(Hearth::Middleware::HostPrefix,
          host_prefix: "foo.{label_member}.",
          disable_host_prefix: config.disable_host_prefix
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
          data_parser: Parsers::EndpointWithHostLabelOperation
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::EndpointWithHostLabelOperation,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpApiKeyAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::HttpApiKeyAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpApiKeyAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :http_api_key_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::HttpApiKeyAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::HttpApiKeyAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::HttpApiKeyAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpBasicAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::HttpBasicAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpBasicAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :http_basic_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::HttpBasicAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::HttpBasicAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::HttpBasicAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpBearerAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::HttpBearerAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpBearerAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :http_bearer_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::HttpBearerAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::HttpBearerAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::HttpBearerAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpDigestAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::HttpDigestAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpDigestAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :http_digest_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::HttpDigestAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::HttpDigestAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::HttpDigestAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class KitchenSink
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::KitchenSinkInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::KitchenSink
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :kitchen_sink),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::KitchenSink,
          endpoint_resolver: config.endpoint_resolver
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
            errors: [Errors::ClientError, Errors::ServerError]
          ),
          data_parser: Parsers::KitchenSink
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [Stubs::ClientError, Stubs::ServerError],
          stub_data_class: Stubs::KitchenSink,
          stubs: config.stubs
        )
        stack
      end
    end

    class MixinTest
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::MixinTestInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::MixinTest
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :mixin_test),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::MixinTest,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::MixinTest
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::MixinTest,
          stubs: config.stubs
        )
        stack
      end
    end

    class NoAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::NoAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::NoAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :no_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::NoAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::NoAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::NoAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class OptionalAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::OptionalAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::OptionalAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :optional_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::OptionalAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::OptionalAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::OptionalAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class OrderedAuth
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::OrderedAuthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::OrderedAuth
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :ordered_auth),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::OrderedAuth,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::OrderedAuth
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::OrderedAuth,
          stubs: config.stubs
        )
        stack
      end
    end

    class PaginatorsTest
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::PaginatorsTestOperationInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::PaginatorsTest
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :paginators_test),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::PaginatorsTest,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::PaginatorsTest
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::PaginatorsTest,
          stubs: config.stubs
        )
        stack
      end
    end

    class PaginatorsTestWithItems
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::PaginatorsTestWithItemsInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::PaginatorsTestWithItems
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :paginators_test_with_items),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::PaginatorsTestWithItems,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::PaginatorsTestWithItems
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::PaginatorsTestWithItems,
          stubs: config.stubs
        )
        stack
      end
    end

    class RelativeMiddleware
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::RelativeMiddlewareInput,
          validate_input: config.validate_input
        )
        stack.use(Middleware::BeforeMiddleware)
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RelativeMiddleware
        )
        stack.use(Middleware::MidMiddleware)
        stack.use(Middleware::AfterMiddleware)
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :relative_middleware),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::RelativeMiddleware,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::RelativeMiddleware
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::RelativeMiddleware,
          stubs: config.stubs
        )
        stack
      end
    end

    class RequestCompression
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::RequestCompressionInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RequestCompression
        )
        stack.use(Hearth::HTTP::Middleware::RequestCompression,
          streaming: false,
          encodings: ['gzip'],
          request_min_compression_size_bytes: config.request_min_compression_size_bytes,
          disable_request_compression: config.disable_request_compression
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :request_compression),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::HTTP::Middleware::ContentMD5)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::RequestCompression,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::RequestCompression
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::RequestCompression,
          stubs: config.stubs
        )
        stack
      end
    end

    class RequestCompressionStreaming
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::RequestCompressionStreamingInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RequestCompressionStreaming
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :request_compression_streaming),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::RequestCompression,
          streaming: true,
          encodings: ['gzip'],
          request_min_compression_size_bytes: config.request_min_compression_size_bytes,
          disable_request_compression: config.disable_request_compression
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::RequestCompressionStreaming,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::RequestCompressionStreaming
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::RequestCompressionStreaming,
          stubs: config.stubs
        )
        stack
      end
    end

    class ResourceEndpoint
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::ResourceEndpointInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::ResourceEndpoint
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :resource_endpoint),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::ResourceEndpoint,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::ResourceEndpoint
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::ResourceEndpoint,
          stubs: config.stubs
        )
        stack
      end
    end

    class Streaming
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::StreamingInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::Streaming
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :streaming),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::Streaming,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::Streaming
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::Streaming,
          stubs: config.stubs
        )
        stack
      end
    end

    class StreamingWithLength
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::StreamingWithLengthInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::StreamingWithLength
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :streaming_with_length),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::StreamingWithLength,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::StreamingWithLength
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::StreamingWithLength,
          stubs: config.stubs
        )
        stack
      end
    end

    class WaitersTest
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::WaitersTestInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::WaitersTest
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :waiters_test),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::WaitersTest,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::WaitersTest
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::WaitersTest,
          stubs: config.stubs
        )
        stack
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.build(config)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::Struct____PaginatorsTestWithBadNamesInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::Operation____PaginatorsTestWithBadNames
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :operation____paginators_test_with_bad_names),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          stage: config.stage,
          param_builder: Endpoint::Parameters::Operation____PaginatorsTestWithBadNames,
          endpoint_resolver: config.endpoint_resolver
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
          data_parser: Parsers::Operation____PaginatorsTestWithBadNames
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::Operation____PaginatorsTestWithBadNames,
          stubs: config.stubs
        )
        stack
      end
    end

  end
end
