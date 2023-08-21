# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that retries the request using a retry strategy.
    # @api private
    class Retry
      # @param [Class] app The next middleware in the stack.
      # @param [Standard|Adaptive] retry_strategy (Standard) The retry strategy
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
        # undocumented - protocol specific
        @error_inspector_class = error_inspector_class
        # instance state
        @retries = 0
      end

      def call(input, context)
        token = @retry_strategy.acquire_initial_retry_token(
          context.metadata[:retry_token_scope]
        )

        output = nil
        request_copy = context.request.dup
        loop do
          interceptor_error = context.interceptors.apply(
            hook: Interceptor::Hooks::READ_BEFORE_ATTEMPT,
            input: input,
            context: context,
            output: nil,
            aggregate_errors: false
          )
          output =
            if interceptor_error
              Hearth::Output.new(error: interceptor_error)
            else
              @app.call(input, context)
            end

          if (error = output.error)
            error_info = @error_inspector_class.new(error, context.response)
            token = @retry_strategy.refresh_retry_token(token, error_info)

            Kernel.sleep(token.retry_delay) if token
          else
            @retry_strategy.record_success(token)
          end

          context.interceptors.apply(
            hook: Interceptor::Hooks::MODIFY_BEFORE_ATTEMPT_COMPLETION,
            input: input,
            context: context,
            output: output,
            aggregate_errors: false
          )

          context.interceptors.apply(
            hook: Interceptor::Hooks::READ_AFTER_ATTEMPT,
            input: input,
            context: context,
            output: output,
            aggregate_errors: true
          )

          break unless token && output.error

          reset_request(request_copy, context, output)
          @retries += 1
        end
        output
      end

      private

      def reset_request(request_copy, context, output)
        request_copy.body.rewind if request_copy.body.respond_to?(:rewind)
        context.request = request_copy
        context.response.reset
        output.error = nil
      end
    end
  end
end
