# frozen_string_literal: true

module Hearth
  module EventStream
    module Middleware
      # A middleware that signs EventStream requests
      # using the resolved identity.
      # @api private
      class Sign
        include Middleware::Logging

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
          puts "EVENT SIGNING"
          log_debug(context, "Signing request with: #{context.auth.signer}")
          context.auth.signer.sign(
            request: context.request,
            identity: context.auth.identity,
            properties: context.auth.signer_properties
          )
          # TODO: We need to extract a signature from this and
          # set it on the body as the prior signature
          log_debug(context, "Signed request: #{context.request.inspect}")
        end
      end
    end
    end
end
