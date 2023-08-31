# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

require_relative 'middleware/test_middleware'
require_relative 'plugins/test_plugin'

module WhiteLabel
  # An API client for WhiteLabel
  # See {#initialize} for a full list of supported configuration options
  # The test SDK.
  # This service should pass the tests.
  # @deprecated
  #   This test SDK is not suitable
  #   for production use.
  #   Since: today
  # @note
  #   This shape is unstable and may change in the future.
  # @see https://www.ruby-lang.org/en/ Homepage
  # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
  # @note
  #   This shape is meant for internal use only.
  # @since today
  class Client
    include Hearth::ClientStubs
    @plugins = Hearth::PluginList.new([
      Plugins::TestPlugin.new
    ])

    def self.plugins
      @plugins
    end

    # @param [Config] config
    #   An instance of {Config}
    def initialize(config = WhiteLabel::Config.new, options = {})
      @config = initialize_config(config)
      @stubs = Hearth::Stubs.new
    end

    # @return [Config] config
    attr_reader :config

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::DefaultsTestInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::DefaultsTestOutput]
    # @example Request syntax with placeholder values
    #   resp = client.defaults_test(
    #     string: 'String',
    #     struct: {
    #       value: 'value'
    #     },
    #     un_required_number: 1,
    #     un_required_bool: false,
    #     number: 1, # required
    #     bool: false, # required
    #     hello: 'hello', # required
    #     simple_enum: 'YES', # required - accepts ["YES", "NO", "MAYBE"]
    #     typed_enum: 'YES', # required - accepts ["YES", "NO", "MAYBE"]
    #     int_enum: 1, # required
    #     null_document: {
    #       'nil' => nil,
    #       'number' => 123.0,
    #       'string' => 'value',
    #       'boolean' => true,
    #       'array' => [],
    #       'map' => {}
    #     }, # required
    #     list_of_strings: [
    #       'member'
    #     ], # required
    #     map_of_strings: {
    #       'key' => 'value'
    #     }, # required
    #     iso8601_timestamp: Time.now, # required
    #     epoch_timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::DefaultsTestOutput
    #   resp.data.string #=> String
    #   resp.data.struct #=> Types::Struct
    #   resp.data.struct.value #=> String
    #   resp.data.un_required_number #=> Integer
    #   resp.data.un_required_bool #=> Boolean
    #   resp.data.number #=> Integer
    #   resp.data.bool #=> Boolean
    #   resp.data.hello #=> String
    #   resp.data.simple_enum #=> String, one of ["YES", "NO", "MAYBE"]
    #   resp.data.typed_enum #=> String, one of ["YES", "NO", "MAYBE"]
    #   resp.data.int_enum #=> Integer
    #   resp.data.null_document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.string_document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.boolean_document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.numbers_document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.list_document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.map_document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.list_of_strings #=> Array<String>
    #   resp.data.list_of_strings[0] #=> String
    #   resp.data.map_of_strings #=> Hash<String, String>
    #   resp.data.map_of_strings['key'] #=> String
    #   resp.data.iso8601_timestamp #=> Time
    #   resp.data.epoch_timestamp #=> Time
    def defaults_test(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::DefaultsTestInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :defaults_test),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::DefaultsTest,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :defaults_test,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::EndpointOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::EndpointOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.endpoint_operation()
    # @example Response structure
    #   resp.data #=> Types::EndpointOperationOutput
    def endpoint_operation(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::EndpointOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Middleware::TestMiddleware,
        test_config: config.test_config
      )
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::EndpointOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::HostPrefix,
        host_prefix: "foo.",
        disable_host_prefix: config.disable_host_prefix
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::EndpointOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :endpoint_operation),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::EndpointOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :endpoint_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::EndpointWithHostLabelOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::EndpointWithHostLabelOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.endpoint_with_host_label_operation(
    #     label_member: 'labelMember' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::EndpointWithHostLabelOperationOutput
    def endpoint_with_host_label_operation(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::EndpointWithHostLabelOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Middleware::TestMiddleware,
        test_config: config.test_config
      )
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::EndpointWithHostLabelOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::HostPrefix,
        host_prefix: "foo.{label_member}.",
        disable_host_prefix: config.disable_host_prefix
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::EndpointWithHostLabelOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :endpoint_with_host_label_operation),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::EndpointWithHostLabelOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :endpoint_with_host_label_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpApiKeyAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpApiKeyAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_api_key_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpApiKeyAuthOutput
    def http_api_key_auth(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpApiKeyAuthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_api_key_auth),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpApiKeyAuth,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_api_key_auth,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpBasicAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpBasicAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_basic_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpBasicAuthOutput
    def http_basic_auth(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpBasicAuthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_basic_auth),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpBasicAuth,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_basic_auth,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpBearerAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpBearerAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_bearer_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpBearerAuthOutput
    def http_bearer_auth(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpBearerAuthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_bearer_auth),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpBearerAuth,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_bearer_auth,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpDigestAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpDigestAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_digest_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpDigestAuthOutput
    def http_digest_auth(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpDigestAuthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_digest_auth),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpDigestAuth,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_digest_auth,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The kitchen sink operation.
    # It is kinda useless.
    # @deprecated
    #   This operation is not suitable
    #   for production use.
    #   Since: today
    # @note
    #   This shape is unstable and may change in the future.
    # @see https://www.ruby-lang.org/en/ Homepage
    # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    # @note
    #   This shape is meant for internal use only.
    # @since today
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::KitchenSinkInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::KitchenSinkOutput]
    # @example Request syntax with placeholder values
    #   resp = client.kitchen_sink(
    #     string: 'String',
    #     simple_enum: 'YES', # accepts ["YES", "NO", "MAYBE"]
    #     typed_enum: 'YES', # accepts ["YES", "NO", "MAYBE"]
    #     struct: {
    #       value: 'value'
    #     },
    #     document: {
    #       'nil' => nil,
    #       'number' => 123.0,
    #       'string' => 'value',
    #       'boolean' => true,
    #       'array' => [],
    #       'map' => {}
    #     },
    #     list_of_strings: [
    #       'member'
    #     ],
    #     map_of_strings: {
    #       'key' => 'value'
    #     },
    #     union: {
    #       # One of:
    #       string: 'String',
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::KitchenSinkOutput
    #   resp.data.string #=> String
    #   resp.data.simple_enum #=> String, one of ["YES", "NO", "MAYBE"]
    #   resp.data.typed_enum #=> String, one of ["YES", "NO", "MAYBE"]
    #   resp.data.struct #=> Types::Struct
    #   resp.data.struct.value #=> String
    #   resp.data.document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.list_of_strings #=> Array<String>
    #   resp.data.list_of_strings[0] #=> String
    #   resp.data.list_of_structs #=> Array<Struct>
    #   resp.data.map_of_strings #=> Hash<String, String>
    #   resp.data.map_of_strings['key'] #=> String
    #   resp.data.map_of_structs #=> Hash<String, Struct>
    #   resp.data.union #=> Types::Union, one of [String, Struct]
    #   resp.data.union.string #=> String
    #   resp.data.union.struct #=> Types::Struct
    # @example Test input and output
    #   # Demonstrates setting a range of input values and getting different types of outputs.
    #   resp = client.kitchen_sink({
    #     string: "Test",
    #     struct: {
    #       value: "struct"
    #     },
    #     document: {'thing' => true, 'string' => 'hello'},
    #     list_of_strings: [
    #       "foo",
    #       "bar"
    #     ],
    #     list_of_structs: [
    #       {
    #         value: "struct1"
    #       },
    #       {
    #         value: "struct2"
    #       }
    #     ],
    #     map_of_strings: {
    #       'key1' => "value1",
    #       'key2' => "value2"
    #     },
    #     map_of_structs: {
    #       'key1' => {
    #         value: "struct1"
    #       },
    #       'key2' => {
    #         value: "struct2"
    #       }
    #     },
    #     union: {
    #       string: "union string"
    #     }
    #   })
    #
    #   # resp.to_h outputs the following:
    #   {
    #     string: "Test output",
    #     struct: {
    #       value: "struct"
    #     },
    #     document: {'thing' => true, 'string' => 'hello'},
    #     list_of_strings: [
    #       "foo",
    #       "bar"
    #     ],
    #     list_of_structs: [
    #       {
    #         value: "struct1"
    #       },
    #       {
    #         value: "struct2"
    #       }
    #     ],
    #     map_of_strings: {
    #       'key1' => "value1",
    #       'key2' => "value2"
    #     },
    #     map_of_structs: {
    #       'key1' => {
    #         value: "struct1"
    #       },
    #       'key2' => {
    #         value: "struct2"
    #       }
    #     },
    #     union: {
    #       struct: {
    #         value: "union struct"
    #       }
    #     }
    #   }
    # @example Test errors
    #   begin
    #     # Demonstrates an error example.
    #     resp = client.kitchen_sink({
    #       string: "error"
    #     })
    #   rescue ApiError => e
    #     puts e.class # ClientError
    #     puts e.data.to_h
    #   end
    #
    #   # e.data.to_h outputs the following:
    #   {
    #     message: "Client error"
    #   }
    def kitchen_sink(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::KitchenSinkInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :kitchen_sink),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [Stubs::ClientError, Stubs::ServerError],
        stub_data_class: Stubs::KitchenSink,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :kitchen_sink,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::MixinTestInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::MixinTestOutput]
    # @example Request syntax with placeholder values
    #   resp = client.mixin_test(
    #     user_id: 'userId'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MixinTestOutput
    #   resp.data.username #=> String
    #   resp.data.user_id #=> String
    def mixin_test(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::MixinTestInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :mixin_test),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::MixinTest,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :mixin_test,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::NoAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::NoAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.no_auth()
    # @example Response structure
    #   resp.data #=> Types::NoAuthOutput
    def no_auth(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::NoAuthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :no_auth),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::NoAuth,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :no_auth,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::OptionalAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::OptionalAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.optional_auth()
    # @example Response structure
    #   resp.data #=> Types::OptionalAuthOutput
    def optional_auth(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::OptionalAuthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :optional_auth),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::OptionalAuth,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :optional_auth,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::OrderedAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::OrderedAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.ordered_auth()
    # @example Response structure
    #   resp.data #=> Types::OrderedAuthOutput
    def ordered_auth(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::OrderedAuthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :ordered_auth),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::OrderedAuth,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :ordered_auth,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::PaginatorsTestOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::PaginatorsTestOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.paginators_test(
    #     next_token: 'nextToken'
    #   )
    # @example Response structure
    #   resp.data #=> Types::PaginatorsTestOperationOutput
    #   resp.data.next_token #=> String
    #   resp.data.items #=> Array<String>
    #   resp.data.items[0] #=> String
    def paginators_test(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::PaginatorsTestOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :paginators_test),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::PaginatorsTest,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :paginators_test,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::PaginatorsTestWithItemsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::PaginatorsTestWithItemsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.paginators_test_with_items(
    #     next_token: 'nextToken'
    #   )
    # @example Response structure
    #   resp.data #=> Types::PaginatorsTestWithItemsOutput
    #   resp.data.next_token #=> String
    #   resp.data.items #=> Array<String>
    #   resp.data.items[0] #=> String
    def paginators_test_with_items(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::PaginatorsTestWithItemsInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :paginators_test_with_items),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::PaginatorsTestWithItems,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :paginators_test_with_items,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::RequestCompressionOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::RequestCompressionOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.request_compression_operation(
    #     body: 'body'
    #   )
    # @example Response structure
    #   resp.data #=> Types::RequestCompressionOperationOutput
    def request_compression_operation(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::RequestCompressionOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Middleware::TestMiddleware,
        test_config: config.test_config
      )
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::RequestCompressionOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::RequestCompressionOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::HTTP::Middleware::RequestCompression,
        streaming: false,
        encodings: ['gzip'],
        request_min_compression_size_bytes: options.fetch(:request_min_compression_size_bytes, config.request_min_compression_size_bytes),
        disable_request_compression: options.fetch(:disable_request_compression, config.disable_request_compression)
      )
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :request_compression_operation),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::RequestCompressionOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::RequestCompressionOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :request_compression_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::RequestCompressionStreamingOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::RequestCompressionStreamingOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.request_compression_streaming_operation(
    #     body: 'body'
    #   )
    # @example Response structure
    #   resp.data #=> Types::RequestCompressionStreamingOperationOutput
    def request_compression_streaming_operation(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::RequestCompressionStreamingOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Middleware::TestMiddleware,
        test_config: config.test_config
      )
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::RequestCompressionStreamingOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::RequestCompressionStreamingOperation
      )
      stack.use(Hearth::HTTP::Middleware::RequestCompression,
        streaming: true,
        encodings: ['gzip'],
        request_min_compression_size_bytes: options.fetch(:request_min_compression_size_bytes, config.request_min_compression_size_bytes),
        disable_request_compression: options.fetch(:disable_request_compression, config.disable_request_compression)
      )
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :request_compression_streaming_operation),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::RequestCompressionStreamingOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::RequestCompressionStreamingOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :request_compression_streaming_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::StreamingOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::StreamingOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.streaming_operation(
    #     stream: 'stream'
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingOperationOutput
    #   resp.data.stream #=> String
    def streaming_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::StreamingOperationInput.build(params, context: 'params')
      response_body = output_stream(options, &block)
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Middleware::TestMiddleware,
        test_config: config.test_config
      )
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::StreamingOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::StreamingOperation
      )
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :streaming_operation),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::StreamingOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::StreamingOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :streaming_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::StreamingWithLengthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::StreamingWithLengthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.streaming_with_length(
    #     stream: 'stream'
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingWithLengthOutput
    def streaming_with_length(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::StreamingWithLengthInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :streaming_with_length),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::StreamingWithLength,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :streaming_with_length,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::WaitersTestInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::WaitersTestOutput]
    # @example Request syntax with placeholder values
    #   resp = client.waiters_test(
    #     status: 'Status'
    #   )
    # @example Response structure
    #   resp.data #=> Types::WaitersTestOutput
    #   resp.data.status #=> String
    def waiters_test(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::WaitersTestInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :waiters_test),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::WaitersTest,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :waiters_test,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::Struct____PaginatorsTestWithBadNamesInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::Struct____PaginatorsTestWithBadNamesOutput]
    # @example Request syntax with placeholder values
    #   resp = client.operation____paginators_test_with_bad_names(
    #     member___next_token: '__nextToken'
    #   )
    # @example Response structure
    #   resp.data #=> Types::Struct____PaginatorsTestWithBadNamesOutput
    #   resp.data.member___wrapper #=> Types::ResultWrapper
    #   resp.data.member___wrapper.member___123next_token #=> String
    #   resp.data.member___items #=> Array<String>
    #   resp.data.member___items[0] #=> String
    def operation____paginators_test_with_bad_names(params = {}, options = {})
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::Struct____PaginatorsTestWithBadNamesInput.build(params, context: 'params')
      response_body = ::StringIO.new
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
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :operation____paginators_test_with_bad_names),
        http_api_key_identity_resolver: options.fetch(:http_api_key_identity_resolver, config.http_api_key_identity_resolver),
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        http_bearer_identity_resolver: options.fetch(:http_bearer_identity_resolver, config.http_bearer_identity_resolver),
        http_login_identity_resolver: options.fetch(:http_login_identity_resolver, config.http_login_identity_resolver)
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
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::Operation____PaginatorsTestWithBadNames,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :operation____paginators_test_with_bad_names,
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
      config.interceptors.concat(client_interceptors)
      config.freeze
    end

    def operation_config(options)
      return @config unless options[:plugins] || options[:interceptors]

      config = @config.dup
      Hearth::PluginList.new(options[:plugins]).apply(config) if options[:plugins]
      config.interceptors.concat(Hearth::InterceptorList.new(options[:interceptors])) if options[:interceptors]
      config.freeze
    end

    def output_stream(options = {}, &block)
      return options[:output_stream] if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      ::StringIO.new
    end
  end
end
