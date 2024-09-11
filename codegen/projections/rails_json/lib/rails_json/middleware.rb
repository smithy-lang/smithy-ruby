# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

require_relative 'middleware/request_id'

module RailsJson
  # @api private
  module Middleware

    class AllQueryStringTypes
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::AllQueryStringTypesInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::AllQueryStringTypes
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :all_query_string_types),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::AllQueryStringTypes
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::AllQueryStringTypes,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::AllQueryStringTypes,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class ConstantAndVariableQueryString
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::ConstantAndVariableQueryStringInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::ConstantAndVariableQueryString
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :constant_and_variable_query_string),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::ConstantAndVariableQueryString
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::ConstantAndVariableQueryString,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::ConstantAndVariableQueryString,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class ConstantQueryString
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::ConstantQueryStringInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::ConstantQueryString
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :constant_query_string),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::ConstantQueryString
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::ConstantQueryString,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::ConstantQueryString,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class DatetimeOffsets
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::DatetimeOffsetsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DatetimeOffsets
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :datetime_offsets),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::DatetimeOffsets
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::DatetimeOffsets,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::DatetimeOffsets,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class DocumentType
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::DocumentTypeInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DocumentType
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :document_type),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::DocumentType
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::DocumentType,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::DocumentType,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class DocumentTypeAsMapValue
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::DocumentTypeAsMapValueInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DocumentTypeAsMapValue
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :document_type_as_map_value),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::DocumentTypeAsMapValue
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::DocumentTypeAsMapValue,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::DocumentTypeAsMapValue,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class DocumentTypeAsPayload
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::DocumentTypeAsPayloadInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::DocumentTypeAsPayload
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :document_type_as_payload),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::DocumentTypeAsPayload
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::DocumentTypeAsPayload,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::DocumentTypeAsPayload,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class EmptyInputAndEmptyOutput
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::EmptyInputAndEmptyOutputInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::EmptyInputAndEmptyOutput
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :empty_input_and_empty_output),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::EmptyInputAndEmptyOutput
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::EmptyInputAndEmptyOutput,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::EmptyInputAndEmptyOutput,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class EndpointOperation
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::EndpointOperationInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::EndpointOperation
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :endpoint_operation),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::EndpointOperation
        )
        stack.use(Hearth::Middleware::HostPrefix,
          disable_host_prefix: config.disable_host_prefix,
          host_prefix: "foo."
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::EndpointOperation,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::EndpointOperation,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class EndpointWithHostLabelOperation
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::EndpointWithHostLabelOperationInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::EndpointWithHostLabelOperation
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :endpoint_with_host_label_operation),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::EndpointWithHostLabelOperation
        )
        stack.use(Hearth::Middleware::HostPrefix,
          disable_host_prefix: config.disable_host_prefix,
          host_prefix: "foo.{label}."
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::EndpointWithHostLabelOperation,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::EndpointWithHostLabelOperation,
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
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
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
            error_parsers: [Parsers::InvalidGreeting, Parsers::ComplexError]
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::GreetingWithErrors,
          stub_error_classes: [Stubs::InvalidGreeting, Stubs::ComplexError],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HostWithPathOperation
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HostWithPathOperationInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HostWithPathOperation
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :host_with_path_operation),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HostWithPathOperation
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HostWithPathOperation,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HostWithPathOperation,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpChecksumRequired
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpChecksumRequiredInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpChecksumRequired
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_checksum_required),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::HTTP::Middleware::ContentMD5)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpChecksumRequired
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpChecksumRequired,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpChecksumRequired,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpEnumPayload
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpEnumPayloadInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpEnumPayload
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_enum_payload),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpEnumPayload
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpEnumPayload,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpEnumPayload,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpPayloadTraits
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpPayloadTraitsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpPayloadTraits
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_payload_traits),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpPayloadTraits
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpPayloadTraits,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpPayloadTraits,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpPayloadTraitsWithMediaType
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpPayloadTraitsWithMediaTypeInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpPayloadTraitsWithMediaType
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_payload_traits_with_media_type),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpPayloadTraitsWithMediaType
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpPayloadTraitsWithMediaType,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpPayloadTraitsWithMediaType,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpPayloadWithStructure
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpPayloadWithStructureInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpPayloadWithStructure
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_payload_with_structure),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpPayloadWithStructure
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpPayloadWithStructure,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpPayloadWithStructure,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpPayloadWithUnion
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpPayloadWithUnionInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpPayloadWithUnion
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_payload_with_union),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpPayloadWithUnion
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpPayloadWithUnion,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpPayloadWithUnion,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpPrefixHeaders
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpPrefixHeadersInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpPrefixHeaders
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_prefix_headers),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpPrefixHeaders
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpPrefixHeaders,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpPrefixHeaders,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpPrefixHeadersInResponse
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpPrefixHeadersInResponseInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpPrefixHeadersInResponse
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_prefix_headers_in_response),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpPrefixHeadersInResponse
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpPrefixHeadersInResponse,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpPrefixHeadersInResponse,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpRequestWithFloatLabels
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpRequestWithFloatLabelsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpRequestWithFloatLabels
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_request_with_float_labels),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpRequestWithFloatLabels
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpRequestWithFloatLabels,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpRequestWithFloatLabels,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpRequestWithGreedyLabelInPath
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpRequestWithGreedyLabelInPathInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpRequestWithGreedyLabelInPath
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_request_with_greedy_label_in_path),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpRequestWithGreedyLabelInPath
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpRequestWithGreedyLabelInPath,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpRequestWithGreedyLabelInPath,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpRequestWithLabels
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpRequestWithLabelsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpRequestWithLabels
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_request_with_labels),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpRequestWithLabels
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpRequestWithLabels,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpRequestWithLabels,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpRequestWithLabelsAndTimestampFormat
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpRequestWithLabelsAndTimestampFormatInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpRequestWithLabelsAndTimestampFormat
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_request_with_labels_and_timestamp_format),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpRequestWithLabelsAndTimestampFormat
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpRequestWithLabelsAndTimestampFormat,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpRequestWithLabelsAndTimestampFormat,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpRequestWithRegexLiteral
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpRequestWithRegexLiteralInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpRequestWithRegexLiteral
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_request_with_regex_literal),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpRequestWithRegexLiteral
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpRequestWithRegexLiteral,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpRequestWithRegexLiteral,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpResponseCode
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpResponseCodeInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpResponseCode
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_response_code),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpResponseCode
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpResponseCode,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpResponseCode,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class HttpStringPayload
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::HttpStringPayloadInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::HttpStringPayload
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :http_string_payload),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::HttpStringPayload
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::HttpStringPayload,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::HttpStringPayload,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class IgnoreQueryParamsInResponse
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::IgnoreQueryParamsInResponseInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::IgnoreQueryParamsInResponse
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :ignore_query_params_in_response),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::IgnoreQueryParamsInResponse
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::IgnoreQueryParamsInResponse,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::IgnoreQueryParamsInResponse,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class InputAndOutputWithHeaders
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::InputAndOutputWithHeadersInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::InputAndOutputWithHeaders
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :input_and_output_with_headers),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::InputAndOutputWithHeaders
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::InputAndOutputWithHeaders,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::InputAndOutputWithHeaders,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class JsonBlobs
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::JsonBlobsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::JsonBlobs
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :json_blobs),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::JsonBlobs
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::JsonBlobs,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::JsonBlobs,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class JsonEnums
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::JsonEnumsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::JsonEnums
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :json_enums),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::JsonEnums
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::JsonEnums,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::JsonEnums,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class JsonIntEnums
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::JsonIntEnumsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::JsonIntEnums
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :json_int_enums),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::JsonIntEnums
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::JsonIntEnums,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::JsonIntEnums,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class JsonLists
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::JsonListsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::JsonLists
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :json_lists),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::JsonLists
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::JsonLists,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::JsonLists,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class JsonMaps
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::JsonMapsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::JsonMaps
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :json_maps),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::JsonMaps
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::JsonMaps,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::JsonMaps,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class JsonTimestamps
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::JsonTimestampsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::JsonTimestamps
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :json_timestamps),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::JsonTimestamps
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::JsonTimestamps,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::JsonTimestamps,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class JsonUnions
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::JsonUnionsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::JsonUnions
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :json_unions),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::JsonUnions
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::JsonUnions,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::JsonUnions,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class MediaTypeHeader
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::MediaTypeHeaderInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::MediaTypeHeader
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :media_type_header),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::MediaTypeHeader
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::MediaTypeHeader,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::MediaTypeHeader,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class NoInputAndNoOutput
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::NoInputAndNoOutputInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::NoInputAndNoOutput
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :no_input_and_no_output),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::NoInputAndNoOutput
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::NoInputAndNoOutput,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::NoInputAndNoOutput,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class NoInputAndOutput
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::NoInputAndOutputInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::NoInputAndOutput
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :no_input_and_output),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::NoInputAndOutput
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::NoInputAndOutput,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::NoInputAndOutput,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class NullAndEmptyHeadersClient
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::NullAndEmptyHeadersClientInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::NullAndEmptyHeadersClient
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :null_and_empty_headers_client),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::NullAndEmptyHeadersClient
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::NullAndEmptyHeadersClient,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::NullAndEmptyHeadersClient,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class NullAndEmptyHeadersServer
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::NullAndEmptyHeadersServerInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::NullAndEmptyHeadersServer
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :null_and_empty_headers_server),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::NullAndEmptyHeadersServer
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::NullAndEmptyHeadersServer,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::NullAndEmptyHeadersServer,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class OmitsNullSerializesEmptyString
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::OmitsNullSerializesEmptyStringInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::OmitsNullSerializesEmptyString
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :omits_null_serializes_empty_string),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::OmitsNullSerializesEmptyString
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::OmitsNullSerializesEmptyString,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::OmitsNullSerializesEmptyString,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class OmitsSerializingEmptyLists
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::OmitsSerializingEmptyListsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::OmitsSerializingEmptyLists
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :omits_serializing_empty_lists),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::OmitsSerializingEmptyLists
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::OmitsSerializingEmptyLists,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::OmitsSerializingEmptyLists,
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
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::OperationWithDefaults,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class OperationWithNestedStructure
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::OperationWithNestedStructureInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::OperationWithNestedStructure
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :operation_with_nested_structure),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::OperationWithNestedStructure
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::OperationWithNestedStructure,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::OperationWithNestedStructure,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class PostPlayerAction
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::PostPlayerActionInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::PostPlayerAction
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :post_player_action),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::PostPlayerAction
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::PostPlayerAction,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::PostPlayerAction,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class PostUnionWithJsonName
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::PostUnionWithJsonNameInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::PostUnionWithJsonName
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :post_union_with_json_name),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::PostUnionWithJsonName
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::PostUnionWithJsonName,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::PostUnionWithJsonName,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class PutWithContentEncoding
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::PutWithContentEncodingInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::PutWithContentEncoding
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :put_with_content_encoding),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::HTTP::Middleware::RequestCompression,
          disable_request_compression: config.disable_request_compression,
          encodings: ['gzip'],
          request_min_compression_size_bytes: config.request_min_compression_size_bytes,
          streaming: false
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::PutWithContentEncoding
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::PutWithContentEncoding,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::PutWithContentEncoding,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class QueryIdempotencyTokenAutoFill
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::QueryIdempotencyTokenAutoFillInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::QueryIdempotencyTokenAutoFill
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :query_idempotency_token_auto_fill),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::QueryIdempotencyTokenAutoFill
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::QueryIdempotencyTokenAutoFill,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::QueryIdempotencyTokenAutoFill,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class QueryParamsAsStringListMap
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::QueryParamsAsStringListMapInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::QueryParamsAsStringListMap
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :query_params_as_string_list_map),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::QueryParamsAsStringListMap
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::QueryParamsAsStringListMap,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::QueryParamsAsStringListMap,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class QueryPrecedence
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::QueryPrecedenceInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::QueryPrecedence
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :query_precedence),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::QueryPrecedence
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::QueryPrecedence,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::QueryPrecedence,
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
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::RecursiveShapes,
          stub_error_classes: [],
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
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::SimpleScalarProperties,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class SparseJsonLists
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::SparseJsonListsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::SparseJsonLists
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :sparse_json_lists),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::SparseJsonLists
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::SparseJsonLists,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::SparseJsonLists,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class SparseJsonMaps
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::SparseJsonMapsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::SparseJsonMaps
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :sparse_json_maps),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::SparseJsonMaps
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::SparseJsonMaps,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::SparseJsonMaps,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class StreamingTraits
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::StreamingTraitsInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::StreamingTraits
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :streaming_traits),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::StreamingTraits
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::StreamingTraits,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::StreamingTraits,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class StreamingTraitsRequireLength
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::StreamingTraitsRequireLengthInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::StreamingTraitsRequireLength
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :streaming_traits_require_length),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::StreamingTraitsRequireLength
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::StreamingTraitsRequireLength,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::StreamingTraitsRequireLength,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class StreamingTraitsWithMediaType
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::StreamingTraitsWithMediaTypeInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::StreamingTraitsWithMediaType
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :streaming_traits_with_media_type),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::StreamingTraitsWithMediaType
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::StreamingTraitsWithMediaType,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::StreamingTraitsWithMediaType,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class TestBodyStructure
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::TestBodyStructureInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::TestBodyStructure
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :test_body_structure),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::TestBodyStructure
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::TestBodyStructure,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::TestBodyStructure,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class TestNoPayload
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::TestNoPayloadInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::TestNoPayload
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :test_no_payload),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::TestNoPayload
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::TestNoPayload,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::TestNoPayload,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class TestPayloadBlob
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::TestPayloadBlobInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::TestPayloadBlob
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :test_payload_blob),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::TestPayloadBlob
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::TestPayloadBlob,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::TestPayloadBlob,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class TestPayloadStructure
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::TestPayloadStructureInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::TestPayloadStructure
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :test_payload_structure),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::TestPayloadStructure
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::TestPayloadStructure,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::TestPayloadStructure,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class TimestampFormatHeaders
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::TimestampFormatHeadersInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::TimestampFormatHeaders
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :timestamp_format_headers),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::TimestampFormatHeaders
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::TimestampFormatHeaders,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::TimestampFormatHeaders,
          stub_error_classes: [],
          stub_message_encoder: Hearth::EventStream::Binary.const_get(:MessageEncoder).new,
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class UnitInputAndOutput
      def self.build(config, options = {})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::UnitInputAndOutputInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::UnitInputAndOutput
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :unit_input_and_output),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::UnitInputAndOutput
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign,
          event_stream: false
        )
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::UnitInputAndOutput,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            error_parsers: []
          )
        )
        stack.use(Middleware::RequestId)
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          event_handler: nil,
          stub_data_class: Stubs::UnitInputAndOutput,
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
