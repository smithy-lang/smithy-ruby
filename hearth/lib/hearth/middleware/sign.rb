# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that signs requests using the resolved identity.
    # @api private
    class Sign
      # @param [Class] app The next middleware in the stack.
      def initialize(app)
        @app = app
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

        sign_request(context)
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
        context.logger.debug('[Middleware::Sign] Started signing request')
        auth = context.auth
        auth.signer.sign(
          request: context.request,
          identity: auth.identity,
          properties: auth.signer_properties
        )
        context.logger.debug('[Middleware::Sign] Finished signing request')
      end
    end
  end
end
