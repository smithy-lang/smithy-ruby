# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Rpcv2Cbor
  # @api private
  module Middleware

    class EmptyInputOutput
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::EmptyInputOutputInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::EmptyInputOutput
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :empty_input_output),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::EmptyInputOutput
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::EmptyInputOutput,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::EmptyInputOutput,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class Float16
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::Float16Input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::Float16
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :float16),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::Float16
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::Float16,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::Float16,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class FractionalSeconds
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::FractionalSecondsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::FractionalSeconds
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :fractional_seconds),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::FractionalSeconds
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::FractionalSeconds,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::FractionalSeconds,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class GreetingWithErrors
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::GreetingWithErrorsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::GreetingWithErrors
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :greeting_with_errors),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::GreetingWithErrors
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::GreetingWithErrors,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: [Errors::InvalidGreeting, Errors::ComplexError]
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::GreetingWithErrors,
          stub_error_classes: [Stubs::InvalidGreeting, Stubs::ComplexError],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class NoInputOutput
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::NoInputOutputInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::NoInputOutput
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :no_input_output),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::NoInputOutput
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::NoInputOutput,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::NoInputOutput,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class OperationWithDefaults
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::OperationWithDefaultsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::OperationWithDefaults
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :operation_with_defaults),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::OperationWithDefaults
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::OperationWithDefaults,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: [Errors::ValidationException]
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::OperationWithDefaults,
          stub_error_classes: [Stubs::ValidationException],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class OptionalInputOutput
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::OptionalInputOutputInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::OptionalInputOutput
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :optional_input_output),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::OptionalInputOutput
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::OptionalInputOutput,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::OptionalInputOutput,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class RecursiveShapes
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::RecursiveShapesInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RecursiveShapes
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :recursive_shapes),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::RecursiveShapes
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::RecursiveShapes,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::RecursiveShapes,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class RpcV2CborDenseMaps
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::RpcV2CborDenseMapsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RpcV2CborDenseMaps
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :rpc_v2_cbor_dense_maps),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::RpcV2CborDenseMaps
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::RpcV2CborDenseMaps,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: [Errors::ValidationException]
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::RpcV2CborDenseMaps,
          stub_error_classes: [Stubs::ValidationException],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class RpcV2CborLists
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::RpcV2CborListsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RpcV2CborLists
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :rpc_v2_cbor_lists),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::RpcV2CborLists
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::RpcV2CborLists,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: [Errors::ValidationException]
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::RpcV2CborLists,
          stub_error_classes: [Stubs::ValidationException],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class RpcV2CborSparseMaps
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::RpcV2CborSparseMapsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::RpcV2CborSparseMaps
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :rpc_v2_cbor_sparse_maps),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::RpcV2CborSparseMaps
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::RpcV2CborSparseMaps,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: [Errors::ValidationException]
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::RpcV2CborSparseMaps,
          stub_error_classes: [Stubs::ValidationException],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class SimpleScalarProperties
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::SimpleScalarPropertiesInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::SimpleScalarProperties
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :simple_scalar_properties),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::SimpleScalarProperties
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::SimpleScalarProperties,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::SimpleScalarProperties,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class SparseNullsOperation
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::SparseNullsOperationInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::SparseNullsOperation
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :sparse_nulls_operation),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::SparseNullsOperation
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::SparseNullsOperation,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          response_events: false,
          stub_data_class: Stubs::SparseNullsOperation,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

  end
end
