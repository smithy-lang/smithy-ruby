# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

require_relative 'plugins/test_plugin'

module WhiteLabel
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

    # @api private
    @plugins = Hearth::PluginList.new([
      Plugins::TestPlugin.new
    ])

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

    # @param [Hash | Types::CustomAuthInput] params
    #   Request parameters for this operation.
    #   See {Types::CustomAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::CustomAuthOutput]
    # @example Request syntax with placeholder values
    #   resp = client.custom_auth()
    # @example Response structure
    #   resp.data #=> Types::CustomAuthOutput
    def custom_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::CustomAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::CustomAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :custom_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#custom_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#custom_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#custom_auth] #{output.data}")
      output
    end

    # @param [Hash | Types::DataplaneOperationInput] params
    #   Request parameters for this operation.
    #   See {Types::DataplaneOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::DataplaneOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.dataplane_operation()
    # @example Response structure
    #   resp.data #=> Types::DataplaneOperationOutput
    def dataplane_operation(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::DataplaneOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::DataplaneOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :dataplane_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#dataplane_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#dataplane_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#dataplane_operation] #{output.data}")
      output
    end

    # @param [Hash | Types::DefaultsTestInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::DefaultsTestInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::DefaultsTest.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :defaults_test,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#defaults_test] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#defaults_test] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#defaults_test] #{output.data}")
      output
    end

    # @param [Hash | Types::EndpointOperationInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::EndpointOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::EndpointOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :endpoint_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#endpoint_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_operation] #{output.data}")
      output
    end

    # @param [Hash | Types::EndpointOperationWithResourceInput] params
    #   Request parameters for this operation.
    #   See {Types::EndpointOperationWithResourceInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::EndpointOperationWithResourceOutput]
    # @example Request syntax with placeholder values
    #   resp = client.endpoint_operation_with_resource(
    #     resource_url: 'resourceUrl' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::EndpointOperationWithResourceOutput
    def endpoint_operation_with_resource(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::EndpointOperationWithResourceInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::EndpointOperationWithResource.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :endpoint_operation_with_resource,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_operation_with_resource] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#endpoint_operation_with_resource] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_operation_with_resource] #{output.data}")
      output
    end

    # @param [Hash | Types::EndpointWithHostLabelOperationInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::EndpointWithHostLabelOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::EndpointWithHostLabelOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :endpoint_with_host_label_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_with_host_label_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#endpoint_with_host_label_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_with_host_label_operation] #{output.data}")
      output
    end

    # @param [Hash | Types::HttpApiKeyAuthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpApiKeyAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpApiKeyAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_api_key_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_api_key_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_api_key_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_api_key_auth] #{output.data}")
      output
    end

    # @param [Hash | Types::HttpBasicAuthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpBasicAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpBasicAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_basic_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_basic_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_basic_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_basic_auth] #{output.data}")
      output
    end

    # @param [Hash | Types::HttpBearerAuthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpBearerAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpBearerAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_bearer_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_bearer_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_bearer_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_bearer_auth] #{output.data}")
      output
    end

    # @param [Hash | Types::HttpDigestAuthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpDigestAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpDigestAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_digest_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_digest_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_digest_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_digest_auth] #{output.data}")
      output
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
    # @param [Hash | Types::KitchenSinkInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::KitchenSinkInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::KitchenSink.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :kitchen_sink,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#kitchen_sink] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#kitchen_sink] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#kitchen_sink] #{output.data}")
      output
    end

    # @param [Hash | Types::MixinTestInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MixinTestInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::MixinTest.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :mixin_test,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#mixin_test] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#mixin_test] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#mixin_test] #{output.data}")
      output
    end

    # @param [Hash | Types::NoAuthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::NoAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::NoAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :no_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#no_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#no_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#no_auth] #{output.data}")
      output
    end

    # @param [Hash | Types::OptionalAuthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::OptionalAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::OptionalAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :optional_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#optional_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#optional_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#optional_auth] #{output.data}")
      output
    end

    # @param [Hash | Types::OrderedAuthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::OrderedAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::OrderedAuth.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :ordered_auth,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#ordered_auth] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#ordered_auth] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#ordered_auth] #{output.data}")
      output
    end

    # @param [Hash | Types::PaginatorsTestOperationInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::PaginatorsTestOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::PaginatorsTest.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :paginators_test,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#paginators_test] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#paginators_test] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#paginators_test] #{output.data}")
      output
    end

    # @param [Hash | Types::PaginatorsTestWithItemsInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::PaginatorsTestWithItemsInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::PaginatorsTestWithItems.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :paginators_test_with_items,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#paginators_test_with_items] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#paginators_test_with_items] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#paginators_test_with_items] #{output.data}")
      output
    end

    # @param [Hash | Types::RelativeMiddlewareOperationInput] params
    #   Request parameters for this operation.
    #   See {Types::RelativeMiddlewareOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Types::RelativeMiddlewareOperationOutput]
    # @example Request syntax with placeholder values
    #   resp = client.relative_middleware_operation()
    # @example Response structure
    #   resp.data #=> Types::RelativeMiddlewareOperationOutput
    def relative_middleware_operation(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RelativeMiddlewareOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::RelativeMiddlewareOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :relative_middleware_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#relative_middleware_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#relative_middleware_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#relative_middleware_operation] #{output.data}")
      output
    end

    # @param [Hash | Types::RequestCompressionOperationInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RequestCompressionOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::RequestCompressionOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :request_compression_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#request_compression_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression_operation] #{output.data}")
      output
    end

    # @param [Hash | Types::RequestCompressionStreamingOperationInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RequestCompressionStreamingOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::RequestCompressionStreamingOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :request_compression_streaming_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression_streaming_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#request_compression_streaming_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression_streaming_operation] #{output.data}")
      output
    end

    # @param [Hash | Types::StreamingOperationInput] params
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
      response_body = output_stream(options, &block)
      config = operation_config(options)
      input = Params::StreamingOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::StreamingOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :streaming_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_operation] #{output.data}")
      output
    end

    # @param [Hash | Types::StreamingWithLengthInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::StreamingWithLengthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::StreamingWithLength.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :streaming_with_length,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_with_length] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_with_length] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_with_length] #{output.data}")
      output
    end

    # @param [Hash | Types::WaitersTestInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::WaitersTestInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::WaitersTest.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :waiters_test,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#waiters_test] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#waiters_test] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#waiters_test] #{output.data}")
      output
    end

    # @param [Hash | Types::Struct____PaginatorsTestWithBadNamesInput] params
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
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::Struct____PaginatorsTestWithBadNamesInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::Operation____PaginatorsTestWithBadNames.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :operation____paginators_test_with_bad_names,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#operation____paginators_test_with_bad_names] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#operation____paginators_test_with_bad_names] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#operation____paginators_test_with_bad_names] #{output.data}")
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

    def output_stream(options = {}, &block)
      return options.delete(:output_stream) if options[:output_stream]
      return Hearth::BlockIO.new(block) if block

      ::StringIO.new
    end
  end
end
