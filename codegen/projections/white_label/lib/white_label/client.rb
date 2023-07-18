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
  #
  # @deprecated
  #   This test SDK is not suitable
  #   for production use.
  #   Since: today
  #
  # @note
  #   This shape is unstable and may change in the future.
  #
  # @see https://www.ruby-lang.org/en/ Homepage
  #
  # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
  #
  # @note
  #   This shape is meant for internal use only.
  #
  # @since today
  #
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
    #
    def initialize(config = WhiteLabel::Config.new, options = {})
      @config = initialize_config(config)
      @stubs = Hearth::Stubbing::Stubs.new
    end

    # @return [Config] config
    attr_reader :config

    # @param [Hash] params
    #   See {Types::DefaultsTestInput}.
    #
    # @option params [Struct] :struct
    #   This docstring should be different than KitchenSink struct member.
    #
    # @return [Types::DefaultsTestOutput]
    #
    # @example Request syntax with placeholder values
    #
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
    #
    # @example Response structure
    #
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
    #   resp.data.null_document #=> Hash,Array,String,Boolean,Numeric
    #   resp.data.string_document #=> Hash,Array,String,Boolean,Numeric
    #   resp.data.boolean_document #=> Hash,Array,String,Boolean,Numeric
    #   resp.data.numbers_document #=> Hash,Array,String,Boolean,Numeric
    #   resp.data.list_document #=> Hash,Array,String,Boolean,Numeric
    #   resp.data.map_document #=> Hash,Array,String,Boolean,Numeric
    #   resp.data.list_of_strings #=> Array<String>
    #   resp.data.list_of_strings[0] #=> String
    #   resp.data.map_of_strings #=> Hash<String, String>
    #   resp.data.map_of_strings['key'] #=> String
    #   resp.data.iso8601_timestamp #=> Time
    #   resp.data.epoch_timestamp #=> Time
    #
    def defaults_test(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::DefaultsTest
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::DefaultsTest,
        stubs: @stubs,
        params_class: Params::DefaultsTestOutput
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
    #   See {Types::EndpointOperationInput}.
    #
    # @return [Types::EndpointOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.endpoint_operation()
    #
    # @example Response structure
    #
    #   resp.data #=> Types::EndpointOperationOutput
    #
    def endpoint_operation(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::EndpointOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::EndpointOperation,
        stubs: @stubs,
        params_class: Params::EndpointOperationOutput
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
    #   See {Types::EndpointWithHostLabelOperationInput}.
    #
    # @return [Types::EndpointWithHostLabelOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.endpoint_with_host_label_operation(
    #     label_member: 'labelMember' # required
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::EndpointWithHostLabelOperationOutput
    #
    def endpoint_with_host_label_operation(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::EndpointWithHostLabelOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::EndpointWithHostLabelOperation,
        stubs: @stubs,
        params_class: Params::EndpointWithHostLabelOperationOutput
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

    # The kitchen sink operation.
    # It is kinda useless.
    #
    # @deprecated
    #   This operation is not suitable
    #   for production use.
    #   Since: today
    #
    # @note
    #   This shape is unstable and may change in the future.
    #
    # @see https://www.ruby-lang.org/en/ Homepage
    #
    # @see https://www.ruby-lang.org/en/downloads/branches/ Ruby Branches
    #
    # @note
    #   This shape is meant for internal use only.
    #
    # @since today
    #
    # @param [Hash] params
    #   See {Types::KitchenSinkInput}.
    #
    # @option params [String] :string
    #   This is some member
    #   documentation of String.
    #
    # @option params [Struct] :struct
    #   This is some member documentation of Struct.
    #   It should override Struct's documentation.
    #
    # @option params [Union] :union
    #   This is some union documentation.
    #   It has some union members
    #
    # @return [Types::KitchenSinkOutput]
    #
    # @example Request syntax with placeholder values
    #
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
    #
    # @example Response structure
    #
    #   resp.data #=> Types::KitchenSinkOutput
    #   resp.data.string #=> String
    #   resp.data.simple_enum #=> String, one of ["YES", "NO", "MAYBE"]
    #   resp.data.typed_enum #=> String, one of ["YES", "NO", "MAYBE"]
    #   resp.data.struct #=> Types::Struct
    #   resp.data.struct.value #=> String
    #   resp.data.document #=> Hash,Array,String,Boolean,Numeric
    #   resp.data.list_of_strings #=> Array<String>
    #   resp.data.list_of_strings[0] #=> String
    #   resp.data.list_of_structs #=> Array<Struct>
    #   resp.data.map_of_strings #=> Hash<String, String>
    #   resp.data.map_of_strings['key'] #=> String
    #   resp.data.map_of_structs #=> Hash<String, Struct>
    #   resp.data.union #=> Types::Union, one of [String, Struct]
    #   resp.data.union.string #=> String
    #   resp.data.union.struct #=> Types::Struct
    #
    # @example Test input and output
    #
    #   # Demonstrates setting a range of input values and getting different types of outputs.
    #   #
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
    #
    # @example Test errors
    #
    #   begin
    #     # Demonstrates an error example.
    #     #
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
    #
    def kitchen_sink(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: [Errors::ClientError, Errors::ServerError]),
        data_parser: Parsers::KitchenSink
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::KitchenSink,
        stubs: @stubs,
        params_class: Params::KitchenSinkOutput
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
    #   See {Types::MixinTestInput}.
    #
    # @return [Types::MixinTestOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.mixin_test(
    #     user_id: 'userId'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::MixinTestOutput
    #   resp.data.username #=> String
    #   resp.data.user_id #=> String
    #
    def mixin_test(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::MixinTest
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::MixinTest,
        stubs: @stubs,
        params_class: Params::MixinTestOutput
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
    #   See {Types::PaginatorsTestOperationInput}.
    #
    # @return [Types::PaginatorsTestOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.paginators_test(
    #     next_token: 'nextToken'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::PaginatorsTestOperationOutput
    #   resp.data.next_token #=> String
    #   resp.data.items #=> Array<String>
    #   resp.data.items[0] #=> String
    #
    def paginators_test(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::PaginatorsTest
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::PaginatorsTest,
        stubs: @stubs,
        params_class: Params::PaginatorsTestOperationOutput
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
    #   See {Types::PaginatorsTestWithItemsInput}.
    #
    # @return [Types::PaginatorsTestWithItemsOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.paginators_test_with_items(
    #     next_token: 'nextToken'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::PaginatorsTestWithItemsOutput
    #   resp.data.next_token #=> String
    #   resp.data.items #=> Array<String>
    #   resp.data.items[0] #=> String
    #
    def paginators_test_with_items(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::PaginatorsTestWithItems
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::PaginatorsTestWithItems,
        stubs: @stubs,
        params_class: Params::PaginatorsTestWithItemsOutput
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
    #   See {Types::RequestCompressionOperationInput}.
    #
    # @return [Types::RequestCompressionOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.request_compression_operation(
    #     body: 'body'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::RequestCompressionOperationOutput
    #
    def request_compression_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::RequestCompressionOperationInput.build(params)
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
      stack.use(Hearth::Middleware::RequestCompression,
        streaming: false,
        encodings: ['gzip'],
        request_min_compression_size_bytes: options.fetch(:request_min_compression_size_bytes, config.request_min_compression_size_bytes),
        disable_request_compression: options.fetch(:disable_request_compression, config.disable_request_compression)
      )
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::RequestCompressionOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::RequestCompressionOperation,
        stubs: @stubs,
        params_class: Params::RequestCompressionOperationOutput
      )
      apply_middleware(stack, options[:middleware])

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
    #   See {Types::RequestCompressionStreamingOperationInput}.
    #
    # @return [Types::RequestCompressionStreamingOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.request_compression_streaming_operation(
    #     body: 'body'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::RequestCompressionStreamingOperationOutput
    #
    def request_compression_streaming_operation(params = {}, options = {}, &block)
      config = operation_config(options)
      stack = Hearth::MiddlewareStack.new
      input = Params::RequestCompressionStreamingOperationInput.build(params)
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
      stack.use(Hearth::Middleware::Retry,
        retry_strategy: config.retry_strategy,
        error_inspector_class: Hearth::HTTP::ErrorInspector
      )
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::RequestCompressionStreamingOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::RequestCompressionStreamingOperation,
        stubs: @stubs,
        params_class: Params::RequestCompressionStreamingOperationOutput
      )
      apply_middleware(stack, options[:middleware])

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
    #   See {Types::StreamingOperationInput}.
    #
    # @return [Types::StreamingOperationOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.streaming_operation(
    #     stream: 'stream'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::StreamingOperationOutput
    #   resp.data.stream #=> String
    #
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::StreamingOperation
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::StreamingOperation,
        stubs: @stubs,
        params_class: Params::StreamingOperationOutput
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
    #   See {Types::StreamingWithLengthInput}.
    #
    # @return [Types::StreamingWithLengthOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.streaming_with_length(
    #     stream: 'stream'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::StreamingWithLengthOutput
    #
    def streaming_with_length(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::StreamingWithLength
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::StreamingWithLength,
        stubs: @stubs,
        params_class: Params::StreamingWithLengthOutput
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
    #   See {Types::WaitersTestInput}.
    #
    # @return [Types::WaitersTestOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.waiters_test(
    #     status: 'Status'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::WaitersTestOutput
    #   resp.data.status #=> String
    #
    def waiters_test(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::WaitersTest
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::WaitersTest,
        stubs: @stubs,
        params_class: Params::WaitersTestOutput
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
    #   See {Types::Struct____PaginatorsTestWithBadNamesInput}.
    #
    # @return [Types::Struct____PaginatorsTestWithBadNamesOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.operation____paginators_test_with_bad_names(
    #     member___next_token: '__nextToken'
    #   )
    #
    # @example Response structure
    #
    #   resp.data #=> Types::Struct____PaginatorsTestWithBadNamesOutput
    #   resp.data.member___wrapper #=> Types::ResultWrapper
    #   resp.data.member___wrapper.member___123next_token #=> String
    #   resp.data.member___items #=> Array<String>
    #   resp.data.member___items[0] #=> String
    #
    def operation____paginators_test_with_bad_names(params = {}, options = {}, &block)
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
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, success_status: 200, errors: []),
        data_parser: Parsers::Operation____PaginatorsTestWithBadNames
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: config.stub_responses,
        client: options.fetch(:http_client, config.http_client),
        stub_class: Stubs::Operation____PaginatorsTestWithBadNames,
        stubs: @stubs,
        params_class: Params::Struct____PaginatorsTestWithBadNamesOutput
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
