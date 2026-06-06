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
          @backoff = options[:backoff] || ExponentialBackoff.new
          @max_attempts = options[:max_attempts] || 3
          @quota = Quota.new
        end

        # @return [#call]
        attr_reader :backoff

        # @return [Integer]
        attr_reader :max_attempts

        # Noop in standard mode. Overridden in adaptive mode.
        def request_bookkeeping(_error_info); end

        def acquire_initial_retry_token(_token_scope = nil)
          Token.new
        end

        def refresh_retry_token(retry_token, error_info)
          return unless error_info.retryable?

          return if retry_token.retry_count >= @max_attempts - 1

          capacity_amount = @quota.checkout_capacity(error_info)
          delay = @backoff.call(retry_token.retry_count, error_info)
          retry_token.capacity_amount = capacity_amount

          if capacity_amount.zero?
            retry_token.retry_delay = delay
            retry_token.no_retry_reason = :quota_exhausted
            return retry_token
          end

          retry_token.retry_count += 1
          retry_token.retry_delay = delay
          retry_token.no_retry_reason = nil
          retry_token
        end

        def record_success(retry_token)
          @quota.release(retry_token.capacity_amount)
          retry_token
        end
      end
    end
  end
end
