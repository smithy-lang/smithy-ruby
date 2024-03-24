# frozen_string_literal: true

module Hearth
  module Retry
    # Adaptive retry strategy for retrying requests.
    class Adaptive
      # @param [#call] backoff (ExponentialBackoff) A callable object that
      #   calculates a backoff delay for a retry attempt.
      # @param [Integer] max_attempts (3) The maximum number of attempts that
      #   will be made for a single request, including the initial attempt.
      # @param [Boolean] wait_to_fill When true, the request will sleep until
      #   there is sufficient client side capacity to retry the request. When
      #   false, the request will raise a `CapacityNotAvailableError` and will
      #   not retry instead of sleeping.
      def initialize(backoff: ExponentialBackoff.new, max_attempts: 3,
                     wait_to_fill: true)
        super()
        @backoff = backoff
        @max_attempts = max_attempts
        @wait_to_fill = wait_to_fill

        # instance state
        @client_rate_limiter = ClientRateLimiter.new
        @retry_quota = RetryQuota.new
        @capacity_amount = nil
      end

      def acquire_initial_retry_token(_token_scope = nil)
        @client_rate_limiter.token_bucket_acquire(
          1, wait_to_fill: @wait_to_fill
        )
        Token.new(retry_count: 0)
      end

      def refresh_retry_token(retry_token, error_info)
        return unless error_info.retryable?

        @client_rate_limiter.update_sending_rate(
          error_info.error_type == 'Throttling'
        )
        return if retry_token.retry_count >= @max_attempts - 1

        @capacity_amount = @retry_quota.checkout_capacity(error_info)
        return unless @capacity_amount.positive?

        delay = error_info.hints[:retry_after]
        delay ||= @backoff.call(retry_token.retry_count)
        retry_token.retry_count += 1
        retry_token.retry_delay = delay
        retry_token
      end

      def record_success(retry_token)
        @client_rate_limiter.update_sending_rate(false)
        @retry_quota.release(@capacity_amount)
        retry_token
      end
    end
  end
end
