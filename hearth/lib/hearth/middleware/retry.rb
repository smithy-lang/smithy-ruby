# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that retries the request using a retry strategy.
    # @api private
    class Retry
      include Middleware::Logging

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

        output = nil
        token = @retry_strategy.acquire_initial_retry_token(nil)
        log_debug(context, "Starting retry loop with token: #{token}")
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
              log_debug(context, 'Attempting request in retry loop')
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
            log_debug(context, "Request failed with error: #{error}")
            break unless retryable?(context.request)

            error_info = @error_inspector_class.new(error, context.response)
            token = @retry_strategy.refresh_retry_token(token, error_info)
            break unless token

            log_debug(context, "Retry token refreshed: #{token}")
            log_debug(context, "Sleeping for #{token.retry_delay} seconds")
            Kernel.sleep(token.retry_delay)
          else
            @retry_strategy.record_success(token)
            log_debug(context, 'Request succeeded')
            break
          end

          reset_request(context)
          reset_response(context, output)
          @retries += 1
        end
        log_debug(context, 'Finished retry loop')
        log_debug(context, "Total retries: #{@retries}")
        output
      end

      private

      def retryable?(request)
        # IO responds to #rewind however it returns an illegal seek error
        request.body.respond_to?(:rewind) && !request.body.instance_of?(IO)
      end

      def reset_request(context)
        request = context.request
        request.body.rewind

        context.auth.signer.reset(
          request: request,
          properties: context.auth.signer_properties
        )
      end

      def reset_response(context, output)
        context.response.reset
        output.error = nil
      end
    end
  end
end
