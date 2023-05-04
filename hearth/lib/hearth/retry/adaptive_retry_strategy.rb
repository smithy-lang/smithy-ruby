# frozen_string_literal: true

module Hearth
  module Retry
    # @api private
    # Adaptive retry strategy for retrying requests.
    class AdaptiveRetryStrategy
      # TODO: remove defaults
      # @param [String] max_attempts An integer representing the maximum number
      #   of attempts that will be made for a single request, including the
      #   initial attempt.
      # @param [Boolean] wait_to_fill When true, the request will sleep until
      #   there is sufficient client side capacity to retry the request. When
      #   false, the request will raise a `CapacityNotAvailableError` and will
      #   not retry instead of sleeping.
      def initialize(retry_backoff_strategy: RetryBackoffStrategy.new,
                     max_attempts: 3,
                     wait_to_fill: true)
        @retry_backoff_strategy = retry_backoff_strategy
        @max_attempts = max_attempts
        @wait_to_fill = wait_to_fill

        # instance state
        @client_rate_limiter = ClientRateLimiter.new
        @retry_quota = RetryQuota.new
        @capacity_amount = nil
        # TODO: use token for this, and update testing
        @retries = 0
      end

      def acquire_initial_retry_token(_token_scope = nil)
        @client_rate_limiter.token_bucket_acquire(
          1, wait_to_fill: @wait_to_fill
        )
        RetryToken.new(retry_count: 0)
      end

      def refresh_retry_token(retry_token, error_info)
        return unless retryable?(error_info)

        @client_rate_limiter.update_sending_rate(
          error_info[:error_type] == 'Throttling'
        )

        return if @retries >= @max_attempts - 1

        @capacity_amount = @retry_quota.checkout_capacity(error_info[:error_type])
        return unless @capacity_amount.positive?

        delay = error_info[:retry_after_hint]
        delay ||= @retry_backoff_strategy.compute_next_backoff_delay(retry_token.retry_count)
        @retries += 1
        retry_token.retry_count += 1
        retry_token.retry_delay = delay
        retry_token
      end

      def record_success(retry_token)
        @client_rate_limiter.update_sending_rate(false)
        @retry_quota.release(@capacity_amount)
        retry_token
      end

      private

      def retryable?(error_info)
        error_info[:retryable] ||
          error_info[:error_type] == 'Throttling' ||
          error_info[:error_type] == 'Transient'
      end
    end
  end
end
