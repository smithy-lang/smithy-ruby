# frozen_string_literal: true

module Hearth
  module EventStream
    module Middleware
      # A middleware that signs EventStream requests
      # using the resolved identity.
      # @api private
      class Sign
        include Hearth::Middleware::Logging

        # @param [Class] app The next middleware in the stack.
        def initialize(app)
          @app = app
        end

        # @param input
        # @param context
        # @return [Output]
        # rubocop:disable Metrics/MethodLength
        def call(input, context)
          interceptor_error = Interceptors.invoke(
            hook: Interceptor::MODIFY_BEFORE_SIGNING,
            input: input,
            context: context,
            output: nil,
            aggregate_errors: false
          )
          if interceptor_error
            return Hearth::Output.new(error: interceptor_error)
          end

          interceptor_error = Interceptors.invoke(
            hook: Interceptor::READ_BEFORE_SIGNING,
            input: input,
            context: context,
            output: nil,
            aggregate_errors: false
          )
          if interceptor_error
            return Hearth::Output.new(error: interceptor_error)
          end

          sign_initial_request(context)
          setup_event_signer(context)
          output = @app.call(input, context)

          interceptor_error = Interceptors.invoke(
            hook: Interceptor::READ_AFTER_SIGNING,
            input: input,
            context: context,
            output: output,
            aggregate_errors: false
          )
          output.error = interceptor_error if interceptor_error

          output
        end
        # rubocop:enable Metrics/MethodLength

        private

        def sign_initial_request(context)
          context.request.body.prior_signature =
            context.auth.signer.sign_initial_event_stream_request(
              request: context.request,
              identity: context.auth.identity,
              properties: context.auth.signer_properties
            )
        end

        def setup_event_signer(context)
          sign_event = proc do |prior_signature, event_type, message, encoder|
            context.auth.signer.sign_event(
              message: message,
              prior_signature: prior_signature,
              event_type: event_type,
              encoder: encoder,
              identity: context.auth.identity,
              properties: context.auth.signer_properties
            )
          end
          context.request.body.sign_event = sign_event
        end
      end
    end
  end
end