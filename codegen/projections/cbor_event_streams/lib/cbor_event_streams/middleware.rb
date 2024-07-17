# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module CborEventStreams
  # @api private
  module Middleware

    class NonStreamingOperation
      def self.build(config, options={})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::NonStreamingOperationInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::NonStreamingOperation
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :non_streaming_operation),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::NonStreamingOperation
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::Middleware::Sign)
        stack.use(Hearth::Middleware::Parse,
          data_parser: Parsers::NonStreamingOperation,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          )
        )
        stack.use(Hearth::Middleware::Send,
          client: config.http_client,
          stub_data_class: Stubs::NonStreamingOperation,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

    class StartEventStream
      def self.build(config, options={})
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validate_input: config.validate_input,
          validator: Validators::StartEventStreamInput
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::StartEventStream
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :start_event_stream),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::EventStream::Middleware::Handlers,
          async_output_class: EventStream::EventsOutput,
          event_handler: options[:event_stream_handler],
          message_encoding_module: Hearth::EventStream::Binary,
          request_events: true,
          response_events: true
        )
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          endpoint_resolver: config.endpoint_resolver,
          param_builder: Endpoint::Parameters::StartEventStream
        )
        stack.use(Hearth::Middleware::Retry,
          error_inspector_class: Hearth::HTTP::ErrorInspector,
          retry_strategy: config.retry_strategy
        )
        stack.use(Hearth::EventStream::Middleware::Sign)
        stack.use(Hearth::Middleware::Send,
          client: config.http2_client,
          stub_data_class: Stubs::StartEventStream,
          stub_error_classes: [],
          stub_responses: config.stub_responses,
          stubs: config.stubs
        )
        stack
      end
    end

  end
end
