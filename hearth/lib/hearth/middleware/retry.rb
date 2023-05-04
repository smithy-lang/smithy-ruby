# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that retries the request using a retry strategy.
    # @api private
    class Retry
      # TODO: explain RetryStrategy class in docs or make an interface
      # @param [Class] app The next middleware in the stack.
      # @param [RetryStrategy] retry_strategy The retry strategy to use.
      #   Hearth has two built in classes, Standard and Adaptive RetryStrategy.
      #   * `StandardRetryStrategy` - A standardized set of retry rules across
      #     the AWS SDKs. This includes support for retry quotas, which limit
      #     the number of unsuccessful retries a client can make.
      #   * `AdaptiveRetryStrategy` - An experimental retry mode that includes
      #     all the functionality of `standard` mode along with automatic
      #     client side throttling. This is a provisional mode that may change
      #     behavior in the future.
      def initialize(app, retry_strategy:, error_inspector_class:)
        @app = app

        @retry_strategy = retry_strategy
        # undocumented - protocol specific
        @error_inspector_class = error_inspector_class
      end

      def call(input, context)
        token = @retry_strategy.acquire_initial_retry_token

        raise 'Unable to make request, too many failures' if token.nil?

        # TODO: determine if loop or nested function call is better here
        # If the latter, no outer variable is needed.
        output = nil
        loop do
          output = @app.call(input, context)

          if (error = output.error)
            error_inspector = @error_inspector_class.new(
              error, context.response
            )
            error_info = error_info(error, error_inspector)
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

      private

      def error_info(error, error_inspector)
        {
          error_type: error_type(error, error_inspector),
          retryable: modeled_retryable?(error)
        }.merge(error_inspector.hints)
      end

      def error_type(error, error_inspector)
        if error_inspector.transient?
          'Transient'
        elsif modeled_throttling?(error) || error_inspector.throttling?
          'Throttling'
        elsif error_inspector.server?
          'ServerError'
        elsif error_inspector.client?
          'ClientError'
        else
          'UnknownError'
        end
      end

      def modeled_retryable?(error)
        error.is_a?(Hearth::ApiError) && error.retryable?
      end

      def modeled_throttling?(error)
        modeled_retryable?(error) && error.throttling?
      end

      # TODO: find a way to dup req/resp, to undo signing, rather than resetting?
      def reset_request(context, output)
        context.request.body.rewind
        context.response.reset
        output.error = nil
      end
    end
  end
end
