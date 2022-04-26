# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that retries the request.
    # @api private
    class Retry
      # Max backoff (in seconds)
      MAX_BACKOFF = 20

      # @param [Class] app The next middleware in the stack.
      # @param [Boolean] retry_mode Specifies which retry algorithm to use.
      #   Values are:
      #   * `standard` - A standardized set of retry rules across the AWS SDKs.
      #     This includes support for retry quotas, which limit the number of
      #     unsuccessful retries a client can make.
      #   * `adaptive` - An experimental retry mode that includes all the
      #     functionality of `standard` mode along with automatic client side
      #     throttling.  This is a provisional mode that may change behavior
      #     in the future.
      # @param [String] max_attempts An integer representing the maximum number
      #   of attempts that will be made for a single request, including the
      #   initial attempt.
      # @param [Boolean] adaptive_retry_wait_to_fill Used only in `adaptive`
      #   retry mode. When true, the request will sleep until there is
      #   sufficient client side capacity to retry the request. When false,
      #   the request will raise a `CapacityNotAvailableError` and will not
      #   retry instead of sleeping.
      def initialize(app, retry_mode:, max_attempts:,
                     adaptive_retry_wait_to_fill:, error_inspector_class:,
                     retry_quota:, client_rate_limiter:)
        @app = app

        # public config
        @retry_mode = retry_mode
        @max_attempts = max_attempts
        @adaptive_retry_wait_to_fill = adaptive_retry_wait_to_fill

        # undocumented options
        @error_inspector_class = error_inspector_class
        @retry_quota = retry_quota
        @client_rate_limiter = client_rate_limiter

        # instance state
        @capacity_amount = nil
        @retries = 0
      end

      # @param input
      # @param context
      # @return [Output]
      # rubocop:disable Metrics/AbcSize
      def call(input, context)
        acquire_token
        output = @app.call(input, context)
        error_inspector = @error_inspector_class.new(
          output.error, context.response.status
        )
        request_bookkeeping(output, error_inspector)

        return output unless retryable?(context, output, error_inspector)

        return output if @retries >= @max_attempts - 1

        @capacity_amount = @retry_quota.checkout_capacity(error_inspector)
        return output unless @capacity_amount.positive?

        delay = [Kernel.rand * (2**@retries), MAX_BACKOFF].min
        Kernel.sleep(delay)
        retry_request(input, context, output)
      end
      # rubocop:enable Metrics/AbcSize

      private

      def acquire_token
        return unless @retry_mode != 'adaptive'

        # either fail fast or block until a token becomes available
        # must be configurable
        # need a maximum rate at which we can send requests (max_send_rate)
        # is unset until a throttle is seen
        @client_rate_limiter.token_bucket_acquire(
          1, wait_to_fill: @adaptive_retry_wait_to_fill
        )
      end

      # max_send_rate is updated if on adaptive mode and based on response
      # retry quota is updated if the request is successful (both modes)
      def request_bookkeeping(output, error_inspector)
        @retry_quota.release(@capacity_amount) unless output.error

        return unless @retry_mode == 'adaptive'

        @client_rate_limiter.update_sending_rate(
          error_inspector.error_type == 'Throttling'
        )
      end

      def retryable?(context, output, error_inspector)
        return false unless output.error

        error_inspector.retryable? &&
          context.response.body.respond_to?(:truncate)
      end

      def retry_request(input, context, output)
        @retries += 1
        context.request.body.rewind
        context.response.reset
        output.error = nil
        call(input, context)
      end
    end
  end
end
