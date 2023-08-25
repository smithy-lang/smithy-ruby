# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

require_relative 'middleware/request_id'

module RailsJson
  # An API client for RailsJson
  # See {#initialize} for a full list of supported configuration options

  class Client
    include Hearth::ClientStubs
    @plugins = Hearth::PluginList.new

    def self.plugins
      @plugins
    end

    # @param [Config] config
    #   An instance of {Config}
    def initialize(config = RailsJson::Config.new, options = {})
      @config = initialize_config(config)
      @stubs = Hearth::Stubs.new
    end

    # @return [Config] config
    attr_reader :config

    # This example uses all query string types.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::AllQueryStringTypesInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::AllQueryStringTypesOutput]
    # @example Request syntax with placeholder values
    #   resp = client.all_query_string_types(
    #     query_string: 'queryString',
    #     query_string_list: [
    #       'member'
    #     ],
    #     query_string_set: [
    #       'member'
    #     ],
    #     query_byte: 1,
    #     query_short: 1,
    #     query_integer: 1,
    #     query_integer_list: [
    #       1
    #     ],
    #     query_integer_set: [
    #       1
    #     ],
    #     query_long: 1,
    #     query_float: 1.0,
    #     query_double: 1.0,
    #     query_double_list: [
    #       1.0
    #     ],
    #     query_boolean: false,
    #     query_boolean_list: [
    #       false
    #     ],
    #     query_timestamp: Time.now,
    #     query_timestamp_list: [
    #       Time.now
    #     ],
    #     query_enum: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     query_enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     query_params_map_of_strings: {
    #       'key' => 'value'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::AllQueryStringTypesOutput
    def all_query_string_types(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::AllQueryStringTypesInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::AllQueryStringTypesInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::AllQueryStringTypes
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :all_query_string_types)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::AllQueryStringTypes
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::AllQueryStringTypes,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :all_query_string_types,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example uses fixed query string params and variable query string params.
    # The fixed query string parameters and variable parameters must both be
    # serialized (implementations may need to merge them together).
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::ConstantAndVariableQueryStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::ConstantAndVariableQueryStringOutput]
    # @example Request syntax with placeholder values
    #   resp = client.constant_and_variable_query_string(
    #     baz: 'baz',
    #     maybe_set: 'maybeSet'
    #   )
    # @example Response structure
    #   resp.data #=> Types::ConstantAndVariableQueryStringOutput
    def constant_and_variable_query_string(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::ConstantAndVariableQueryStringInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ConstantAndVariableQueryStringInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ConstantAndVariableQueryString
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :constant_and_variable_query_string)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::ConstantAndVariableQueryString
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::ConstantAndVariableQueryString,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :constant_and_variable_query_string,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example uses a constant query string parameters and a label.
    # This simply tests that labels and query string parameters are
    # compatible. The fixed query string parameter named "hello" should
    # in no way conflict with the label, `{hello}`.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::ConstantQueryStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::ConstantQueryStringOutput]
    # @example Request syntax with placeholder values
    #   resp = client.constant_query_string(
    #     hello: 'hello' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::ConstantQueryStringOutput
    def constant_query_string(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::ConstantQueryStringInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::ConstantQueryStringInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::ConstantQueryString
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :constant_query_string)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::ConstantQueryString
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::ConstantQueryString,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :constant_query_string,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example serializes a document as part of the payload.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::DocumentTypeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::DocumentTypeOutput]
    # @example Request syntax with placeholder values
    #   resp = client.document_type(
    #     string_value: 'stringValue',
    #     document_value: {
    #       'nil' => nil,
    #       'number' => 123.0,
    #       'string' => 'value',
    #       'boolean' => true,
    #       'array' => [],
    #       'map' => {}
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::DocumentTypeOutput
    #   resp.data.string_value #=> String
    #   resp.data.document_value #=> Hash,Array,String,Boolean,Numeric
    def document_type(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::DocumentTypeInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::DocumentTypeInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::DocumentType
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :document_type)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::DocumentType
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::DocumentType,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :document_type,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example serializes a document as the entire HTTP payload.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::DocumentTypeAsPayloadInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::DocumentTypeAsPayloadOutput]
    # @example Request syntax with placeholder values
    #   resp = client.document_type_as_payload(
    #     document_value: {
    #       'nil' => nil,
    #       'number' => 123.0,
    #       'string' => 'value',
    #       'boolean' => true,
    #       'array' => [],
    #       'map' => {}
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::DocumentTypeAsPayloadOutput
    #   resp.data.document_value #=> Hash,Array,String,Boolean,Numeric
    def document_type_as_payload(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::DocumentTypeAsPayloadInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::DocumentTypeAsPayloadInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::DocumentTypeAsPayload
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :document_type_as_payload)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::DocumentTypeAsPayload
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::DocumentTypeAsPayload,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :document_type_as_payload,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::EmptyOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::EmptyOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.empty_operation()
    # @example Response structure
    #   resp.data #=> Types::EmptyOperationOutput
    def empty_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::EmptyOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::EmptyOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::EmptyOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :empty_operation)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::EmptyOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::EmptyOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :empty_operation,
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
    def endpoint_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::EndpointOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
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
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :endpoint_operation)
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
      stack.use(Middleware::RequestId)
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
    def endpoint_with_host_label_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::EndpointWithHostLabelOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
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
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :endpoint_with_host_label_operation)
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
      stack.use(Middleware::RequestId)
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

    # This operation has three possible return values:
    #
    # 1. A successful response in the form of GreetingWithErrorsOutput
    # 2. An InvalidGreeting error.
    # 3. A ComplexError error.
    #
    # Implementations must be able to successfully take a response and
    # properly deserialize successful and error responses.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::GreetingWithErrorsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::GreetingWithErrorsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.greeting_with_errors()
    # @example Response structure
    #   resp.data #=> Types::GreetingWithErrorsOutput
    #   resp.data.greeting #=> String
    def greeting_with_errors(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::GreetingWithErrorsInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::GreetingWithErrorsInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::GreetingWithErrors
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :greeting_with_errors)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: [Errors::InvalidGreeting, Errors::ComplexError]
        ),
        data_parser: Parsers::GreetingWithErrors
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [Stubs::InvalidGreeting, Stubs::ComplexError],
        stub_data_class: Stubs::GreetingWithErrors,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :greeting_with_errors,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples serializes a blob shape in the payload.
    #
    # In this example, no JSON document is synthesized because the payload is
    # not a structure or a union type.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpPayloadTraitsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpPayloadTraitsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_payload_traits(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpPayloadTraitsOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> String
    def http_payload_traits(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPayloadTraitsInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPayloadTraitsInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPayloadTraits
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_payload_traits)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpPayloadTraits
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpPayloadTraits,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_payload_traits,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples uses a `@mediaType` trait on the payload to force a custom
    # content-type to be serialized.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpPayloadTraitsWithMediaTypeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpPayloadTraitsWithMediaTypeOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_payload_traits_with_media_type(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpPayloadTraitsWithMediaTypeOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> String
    def http_payload_traits_with_media_type(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPayloadTraitsWithMediaTypeInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPayloadTraitsWithMediaTypeInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPayloadTraitsWithMediaType
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_payload_traits_with_media_type)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpPayloadTraitsWithMediaType
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpPayloadTraitsWithMediaType,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_payload_traits_with_media_type,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples serializes a structure in the payload.
    #
    # Note that serializing a structure changes the wrapper element name
    # to match the targeted structure.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpPayloadWithStructureInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpPayloadWithStructureOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_payload_with_structure(
    #     nested: {
    #       greeting: 'greeting',
    #       name: 'name'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpPayloadWithStructureOutput
    #   resp.data.nested #=> Types::NestedPayload
    #   resp.data.nested.greeting #=> String
    #   resp.data.nested.name #=> String
    def http_payload_with_structure(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPayloadWithStructureInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPayloadWithStructureInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPayloadWithStructure
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_payload_with_structure)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpPayloadWithStructure
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpPayloadWithStructure,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_payload_with_structure,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This examples adds headers to the input of a request and response by prefix.
    # @see https://awslabs.github.io/smithy/1.0/spec/http.html#httpprefixheaders-trait httpPrefixHeaders Trait
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpPrefixHeadersInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpPrefixHeadersOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_prefix_headers(
    #     foo: 'foo',
    #     foo_map: {
    #       'key' => 'value'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpPrefixHeadersOutput
    #   resp.data.foo #=> String
    #   resp.data.foo_map #=> Hash<String, String>
    #   resp.data.foo_map['key'] #=> String
    def http_prefix_headers(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPrefixHeadersInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPrefixHeadersInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPrefixHeaders
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_prefix_headers)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpPrefixHeaders
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpPrefixHeaders,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_prefix_headers,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Clients that perform this test extract all headers from the response.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpPrefixHeadersInResponseInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpPrefixHeadersInResponseOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_prefix_headers_in_response()
    # @example Response structure
    #   resp.data #=> Types::HttpPrefixHeadersInResponseOutput
    #   resp.data.prefix_headers #=> Hash<String, String>
    #   resp.data.prefix_headers['key'] #=> String
    def http_prefix_headers_in_response(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpPrefixHeadersInResponseInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpPrefixHeadersInResponseInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpPrefixHeadersInResponse
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_prefix_headers_in_response)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpPrefixHeadersInResponse
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpPrefixHeadersInResponse,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_prefix_headers_in_response,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithFloatLabelsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpRequestWithFloatLabelsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_request_with_float_labels(
    #     float: 1.0, # required
    #     double: 1.0 # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpRequestWithFloatLabelsOutput
    def http_request_with_float_labels(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithFloatLabelsInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithFloatLabelsInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithFloatLabels
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_request_with_float_labels)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpRequestWithFloatLabels
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpRequestWithFloatLabels,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_request_with_float_labels,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithGreedyLabelInPathInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpRequestWithGreedyLabelInPathOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_request_with_greedy_label_in_path(
    #     foo: 'foo', # required
    #     baz: 'baz' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpRequestWithGreedyLabelInPathOutput
    def http_request_with_greedy_label_in_path(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithGreedyLabelInPathInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithGreedyLabelInPathInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithGreedyLabelInPath
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_request_with_greedy_label_in_path)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpRequestWithGreedyLabelInPath
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpRequestWithGreedyLabelInPath,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_request_with_greedy_label_in_path,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests how requests are serialized when there's no input
    # payload but there are HTTP labels.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithLabelsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpRequestWithLabelsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_request_with_labels(
    #     string: 'string', # required
    #     short: 1, # required
    #     integer: 1, # required
    #     long: 1, # required
    #     float: 1.0, # required
    #     double: 1.0, # required
    #     boolean: false, # required
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpRequestWithLabelsOutput
    def http_request_with_labels(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithLabelsInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithLabelsInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithLabels
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_request_with_labels)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpRequestWithLabels
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpRequestWithLabels,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_request_with_labels,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests how requests serialize different timestamp formats in the
    # URI path.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithLabelsAndTimestampFormatInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpRequestWithLabelsAndTimestampFormatOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_request_with_labels_and_timestamp_format(
    #     member_epoch_seconds: Time.now, # required
    #     member_http_date: Time.now, # required
    #     member_date_time: Time.now, # required
    #     default_format: Time.now, # required
    #     target_epoch_seconds: Time.now, # required
    #     target_http_date: Time.now, # required
    #     target_date_time: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpRequestWithLabelsAndTimestampFormatOutput
    def http_request_with_labels_and_timestamp_format(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpRequestWithLabelsAndTimestampFormatInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpRequestWithLabelsAndTimestampFormatInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpRequestWithLabelsAndTimestampFormat
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_request_with_labels_and_timestamp_format)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpRequestWithLabelsAndTimestampFormat
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpRequestWithLabelsAndTimestampFormat,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_request_with_labels_and_timestamp_format,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::HttpResponseCodeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::HttpResponseCodeOutput]
    # @example Request syntax with placeholder values
    #   resp = client.http_response_code()
    # @example Response structure
    #   resp.data #=> Types::HttpResponseCodeOutput
    #   resp.data.status #=> Integer
    def http_response_code(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::HttpResponseCodeInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::HttpResponseCodeInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::HttpResponseCode
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :http_response_code)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::HttpResponseCode
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::HttpResponseCode,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :http_response_code,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example ensures that query string bound request parameters are
    # serialized in the body of responses if the structure is used in both
    # the request and response.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::IgnoreQueryParamsInResponseInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::IgnoreQueryParamsInResponseOutput]
    # @example Request syntax with placeholder values
    #   resp = client.ignore_query_params_in_response()
    # @example Response structure
    #   resp.data #=> Types::IgnoreQueryParamsInResponseOutput
    #   resp.data.baz #=> String
    def ignore_query_params_in_response(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::IgnoreQueryParamsInResponseInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::IgnoreQueryParamsInResponseInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::IgnoreQueryParamsInResponse
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :ignore_query_params_in_response)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::IgnoreQueryParamsInResponse
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::IgnoreQueryParamsInResponse,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :ignore_query_params_in_response,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests how requests and responses are serialized when there is
    # no input or output payload but there are HTTP header bindings.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::InputAndOutputWithHeadersInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::InputAndOutputWithHeadersOutput]
    # @example Request syntax with placeholder values
    #   resp = client.input_and_output_with_headers(
    #     header_string: 'headerString',
    #     header_byte: 1,
    #     header_short: 1,
    #     header_integer: 1,
    #     header_long: 1,
    #     header_float: 1.0,
    #     header_double: 1.0,
    #     header_true_bool: false,
    #     header_false_bool: false,
    #     header_string_list: [
    #       'member'
    #     ],
    #     header_string_set: [
    #       'member'
    #     ],
    #     header_integer_list: [
    #       1
    #     ],
    #     header_boolean_list: [
    #       false
    #     ],
    #     header_timestamp_list: [
    #       Time.now
    #     ],
    #     header_enum: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     header_enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::InputAndOutputWithHeadersOutput
    #   resp.data.header_string #=> String
    #   resp.data.header_byte #=> Integer
    #   resp.data.header_short #=> Integer
    #   resp.data.header_integer #=> Integer
    #   resp.data.header_long #=> Integer
    #   resp.data.header_float #=> Float
    #   resp.data.header_double #=> Float
    #   resp.data.header_true_bool #=> Boolean
    #   resp.data.header_false_bool #=> Boolean
    #   resp.data.header_string_list #=> Array<String>
    #   resp.data.header_string_list[0] #=> String
    #   resp.data.header_string_set #=> Array<String>
    #   resp.data.header_string_set[0] #=> String
    #   resp.data.header_integer_list #=> Array<Integer>
    #   resp.data.header_integer_list[0] #=> Integer
    #   resp.data.header_boolean_list #=> Array<Boolean>
    #   resp.data.header_boolean_list[0] #=> Boolean
    #   resp.data.header_timestamp_list #=> Array<Time>
    #   resp.data.header_timestamp_list[0] #=> Time
    #   resp.data.header_enum #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.header_enum_list #=> Array<String>
    #   resp.data.header_enum_list[0] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    def input_and_output_with_headers(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::InputAndOutputWithHeadersInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::InputAndOutputWithHeadersInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::InputAndOutputWithHeaders
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :input_and_output_with_headers)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::InputAndOutputWithHeaders
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::InputAndOutputWithHeaders,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :input_and_output_with_headers,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example serializes enums as top level properties, in lists, sets, and maps.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::JsonEnumsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::JsonEnumsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.json_enums(
    #     foo_enum1: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     foo_enum2: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     foo_enum3: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     foo_enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     foo_enum_set: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     foo_enum_map: {
    #       'key' => 'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonEnumsOutput
    #   resp.data.foo_enum1 #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum2 #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum3 #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum_list #=> Array<String>
    #   resp.data.foo_enum_list[0] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum_set #=> Array<String>
    #   resp.data.foo_enum_set[0] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.foo_enum_map #=> Hash<String, String>
    #   resp.data.foo_enum_map['key'] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    def json_enums(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::JsonEnumsInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::JsonEnumsInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::JsonEnums
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :json_enums)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::JsonEnums
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::JsonEnums,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :json_enums,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # The example tests basic map serialization.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::JsonMapsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::JsonMapsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.json_maps(
    #     dense_struct_map: {
    #       'key' => {
    #         hi: 'hi'
    #       }
    #     },
    #     dense_number_map: {
    #       'key' => 1
    #     },
    #     dense_boolean_map: {
    #       'key' => false
    #     },
    #     dense_string_map: {
    #       'key' => 'value'
    #     },
    #     sparse_number_map: {
    #       'key' => 1
    #     },
    #     sparse_boolean_map: {
    #       'key' => false
    #     },
    #     sparse_string_map: {
    #       'key' => 'value'
    #     },
    #     dense_set_map: {
    #       'key' => [
    #         'member'
    #       ]
    #     },
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonMapsOutput
    #   resp.data.dense_struct_map #=> Hash<String, GreetingStruct>
    #   resp.data.dense_struct_map['key'] #=> Types::GreetingStruct
    #   resp.data.dense_struct_map['key'].hi #=> String
    #   resp.data.sparse_struct_map #=> Hash<String, GreetingStruct>
    #   resp.data.dense_number_map #=> Hash<String, Integer>
    #   resp.data.dense_number_map['key'] #=> Integer
    #   resp.data.dense_boolean_map #=> Hash<String, Boolean>
    #   resp.data.dense_boolean_map['key'] #=> Boolean
    #   resp.data.dense_string_map #=> Hash<String, String>
    #   resp.data.dense_string_map['key'] #=> String
    #   resp.data.sparse_number_map #=> Hash<String, Integer>
    #   resp.data.sparse_number_map['key'] #=> Integer
    #   resp.data.sparse_boolean_map #=> Hash<String, Boolean>
    #   resp.data.sparse_boolean_map['key'] #=> Boolean
    #   resp.data.sparse_string_map #=> Hash<String, String>
    #   resp.data.sparse_string_map['key'] #=> String
    #   resp.data.dense_set_map #=> Hash<String, Array<String>>
    #   resp.data.dense_set_map['key'] #=> Array<String>
    #   resp.data.dense_set_map['key'][0] #=> String
    #   resp.data.sparse_set_map #=> Hash<String, Array<String>>
    def json_maps(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::JsonMapsInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::JsonMapsInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::JsonMaps
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :json_maps)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::JsonMaps
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::JsonMaps,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :json_maps,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This operation uses unions for inputs and outputs.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::JsonUnionsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::JsonUnionsOutput]
    # @example Request syntax with placeholder values
    #   resp = client.json_unions(
    #     contents: {
    #       # One of:
    #       string_value: 'stringValue',
    #       boolean_value: false,
    #       number_value: 1,
    #       blob_value: 'blobValue',
    #       timestamp_value: Time.now,
    #       enum_value: 'Foo', # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #       list_value: [
    #         'member'
    #       ],
    #       map_value: {
    #         'key' => 'value'
    #       },
    #       structure_value: {
    #         hi: 'hi'
    #       },
    #       renamed_structure_value: {
    #         salutation: 'salutation'
    #       }
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonUnionsOutput
    #   resp.data.contents #=> Types::MyUnion, one of [StringValue, BooleanValue, NumberValue, BlobValue, TimestampValue, EnumValue, ListValue, MapValue, StructureValue, RenamedStructureValue]
    #   resp.data.contents.string_value #=> String
    #   resp.data.contents.boolean_value #=> Boolean
    #   resp.data.contents.number_value #=> Integer
    #   resp.data.contents.blob_value #=> String
    #   resp.data.contents.timestamp_value #=> Time
    #   resp.data.contents.enum_value #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.contents.list_value #=> Array<String>
    #   resp.data.contents.list_value[0] #=> String
    #   resp.data.contents.map_value #=> Hash<String, String>
    #   resp.data.contents.map_value['key'] #=> String
    #   resp.data.contents.structure_value #=> Types::GreetingStruct
    #   resp.data.contents.structure_value.hi #=> String
    #   resp.data.contents.renamed_structure_value #=> Types::RenamedGreeting
    #   resp.data.contents.renamed_structure_value.salutation #=> String
    def json_unions(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::JsonUnionsInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::JsonUnionsInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::JsonUnions
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :json_unions)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::JsonUnions
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::JsonUnions,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :json_unions,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::KitchenSinkOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::KitchenSinkOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.kitchen_sink_operation(
    #     blob: 'Blob',
    #     boolean: false,
    #     double: 1.0,
    #     empty_struct: { },
    #     float: 1.0,
    #     httpdate_timestamp: Time.now,
    #     integer: 1,
    #     iso8601_timestamp: Time.now,
    #     json_value: 'JsonValue',
    #     list_of_lists: [
    #       [
    #         'member'
    #       ]
    #     ],
    #     list_of_maps_of_strings: [
    #       {
    #         'key' => 'value'
    #       }
    #     ],
    #     list_of_structs: [
    #       {
    #         value: 'Value'
    #       }
    #     ],
    #     long: 1,
    #     recursive_list: [
    #       {
    #         blob: 'Blob',
    #         boolean: false,
    #         double: 1.0,
    #         float: 1.0,
    #         httpdate_timestamp: Time.now,
    #         integer: 1,
    #         iso8601_timestamp: Time.now,
    #         json_value: 'JsonValue',
    #         long: 1,
    #         string: 'String',
    #         struct_with_location_name: {
    #           value: 'Value'
    #         },
    #         timestamp: Time.now,
    #         unix_timestamp: Time.now
    #       }
    #     ],
    #     string: 'String',
    #     timestamp: Time.now,
    #     unix_timestamp: Time.now
    #   )
    # @example Response structure
    #   resp.data #=> Types::KitchenSinkOperationOutput
    #   resp.data.blob #=> String
    #   resp.data.boolean #=> Boolean
    #   resp.data.double #=> Float
    #   resp.data.empty_struct #=> Types::EmptyStruct
    #   resp.data.float #=> Float
    #   resp.data.httpdate_timestamp #=> Time
    #   resp.data.integer #=> Integer
    #   resp.data.iso8601_timestamp #=> Time
    #   resp.data.json_value #=> String
    #   resp.data.list_of_lists #=> Array<Array<String>>
    #   resp.data.list_of_lists[0] #=> Array<String>
    #   resp.data.list_of_lists[0][0] #=> String
    #   resp.data.list_of_maps_of_strings #=> Array<Hash<String, String>>
    #   resp.data.list_of_maps_of_strings[0] #=> Hash<String, String>
    #   resp.data.list_of_maps_of_strings[0]['key'] #=> String
    #   resp.data.list_of_strings #=> Array<String>
    #   resp.data.list_of_structs #=> Array<SimpleStruct>
    #   resp.data.list_of_structs[0] #=> Types::SimpleStruct
    #   resp.data.list_of_structs[0].value #=> String
    #   resp.data.long #=> Integer
    #   resp.data.map_of_lists_of_strings #=> Hash<String, Array<String>>
    #   resp.data.map_of_maps #=> Hash<String, Hash<String, String>>
    #   resp.data.map_of_strings #=> Hash<String, String>
    #   resp.data.map_of_structs #=> Hash<String, SimpleStruct>
    #   resp.data.recursive_list #=> Array<KitchenSink>
    #   resp.data.recursive_list[0] #=> Types::KitchenSink
    #   resp.data.recursive_list[0].blob #=> String
    #   resp.data.recursive_list[0].boolean #=> Boolean
    #   resp.data.recursive_list[0].double #=> Float
    #   resp.data.recursive_list[0].empty_struct #=> Types::EmptyStruct
    #   resp.data.recursive_list[0].float #=> Float
    #   resp.data.recursive_list[0].httpdate_timestamp #=> Time
    #   resp.data.recursive_list[0].integer #=> Integer
    #   resp.data.recursive_list[0].iso8601_timestamp #=> Time
    #   resp.data.recursive_list[0].json_value #=> String
    #   resp.data.recursive_list[0].list_of_lists #=> Array<Array<String>>
    #   resp.data.recursive_list[0].list_of_maps_of_strings #=> Array<Hash<String, String>>
    #   resp.data.recursive_list[0].list_of_strings #=> Array<String>
    #   resp.data.recursive_list[0].list_of_structs #=> Array<SimpleStruct>
    #   resp.data.recursive_list[0].long #=> Integer
    #   resp.data.recursive_list[0].map_of_lists_of_strings #=> Hash<String, Array<String>>
    #   resp.data.recursive_list[0].map_of_maps #=> Hash<String, Hash<String, String>>
    #   resp.data.recursive_list[0].map_of_strings #=> Hash<String, String>
    #   resp.data.recursive_list[0].map_of_structs #=> Hash<String, SimpleStruct>
    #   resp.data.recursive_list[0].recursive_list #=> Array<KitchenSink>
    #   resp.data.recursive_list[0].recursive_map #=> Hash<String, KitchenSink>
    #   resp.data.recursive_list[0].recursive_struct #=> Types::KitchenSink
    #   resp.data.recursive_list[0].simple_struct #=> Types::SimpleStruct
    #   resp.data.recursive_list[0].string #=> String
    #   resp.data.recursive_list[0].struct_with_location_name #=> Types::StructWithLocationName
    #   resp.data.recursive_list[0].struct_with_location_name.value #=> String
    #   resp.data.recursive_list[0].timestamp #=> Time
    #   resp.data.recursive_list[0].unix_timestamp #=> Time
    #   resp.data.recursive_map #=> Hash<String, KitchenSink>
    #   resp.data.recursive_struct #=> Types::KitchenSink
    #   resp.data.simple_struct #=> Types::SimpleStruct
    #   resp.data.string #=> String
    #   resp.data.struct_with_location_name #=> Types::StructWithLocationName
    #   resp.data.timestamp #=> Time
    #   resp.data.unix_timestamp #=> Time
    def kitchen_sink_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::KitchenSinkOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::KitchenSinkOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::KitchenSinkOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :kitchen_sink_operation)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: [Errors::ErrorWithMembers, Errors::ErrorWithoutMembers]
        ),
        data_parser: Parsers::KitchenSinkOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [Stubs::ErrorWithMembers, Stubs::ErrorWithoutMembers],
        stub_data_class: Stubs::KitchenSinkOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :kitchen_sink_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # This example ensures that mediaType strings are base64 encoded in headers.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::MediaTypeHeaderInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::MediaTypeHeaderOutput]
    # @example Request syntax with placeholder values
    #   resp = client.media_type_header(
    #     json: 'json'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MediaTypeHeaderOutput
    #   resp.data.json #=> String
    def media_type_header(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::MediaTypeHeaderInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::MediaTypeHeaderInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::MediaTypeHeader
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :media_type_header)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::MediaTypeHeader
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::MediaTypeHeader,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :media_type_header,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::NestedAttributesOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::NestedAttributesOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.nested_attributes_operation(
    #     simple_struct: {
    #       value: 'Value'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::NestedAttributesOperationOutput
    #   resp.data.value #=> String
    def nested_attributes_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::NestedAttributesOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::NestedAttributesOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::NestedAttributesOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :nested_attributes_operation)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::NestedAttributesOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::NestedAttributesOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :nested_attributes_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Null and empty headers are not sent over the wire.
    # Tags: ["client-only"]
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::NullAndEmptyHeadersClientInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::NullAndEmptyHeadersClientOutput]
    # @example Request syntax with placeholder values
    #   resp = client.null_and_empty_headers_client(
    #     a: 'a',
    #     b: 'b',
    #     c: [
    #       'member'
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::NullAndEmptyHeadersClientOutput
    #   resp.data.a #=> String
    #   resp.data.b #=> String
    #   resp.data.c #=> Array<String>
    #   resp.data.c[0] #=> String
    def null_and_empty_headers_client(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::NullAndEmptyHeadersClientInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::NullAndEmptyHeadersClientInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::NullAndEmptyHeadersClient
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :null_and_empty_headers_client)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::NullAndEmptyHeadersClient
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::NullAndEmptyHeadersClient,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :null_and_empty_headers_client,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::NullOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::NullOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.null_operation(
    #     string: 'string',
    #     sparse_string_list: [
    #       'member'
    #     ],
    #     sparse_string_map: {
    #       'key' => 'value'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::NullOperationOutput
    #   resp.data.string #=> String
    #   resp.data.sparse_string_list #=> Array<String>
    #   resp.data.sparse_string_list[0] #=> String
    #   resp.data.sparse_string_map #=> Hash<String, String>
    #   resp.data.sparse_string_map['key'] #=> String
    def null_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::NullOperationInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::NullOperationInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::NullOperation
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :null_operation)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::NullOperation
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::NullOperation,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :null_operation,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Omits null, but serializes empty string value.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::OmitsNullSerializesEmptyStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::OmitsNullSerializesEmptyStringOutput]
    # @example Request syntax with placeholder values
    #   resp = client.omits_null_serializes_empty_string(
    #     null_value: 'nullValue',
    #     empty_string: 'emptyString'
    #   )
    # @example Response structure
    #   resp.data #=> Types::OmitsNullSerializesEmptyStringOutput
    def omits_null_serializes_empty_string(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::OmitsNullSerializesEmptyStringInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::OmitsNullSerializesEmptyStringInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::OmitsNullSerializesEmptyString
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :omits_null_serializes_empty_string)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::OmitsNullSerializesEmptyString
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::OmitsNullSerializesEmptyString,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :omits_null_serializes_empty_string,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::OperationWithOptionalInputOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::OperationWithOptionalInputOutputOutput]
    # @example Request syntax with placeholder values
    #   resp = client.operation_with_optional_input_output(
    #     value: 'Value'
    #   )
    # @example Response structure
    #   resp.data #=> Types::OperationWithOptionalInputOutputOutput
    #   resp.data.value #=> String
    def operation_with_optional_input_output(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::OperationWithOptionalInputOutputInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::OperationWithOptionalInputOutputInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::OperationWithOptionalInputOutput
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :operation_with_optional_input_output)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::OperationWithOptionalInputOutput
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::OperationWithOptionalInputOutput,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :operation_with_optional_input_output,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # Automatically adds idempotency tokens.
    # Tags: ["client-only"]
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::QueryIdempotencyTokenAutoFillInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::QueryIdempotencyTokenAutoFillOutput]
    # @example Request syntax with placeholder values
    #   resp = client.query_idempotency_token_auto_fill(
    #     token: 'token'
    #   )
    # @example Response structure
    #   resp.data #=> Types::QueryIdempotencyTokenAutoFillOutput
    def query_idempotency_token_auto_fill(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::QueryIdempotencyTokenAutoFillInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::QueryIdempotencyTokenAutoFillInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::QueryIdempotencyTokenAutoFill
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :query_idempotency_token_auto_fill)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::QueryIdempotencyTokenAutoFill
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::QueryIdempotencyTokenAutoFill,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :query_idempotency_token_auto_fill,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::QueryParamsAsStringListMapInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::QueryParamsAsStringListMapOutput]
    # @example Request syntax with placeholder values
    #   resp = client.query_params_as_string_list_map(
    #     qux: 'qux',
    #     foo: {
    #       'key' => [
    #         'member'
    #       ]
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::QueryParamsAsStringListMapOutput
    def query_params_as_string_list_map(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::QueryParamsAsStringListMapInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::QueryParamsAsStringListMapInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::QueryParamsAsStringListMap
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :query_params_as_string_list_map)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::QueryParamsAsStringListMap
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::QueryParamsAsStringListMap,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :query_params_as_string_list_map,
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
    #     output: 'output'
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingOperationOutput
    #   resp.data.output #=> String
    def streaming_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::StreamingOperationInput.build(params, context: 'params')
      response_body = output_stream(options, &block)
      stack.use(Hearth::Middleware::Initialize)
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
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :streaming_operation)
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
      stack.use(Middleware::RequestId)
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

    # This example tests how timestamp request and response headers are serialized.
    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::TimestampFormatHeadersInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::TimestampFormatHeadersOutput]
    # @example Request syntax with placeholder values
    #   resp = client.timestamp_format_headers(
    #     member_epoch_seconds: Time.now,
    #     member_http_date: Time.now,
    #     member_date_time: Time.now,
    #     default_format: Time.now,
    #     target_epoch_seconds: Time.now,
    #     target_http_date: Time.now,
    #     target_date_time: Time.now
    #   )
    # @example Response structure
    #   resp.data #=> Types::TimestampFormatHeadersOutput
    #   resp.data.member_epoch_seconds #=> Time
    #   resp.data.member_http_date #=> Time
    #   resp.data.member_date_time #=> Time
    #   resp.data.default_format #=> Time
    #   resp.data.target_epoch_seconds #=> Time
    #   resp.data.target_http_date #=> Time
    #   resp.data.target_date_time #=> Time
    def timestamp_format_headers(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::TimestampFormatHeadersInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::TimestampFormatHeadersInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::TimestampFormatHeaders
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :timestamp_format_headers)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::TimestampFormatHeaders
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::TimestampFormatHeaders,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :timestamp_format_headers,
          interceptors: config.interceptors
        )
      )
      raise resp.error if resp.error
      resp
    end

    # @param [Hash] params
    #   Request parameters for this operation.
    #   See {Types::Struct____789BadNameInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::Struct____789BadNameOutput]
    # @example Request syntax with placeholder values
    #   resp = client.operation____789_bad_name(
    #     member___123abc: '__123abc', # required
    #     member: {
    #       member___123foo: '__123foo'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::Struct____789BadNameOutput
    #   resp.data.member #=> Types::Struct____456efg
    #   resp.data.member.member___123foo #=> String
    def operation____789_bad_name(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::Struct____789BadNameInput.build(params, context: 'params')
      response_body = ::StringIO.new
      stack.use(Hearth::Middleware::Initialize)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::Struct____789BadNameInput,
        validate_input: config.validate_input
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::Operation____789BadName
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Auth,
        auth_resolver: options.fetch(:auth_resolver, config.auth_resolver),
        auth_schemes: options.fetch(:auth_schemes, config.auth_schemes),
        auth_params: Auth::Params.new(operation_name: :operation____789_bad_name)
      )
      stack.use(Hearth::Middleware::Sign)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(
          error_module: Errors,
          success_status: 200,
          errors: []
        ),
        data_parser: Parsers::Operation____789BadName
      )
      stack.use(Middleware::RequestId)
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_error_classes: [],
        stub_data_class: Stubs::Operation____789BadName,
        stubs: @stubs
      )
      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(uri: URI(options.fetch(:endpoint, config.endpoint))),
          response: Hearth::HTTP::Response.new(body: response_body),
          params: params,
          logger: config.logger,
          operation_name: :operation____789_bad_name,
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
      config.interceptors << client_interceptors
      config.freeze
    end

    def operation_config(options)
      return @config unless options[:plugins] || options[:interceptors]

      config = @config.dup
      Hearth::PluginList.new(options[:plugins]).apply(config) if options[:plugins]
      config.interceptors << options[:interceptors] if options[:interceptors]
      config.freeze
    end

    def output_stream(options = {}, &block)
      return options[:output_stream] if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      ::StringIO.new
    end
  end
end
