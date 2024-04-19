# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require 'stringio'

module RailsJson
  # A REST JSON service that sends JSON requests and responses.
  class Client
    include Hearth::ClientStubs

    # @api private
    @plugins = Hearth::PluginList.new

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
      config = operation_config(options)
      input = Params::AllQueryStringTypesInput.build(params, context: 'params')
      stack = RailsJson::Middleware::AllQueryStringTypes.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :all_query_string_types,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#all_query_string_types] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#all_query_string_types] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#all_query_string_types] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::ConstantAndVariableQueryStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::ConstantAndVariableQueryString.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :constant_and_variable_query_string,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#constant_and_variable_query_string] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#constant_and_variable_query_string] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#constant_and_variable_query_string] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::ConstantQueryStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::ConstantQueryString.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :constant_query_string,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#constant_query_string] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#constant_query_string] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#constant_query_string] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::DatetimeOffsetsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DatetimeOffsets.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :datetime_offsets,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#datetime_offsets] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#datetime_offsets] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#datetime_offsets] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::DocumentTypeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DocumentType.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :document_type,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#document_type] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#document_type] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#document_type] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::DocumentTypeAsMapValueInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DocumentTypeAsMapValue.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :document_type_as_map_value,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_map_value] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#document_type_as_map_value] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_map_value] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::DocumentTypeAsPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::DocumentTypeAsPayload.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :document_type_as_payload,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_payload] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#document_type_as_payload] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#document_type_as_payload] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::EmptyInputAndEmptyOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::EmptyInputAndEmptyOutput.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :empty_input_and_empty_output,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#empty_input_and_empty_output] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#empty_input_and_empty_output] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#empty_input_and_empty_output] #{output.data}")
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
      stack = RailsJson::Middleware::EndpointOperation.build(config, @stubs)
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
    #     label: 'label' # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::EndpointWithHostLabelOperationOutput
    def endpoint_with_host_label_operation(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::EndpointWithHostLabelOperationInput.build(params, context: 'params')
      stack = RailsJson::Middleware::EndpointWithHostLabelOperation.build(config, @stubs)
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
      stack = RailsJson::Middleware::FractionalSeconds.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :fractional_seconds,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#fractional_seconds] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#fractional_seconds] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#fractional_seconds] #{output.data}")
      output
    end

    # This operation has four possible return values:
    #
    # 1. A successful response in the form of GreetingWithErrorsOutput
    # 2. An InvalidGreeting error.
    # 3. A BadRequest error.
    # 4. A FooError.
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
      config = operation_config(options)
      input = Params::GreetingWithErrorsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::GreetingWithErrors.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :greeting_with_errors,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#greeting_with_errors] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HostWithPathOperationInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HostWithPathOperation.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :host_with_path_operation,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#host_with_path_operation] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#host_with_path_operation] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#host_with_path_operation] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpChecksumRequiredInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpChecksumRequired.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_checksum_required,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_checksum_required] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_checksum_required] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_checksum_required] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpEnumPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpEnumPayload.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_enum_payload,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_enum_payload] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_enum_payload] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_enum_payload] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpPayloadTraitsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadTraits.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_payload_traits,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_traits] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpPayloadTraitsWithMediaTypeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadTraitsWithMediaType.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_payload_traits_with_media_type,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits_with_media_type] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_traits_with_media_type] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_traits_with_media_type] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpPayloadWithStructureInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadWithStructure.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_payload_with_structure,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_structure] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_with_structure] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_structure] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpPayloadWithUnionInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPayloadWithUnion.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_payload_with_union,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_union] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_payload_with_union] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_payload_with_union] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpPrefixHeadersInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPrefixHeaders.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_prefix_headers,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_prefix_headers] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpPrefixHeadersInResponseInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpPrefixHeadersInResponse.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_prefix_headers_in_response,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers_in_response] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_prefix_headers_in_response] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_prefix_headers_in_response] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpRequestWithFloatLabelsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithFloatLabels.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_request_with_float_labels,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_float_labels] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_float_labels] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_float_labels] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpRequestWithGreedyLabelInPathInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithGreedyLabelInPath.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_request_with_greedy_label_in_path,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_greedy_label_in_path] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_greedy_label_in_path] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_greedy_label_in_path] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpRequestWithLabelsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithLabels.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_request_with_labels,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_labels] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpRequestWithLabelsAndTimestampFormatInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithLabelsAndTimestampFormat.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_request_with_labels_and_timestamp_format,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels_and_timestamp_format] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_labels_and_timestamp_format] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_labels_and_timestamp_format] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpRequestWithRegexLiteralInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpRequestWithRegexLiteral.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_request_with_regex_literal,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_regex_literal] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_request_with_regex_literal] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_request_with_regex_literal] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpResponseCodeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpResponseCode.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_response_code,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_response_code] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_response_code] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_response_code] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::HttpStringPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::HttpStringPayload.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :http_string_payload,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_string_payload] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#http_string_payload] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#http_string_payload] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::IgnoreQueryParamsInResponseInput.build(params, context: 'params')
      stack = RailsJson::Middleware::IgnoreQueryParamsInResponse.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :ignore_query_params_in_response,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#ignore_query_params_in_response] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#ignore_query_params_in_response] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#ignore_query_params_in_response] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::InputAndOutputWithHeadersInput.build(params, context: 'params')
      stack = RailsJson::Middleware::InputAndOutputWithHeaders.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :input_and_output_with_headers,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#input_and_output_with_headers] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#input_and_output_with_headers] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#input_and_output_with_headers] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::JsonBlobsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonBlobs.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :json_blobs,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_blobs] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#json_blobs] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_blobs] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::JsonEnumsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonEnums.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :json_enums,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_enums] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#json_enums] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_enums] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::JsonIntEnumsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonIntEnums.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :json_int_enums,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_int_enums] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#json_int_enums] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_int_enums] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::JsonListsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonLists.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :json_lists,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_lists] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#json_lists] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_lists] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::JsonMapsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonMaps.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :json_maps,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_maps] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#json_maps] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_maps] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::JsonTimestampsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonTimestamps.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :json_timestamps,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_timestamps] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#json_timestamps] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_timestamps] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::JsonUnionsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::JsonUnions.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :json_unions,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_unions] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#json_unions] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#json_unions] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedAcceptWithBodyInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedAcceptWithBodyInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_accept_with_body()
    # @example Response structure
    #   resp.data #=> Types::MalformedAcceptWithBodyOutput
    #   resp.data.hi #=> String
    def malformed_accept_with_body(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedAcceptWithBodyInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedAcceptWithBody.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_accept_with_body,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_body] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_body] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_body] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedAcceptWithGenericStringInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedAcceptWithGenericStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_accept_with_generic_string()
    # @example Response structure
    #   resp.data #=> Types::MalformedAcceptWithGenericStringOutput
    #   resp.data.payload #=> String
    def malformed_accept_with_generic_string(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedAcceptWithGenericStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedAcceptWithGenericString.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_accept_with_generic_string,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_generic_string] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_generic_string] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_generic_string] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedAcceptWithPayloadInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedAcceptWithPayloadInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_accept_with_payload()
    # @example Response structure
    #   resp.data #=> Types::MalformedAcceptWithPayloadOutput
    #   resp.data.payload #=> String
    def malformed_accept_with_payload(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedAcceptWithPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedAcceptWithPayload.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_accept_with_payload,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_payload] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_payload] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_accept_with_payload] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedBlobInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedBlobInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_blob(
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedBlobOutput
    def malformed_blob(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedBlobInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedBlob.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_blob,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_blob] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_blob] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_blob] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedBooleanInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedBooleanInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_boolean(
    #     boolean_in_body: false,
    #     boolean_in_path: false, # required
    #     boolean_in_query: false,
    #     boolean_in_header: false
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedBooleanOutput
    def malformed_boolean(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedBooleanInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedBoolean.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_boolean,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_boolean] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_boolean] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_boolean] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedByteInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedByteInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_byte(
    #     byte_in_body: 1,
    #     byte_in_path: 1, # required
    #     byte_in_query: 1,
    #     byte_in_header: 1
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedByteOutput
    def malformed_byte(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedByteInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedByte.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_byte,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_byte] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_byte] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_byte] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedContentTypeWithBodyInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedContentTypeWithBodyInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_content_type_with_body(
    #     hi: 'hi'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedContentTypeWithBodyOutput
    def malformed_content_type_with_body(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedContentTypeWithBodyInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedContentTypeWithBody.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_content_type_with_body,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_body] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_body] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_body] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedContentTypeWithGenericStringInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedContentTypeWithGenericStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_content_type_with_generic_string(
    #     payload: 'payload'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedContentTypeWithGenericStringOutput
    def malformed_content_type_with_generic_string(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedContentTypeWithGenericStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedContentTypeWithGenericString.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_content_type_with_generic_string,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_generic_string] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_generic_string] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_generic_string] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedContentTypeWithPayloadInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedContentTypeWithPayloadInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_content_type_with_payload(
    #     payload: 'payload'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedContentTypeWithPayloadOutput
    def malformed_content_type_with_payload(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedContentTypeWithPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedContentTypeWithPayload.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_content_type_with_payload,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_payload] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_payload] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_with_payload] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedContentTypeWithoutBodyInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedContentTypeWithoutBodyInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_content_type_without_body()
    # @example Response structure
    #   resp.data #=> Types::MalformedContentTypeWithoutBodyOutput
    def malformed_content_type_without_body(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedContentTypeWithoutBodyInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedContentTypeWithoutBody.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_content_type_without_body,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_without_body] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_content_type_without_body] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_content_type_without_body] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedDoubleInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedDoubleInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_double(
    #     double_in_body: 1.0,
    #     double_in_path: 1.0, # required
    #     double_in_query: 1.0,
    #     double_in_header: 1.0
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedDoubleOutput
    def malformed_double(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedDoubleInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedDouble.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_double,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_double] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_double] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_double] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedFloatInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedFloatInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_float(
    #     float_in_body: 1.0,
    #     float_in_path: 1.0, # required
    #     float_in_query: 1.0,
    #     float_in_header: 1.0
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedFloatOutput
    def malformed_float(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedFloatInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedFloat.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_float,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_float] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_float] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_float] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedIntegerInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedIntegerInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_integer(
    #     integer_in_body: 1,
    #     integer_in_path: 1, # required
    #     integer_in_query: 1,
    #     integer_in_header: 1
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedIntegerOutput
    def malformed_integer(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedIntegerInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedInteger.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_integer,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_integer] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_integer] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_integer] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedListInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedListInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_list(
    #     body_list: [
    #       'member'
    #     ]
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedListOutput
    def malformed_list(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedListInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedList.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_list,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_list] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_list] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_list] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedLongInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedLongInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_long(
    #     long_in_body: 1,
    #     long_in_path: 1, # required
    #     long_in_query: 1,
    #     long_in_header: 1
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedLongOutput
    def malformed_long(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedLongInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedLong.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_long,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_long] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_long] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_long] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedMapInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedMapInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_map(
    #     body_map: {
    #       'key' => 'value'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedMapOutput
    def malformed_map(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedMapInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedMap.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_map,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_map] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_map] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_map] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedRequestBodyInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedRequestBodyInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_request_body(
    #     int: 1,
    #     float: 1.0
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedRequestBodyOutput
    def malformed_request_body(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedRequestBodyInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedRequestBody.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_request_body,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_request_body] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_request_body] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_request_body] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedShortInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedShortInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_short(
    #     short_in_body: 1,
    #     short_in_path: 1, # required
    #     short_in_query: 1,
    #     short_in_header: 1
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedShortOutput
    def malformed_short(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedShortInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedShort.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_short,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_short] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_short] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_short] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedStringInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedStringInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_string(
    #     blob: 'blob'
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedStringOutput
    def malformed_string(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedString.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_string,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_string] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_string] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_string] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampBodyDateTimeInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampBodyDateTimeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_body_date_time(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampBodyDateTimeOutput
    def malformed_timestamp_body_date_time(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampBodyDateTimeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampBodyDateTime.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_body_date_time,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_date_time] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_date_time] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_date_time] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampBodyDefaultInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampBodyDefaultInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_body_default(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampBodyDefaultOutput
    def malformed_timestamp_body_default(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampBodyDefaultInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampBodyDefault.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_body_default,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_default] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_default] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_default] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampBodyHttpDateInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampBodyHttpDateInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_body_http_date(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampBodyHttpDateOutput
    def malformed_timestamp_body_http_date(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampBodyHttpDateInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampBodyHttpDate.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_body_http_date,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_http_date] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_http_date] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_body_http_date] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampHeaderDateTimeInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampHeaderDateTimeInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_header_date_time(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampHeaderDateTimeOutput
    def malformed_timestamp_header_date_time(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampHeaderDateTimeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampHeaderDateTime.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_header_date_time,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_date_time] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_date_time] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_date_time] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampHeaderDefaultInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampHeaderDefaultInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_header_default(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampHeaderDefaultOutput
    def malformed_timestamp_header_default(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampHeaderDefaultInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampHeaderDefault.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_header_default,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_default] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_default] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_default] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampHeaderEpochInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampHeaderEpochInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_header_epoch(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampHeaderEpochOutput
    def malformed_timestamp_header_epoch(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampHeaderEpochInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampHeaderEpoch.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_header_epoch,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_epoch] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_epoch] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_header_epoch] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampPathDefaultInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampPathDefaultInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_path_default(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampPathDefaultOutput
    def malformed_timestamp_path_default(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampPathDefaultInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampPathDefault.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_path_default,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_default] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_default] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_default] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampPathEpochInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampPathEpochInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_path_epoch(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampPathEpochOutput
    def malformed_timestamp_path_epoch(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampPathEpochInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampPathEpoch.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_path_epoch,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_epoch] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_epoch] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_epoch] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampPathHttpDateInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampPathHttpDateInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_path_http_date(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampPathHttpDateOutput
    def malformed_timestamp_path_http_date(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampPathHttpDateInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampPathHttpDate.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_path_http_date,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_http_date] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_http_date] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_path_http_date] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampQueryDefaultInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampQueryDefaultInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_query_default(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampQueryDefaultOutput
    def malformed_timestamp_query_default(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampQueryDefaultInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampQueryDefault.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_query_default,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_default] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_default] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_default] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampQueryEpochInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampQueryEpochInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_query_epoch(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampQueryEpochOutput
    def malformed_timestamp_query_epoch(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampQueryEpochInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampQueryEpoch.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_query_epoch,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_epoch] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_epoch] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_epoch] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedTimestampQueryHttpDateInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedTimestampQueryHttpDateInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_timestamp_query_http_date(
    #     timestamp: Time.now # required
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedTimestampQueryHttpDateOutput
    def malformed_timestamp_query_http_date(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedTimestampQueryHttpDateInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedTimestampQueryHttpDate.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_timestamp_query_http_date,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_http_date] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_http_date] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_timestamp_query_http_date] #{output.data}")
      output
    end

    # @param [Hash | Types::MalformedUnionInput] params
    #   Request parameters for this operation.
    #   See {Types::MalformedUnionInput#initialize} for available parameters.
    # @param [Hash] options
    #   Request option override of configuration. See {Config#initialize} for available options.
    #   Some configurations cannot be overridden.
    # @return [Hearth::Output]
    # @example Request syntax with placeholder values
    #   resp = client.malformed_union(
    #     union: {
    #       # One of:
    #       int: 1,
    #       string: 'string'
    #     }
    #   )
    # @example Response structure
    #   resp.data #=> Types::MalformedUnionOutput
    def malformed_union(params = {}, options = {})
      response_body = ::StringIO.new
      config = operation_config(options)
      input = Params::MalformedUnionInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MalformedUnion.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :malformed_union,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_union] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#malformed_union] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#malformed_union] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::MediaTypeHeaderInput.build(params, context: 'params')
      stack = RailsJson::Middleware::MediaTypeHeader.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :media_type_header,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#media_type_header] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#media_type_header] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#media_type_header] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::NoInputAndNoOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NoInputAndNoOutput.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :no_input_and_no_output,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_no_output] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#no_input_and_no_output] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_no_output] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::NoInputAndOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NoInputAndOutput.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :no_input_and_output,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_output] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#no_input_and_output] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#no_input_and_output] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::NullAndEmptyHeadersClientInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NullAndEmptyHeadersClient.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :null_and_empty_headers_client,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_client] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_client] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_client] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::NullAndEmptyHeadersServerInput.build(params, context: 'params')
      stack = RailsJson::Middleware::NullAndEmptyHeadersServer.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :null_and_empty_headers_server,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_server] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_server] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#null_and_empty_headers_server] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::OmitsNullSerializesEmptyStringInput.build(params, context: 'params')
      stack = RailsJson::Middleware::OmitsNullSerializesEmptyString.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :omits_null_serializes_empty_string,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#omits_null_serializes_empty_string] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#omits_null_serializes_empty_string] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#omits_null_serializes_empty_string] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::OmitsSerializingEmptyListsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::OmitsSerializingEmptyLists.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :omits_serializing_empty_lists,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#omits_serializing_empty_lists] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#omits_serializing_empty_lists] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#omits_serializing_empty_lists] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::PostPlayerActionInput.build(params, context: 'params')
      stack = RailsJson::Middleware::PostPlayerAction.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :post_player_action,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#post_player_action] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#post_player_action] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#post_player_action] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::PostUnionWithJsonNameInput.build(params, context: 'params')
      stack = RailsJson::Middleware::PostUnionWithJsonName.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :post_union_with_json_name,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#post_union_with_json_name] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#post_union_with_json_name] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#post_union_with_json_name] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::PutWithContentEncodingInput.build(params, context: 'params')
      stack = RailsJson::Middleware::PutWithContentEncoding.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :put_with_content_encoding,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#put_with_content_encoding] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#put_with_content_encoding] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#put_with_content_encoding] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::QueryIdempotencyTokenAutoFillInput.build(params, context: 'params')
      stack = RailsJson::Middleware::QueryIdempotencyTokenAutoFill.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :query_idempotency_token_auto_fill,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#query_idempotency_token_auto_fill] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#query_idempotency_token_auto_fill] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#query_idempotency_token_auto_fill] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::QueryParamsAsStringListMapInput.build(params, context: 'params')
      stack = RailsJson::Middleware::QueryParamsAsStringListMap.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :query_params_as_string_list_map,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#query_params_as_string_list_map] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#query_params_as_string_list_map] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#query_params_as_string_list_map] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::QueryPrecedenceInput.build(params, context: 'params')
      stack = RailsJson::Middleware::QueryPrecedence.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :query_precedence,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#query_precedence] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#query_precedence] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#query_precedence] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::RecursiveShapesInput.build(params, context: 'params')
      stack = RailsJson::Middleware::RecursiveShapes.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :recursive_shapes,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#recursive_shapes] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#recursive_shapes] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#recursive_shapes] #{output.data}")
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
      config = operation_config(options)
      input = Params::SimpleScalarPropertiesInput.build(params, context: 'params')
      stack = RailsJson::Middleware::SimpleScalarProperties.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :simple_scalar_properties,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#simple_scalar_properties] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::SparseJsonListsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::SparseJsonLists.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :sparse_json_lists,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_lists] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#sparse_json_lists] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_lists] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::SparseJsonMapsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::SparseJsonMaps.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :sparse_json_maps,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_maps] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#sparse_json_maps] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#sparse_json_maps] #{output.data}")
      output
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
    #   resp.data.blob #=> String
    def streaming_traits(params = {}, options = {}, &block)
      response_body = output_stream(options, &block)
      config = operation_config(options)
      input = Params::StreamingTraitsInput.build(params, context: 'params')
      stack = RailsJson::Middleware::StreamingTraits.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :streaming_traits,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_traits] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::StreamingTraitsRequireLengthInput.build(params, context: 'params')
      stack = RailsJson::Middleware::StreamingTraitsRequireLength.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :streaming_traits_require_length,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_require_length] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_traits_require_length] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_require_length] #{output.data}")
      output
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
    #   resp.data.blob #=> String
    def streaming_traits_with_media_type(params = {}, options = {}, &block)
      response_body = output_stream(options, &block)
      config = operation_config(options)
      input = Params::StreamingTraitsWithMediaTypeInput.build(params, context: 'params')
      stack = RailsJson::Middleware::StreamingTraitsWithMediaType.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :streaming_traits_with_media_type,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_with_media_type] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#streaming_traits_with_media_type] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#streaming_traits_with_media_type] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::TestBodyStructureInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestBodyStructure.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :test_body_structure,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_body_structure] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#test_body_structure] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_body_structure] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::TestNoPayloadInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestNoPayload.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :test_no_payload,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_no_payload] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#test_no_payload] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_no_payload] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::TestPayloadBlobInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestPayloadBlob.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :test_payload_blob,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_blob] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#test_payload_blob] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_blob] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::TestPayloadStructureInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TestPayloadStructure.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :test_payload_structure,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_structure] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#test_payload_structure] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#test_payload_structure] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::TimestampFormatHeadersInput.build(params, context: 'params')
      stack = RailsJson::Middleware::TimestampFormatHeaders.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :timestamp_format_headers,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#timestamp_format_headers] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#timestamp_format_headers] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#timestamp_format_headers] #{output.data}")
      output
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
      config = operation_config(options)
      input = Params::UnitInputAndOutputInput.build(params, context: 'params')
      stack = RailsJson::Middleware::UnitInputAndOutput.build(config, @stubs)
      context = Hearth::Context.new(
        request: Hearth::HTTP::Request.new(uri: URI('')),
        response: Hearth::HTTP::Response.new(body: response_body),
        logger: config.logger,
        operation_name: :unit_input_and_output,
        interceptors: config.interceptors
      )
      context.logger.info("[#{context.invocation_id}] [#{self.class}#unit_input_and_output] params: #{params}, options: #{options}")
      output = stack.run(input, context)
      if output.error
        context.logger.error("[#{context.invocation_id}] [#{self.class}#unit_input_and_output] #{output.error} (#{output.error.class})")
        raise output.error
      end
      context.logger.info("[#{context.invocation_id}] [#{self.class}#unit_input_and_output] #{output.data}")
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
