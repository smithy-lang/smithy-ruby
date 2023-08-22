# frozen_string_literal: true

module Hearth
  module Retry
    # Standard retry strategy for retrying requests.
    class Standard < Strategy
      # @param [#call] backoff (ExponentialBackoff) A callable object that
      #   calculates a backoff delay for a retry attempt.
      # @param [Integer] max_attempts (3) The maximum number of attempts that
      #   will be made for a single request, including the initial attempt.
      def initialize(backoff: ExponentialBackoff.new, max_attempts: 3)
        super()
        @backoff = backoff
        @max_attempts = max_attempts

        # instance state
        @retry_quota = RetryQuota.new
        @capacity_amount = nil
      end

      def acquire_initial_retry_token(_token_scope = nil)
        Token.new(retry_count: 0)
      end

      def refresh_retry_token(retry_token, error_info)
        return unless error_info.retryable?

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
        @retry_quota.release(@capacity_amount)
        retry_token
      end
    end
  end
end
