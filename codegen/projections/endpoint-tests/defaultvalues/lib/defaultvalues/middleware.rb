# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module DefaultValues
  # @api private
  module Middleware

    class GetThing
      def self.build(config, stubs)
        stack = Hearth::MiddlewareStack.new
        stack.use(Hearth::Middleware::Initialize)
        stack.use(Hearth::Middleware::Validate,
          validator: Validators::GetThingInput,
          validate_input: config.validate_input
        )
        stack.use(Hearth::Middleware::Build,
          builder: Builders::GetThing
        )
        stack.use(Hearth::Middleware::Auth,
          auth_params: Auth::Params.new(operation_name: :get_thing),
          auth_resolver: config.auth_resolver,
          auth_schemes: config.auth_schemes
        )
        stack.use(Hearth::HTTP::Middleware::ContentLength)
        stack.use(Hearth::Middleware::Endpoint,
          endpoint: config.endpoint,
          bar: config.bar,
          baz: config.baz,
          param_builder: Endpoint::Parameters::GetThing,
          endpoint_resolver: config.endpoint_resolver
        )
        stack.use(Hearth::Middleware::Retry,
          retry_strategy: config.retry_strategy,
          error_inspector_class: Hearth::HTTP::ErrorInspector
        )
        stack.use(Hearth::Middleware::Sign)
        stack.use(Hearth::Middleware::Parse,
          error_parser: Hearth::HTTP::ErrorParser.new(
            error_module: Errors,
            success_status: 200,
            errors: []
          ),
          data_parser: Parsers::GetThing
        )
        stack.use(Hearth::Middleware::Send,
          stub_responses: config.stub_responses,
          client: config.http_client,
          stub_error_classes: [],
          stub_data_class: Stubs::GetThing,
          stubs: stubs
        )
        stack
      end
    end

  end
end
