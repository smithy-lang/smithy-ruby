# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that retries the request using a retry strategy.
    # @api private
    class Retry
      # @param [Class] app The next middleware in the stack.
      # @param [Standard|Adaptive] retry_strategy (Standard) The retry strategy
      #   to use. Hearth has two built in classes, Standard and Adaptive.
      #   * `Standard` - A standardized set of retry rules across
      #     the AWS SDKs. This includes support for retry quotas, which limit
      #     the number of unsuccessful retries a client can make.
      #   * `Adaptive` - An experimental retry mode that includes
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

      # rubocop:disable Metrics
      def call(input, context)
        token = @retry_strategy.acquire_initial_retry_token(
          context.metadata[:retry_token_scope]
        )
        raise 'Unable to make request, too many failures' if token.nil?

        output = nil
        loop do
          output = @app.call(input, context)

          if (error = output.error)
            error_info = @error_inspector_class.new(error, context.response)
            token = @retry_strategy.refresh_retry_token(token, error_info)

            Kernel.sleep(token.retry_delay) if token
          else
            @retry_strategy.record_success(token)
          end
          break unless token && output.error

          reset_request(context, output)
        end
        output
      end
      # rubocop:enable Metrics

      private

      def reset_request(context, output)
        @retries += 1
        context.request.body.rewind
        context.response.reset
        output.error = nil
      end
    end
  end
end
