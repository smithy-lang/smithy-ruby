# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that retries the request using a retry strategy.
    # @api private
    class Retry
      # @param [Class] app The next middleware in the stack.
      # @param [Strategy] retry_strategy (Standard) The retry strategy
      #   to use. Hearth has two built in classes, Standard and Adaptive.
      #   * `Retry::Standard` - A standardized set of retry rules across
      #     the AWS SDKs. This includes support for retry quotas, which limit
      #     the number of unsuccessful retries a client can make.
      #   * `Retry::Adaptive` - An experimental retry mode that includes
      #     all the functionality of `standard` mode along with automatic
      #     client side throttling. This is a provisional mode that may change
      #     behavior in the future.
      def initialize(app, retry_strategy:, error_inspector_class:)
        @app = app
        @retry_strategy = retry_strategy
        @error_inspector_class = error_inspector_class

        @retries = 0
      end

      def call(input, context)
        interceptor_error = Interceptors.invoke(
          hook: Interceptor::MODIFY_BEFORE_RETRY_LOOP,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        token_scope = context.metadata[:retry_token_scope]
        token = @retry_strategy.acquire_initial_retry_token(token_scope)
        output = nil
        context.logger.debug('[Middleware::Retry] Starting retry loop')
        loop do
          interceptor_error = Interceptors.invoke(
            hook: Interceptor::READ_BEFORE_ATTEMPT,
            input: input,
            context: context,
            output: nil,
            aggregate_errors: true
          )

          output =
            if interceptor_error
              Hearth::Output.new(error: interceptor_error)
            else
              context.logger.debug('[Middleware::Retry] Trying request')
              @app.call(input, context)
            end

          interceptor_error = Interceptors.invoke(
            hook: Interceptor::MODIFY_BEFORE_ATTEMPT_COMPLETION,
            input: input,
            context: context,
            output: output,
            aggregate_errors: false
          )
          output.error = interceptor_error if interceptor_error

          interceptor_error = Interceptors.invoke(
            hook: Interceptor::READ_AFTER_ATTEMPT,
            input: input,
            context: context,
            output: output,
            aggregate_errors: true
          )
          output.error = interceptor_error if interceptor_error

          if (error = output.error)
            context.logger.debug(
              "[Middleware::Retry] Request errored: #{error.class}"
            )
            error_info = @error_inspector_class.new(error, context.response)
            token = @retry_strategy.refresh_retry_token(token, error_info)
            break unless token

            context.logger.debug(
              "[Middleware::Retry] Sleeping #{token.retry_delay} before retry"
            )
            Kernel.sleep(token.retry_delay)
          else
            @retry_strategy.record_success(token)
            context.logger.debug('[Middleware::Retry] Finished sending request')
            break
          end

          reset_request(context)
          reset_response(context, output)
          @retries += 1
        end
        context.logger.debug('[Middleware::Retry] Finished retry loop')
        output
      end

      private

      def reset_request(context)
        request = context.request
        request.body.rewind if request.body.respond_to?(:rewind)

        auth = context.auth
        auth.signer.reset(
          request: request,
          properties: auth.signer_properties
        )
      end

      def reset_response(context, output)
        context.response.reset
        output.error = nil
      end
    end
  end
end
