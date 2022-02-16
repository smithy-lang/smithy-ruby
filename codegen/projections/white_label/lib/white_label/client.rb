# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

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

    @middleware = Hearth::MiddlewareBuilder.new

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
      @middleware = Hearth::MiddlewareBuilder.new(options[:middleware])
      @stub_responses = options.fetch(:stub_responses, false)
      @stubs = Hearth::Stubbing::Stubs.new
      @validate_input = options.fetch(:validate_input, true)

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
    #     set_of_strings: [
    #       'member'
    #     ],
    #     union: {
    #       # One of:
    #       string: 'String',
    #     }
    #   )
    #
    # @example Response structure
    #
    #   resp #=> Types::KitchenSinkOutput
    #   resp.string #=> String
    #   resp.struct #=> Types::Struct
    #   resp.struct.value #=> String
    #   resp.document #=> Hash,Array,String,Boolean,Numeric
    #   resp.list_of_strings #=> Array<String>
    #   resp.list_of_strings[0] #=> String
    #   resp.list_of_structs #=> Array<Struct>
    #   resp.map_of_strings #=> Hash<String, String>
    #   resp.map_of_strings['key'] #=> String
    #   resp.map_of_structs #=> Hash<String, Struct>
    #   resp.set_of_strings #=> Set<String>
    #   resp.set_of_strings[0] #=> String
    #   resp.set_of_structs #=> Set<Struct>
    #   resp.union #=> Union
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
    #     set_of_strings: [
    #       "set",
    #       "of",
    #       "strings"
    #     ],
    #     set_of_structs: [
    #       {
    #         value: "struct1"
    #       },
    #       {
    #         value: "struct2"
    #       }
    #     ],
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
    #     set_of_strings: [
    #       "set",
    #       "of",
    #       "strings"
    #     ],
    #     set_of_structs: [
    #       {
    #         value: "struct1"
    #       },
    #       {
    #         value: "struct2"
    #       }
    #     ],
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
      stack = Hearth::MiddlewareStack.new
      input = Params::KitchenSinkInput.build(params)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::KitchenSinkInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::KitchenSink
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: [Errors::ClientError, Errors::ServerError]),
        data_parser: Parsers::KitchenSink
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::KitchenSink,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: output_stream(options, &block)),
          params: params,
          logger: @logger,
          operation_name: :kitchen_sink
        )
      )
      raise resp.error if resp.error
      resp.data
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
    #   resp #=> Types::PaginatorsTestOperationOutput
    #   resp.next_token #=> String
    #   resp.items #=> Array<String>
    #   resp.items[0] #=> String
    #
    def paginators_test(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::PaginatorsTestOperationInput.build(params)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::PaginatorsTestOperationInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::PaginatorsTest
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::PaginatorsTest
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::PaginatorsTest,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: output_stream(options, &block)),
          params: params,
          logger: @logger,
          operation_name: :paginators_test
        )
      )
      raise resp.error if resp.error
      resp.data
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
    #   resp #=> Types::PaginatorsTestWithItemsOutput
    #   resp.next_token #=> String
    #   resp.items #=> Array<String>
    #   resp.items[0] #=> String
    #
    def paginators_test_with_items(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::PaginatorsTestWithItemsInput.build(params)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::PaginatorsTestWithItemsInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::PaginatorsTestWithItems
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::PaginatorsTestWithItems
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::PaginatorsTestWithItems,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: output_stream(options, &block)),
          params: params,
          logger: @logger,
          operation_name: :paginators_test_with_items
        )
      )
      raise resp.error if resp.error
      resp.data
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
    #   resp #=> Types::WaitersTestOutput
    #   resp.status #=> String
    #
    def waiters_test(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::WaitersTestInput.build(params)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::WaitersTestInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::WaitersTest
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::WaitersTest
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::WaitersTest,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: output_stream(options, &block)),
          params: params,
          logger: @logger,
          operation_name: :waiters_test
        )
      )
      raise resp.error if resp.error
      resp.data
    end

    # @param [Hash] params
    #   See {Types::Struct____PaginatorsTestWithBadNamesInput}.
    #
    # @return [Types::Struct____PaginatorsTestWithBadNamesOutput]
    #
    # @example Request syntax with placeholder values
    #
    #   resp = client.operation____paginators_test_with_bad_names(
    #     member____next_token: '__nextToken'
    #   )
    #
    # @example Response structure
    #
    #   resp #=> Types::Struct____PaginatorsTestWithBadNamesOutput
    #   resp.member____wrapper #=> Types::ResultWrapper
    #   resp.member____wrapper.member____123next_token #=> String
    #   resp.member____items #=> Array<String>
    #   resp.member____items[0] #=> String
    #
    def operation____paginators_test_with_bad_names(params = {}, options = {}, &block)
      stack = Hearth::MiddlewareStack.new
      input = Params::Struct____PaginatorsTestWithBadNamesInput.build(params)
      stack.use(Hearth::Middleware::Validate,
        validator: Validators::Struct____PaginatorsTestWithBadNamesInput,
        validate_input: options.fetch(:validate_input, @validate_input)
      )
      stack.use(Hearth::Middleware::Build,
        builder: Builders::Operation____PaginatorsTestWithBadNames
      )
      stack.use(Hearth::HTTP::Middleware::ContentLength)
      stack.use(Hearth::Middleware::Parse,
        error_parser: Hearth::HTTP::ErrorParser.new(error_module: Errors, error_code_fn: Errors.method(:error_code), success_status: 200, errors: []),
        data_parser: Parsers::Operation____PaginatorsTestWithBadNames
      )
      stack.use(Hearth::Middleware::Send,
        stub_responses: options.fetch(:stub_responses, @stub_responses),
        client: Hearth::HTTP::Client.new(logger: @logger, http_wire_trace: options.fetch(:http_wire_trace, @http_wire_trace)),
        stub_class: Stubs::Operation____PaginatorsTestWithBadNames,
        stubs: options.fetch(:stubs, @stubs)
      )
      apply_middleware(stack, options[:middleware])

      resp = stack.run(
        input: input,
        context: Hearth::Context.new(
          request: Hearth::HTTP::Request.new(url: options.fetch(:endpoint, @endpoint)),
          response: Hearth::HTTP::Response.new(body: output_stream(options, &block)),
          params: params,
          logger: @logger,
          operation_name: :operation____paginators_test_with_bad_names
        )
      )
      raise resp.error if resp.error
      resp.data
    end

    private

    def apply_middleware(middleware_stack, middleware)
      Client.middleware.apply(middleware_stack)
      @middleware.apply(middleware_stack)
      Hearth::MiddlewareBuilder.new(middleware).apply(middleware_stack)
    end

    def output_stream(options = {}, &block)
      return options[:output_stream] if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      StringIO.new
    end
  end
end
