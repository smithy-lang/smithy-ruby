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
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::CustomAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::CustomAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::CustomAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::CustomAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class DataplaneEndpoint
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::DataplaneEndpointInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::DataplaneEndpoint,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::DataplaneEndpoint,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::DataplaneEndpoint,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class DefaultsTest
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::DefaultsTestInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::DefaultsTest,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::DefaultsTest,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::DefaultsTest,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class EndpointOperation
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::EndpointOperationInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::EndpointOperation,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::HostPrefix,
          disable_host_prefix: config.disable_host_prefix,
          host_prefix: "foo."
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::EndpointOperation,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::EndpointOperation,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::EndpointWithHostLabelOperationInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::EndpointWithHostLabelOperation,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::HostPrefix,
          disable_host_prefix: config.disable_host_prefix,
          host_prefix: "foo.{label_member}."
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::EndpointWithHostLabelOperation,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::EndpointWithHostLabelOperation,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpApiKeyAuth
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpApiKeyAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpApiKeyAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpApiKeyAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::HttpApiKeyAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpBasicAuth
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpBasicAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpBasicAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpBasicAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::HttpBasicAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpBearerAuth
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpBearerAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpBearerAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpBearerAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::HttpBearerAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpDigestAuth
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpDigestAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpDigestAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpDigestAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::HttpDigestAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class KitchenSink
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::KitchenSinkInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::KitchenSink,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::KitchenSink,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: [Errors::ClientError, Errors::ServerError]
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::KitchenSink,
          stub_error_classes: [Stubs::ClientError, Stubs::ServerError],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class MixinTest
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::MixinTestInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::MixinTest,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::MixinTest,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::MixinTest,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class NoAuth
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::NoAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::NoAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::NoAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::NoAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class OptionalAuth
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::OptionalAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::OptionalAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::OptionalAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::OptionalAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class OrderedAuth
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::OrderedAuthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::OrderedAuth,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::OrderedAuth,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::OrderedAuth,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class PaginatorsTest
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::PaginatorsTestOperationInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::PaginatorsTest,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::PaginatorsTest,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::PaginatorsTest,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class PaginatorsTestWithItems
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::PaginatorsTestWithItemsInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::PaginatorsTestWithItems,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::PaginatorsTestWithItems,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::PaginatorsTestWithItems,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class RelativeMiddleware
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::RelativeMiddlewareInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::RelativeMiddleware,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::RelativeMiddleware,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::RelativeMiddleware,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class RequestCompression
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::RequestCompressionInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RequestCompression
        )
        stack.use(Hearth::HTTP::Middleware::RequestCompression,
          disable_request_compression: config.disable_request_compression,
          encodings: ['gzip'],
          request_min_compression_size_bytes: config.request_min_compression_size_bytes,
          streaming: false
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::RequestCompression,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::RequestCompression,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::RequestCompression,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class RequestCompressionStreaming
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::RequestCompressionStreamingInput
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
          disable_request_compression: config.disable_request_compression,
          encodings: ['gzip'],
          request_min_compression_size_bytes: config.request_min_compression_size_bytes,
          streaming: true
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::RequestCompressionStreaming,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::RequestCompressionStreaming,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::RequestCompressionStreaming,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class ResourceEndpoint
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::ResourceEndpointInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::ResourceEndpoint,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::ResourceEndpoint,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::ResourceEndpoint,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class StartEventStream
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::StartEventStreamInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::StartEventStream
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(custom_param: 'custom_value', operation_name: :start_event_stream),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes,
          Hearth::Identities::HTTPLogin => config.http_login_provider,
          Hearth::Identities::HTTPBearer => config.http_bearer_provider,
          Hearth::Identities::HTTPApiKey => config.http_api_key_provider,
          Auth::HTTPCustomKey => config.http_custom_key_provider
        )
        stack.use(Hearth::EventStream::Middleware::Handlers,
          async_output_class: EventStream::StartEventStreamOutput,
          event_handler: options[:event_stream_handler],
          message_encoding_module: Hearth::EventStream::Binary,
          request_events: true,
          response_events: true
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::StartEventStream,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: true
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http2_client,
          stub_data_class: Stubs::StartEventStream,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class Streaming
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::StreamingInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::Streaming,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::Streaming,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::Streaming,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class StreamingWithLength
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::StreamingWithLengthInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::StreamingWithLength,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::StreamingWithLength,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::StreamingWithLength,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class WaitersTest
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::WaitersTestInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::WaitersTest,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::WaitersTest,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::WaitersTest,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class Operation____PaginatorsTestWithBadNames
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Middleware::TestMiddleware,
          test_config: config.test_config
        )
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::Struct____PaginatorsTestWithBadNamesInput
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
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::Operation____PaginatorsTestWithBadNames,
          stage: config.stage
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::Operation____PaginatorsTestWithBadNames,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::Operation____PaginatorsTestWithBadNames,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

  end
end
