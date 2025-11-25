# frozen_string_literal: true

module Smithy
  module Client
    module Retry
      # Standard retry strategy for retrying requests.
      class Standard
        # @option [#call] :backoff (ExponentialBackoff.new) A callable object that
        #  calculates a backoff delay for a retry attempt.
        # @option [Integer] :max_attempts (3) The maximum number of attempts that
        #  will be made for a single request, including the initial attempt.
        def initialize(options = {})
          super()
          @backoff = options[:backoff] || ExponentialBackoff.new(
            base_delay: options[:base_delay],
            max_delay: options[:max_delay]
          )
          @max_attempts = options[:max_attempts] || 3
          @quota = Quota.new
          @capacity_amount = 0
        end

        # @return [#call]
        attr_reader :backoff

        # @return [Integer]
        attr_reader :max_attempts

        def acquire_initial_retry_token(_token_scope = nil)
          Token.new
        end

        def refresh_retry_token(retry_token, error_info)
          return unless error_info.retryable?

          return if retry_token.retry_count >= @max_attempts - 1

          @capacity_amount = @quota.checkout_capacity(error_info)
          return unless @capacity_amount.positive?

          delay = error_info.hints[:retry_after]
          delay ||= @backoff.call(retry_token.retry_count)
          retry_token.retry_count += 1
          retry_token.retry_delay = delay
          retry_token
        end

        def record_success(retry_token)
          @quota.release(@capacity_amount)
          retry_token
        end
      end
    end
  end
end
