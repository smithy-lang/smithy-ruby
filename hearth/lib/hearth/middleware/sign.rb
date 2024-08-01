# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that signs requests using the resolved identity.
    # @api private
    class Sign
      include Middleware::Logging

      # @param [Class] app The next middleware in the stack.
      # @param [Boolean] event_stream true when the operation
      #   uses event signing.
      def initialize(app, event_stream:)
        @app = app
        @event_stream = event_stream
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        interceptor_error = Interceptors.invoke(
          hook: Interceptor::MODIFY_BEFORE_SIGNING,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        interceptor_error = Interceptors.invoke(
          hook: Interceptor::READ_BEFORE_SIGNING,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        if @event_stream
          sign_initial_request(context)
          setup_event_signer(context)
        else
          sign_request(context)
        end
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

      private

      def sign_request(context)
        log_debug(context, "Signing request with: #{context.auth.signer}")
        context.auth.signer.sign(
          request: context.request,
          identity: context.auth.identity,
          properties: context.auth.signer_properties
        )
        log_debug(context, "Signed request: #{context.request.inspect}")
      end

      def sign_initial_request(context)
        log_debug(context,
                  "Signing initial request with: #{context.auth.signer}")
        context.request.body.prior_signature =
          context.auth.signer.sign(
            request: context.request,
            identity: context.auth.identity,
            properties: context.auth.signer_properties.merge(event_stream: true)
          )
      end

      def setup_event_signer(context)
        log_debug(context, 'Setting up event signer on request')
        sign_event = -> (prior_signature, event_type, message, encoder) do
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
