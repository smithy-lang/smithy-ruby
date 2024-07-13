# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

require_relative 'plugins/global_config'

module Rpcv2Cbor
  class Client < Hearth::Client

    # @api private
    @plugins = Hearth::PluginList.new([
      Plugins::GlobalConfig.new
    ])

    # @param [Hash] options
    #   Options used to construct an instance of {Config}
    def initialize(options = {})
      super(options, Config)
    end

    # @return [Config] config
    attr_reader :config

    # @param [Hash | Types::EmptyInputOutputInput] params
    #   Request parameters for this operation.
    #   See {Types::EmptyInputOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.empty_input_output()
    # @example Response structure
    #   resp.data #=> Types::EmptyInputOutputOutput
    def empty_input_output(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::EmptyInputOutputInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::EmptyInputOutput.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :empty_input_output,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#empty_input_output] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#empty_input_output] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#empty_input_output] #{output.data}")
      output
    end

    # Tags: ["client-only"]
    # @param [Hash | Types::Float16Input] params
    #   Request parameters for this operation.
    #   See {Types::Float16Input#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.float16()
    # @example Response structure
    #   resp.data #=> Types::Float16Output
    #   resp.data.value #=> Float
    def float16(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::Float16Input.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::Float16.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :float16,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#float16] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#float16] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#float16] #{output.data}")
      output
    end

    # Tags: ["client-only"]
    # @param [Hash | Types::FractionalSecondsInput] params
    #   Request parameters for this operation.
    #   See {Types::FractionalSecondsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.fractional_seconds()
    # @example Response structure
    #   resp.data #=> Types::FractionalSecondsOutput
    #   resp.data.datetime #=> Time
    def fractional_seconds(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::FractionalSecondsInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::FractionalSeconds.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :fractional_seconds,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#fractional_seconds] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#fractional_seconds] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#fractional_seconds] #{output.data}")
      output
    end

    # This operation has three possible return values:
    #
    # 1. A successful response in the form of GreetingWithErrorsOutput
    # 2. An InvalidGreeting error.
    # 3. A ComplexError error.
    #
    # Implementations must be able to successfully take a response and
    # properly deserialize successful and error responses.
    # @param [Hash | Types::GreetingWithErrorsInput] params
    #   Request parameters for this operation.
    #   See {Types::GreetingWithErrorsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.greeting_with_errors()
    # @example Response structure
    #   resp.data #=> Types::GreetingWithErrorsOutput
    #   resp.data.greeting #=> String
    def greeting_with_errors(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::GreetingWithErrorsInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::GreetingWithErrors.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :greeting_with_errors,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] #{output.data}")
      output
    end

    # @param [Hash | Types::NoInputOutputInput] params
    #   Request parameters for this operation.
    #   See {Types::NoInputOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.no_input_output()
    # @example Response structure
    #   resp.data #=> Types::NoInputOutputOutput
    def no_input_output(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::NoInputOutputInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::NoInputOutput.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :no_input_output,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_output] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#no_input_output] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_output] #{output.data}")
      output
    end

    # @param [Hash | Types::OperationWithDefaultsInput] params
    #   Request parameters for this operation.
    #   See {Types::OperationWithDefaultsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.operation_with_defaults(
    #     defaults: {
    #       default_string: 'defaultString',
    #       default_boolean: false,
    #       default_list: [
    #         'member'
    #       ],
    #       default_timestamp: Time.now,
    #       default_blob: 'defaultBlob',
    #       default_byte: 1,
    #       default_short: 1,
    #       default_integer: 1,
    #       default_long: 1,
    #       default_float: 1.0,
    #       default_double: 1.0,
    #       default_map: {
    #         'key' => 'value'
    #       },
    #       default_enum: 'FOO', # accepts ["FOO", "BAR", "BAZ"]
    #       default_int_enum: 1,
    #       empty_string: 'emptyString',
    #       false_boolean: false,
    #       empty_blob: 'emptyBlob',
    #       zero_byte: 1,
    #       zero_short: 1,
    #       zero_integer: 1,
    #       zero_long: 1,
    #       zero_float: 1.0,
    #       zero_double: 1.0
    #     },
    #     client_optional_defaults: {
    #       member: 1
    #     },
    #     top_level_default: 'topLevelDefault',
    #     other_top_level_default: 1
    #   )
    # @example Response structure
    #   resp.data #=> Types::OperationWithDefaultsOutput
    #   resp.data.default_string #=> String
    #   resp.data.default_boolean #=> Boolean
    #   resp.data.default_list #=> Array<String>
    #   resp.data.default_list[0] #=> String
    #   resp.data.default_timestamp #=> Time
    #   resp.data.default_blob #=> String
    #   resp.data.default_byte #=> Integer
    #   resp.data.default_short #=> Integer
    #   resp.data.default_integer #=> Integer
    #   resp.data.default_long #=> Integer
    #   resp.data.default_float #=> Float
    #   resp.data.default_double #=> Float
    #   resp.data.default_map #=> Hash<String | Symbol, String>
    #   resp.data.default_map['key'] #=> String
    #   resp.data.default_enum #=> String, one of ["FOO", "BAR", "BAZ"]
    #   resp.data.default_int_enum #=> Integer
    #   resp.data.empty_string #=> String
    #   resp.data.false_boolean #=> Boolean
    #   resp.data.empty_blob #=> String
    #   resp.data.zero_byte #=> Integer
    #   resp.data.zero_short #=> Integer
    #   resp.data.zero_integer #=> Integer
    #   resp.data.zero_long #=> Integer
    #   resp.data.zero_float #=> Float
    #   resp.data.zero_double #=> Float
    def operation_with_defaults(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::OperationWithDefaultsInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::OperationWithDefaults.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :operation_with_defaults,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#operation_with_defaults] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#operation_with_defaults] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#operation_with_defaults] #{output.data}")
      output
    end

    # @param [Hash | Types::OptionalInputOutputInput] params
    #   Request parameters for this operation.
    #   See {Types::OptionalInputOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.optional_input_output(
    #     value: 'value'
    #   )
    # @example Response structure
    #   resp.data #=> Types::OptionalInputOutputOutput
    #   resp.data.value #=> String
    def optional_input_output(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::OptionalInputOutputInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::OptionalInputOutput.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :optional_input_output,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#optional_input_output] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#optional_input_output] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#optional_input_output] #{output.data}")
      output
    end

    # @param [Hash | Types::RecursiveShapesInput] params
    #   Request parameters for this operation.
    #   See {Types::RecursiveShapesInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.recursive_shapes(
    #     nested: {
    #       foo: 'foo',
    #       nested: {
    #         bar: 'bar',
    #       }
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::RecursiveShapesOutput
    #   resp.data.nested #=> Types::RecursiveShapesInputOutputNested1
    #   resp.data.nested.foo #=> String
    #   resp.data.nested.nested #=> Types::RecursiveShapesInputOutputNested2
    #   resp.data.nested.nested.bar #=> String
    #   resp.data.nested.nested.recursive_member #=> Types::RecursiveShapesInputOutputNested1
    def recursive_shapes(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RecursiveShapesInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::RecursiveShapes.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :recursive_shapes,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#recursive_shapes] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#recursive_shapes] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#recursive_shapes] #{output.data}")
      output
    end

    # The example tests basic map serialization.
    # @param [Hash | Types::RpcV2CborDenseMapsInput] params
    #   Request parameters for this operation.
    #   See {Types::RpcV2CborDenseMapsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.rpc_v2_cbor_dense_maps(
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
    #     dense_set_map: {
    #       'key' => [
    #         'member'
    #       ]
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::RpcV2CborDenseMapsOutput
    #   resp.data.dense_struct_map #=> Hash<String | Symbol, GreetingStruct>
    #   resp.data.dense_struct_map['key'] #=> Types::GreetingStruct
    #   resp.data.dense_struct_map['key'].hi #=> String
    #   resp.data.dense_number_map #=> Hash<String | Symbol, Integer>
    #   resp.data.dense_number_map['key'] #=> Integer
    #   resp.data.dense_boolean_map #=> Hash<String | Symbol, Boolean>
    #   resp.data.dense_boolean_map['key'] #=> Boolean
    #   resp.data.dense_string_map #=> Hash<String | Symbol, String>
    #   resp.data.dense_string_map['key'] #=> String
    #   resp.data.dense_set_map #=> Hash<String | Symbol, Array<String>>
    #   resp.data.dense_set_map['key'] #=> Array<String>
    #   resp.data.dense_set_map['key'][0] #=> String
    def rpc_v2_cbor_dense_maps(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RpcV2CborDenseMapsInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::RpcV2CborDenseMaps.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :rpc_v2_cbor_dense_maps,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_dense_maps] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_dense_maps] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_dense_maps] #{output.data}")
      output
    end

    # This test case serializes JSON lists for the following cases for both
    # input and output:
    #
    # 1. Normal lists.
    # 2. Normal sets.
    # 3. Lists of lists.
    # 4. Lists of structures.
    # @param [Hash | Types::RpcV2CborListsInput] params
    #   Request parameters for this operation.
    #   See {Types::RpcV2CborListsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.rpc_v2_cbor_lists(
    #     string_list: [
    #       'member'
    #     ],
    #     string_set: [
    #       'member'
    #     ],
    #     integer_list: [
    #       1
    #     ],
    #     boolean_list: [
    #       false
    #     ],
    #     timestamp_list: [
    #       Time.now
    #     ],
    #     enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     int_enum_list: [
    #       1
    #     ],
    #     structure_list: [
    #       {
    #         a: 'a',
    #         b: 'b'
    #       }
    #     ],
    #     blob_list: [
    #       'member'
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::RpcV2CborListsOutput
    #   resp.data.string_list #=> Array<String>
    #   resp.data.string_list[0] #=> String
    #   resp.data.string_set #=> Array<String>
    #   resp.data.string_set[0] #=> String
    #   resp.data.integer_list #=> Array<Integer>
    #   resp.data.integer_list[0] #=> Integer
    #   resp.data.boolean_list #=> Array<Boolean>
    #   resp.data.boolean_list[0] #=> Boolean
    #   resp.data.timestamp_list #=> Array<Time>
    #   resp.data.timestamp_list[0] #=> Time
    #   resp.data.enum_list #=> Array<String>
    #   resp.data.enum_list[0] #=> String, one of ["Foo", "Baz", "Bar", "1", "0"]
    #   resp.data.int_enum_list #=> Array<Integer>
    #   resp.data.int_enum_list[0] #=> Integer
    #   resp.data.nested_string_list #=> Array<Array<String>>
    #   resp.data.structure_list #=> Array<StructureListMember>
    #   resp.data.structure_list[0] #=> Types::StructureListMember
    #   resp.data.structure_list[0].a #=> String
    #   resp.data.structure_list[0].b #=> String
    #   resp.data.blob_list #=> Array<String>
    #   resp.data.blob_list[0] #=> String
    def rpc_v2_cbor_lists(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RpcV2CborListsInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::RpcV2CborLists.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :rpc_v2_cbor_lists,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_lists] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_lists] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_lists] #{output.data}")
      output
    end

    # @param [Hash | Types::RpcV2CborSparseMapsInput] params
    #   Request parameters for this operation.
    #   See {Types::RpcV2CborSparseMapsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.rpc_v2_cbor_sparse_maps(
    #     sparse_struct_map: {
    #       'key' => {
    #         hi: 'hi'
    #       }
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
    #     sparse_set_map: {
    #       'key' => [
    #         'member'
    #       ]
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::RpcV2CborSparseMapsOutput
    #   resp.data.sparse_struct_map #=> Hash<String | Symbol, GreetingStruct>
    #   resp.data.sparse_struct_map['key'] #=> Types::GreetingStruct
    #   resp.data.sparse_struct_map['key'].hi #=> String
    #   resp.data.sparse_number_map #=> Hash<String | Symbol, Integer>
    #   resp.data.sparse_number_map['key'] #=> Integer
    #   resp.data.sparse_boolean_map #=> Hash<String | Symbol, Boolean>
    #   resp.data.sparse_boolean_map['key'] #=> Boolean
    #   resp.data.sparse_string_map #=> Hash<String | Symbol, String>
    #   resp.data.sparse_string_map['key'] #=> String
    #   resp.data.sparse_set_map #=> Hash<String | Symbol, Array<String>>
    #   resp.data.sparse_set_map['key'] #=> Array<String>
    #   resp.data.sparse_set_map['key'][0] #=> String
    def rpc_v2_cbor_sparse_maps(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::RpcV2CborSparseMapsInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::RpcV2CborSparseMaps.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :rpc_v2_cbor_sparse_maps,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_sparse_maps] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_sparse_maps] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#rpc_v2_cbor_sparse_maps] #{output.data}")
      output
    end

    # @param [Hash | Types::SimpleScalarPropertiesInput] params
    #   Request parameters for this operation.
    #   See {Types::SimpleScalarPropertiesInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.simple_scalar_properties(
    #     true_boolean_value: false,
    #     false_boolean_value: false,
    #     byte_value: 1,
    #     double_value: 1.0,
    #     float_value: 1.0,
    #     integer_value: 1,
    #     long_value: 1,
    #     short_value: 1,
    #     string_value: 'stringValue',
    #     blob_value: 'blobValue'
    #   )
    # @example Response structure
    #   resp.data #=> Types::SimpleScalarPropertiesOutput
    #   resp.data.true_boolean_value #=> Boolean
    #   resp.data.false_boolean_value #=> Boolean
    #   resp.data.byte_value #=> Integer
    #   resp.data.double_value #=> Float
    #   resp.data.float_value #=> Float
    #   resp.data.integer_value #=> Integer
    #   resp.data.long_value #=> Integer
    #   resp.data.short_value #=> Integer
    #   resp.data.string_value #=> String
    #   resp.data.blob_value #=> String
    def simple_scalar_properties(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::SimpleScalarPropertiesInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::SimpleScalarProperties.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :simple_scalar_properties,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] #{output.data}")
      output
    end

    # @param [Hash | Types::SparseNullsOperationInput] params
    #   Request parameters for this operation.
    #   See {Types::SparseNullsOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.sparse_nulls_operation(
    #     sparse_string_list: [
    #       'member'
    #     ],
    #     sparse_string_map: {
    #       'key' => 'value'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::SparseNullsOperationOutput
    #   resp.data.sparse_string_list #=> Array<String>
    #   resp.data.sparse_string_list[0] #=> String
    #   resp.data.sparse_string_map #=> Hash<String | Symbol, String>
    #   resp.data.sparse_string_map['key'] #=> String
    def sparse_nulls_operation(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::SparseNullsOperationInput.build(params, context: 'params')
      stack = Rpcv2Cbor::Middleware::SparseNullsOperation.build(config)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :sparse_nulls_operation,
      )
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_nulls_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.config.logger.error("[#{context.invocation_id}] [#{self.class}#sparse_nulls_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.config.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_nulls_operation] #{output.data}")
      output
    end
  end
end
