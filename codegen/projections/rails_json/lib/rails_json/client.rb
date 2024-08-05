# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

require_relative 'plugins/global_config'

module RailsJson
  # A REST JSON service that sends JSON requests and responses.
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

    # This example uses all query string types.
    # @param [Hash | Types::AllQueryStringTypesInput] params
    #   Request parameters for this operation.
    #   See {Types::AllQueryStringTypesInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    #     query_integer_enum: 1,
    #     query_integer_enum_list: [
    #       1
    #     ],
    #   )
    # @example Response structure
    #   resp.data #=> Types::AllQueryStringTypesOutput
    def all_query_string_types(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::AllQueryStringTypesInput.build(params, context: 'params')
      stack = RailsJson::Middleware::AllQueryStringTypes.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :all_query_string_types,
        tracer: tracer
      )
      Telemetry::AllQueryStringTypes.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#all_query_string_types] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#all_query_string_types] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#all_query_string_types] #{output.data}")
        output
      end
    end

    # This example uses fixed query string params and variable query string params.
    # The fixed query string parameters and variable parameters must both be
    # serialized (implementations may need to merge them together).
    # @param [Hash | Types::ConstantAndVariableQueryStringInput] params
    #   Request parameters for this operation.
    #   See {Types::ConstantAndVariableQueryStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.constant_and_variable_query_string(
    #     baz: 'baz',
    #     maybe_set: 'maybeSet'
    #   )
    # @example Response structure
    #   resp.data #=> Types::ConstantAndVariableQueryStringOutput
    def constant_and_variable_query_string(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::ConstantAndVariableQueryStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::ConstantAndVariableQueryString.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :constant_and_variable_query_string,
        tracer: tracer
      )
      Telemetry::ConstantAndVariableQueryString.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#constant_and_variable_query_string] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#constant_and_variable_query_string] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#constant_and_variable_query_string] #{output.data}")
        output
      end
    end

    # This example uses a constant query string parameters and a label.
    # This simply tests that labels and query string parameters are
    # compatible. The fixed query string parameter named "hello" should
    # in no way conflict with the label, `{hello}`.
    # @param [Hash | Types::ConstantQueryStringInput] params
    #   Request parameters for this operation.
    #   See {Types::ConstantQueryStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.constant_query_string(
    #     hello: 'hello' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::ConstantQueryStringOutput
    def constant_query_string(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::ConstantQueryStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::ConstantQueryString.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :constant_query_string,
        tracer: tracer
      )
      Telemetry::ConstantQueryString.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#constant_query_string] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#constant_query_string] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#constant_query_string] #{output.data}")
        output
      end
    end

    # Tags: ["client-only"]
    # @param [Hash | Types::DatetimeOffsetsInput] params
    #   Request parameters for this operation.
    #   See {Types::DatetimeOffsetsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.datetime_offsets()
    # @example Response structure
    #   resp.data #=> Types::DatetimeOffsetsOutput
    #   resp.data.datetime #=> Time
    def datetime_offsets(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::DatetimeOffsetsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DatetimeOffsets.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :datetime_offsets,
        tracer: tracer
      )
      Telemetry::DatetimeOffsets.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#datetime_offsets] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#datetime_offsets] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#datetime_offsets] #{output.data}")
        output
      end
    end

    # This example serializes a document as part of the payload.
    # @param [Hash | Types::DocumentTypeInput] params
    #   Request parameters for this operation.
    #   See {Types::DocumentTypeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    #   resp.data.document_value #=> Hash, Array, String, Boolean, Numeric
    def document_type(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::DocumentTypeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DocumentType.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :document_type,
        tracer: tracer
      )
      Telemetry::DocumentType.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#document_type] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#document_type] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#document_type] #{output.data}")
        output
      end
    end

    # This example serializes documents as the value of maps.
    # @param [Hash | Types::DocumentTypeAsMapValueInput] params
    #   Request parameters for this operation.
    #   See {Types::DocumentTypeAsMapValueInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.document_type_as_map_value(
    #     doc_valued_map: {
    #       'key' => {
    #         'nil' => nil,
    #         'number' => 123.0,
    #         'string' => 'value',
    #         'boolean' => true,
    #         'array' => [],
    #         'map' => {}
    #       }
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::DocumentTypeAsMapValueOutput
    #   resp.data.doc_valued_map #=> Hash<String, Hash, Array, String, Boolean, Numeric>
    #   resp.data.doc_valued_map['key'] #=> Hash, Array, String, Boolean, Numeric
    def document_type_as_map_value(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::DocumentTypeAsMapValueInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DocumentTypeAsMapValue.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :document_type_as_map_value,
        tracer: tracer
      )
      Telemetry::DocumentTypeAsMapValue.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_map_value] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#document_type_as_map_value] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_map_value] #{output.data}")
        output
      end
    end

    # This example serializes a document as the entire HTTP payload.
    # @param [Hash | Types::DocumentTypeAsPayloadInput] params
    #   Request parameters for this operation.
    #   See {Types::DocumentTypeAsPayloadInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    #   resp.data.document_value #=> Hash, Array, String, Boolean, Numeric
    def document_type_as_payload(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::DocumentTypeAsPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DocumentTypeAsPayload.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :document_type_as_payload,
        tracer: tracer
      )
      Telemetry::DocumentTypeAsPayload.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_payload] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#document_type_as_payload] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_payload] #{output.data}")
        output
      end
    end

    # The example tests how requests and responses are serialized when there's
    # no request or response payload because the operation has an empty input
    # and empty output structure that reuses the same shape. While this should
    # be rare, code generators must support this.
    # @param [Hash | Types::EmptyInputAndEmptyOutputInput] params
    #   Request parameters for this operation.
    #   See {Types::EmptyInputAndEmptyOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.empty_input_and_empty_output()
    # @example Response structure
    #   resp.data #=> Types::EmptyInputAndEmptyOutputOutput
    def empty_input_and_empty_output(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::EmptyInputAndEmptyOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::EmptyInputAndEmptyOutput.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :empty_input_and_empty_output,
        tracer: tracer
      )
      Telemetry::EmptyInputAndEmptyOutput.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#empty_input_and_empty_output] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#empty_input_and_empty_output] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#empty_input_and_empty_output] #{output.data}")
        output
      end
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
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::EndpointOperationInput.build(params, context: 'params')
      stack = RailsJson::Middleware::EndpointOperation.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :endpoint_operation,
        tracer: tracer
      )
      Telemetry::EndpointOperation.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_operation] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#endpoint_operation] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_operation] #{output.data}")
        output
      end
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
    #     label: 'label' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::EndpointWithHostLabelOperationOutput
    def endpoint_with_host_label_operation(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::EndpointWithHostLabelOperationInput.build(params, context: 'params')
      stack = RailsJson::Middleware::EndpointWithHostLabelOperation.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :endpoint_with_host_label_operation,
        tracer: tracer
      )
      Telemetry::EndpointWithHostLabelOperation.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_with_host_label_operation] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#endpoint_with_host_label_operation] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#endpoint_with_host_label_operation] #{output.data}")
        output
      end
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
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::FractionalSecondsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::FractionalSeconds.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :fractional_seconds,
        tracer: tracer
      )
      Telemetry::FractionalSeconds.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#fractional_seconds] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#fractional_seconds] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#fractional_seconds] #{output.data}")
        output
      end
    end

    # This operation has three possible return values:
    #
    # 1. A successful response in the form of GreetingWithErrorsOutput
    # 2. An InvalidGreeting error.
    # 3. A BadRequest error.
    #
    # Implementations must be able to successfully take a response and
    # properly (de)serialize successful and error responses based on the
    # the presence of the
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
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::GreetingWithErrorsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::GreetingWithErrors.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :greeting_with_errors,
        tracer: tracer
      )
      Telemetry::GreetingWithErrors.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::HostWithPathOperationInput] params
    #   Request parameters for this operation.
    #   See {Types::HostWithPathOperationInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.host_with_path_operation()
    # @example Response structure
    #   resp.data #=> Types::HostWithPathOperationOutput
    def host_with_path_operation(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HostWithPathOperationInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HostWithPathOperation.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :host_with_path_operation,
        tracer: tracer
      )
      Telemetry::HostWithPathOperation.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#host_with_path_operation] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#host_with_path_operation] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#host_with_path_operation] #{output.data}")
        output
      end
    end

    # This example tests httpChecksumRequired trait
    # @param [Hash | Types::HttpChecksumRequiredInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpChecksumRequiredInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_checksum_required(
    #     foo: 'foo'
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpChecksumRequiredOutput
    #   resp.data.foo #=> String
    def http_checksum_required(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpChecksumRequiredInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpChecksumRequired.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_checksum_required,
        tracer: tracer
      )
      Telemetry::HttpChecksumRequired.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_checksum_required] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_checksum_required] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_checksum_required] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::HttpEnumPayloadInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpEnumPayloadInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_enum_payload(
    #     payload: 'enumvalue' # accepts ["enumvalue"]
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpEnumPayloadOutput
    #   resp.data.payload #=> String, one of ["enumvalue"]
    def http_enum_payload(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpEnumPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpEnumPayload.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_enum_payload,
        tracer: tracer
      )
      Telemetry::HttpEnumPayload.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_enum_payload] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_enum_payload] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_enum_payload] #{output.data}")
        output
      end
    end

    # This example serializes a blob shape in the payload.
    #
    # In this example, no JSON document is synthesized because the payload is
    # not a structure or a union type.
    # @param [Hash | Types::HttpPayloadTraitsInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpPayloadTraitsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_payload_traits(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpPayloadTraitsOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> String
    def http_payload_traits(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpPayloadTraitsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadTraits.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_payload_traits,
        tracer: tracer
      )
      Telemetry::HttpPayloadTraits.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_traits] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits] #{output.data}")
        output
      end
    end

    # This example uses a `@mediaType` trait on the payload to force a custom
    # content-type to be serialized.
    # @param [Hash | Types::HttpPayloadTraitsWithMediaTypeInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpPayloadTraitsWithMediaTypeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_payload_traits_with_media_type(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpPayloadTraitsWithMediaTypeOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> String
    def http_payload_traits_with_media_type(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpPayloadTraitsWithMediaTypeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadTraitsWithMediaType.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_payload_traits_with_media_type,
        tracer: tracer
      )
      Telemetry::HttpPayloadTraitsWithMediaType.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits_with_media_type] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_traits_with_media_type] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits_with_media_type] #{output.data}")
        output
      end
    end

    # This example serializes a structure in the payload.
    #
    # Note that serializing a structure changes the wrapper element name
    # to match the targeted structure.
    # @param [Hash | Types::HttpPayloadWithStructureInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpPayloadWithStructureInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def http_payload_with_structure(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpPayloadWithStructureInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadWithStructure.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_payload_with_structure,
        tracer: tracer
      )
      Telemetry::HttpPayloadWithStructure.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_structure] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_with_structure] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_structure] #{output.data}")
        output
      end
    end

    # This example serializes a union in the payload.
    # @param [Hash | Types::HttpPayloadWithUnionInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpPayloadWithUnionInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_payload_with_union(
    #     nested: {
    #       # One of:
    #       greeting: 'greeting'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpPayloadWithUnionOutput
    #   resp.data.nested #=> Types::UnionPayload, one of [Greeting]
    #   resp.data.nested.greeting #=> String
    def http_payload_with_union(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpPayloadWithUnionInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadWithUnion.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_payload_with_union,
        tracer: tracer
      )
      Telemetry::HttpPayloadWithUnion.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_union] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_with_union] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_union] #{output.data}")
        output
      end
    end

    # This examples adds headers to the input of a request and response by prefix.
    # @see https://smithy.io/2.0/spec/http-bindings.html#httpprefixheaders-trait httpPrefixHeaders Trait
    # @param [Hash | Types::HttpPrefixHeadersInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpPrefixHeadersInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def http_prefix_headers(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpPrefixHeadersInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPrefixHeaders.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_prefix_headers,
        tracer: tracer
      )
      Telemetry::HttpPrefixHeaders.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_prefix_headers] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers] #{output.data}")
        output
      end
    end

    # Clients that perform this test extract all headers from the response.
    # @param [Hash | Types::HttpPrefixHeadersInResponseInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpPrefixHeadersInResponseInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_prefix_headers_in_response()
    # @example Response structure
    #   resp.data #=> Types::HttpPrefixHeadersInResponseOutput
    #   resp.data.prefix_headers #=> Hash<String, String>
    #   resp.data.prefix_headers['key'] #=> String
    def http_prefix_headers_in_response(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpPrefixHeadersInResponseInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPrefixHeadersInResponse.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_prefix_headers_in_response,
        tracer: tracer
      )
      Telemetry::HttpPrefixHeadersInResponse.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers_in_response] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_prefix_headers_in_response] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers_in_response] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::HttpRequestWithFloatLabelsInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithFloatLabelsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_request_with_float_labels(
    #     float: 1.0, # required
    #     double: 1.0 # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpRequestWithFloatLabelsOutput
    def http_request_with_float_labels(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpRequestWithFloatLabelsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithFloatLabels.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_request_with_float_labels,
        tracer: tracer
      )
      Telemetry::HttpRequestWithFloatLabels.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_float_labels] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_float_labels] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_float_labels] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::HttpRequestWithGreedyLabelInPathInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithGreedyLabelInPathInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_request_with_greedy_label_in_path(
    #     foo: 'foo', # required
    #     baz: 'baz' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpRequestWithGreedyLabelInPathOutput
    def http_request_with_greedy_label_in_path(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpRequestWithGreedyLabelInPathInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithGreedyLabelInPath.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_request_with_greedy_label_in_path,
        tracer: tracer
      )
      Telemetry::HttpRequestWithGreedyLabelInPath.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_greedy_label_in_path] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_greedy_label_in_path] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_greedy_label_in_path] #{output.data}")
        output
      end
    end

    # The example tests how requests are serialized when there's no input
    # payload but there are HTTP labels.
    # @param [Hash | Types::HttpRequestWithLabelsInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithLabelsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def http_request_with_labels(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpRequestWithLabelsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithLabels.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_request_with_labels,
        tracer: tracer
      )
      Telemetry::HttpRequestWithLabels.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_labels] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels] #{output.data}")
        output
      end
    end

    # The example tests how requests serialize different timestamp formats in the
    # URI path.
    # @param [Hash | Types::HttpRequestWithLabelsAndTimestampFormatInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithLabelsAndTimestampFormatInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def http_request_with_labels_and_timestamp_format(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpRequestWithLabelsAndTimestampFormatInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithLabelsAndTimestampFormat.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_request_with_labels_and_timestamp_format,
        tracer: tracer
      )
      Telemetry::HttpRequestWithLabelsAndTimestampFormat.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels_and_timestamp_format] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_labels_and_timestamp_format] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels_and_timestamp_format] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::HttpRequestWithRegexLiteralInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpRequestWithRegexLiteralInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_request_with_regex_literal(
    #     str: 'str' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpRequestWithRegexLiteralOutput
    def http_request_with_regex_literal(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpRequestWithRegexLiteralInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithRegexLiteral.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_request_with_regex_literal,
        tracer: tracer
      )
      Telemetry::HttpRequestWithRegexLiteral.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_regex_literal] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_regex_literal] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_regex_literal] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::HttpResponseCodeInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpResponseCodeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_response_code()
    # @example Response structure
    #   resp.data #=> Types::HttpResponseCodeOutput
    #   resp.data.status #=> Integer
    def http_response_code(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpResponseCodeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpResponseCode.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_response_code,
        tracer: tracer
      )
      Telemetry::HttpResponseCode.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_response_code] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_response_code] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_response_code] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::HttpStringPayloadInput] params
    #   Request parameters for this operation.
    #   See {Types::HttpStringPayloadInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.http_string_payload(
    #     payload: 'payload'
    #   )
    # @example Response structure
    #   resp.data #=> Types::HttpStringPayloadOutput
    #   resp.data.payload #=> String
    def http_string_payload(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::HttpStringPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpStringPayload.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :http_string_payload,
        tracer: tracer
      )
      Telemetry::HttpStringPayload.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_string_payload] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#http_string_payload] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#http_string_payload] #{output.data}")
        output
      end
    end

    # This example ensures that query string bound request parameters are
    # serialized in the body of responses if the structure is used in both
    # the request and response.
    # @param [Hash | Types::IgnoreQueryParamsInResponseInput] params
    #   Request parameters for this operation.
    #   See {Types::IgnoreQueryParamsInResponseInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.ignore_query_params_in_response()
    # @example Response structure
    #   resp.data #=> Types::IgnoreQueryParamsInResponseOutput
    #   resp.data.baz #=> String
    def ignore_query_params_in_response(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::IgnoreQueryParamsInResponseInput.build(params, context: 'params')
      stack = RailsJson::Middleware::IgnoreQueryParamsInResponse.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :ignore_query_params_in_response,
        tracer: tracer
      )
      Telemetry::IgnoreQueryParamsInResponse.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#ignore_query_params_in_response] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#ignore_query_params_in_response] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#ignore_query_params_in_response] #{output.data}")
        output
      end
    end

    # The example tests how requests and responses are serialized when there is
    # no input or output payload but there are HTTP header bindings.
    # @param [Hash | Types::InputAndOutputWithHeadersInput] params
    #   Request parameters for this operation.
    #   See {Types::InputAndOutputWithHeadersInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    #     ],
    #     header_integer_enum: 1,
    #     header_integer_enum_list: [
    #       1
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
    #   resp.data.header_integer_enum #=> Integer
    #   resp.data.header_integer_enum_list #=> Array<Integer>
    #   resp.data.header_integer_enum_list[0] #=> Integer
    def input_and_output_with_headers(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::InputAndOutputWithHeadersInput.build(params, context: 'params')
      stack = RailsJson::Middleware::InputAndOutputWithHeaders.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :input_and_output_with_headers,
        tracer: tracer
      )
      Telemetry::InputAndOutputWithHeaders.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#input_and_output_with_headers] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#input_and_output_with_headers] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#input_and_output_with_headers] #{output.data}")
        output
      end
    end

    # Blobs are base64 encoded
    # @param [Hash | Types::JsonBlobsInput] params
    #   Request parameters for this operation.
    #   See {Types::JsonBlobsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.json_blobs(
    #     data: 'data'
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonBlobsOutput
    #   resp.data.data #=> String
    def json_blobs(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::JsonBlobsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonBlobs.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :json_blobs,
        tracer: tracer
      )
      Telemetry::JsonBlobs.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_blobs] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#json_blobs] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_blobs] #{output.data}")
        output
      end
    end

    # This example serializes enums as top level properties, in lists, sets, and maps.
    # @param [Hash | Types::JsonEnumsInput] params
    #   Request parameters for this operation.
    #   See {Types::JsonEnumsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def json_enums(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::JsonEnumsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonEnums.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :json_enums,
        tracer: tracer
      )
      Telemetry::JsonEnums.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_enums] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#json_enums] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_enums] #{output.data}")
        output
      end
    end

    # This example serializes intEnums as top level properties, in lists, sets, and maps.
    # @param [Hash | Types::JsonIntEnumsInput] params
    #   Request parameters for this operation.
    #   See {Types::JsonIntEnumsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.json_int_enums(
    #     integer_enum1: 1,
    #     integer_enum2: 1,
    #     integer_enum3: 1,
    #     integer_enum_list: [
    #       1
    #     ],
    #     integer_enum_set: [
    #       1
    #     ],
    #     integer_enum_map: {
    #       'key' => 1
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonIntEnumsOutput
    #   resp.data.integer_enum1 #=> Integer
    #   resp.data.integer_enum2 #=> Integer
    #   resp.data.integer_enum3 #=> Integer
    #   resp.data.integer_enum_list #=> Array<Integer>
    #   resp.data.integer_enum_list[0] #=> Integer
    #   resp.data.integer_enum_set #=> Array<Integer>
    #   resp.data.integer_enum_set[0] #=> Integer
    #   resp.data.integer_enum_map #=> Hash<String, Integer>
    #   resp.data.integer_enum_map['key'] #=> Integer
    def json_int_enums(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::JsonIntEnumsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonIntEnums.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :json_int_enums,
        tracer: tracer
      )
      Telemetry::JsonIntEnums.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_int_enums] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#json_int_enums] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_int_enums] #{output.data}")
        output
      end
    end

    # This test case serializes JSON lists for the following cases for both
    # input and output:
    #
    # 1. Normal JSON lists.
    # 2. Normal JSON sets.
    # 3. JSON lists of lists.
    # 4. Lists of structures.
    # @param [Hash | Types::JsonListsInput] params
    #   Request parameters for this operation.
    #   See {Types::JsonListsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.json_lists(
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
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonListsOutput
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
    def json_lists(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::JsonListsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonLists.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :json_lists,
        tracer: tracer
      )
      Telemetry::JsonLists.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_lists] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#json_lists] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_lists] #{output.data}")
        output
      end
    end

    # The example tests basic map serialization.
    # @param [Hash | Types::JsonMapsInput] params
    #   Request parameters for this operation.
    #   See {Types::JsonMapsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    #     dense_set_map: {
    #       'key' => [
    #         'member'
    #       ]
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonMapsOutput
    #   resp.data.dense_struct_map #=> Hash<String, GreetingStruct>
    #   resp.data.dense_struct_map['key'] #=> Types::GreetingStruct
    #   resp.data.dense_struct_map['key'].hi #=> String
    #   resp.data.dense_number_map #=> Hash<String, Integer>
    #   resp.data.dense_number_map['key'] #=> Integer
    #   resp.data.dense_boolean_map #=> Hash<String, Boolean>
    #   resp.data.dense_boolean_map['key'] #=> Boolean
    #   resp.data.dense_string_map #=> Hash<String, String>
    #   resp.data.dense_string_map['key'] #=> String
    #   resp.data.dense_set_map #=> Hash<String, Array<String>>
    #   resp.data.dense_set_map['key'] #=> Array<String>
    #   resp.data.dense_set_map['key'][0] #=> String
    def json_maps(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::JsonMapsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonMaps.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :json_maps,
        tracer: tracer
      )
      Telemetry::JsonMaps.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_maps] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#json_maps] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_maps] #{output.data}")
        output
      end
    end

    # This tests how timestamps are serialized, including using the
    # default format of date-time and various @timestampFormat trait
    # values.
    # @param [Hash | Types::JsonTimestampsInput] params
    #   Request parameters for this operation.
    #   See {Types::JsonTimestampsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.json_timestamps(
    #     normal: Time.now,
    #     date_time: Time.now,
    #     date_time_on_target: Time.now,
    #     epoch_seconds: Time.now,
    #     epoch_seconds_on_target: Time.now,
    #     http_date: Time.now,
    #     http_date_on_target: Time.now
    #   )
    # @example Response structure
    #   resp.data #=> Types::JsonTimestampsOutput
    #   resp.data.normal #=> Time
    #   resp.data.date_time #=> Time
    #   resp.data.date_time_on_target #=> Time
    #   resp.data.epoch_seconds #=> Time
    #   resp.data.epoch_seconds_on_target #=> Time
    #   resp.data.http_date #=> Time
    #   resp.data.http_date_on_target #=> Time
    def json_timestamps(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::JsonTimestampsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonTimestamps.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :json_timestamps,
        tracer: tracer
      )
      Telemetry::JsonTimestamps.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_timestamps] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#json_timestamps] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_timestamps] #{output.data}")
        output
      end
    end

    # This operation uses unions for inputs and outputs.
    # @param [Hash | Types::JsonUnionsInput] params
    #   Request parameters for this operation.
    #   See {Types::JsonUnionsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def json_unions(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::JsonUnionsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonUnions.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :json_unions,
        tracer: tracer
      )
      Telemetry::JsonUnions.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_unions] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#json_unions] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#json_unions] #{output.data}")
        output
      end
    end

    # This example ensures that mediaType strings are base64 encoded in headers.
    # @param [Hash | Types::MediaTypeHeaderInput] params
    #   Request parameters for this operation.
    #   See {Types::MediaTypeHeaderInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.media_type_header(
    #     json: 'json'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MediaTypeHeaderOutput
    #   resp.data.json #=> String
    def media_type_header(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::MediaTypeHeaderInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MediaTypeHeader.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :media_type_header,
        tracer: tracer
      )
      Telemetry::MediaTypeHeader.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#media_type_header] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#media_type_header] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#media_type_header] #{output.data}")
        output
      end
    end

    # The example tests how requests and responses are serialized when there's
    # no request or response payload because the operation has no input or output.
    # While this should be rare, code generators must support this.
    # @param [Hash | Types::NoInputAndNoOutputInput] params
    #   Request parameters for this operation.
    #   See {Types::NoInputAndNoOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.no_input_and_no_output()
    # @example Response structure
    #   resp.data #=> Types::NoInputAndNoOutputOutput
    def no_input_and_no_output(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::NoInputAndNoOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NoInputAndNoOutput.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :no_input_and_no_output,
        tracer: tracer
      )
      Telemetry::NoInputAndNoOutput.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_no_output] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#no_input_and_no_output] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_no_output] #{output.data}")
        output
      end
    end

    # The example tests how requests and responses are serialized when there's
    # no request or response payload because the operation has no input and the
    # output is empty. While this should be rare, code generators must support
    # this.
    # @param [Hash | Types::NoInputAndOutputInput] params
    #   Request parameters for this operation.
    #   See {Types::NoInputAndOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.no_input_and_output()
    # @example Response structure
    #   resp.data #=> Types::NoInputAndOutputOutput
    def no_input_and_output(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::NoInputAndOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NoInputAndOutput.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :no_input_and_output,
        tracer: tracer
      )
      Telemetry::NoInputAndOutput.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_output] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#no_input_and_output] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_output] #{output.data}")
        output
      end
    end

    # Null and empty headers are not sent over the wire.
    # Tags: ["client-only"]
    # @param [Hash | Types::NullAndEmptyHeadersClientInput] params
    #   Request parameters for this operation.
    #   See {Types::NullAndEmptyHeadersClientInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def null_and_empty_headers_client(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::NullAndEmptyHeadersClientInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NullAndEmptyHeadersClient.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :null_and_empty_headers_client,
        tracer: tracer
      )
      Telemetry::NullAndEmptyHeadersClient.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_client] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_client] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_client] #{output.data}")
        output
      end
    end

    # Null and empty headers are not sent over the wire.
    # Tags: ["server-only"]
    # @param [Hash | Types::NullAndEmptyHeadersServerInput] params
    #   Request parameters for this operation.
    #   See {Types::NullAndEmptyHeadersServerInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.null_and_empty_headers_server(
    #     a: 'a',
    #     b: 'b',
    #     c: [
    #       'member'
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::NullAndEmptyHeadersServerOutput
    #   resp.data.a #=> String
    #   resp.data.b #=> String
    #   resp.data.c #=> Array<String>
    #   resp.data.c[0] #=> String
    def null_and_empty_headers_server(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::NullAndEmptyHeadersServerInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NullAndEmptyHeadersServer.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :null_and_empty_headers_server,
        tracer: tracer
      )
      Telemetry::NullAndEmptyHeadersServer.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_server] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_server] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_server] #{output.data}")
        output
      end
    end

    # Omits null, but serializes empty string value.
    # @param [Hash | Types::OmitsNullSerializesEmptyStringInput] params
    #   Request parameters for this operation.
    #   See {Types::OmitsNullSerializesEmptyStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.omits_null_serializes_empty_string(
    #     null_value: 'nullValue',
    #     empty_string: 'emptyString'
    #   )
    # @example Response structure
    #   resp.data #=> Types::OmitsNullSerializesEmptyStringOutput
    def omits_null_serializes_empty_string(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::OmitsNullSerializesEmptyStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::OmitsNullSerializesEmptyString.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :omits_null_serializes_empty_string,
        tracer: tracer
      )
      Telemetry::OmitsNullSerializesEmptyString.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#omits_null_serializes_empty_string] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#omits_null_serializes_empty_string] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#omits_null_serializes_empty_string] #{output.data}")
        output
      end
    end

    # Omits serializing empty lists. Because empty strings are serilized as
    # `Foo=`, empty lists cannot also be serialized as `Foo=` and instead
    # must be omitted.
    # Tags: ["client-only"]
    # @param [Hash | Types::OmitsSerializingEmptyListsInput] params
    #   Request parameters for this operation.
    #   See {Types::OmitsSerializingEmptyListsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.omits_serializing_empty_lists(
    #     query_string_list: [
    #       'member'
    #     ],
    #     query_integer_list: [
    #       1
    #     ],
    #     query_double_list: [
    #       1.0
    #     ],
    #     query_boolean_list: [
    #       false
    #     ],
    #     query_timestamp_list: [
    #       Time.now
    #     ],
    #     query_enum_list: [
    #       'Foo' # accepts ["Foo", "Baz", "Bar", "1", "0"]
    #     ],
    #     query_integer_enum_list: [
    #       1
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::OmitsSerializingEmptyListsOutput
    def omits_serializing_empty_lists(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::OmitsSerializingEmptyListsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::OmitsSerializingEmptyLists.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :omits_serializing_empty_lists,
        tracer: tracer
      )
      Telemetry::OmitsSerializingEmptyLists.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#omits_serializing_empty_lists] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#omits_serializing_empty_lists] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#omits_serializing_empty_lists] #{output.data}")
        output
      end
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
    #       default_document_map: {
    #         'nil' => nil,
    #         'number' => 123.0,
    #         'string' => 'value',
    #         'boolean' => true,
    #         'array' => [],
    #         'map' => {}
    #       },
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
    #   resp.data.default_document_map #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.default_document_string #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.default_document_boolean #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.default_document_list #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.default_null_document #=> Hash, Array, String, Boolean, Numeric
    #   resp.data.default_timestamp #=> Time
    #   resp.data.default_blob #=> String
    #   resp.data.default_byte #=> Integer
    #   resp.data.default_short #=> Integer
    #   resp.data.default_integer #=> Integer
    #   resp.data.default_long #=> Integer
    #   resp.data.default_float #=> Float
    #   resp.data.default_double #=> Float
    #   resp.data.default_map #=> Hash<String, String>
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
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::OperationWithDefaultsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::OperationWithDefaults.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :operation_with_defaults,
        tracer: tracer
      )
      Telemetry::OperationWithDefaults.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#operation_with_defaults] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#operation_with_defaults] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#operation_with_defaults] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::OperationWithNestedStructureInput] params
    #   Request parameters for this operation.
    #   See {Types::OperationWithNestedStructureInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.operation_with_nested_structure(
    #     top_level: {
    #       dialog: {
    #         language: 'language',
    #         greeting: 'greeting',
    #         farewell: {
    #           phrase: 'phrase'
    #         }
    #       }, # required
    #     } # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::OperationWithNestedStructureOutput
    #   resp.data.dialog #=> Types::Dialog
    #   resp.data.dialog.language #=> String
    #   resp.data.dialog.greeting #=> String
    #   resp.data.dialog.farewell #=> Types::Farewell
    #   resp.data.dialog.farewell.phrase #=> String
    #   resp.data.dialog_list #=> Array<Dialog>
    #   resp.data.dialog_map #=> Hash<String, Dialog>
    def operation_with_nested_structure(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::OperationWithNestedStructureInput.build(params, context: 'params')
      stack = RailsJson::Middleware::OperationWithNestedStructure.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :operation_with_nested_structure,
        tracer: tracer
      )
      Telemetry::OperationWithNestedStructure.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#operation_with_nested_structure] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#operation_with_nested_structure] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#operation_with_nested_structure] #{output.data}")
        output
      end
    end

    # This operation defines a union with a Unit member.
    # @param [Hash | Types::PostPlayerActionInput] params
    #   Request parameters for this operation.
    #   See {Types::PostPlayerActionInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.post_player_action(
    #     action: {
    #       # One of:
    #       quit: { }
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::PostPlayerActionOutput
    #   resp.data.action #=> Types::PlayerAction, one of [Quit]
    #   resp.data.action.quit #=> Types::Unit
    def post_player_action(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::PostPlayerActionInput.build(params, context: 'params')
      stack = RailsJson::Middleware::PostPlayerAction.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :post_player_action,
        tracer: tracer
      )
      Telemetry::PostPlayerAction.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#post_player_action] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#post_player_action] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#post_player_action] #{output.data}")
        output
      end
    end

    # This operation defines a union that uses jsonName on some members.
    # @param [Hash | Types::PostUnionWithJsonNameInput] params
    #   Request parameters for this operation.
    #   See {Types::PostUnionWithJsonNameInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.post_union_with_json_name(
    #     value: {
    #       # One of:
    #       foo: 'foo',
    #       bar: 'bar',
    #       baz: 'baz'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::PostUnionWithJsonNameOutput
    #   resp.data.value #=> Types::UnionWithJsonName, one of [Foo, Bar, Baz]
    #   resp.data.value.foo #=> String
    #   resp.data.value.bar #=> String
    #   resp.data.value.baz #=> String
    def post_union_with_json_name(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::PostUnionWithJsonNameInput.build(params, context: 'params')
      stack = RailsJson::Middleware::PostUnionWithJsonName.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :post_union_with_json_name,
        tracer: tracer
      )
      Telemetry::PostUnionWithJsonName.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#post_union_with_json_name] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#post_union_with_json_name] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#post_union_with_json_name] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::PutWithContentEncodingInput] params
    #   Request parameters for this operation.
    #   See {Types::PutWithContentEncodingInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.put_with_content_encoding(
    #     encoding: 'encoding',
    #     data: 'data'
    #   )
    # @example Response structure
    #   resp.data #=> Types::PutWithContentEncodingOutput
    def put_with_content_encoding(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::PutWithContentEncodingInput.build(params, context: 'params')
      stack = RailsJson::Middleware::PutWithContentEncoding.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :put_with_content_encoding,
        tracer: tracer
      )
      Telemetry::PutWithContentEncoding.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#put_with_content_encoding] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#put_with_content_encoding] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#put_with_content_encoding] #{output.data}")
        output
      end
    end

    # Automatically adds idempotency tokens.
    # Tags: ["client-only"]
    # @param [Hash | Types::QueryIdempotencyTokenAutoFillInput] params
    #   Request parameters for this operation.
    #   See {Types::QueryIdempotencyTokenAutoFillInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.query_idempotency_token_auto_fill(
    #     token: 'token'
    #   )
    # @example Response structure
    #   resp.data #=> Types::QueryIdempotencyTokenAutoFillOutput
    def query_idempotency_token_auto_fill(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::QueryIdempotencyTokenAutoFillInput.build(params, context: 'params')
      stack = RailsJson::Middleware::QueryIdempotencyTokenAutoFill.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :query_idempotency_token_auto_fill,
        tracer: tracer
      )
      Telemetry::QueryIdempotencyTokenAutoFill.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#query_idempotency_token_auto_fill] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#query_idempotency_token_auto_fill] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#query_idempotency_token_auto_fill] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::QueryParamsAsStringListMapInput] params
    #   Request parameters for this operation.
    #   See {Types::QueryParamsAsStringListMapInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def query_params_as_string_list_map(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::QueryParamsAsStringListMapInput.build(params, context: 'params')
      stack = RailsJson::Middleware::QueryParamsAsStringListMap.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :query_params_as_string_list_map,
        tracer: tracer
      )
      Telemetry::QueryParamsAsStringListMap.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#query_params_as_string_list_map] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#query_params_as_string_list_map] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#query_params_as_string_list_map] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::QueryPrecedenceInput] params
    #   Request parameters for this operation.
    #   See {Types::QueryPrecedenceInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.query_precedence(
    #     foo: 'foo',
    #     baz: {
    #       'key' => 'value'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::QueryPrecedenceOutput
    def query_precedence(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::QueryPrecedenceInput.build(params, context: 'params')
      stack = RailsJson::Middleware::QueryPrecedence.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :query_precedence,
        tracer: tracer
      )
      Telemetry::QueryPrecedence.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#query_precedence] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#query_precedence] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#query_precedence] #{output.data}")
        output
      end
    end

    # Recursive shapes
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
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::RecursiveShapesInput.build(params, context: 'params')
      stack = RailsJson::Middleware::RecursiveShapes.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :recursive_shapes,
        tracer: tracer
      )
      Telemetry::RecursiveShapes.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#recursive_shapes] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#recursive_shapes] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#recursive_shapes] #{output.data}")
        output
      end
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
    #     foo: 'foo',
    #     string_value: 'stringValue',
    #     true_boolean_value: false,
    #     false_boolean_value: false,
    #     byte_value: 1,
    #     short_value: 1,
    #     integer_value: 1,
    #     long_value: 1,
    #     float_value: 1.0,
    #     double_value: 1.0
    #   )
    # @example Response structure
    #   resp.data #=> Types::SimpleScalarPropertiesOutput
    #   resp.data.foo #=> String
    #   resp.data.string_value #=> String
    #   resp.data.true_boolean_value #=> Boolean
    #   resp.data.false_boolean_value #=> Boolean
    #   resp.data.byte_value #=> Integer
    #   resp.data.short_value #=> Integer
    #   resp.data.integer_value #=> Integer
    #   resp.data.long_value #=> Integer
    #   resp.data.float_value #=> Float
    #   resp.data.double_value #=> Float
    def simple_scalar_properties(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::SimpleScalarPropertiesInput.build(params, context: 'params')
      stack = RailsJson::Middleware::SimpleScalarProperties.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :simple_scalar_properties,
        tracer: tracer
      )
      Telemetry::SimpleScalarProperties.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] #{output.data}")
        output
      end
    end

    # @param [Hash | Types::SparseJsonListsInput] params
    #   Request parameters for this operation.
    #   See {Types::SparseJsonListsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.sparse_json_lists(
    #     sparse_string_list: [
    #       'member'
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::SparseJsonListsOutput
    #   resp.data.sparse_string_list #=> Array<String>
    #   resp.data.sparse_string_list[0] #=> String
    def sparse_json_lists(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::SparseJsonListsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::SparseJsonLists.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :sparse_json_lists,
        tracer: tracer
      )
      Telemetry::SparseJsonLists.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_lists] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#sparse_json_lists] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_lists] #{output.data}")
        output
      end
    end

    # This example tests sparse map serialization.
    # @param [Hash | Types::SparseJsonMapsInput] params
    #   Request parameters for this operation.
    #   See {Types::SparseJsonMapsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.sparse_json_maps(
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
    #   resp.data #=> Types::SparseJsonMapsOutput
    #   resp.data.sparse_struct_map #=> Hash<String, GreetingStruct>
    #   resp.data.sparse_struct_map['key'] #=> Types::GreetingStruct
    #   resp.data.sparse_struct_map['key'].hi #=> String
    #   resp.data.sparse_number_map #=> Hash<String, Integer>
    #   resp.data.sparse_number_map['key'] #=> Integer
    #   resp.data.sparse_boolean_map #=> Hash<String, Boolean>
    #   resp.data.sparse_boolean_map['key'] #=> Boolean
    #   resp.data.sparse_string_map #=> Hash<String, String>
    #   resp.data.sparse_string_map['key'] #=> String
    #   resp.data.sparse_set_map #=> Hash<String, Array<String>>
    #   resp.data.sparse_set_map['key'] #=> Array<String>
    #   resp.data.sparse_set_map['key'][0] #=> String
    def sparse_json_maps(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::SparseJsonMapsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::SparseJsonMaps.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :sparse_json_maps,
        tracer: tracer
      )
      Telemetry::SparseJsonMaps.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_maps] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#sparse_json_maps] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_maps] #{output.data}")
        output
      end
    end

    # This examples serializes a streaming blob shape in the request body.
    #
    # In this example, no JSON document is synthesized because the payload is
    # not a structure or a union type.
    # @param [Hash | Types::StreamingTraitsInput] params
    #   Request parameters for this operation.
    #   See {Types::StreamingTraitsInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.streaming_traits(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingTraitsOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> IO
    def streaming_traits(params = {}, options = {}, &block)
      response_body = output_stream(options, &block)
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::StreamingTraitsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::StreamingTraits.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :streaming_traits,
        tracer: tracer
      )
      Telemetry::StreamingTraits.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_traits] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits] #{output.data}")
        output
      end
    end

    # This examples serializes a streaming blob shape with a required content
    # length in the request body.
    #
    # In this example, no JSON document is synthesized because the payload is
    # not a structure or a union type.
    # @param [Hash | Types::StreamingTraitsRequireLengthInput] params
    #   Request parameters for this operation.
    #   See {Types::StreamingTraitsRequireLengthInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.streaming_traits_require_length(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingTraitsRequireLengthOutput
    def streaming_traits_require_length(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::StreamingTraitsRequireLengthInput.build(params, context: 'params')
      stack = RailsJson::Middleware::StreamingTraitsRequireLength.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :streaming_traits_require_length,
        tracer: tracer
      )
      Telemetry::StreamingTraitsRequireLength.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_require_length] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_traits_require_length] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_require_length] #{output.data}")
        output
      end
    end

    # This examples serializes a streaming media-typed blob shape in the request body.
    #
    # This examples uses a `@mediaType` trait on the payload to force a custom
    # content-type to be serialized.
    # @param [Hash | Types::StreamingTraitsWithMediaTypeInput] params
    #   Request parameters for this operation.
    #   See {Types::StreamingTraitsWithMediaTypeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.streaming_traits_with_media_type(
    #     foo: 'foo',
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::StreamingTraitsWithMediaTypeOutput
    #   resp.data.foo #=> String
    #   resp.data.blob #=> IO
    def streaming_traits_with_media_type(params = {}, options = {}, &block)
      response_body = output_stream(options, &block)
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::StreamingTraitsWithMediaTypeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::StreamingTraitsWithMediaType.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :streaming_traits_with_media_type,
        tracer: tracer
      )
      Telemetry::StreamingTraitsWithMediaType.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_with_media_type] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_traits_with_media_type] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_with_media_type] #{output.data}")
        output
      end
    end

    # This example operation serializes a structure in the HTTP body.
    #
    # It should ensure Content-Type: application/json is
    # used in all requests and that an "empty" body is
    # an empty JSON document ({}).
    #
    # @param [Hash | Types::TestBodyStructureInput] params
    #   Request parameters for this operation.
    #   See {Types::TestBodyStructureInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.test_body_structure(
    #     test_id: 'testId',
    #     test_config: {
    #       timeout: 1
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::TestBodyStructureOutput
    #   resp.data.test_id #=> String
    #   resp.data.test_config #=> Types::TestConfig
    #   resp.data.test_config.timeout #=> Integer
    def test_body_structure(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::TestBodyStructureInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestBodyStructure.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :test_body_structure,
        tracer: tracer
      )
      Telemetry::TestBodyStructure.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_body_structure] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#test_body_structure] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_body_structure] #{output.data}")
        output
      end
    end

    # This example operation serializes a request without an HTTP body.
    #
    # These tests are to ensure we do not attach a body or related headers
    # (Content-Length, Content-Type) to operations that semantically
    # cannot produce an HTTP body.
    #
    # @param [Hash | Types::TestNoPayloadInput] params
    #   Request parameters for this operation.
    #   See {Types::TestNoPayloadInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.test_no_payload(
    #     test_id: 'testId'
    #   )
    # @example Response structure
    #   resp.data #=> Types::TestNoPayloadOutput
    #   resp.data.test_id #=> String
    def test_no_payload(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::TestNoPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestNoPayload.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :test_no_payload,
        tracer: tracer
      )
      Telemetry::TestNoPayload.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_no_payload] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#test_no_payload] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_no_payload] #{output.data}")
        output
      end
    end

    # This example operation serializes a payload targeting a blob.
    #
    # The Blob shape is not structured content and we cannot
    # make assumptions about what data will be sent. This test ensures
    # only a generic "Content-Type: application/octet-stream" header
    # is used, and that we are not treating an empty body as an
    # empty JSON document.
    #
    # @param [Hash | Types::TestPayloadBlobInput] params
    #   Request parameters for this operation.
    #   See {Types::TestPayloadBlobInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.test_payload_blob(
    #     content_type: 'contentType',
    #     data: 'data'
    #   )
    # @example Response structure
    #   resp.data #=> Types::TestPayloadBlobOutput
    #   resp.data.content_type #=> String
    #   resp.data.data #=> String
    def test_payload_blob(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::TestPayloadBlobInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestPayloadBlob.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :test_payload_blob,
        tracer: tracer
      )
      Telemetry::TestPayloadBlob.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_blob] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#test_payload_blob] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_blob] #{output.data}")
        output
      end
    end

    # This example operation serializes a payload targeting a structure.
    #
    # This enforces the same requirements as TestBodyStructure
    # but with the body specified by the @httpPayload trait.
    #
    # @param [Hash | Types::TestPayloadStructureInput] params
    #   Request parameters for this operation.
    #   See {Types::TestPayloadStructureInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.test_payload_structure(
    #     test_id: 'testId',
    #     payload_config: {
    #       data: 1
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::TestPayloadStructureOutput
    #   resp.data.test_id #=> String
    #   resp.data.payload_config #=> Types::PayloadConfig
    #   resp.data.payload_config.data #=> Integer
    def test_payload_structure(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::TestPayloadStructureInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestPayloadStructure.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :test_payload_structure,
        tracer: tracer
      )
      Telemetry::TestPayloadStructure.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_structure] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#test_payload_structure] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_structure] #{output.data}")
        output
      end
    end

    # This example tests how timestamp request and response headers are serialized.
    # @param [Hash | Types::TimestampFormatHeadersInput] params
    #   Request parameters for this operation.
    #   See {Types::TimestampFormatHeadersInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
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
    def timestamp_format_headers(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::TimestampFormatHeadersInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TimestampFormatHeaders.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :timestamp_format_headers,
        tracer: tracer
      )
      Telemetry::TimestampFormatHeaders.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#timestamp_format_headers] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#timestamp_format_headers] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#timestamp_format_headers] #{output.data}")
        output
      end
    end

    # This test is similar to NoInputAndNoOutput, but uses explicit Unit types.
    # @param [Hash | Types::UnitInputAndOutputInput] params
    #   Request parameters for this operation.
    #   See {Types::UnitInputAndOutputInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.unit_input_and_output()
    # @example Response structure
    #   resp.data #=> Types::UnitInputAndOutputOutput
    def unit_input_and_output(params = {}, options = {})
      response_body = ::StringIO.new
      middleware_opts = {}
      config = operation_config(options)
      tracer = config.telemetry_provider.tracer_provider.tracer('railsjson.client')
      input = Params::UnitInputAndOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::UnitInputAndOutput.build(config, middleware_opts)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        config: config,
        operation_name: :unit_input_and_output,
        tracer: tracer
      )
      Telemetry::UnitInputAndOutput.in_span(context) do
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#unit_input_and_output] params: #{params}, options: #{options}")
        output = stack.run(input, context)
        if output.error
          context.config.logger.error("[#{context.invocation_id}] [#{self.class}#unit_input_and_output] #{output.error} (#{output.error.class})")
          raise output.error
        end
        context.config.logger.info("[#{context.invocation_id}] [#{self.class}#unit_input_and_output] #{output.data}")
        output
      end
    end
  end
end
