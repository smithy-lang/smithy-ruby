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
  class Client < Hearth::Client

    # @api private
    @plugins = Hearth::PluginList.new([
      Plugins::TestPlugin.new
    ])

    # @param [Hash] options
    #   Options used to construct an instance of {Config}
    def initialize(options = {})
      super(options, Config)
    end

    # @return [Config] config
    attr_reader :config

    # @param [Hash | Types::CustomAuthInput] params
    #   Request parameters for this operation.
    #   See {Types::CustomAuthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.custom_auth()
    # @example Response structure
    #   resp.data #=> Types::CustomAuthOutput
    def custom_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::CustomAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::CustomAuth.build(config)
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

    # @param [Hash | Types::DataplaneEndpointInput] params
    #   Request parameters for this operation.
    #   See {Types::DataplaneEndpointInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.dataplane_endpoint()
    # @example Response structure
    #   resp.data #=> Types::DataplaneEndpointOutput
    def dataplane_endpoint(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::DataplaneEndpointInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::DataplaneEndpoint.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :dataplane_endpoint,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#dataplane_endpoint] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#dataplane_endpoint] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#dataplane_endpoint] #{output.data}")
      output
    end

    # @param [Hash | Types::DefaultsTestInput] params
    #   Request parameters for this operation.
    #   See {Types::DefaultsTestInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.defaults_test(
    #     defaults: {
    #       string: 'String',
    #       struct: {
    #         value: 'value'
    #       },
    #       un_required_number: 1,
    #       un_required_bool: false,
    #       number: 1, # required
    #       bool: false, # required
    #       hello: 'hello', # required
    #       simple_enum: 'YES', # required - accepts ["YES", "NO"]
    #       valued_enum: 'yes', # required - accepts ["yes", "no"]
    #       int_enum: 1, # required
    #       null_document: {
    #         'nil' => nil,
    #         'number' => 123.0,
    #         'string' => 'value',
    #         'boolean' => true,
    #         'array' => [],
    #         'map' => {}
    #       }, # required
    #       list_of_strings: [
    #         'member'
    #       ], # required
    #       map_of_strings: {
    #         'key' => 'value'
    #       }, # required
    #       iso8601_timestamp: Time.now, # required
    #       epoch_timestamp: Time.now # required
    #     }
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
    #   resp.data.simple_enum #=> String, one of ["YES", "NO"]
    #   resp.data.valued_enum #=> String, one of ["yes", "no"]
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
      stack = WhiteLabel::Middleware::DefaultsTest.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.endpoint_operation()
    # @example Response structure
    #   resp.data #=> Types::EndpointOperationOutput
    def endpoint_operation(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::EndpointOperationInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::EndpointOperation.build(config)
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

    # @param [Hash | Types::EndpointWithHostLabelOperationInput] params
    #   Request parameters for this operation.
    #   See {Types::EndpointWithHostLabelOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
      stack = WhiteLabel::Middleware::EndpointWithHostLabelOperation.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_api_key_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpApiKeyAuthOutput
    def http_api_key_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpApiKeyAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpApiKeyAuth.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_basic_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpBasicAuthOutput
    def http_basic_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpBasicAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpBasicAuth.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_bearer_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpBearerAuthOutput
    def http_bearer_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpBearerAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpBearerAuth.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_digest_auth()
    # @example Response structure
    #   resp.data #=> Types::HttpDigestAuthOutput
    def http_digest_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::HttpDigestAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::HttpDigestAuth.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.kitchen_sink(
    #     string: 'String',
    #     simple_enum: 'YES', # accepts ["YES", "NO"]
    #     valued_enum: 'yes', # accepts ["yes", "no"]
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
    #   resp.data.simple_enum #=> String, one of ["YES", "NO"]
    #   resp.data.valued_enum #=> String, one of ["yes", "no"]
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
      stack = WhiteLabel::Middleware::KitchenSink.build(config)
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
    # @return [Hearth::Output]
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
      stack = WhiteLabel::Middleware::MixinTest.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.no_auth()
    # @example Response structure
    #   resp.data #=> Types::NoAuthOutput
    def no_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::NoAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::NoAuth.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.optional_auth()
    # @example Response structure
    #   resp.data #=> Types::OptionalAuthOutput
    def optional_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::OptionalAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::OptionalAuth.build(config)
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
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.ordered_auth()
    # @example Response structure
    #   resp.data #=> Types::OrderedAuthOutput
    def ordered_auth(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::OrderedAuthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::OrderedAuth.build(config)
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
    # @return [Hearth::Output]
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
      stack = WhiteLabel::Middleware::PaginatorsTest.build(config)
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
    # @return [Hearth::Output]
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
      stack = WhiteLabel::Middleware::PaginatorsTestWithItems.build(config)
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

    # @param [Hash | Types::RelativeMiddlewareInput] params
    #   Request parameters for this operation.
    #   See {Types::RelativeMiddlewareInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.relative_middleware()
    # @example Response structure
    #   resp.data #=> Types::RelativeMiddlewareOutput
    def relative_middleware(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RelativeMiddlewareInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::RelativeMiddleware.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :relative_middleware,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#relative_middleware] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#relative_middleware] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#relative_middleware] #{output.data}")
      output
    end

    # @param [Hash | Types::RequestCompressionInput] params
    #   Request parameters for this operation.
    #   See {Types::RequestCompressionInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.request_compression(
    #     body: 'body'
    #   )
    # @example Response structure
    #   resp.data #=> Types::RequestCompressionOutput
    def request_compression(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RequestCompressionInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::RequestCompression.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :request_compression,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#request_compression] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression] #{output.data}")
      output
    end

    # @param [Hash | Types::RequestCompressionStreamingInput] params
    #   Request parameters for this operation.
    #   See {Types::RequestCompressionStreamingInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.request_compression_streaming(
    #     body: 'body' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::RequestCompressionStreamingOutput
    def request_compression_streaming(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RequestCompressionStreamingInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::RequestCompressionStreaming.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :request_compression_streaming,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression_streaming] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#request_compression_streaming] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#request_compression_streaming] #{output.data}")
      output
    end

    # @param [Hash | Types::ResourceEndpointInput] params
    #   Request parameters for this operation.
    #   See {Types::ResourceEndpointInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.resource_endpoint(
    #     resource_url: 'resourceUrl' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::ResourceEndpointOutput
    def resource_endpoint(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::ResourceEndpointInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::ResourceEndpoint.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :resource_endpoint,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#resource_endpoint] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#resource_endpoint] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#resource_endpoint] #{output.data}")
      output
    end

    # @param [Hash | Types::StreamingInput] params
    #   Request parameters for this operation.
    #   See {Types::StreamingInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.streaming(
    #     stream: 'stream' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingOutput
    #   resp.data.stream #=> String
    def streaming(params = {}, options = {}, &block)
      response_body = output_stream(options, &block)
      config = operation_config(options)
      input = Params::StreamingInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::Streaming.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :streaming,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#streaming] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming] #{output.data}")
      output
    end

    # @param [Hash | Types::StreamingWithLengthInput] params
    #   Request parameters for this operation.
    #   See {Types::StreamingWithLengthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.streaming_with_length(
    #     stream: 'stream' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingWithLengthOutput
    def streaming_with_length(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::StreamingWithLengthInput.build(params, context: 'params')
      stack = WhiteLabel::Middleware::StreamingWithLength.build(config)
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
    # @return [Hearth::Output]
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
      stack = WhiteLabel::Middleware::WaitersTest.build(config)
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
    # @return [Hearth::Output]
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
      stack = WhiteLabel::Middleware::Operation____PaginatorsTestWithBadNames.build(config)
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
  end
end
