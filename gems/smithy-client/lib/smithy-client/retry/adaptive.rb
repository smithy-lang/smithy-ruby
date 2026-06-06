# frozen_string_literal: true

module Smithy
  module Client
    module Retry
      # Adaptive retry strategy for retrying requests.
      class Adaptive
        # @option [#call] :backoff (ExponentialBackoff.new) A callable object that
        #  calculates a backoff delay for a retry attempt.
        # @option [Integer] :max_attempts (3) The maximum number of attempts that
        #  will be made for a single request, including the initial attempt.
        # @option [Boolean] :wait_to_fill When true, the request will sleep until
        #  there is sufficient client side capacity to retry the request. When
        #  false, the request will raise a `CapacityNotAvailableError` and will
        #  not retry instead of sleeping.
        def initialize(options = {})
          super()
          @backoff = options[:backoff] || ExponentialBackoff.new
          @max_attempts = options[:max_attempts] || 3
          @wait_to_fill = options.fetch(:wait_to_fill, true)
          @client_rate_limiter = ClientRateLimiter.new
          @quota = Quota.new
        end

        # @return [#call]
        attr_reader :backoff

        # @return [Integer]
        attr_reader :max_attempts

        # @return [Boolean]
        attr_reader :wait_to_fill

        def request_bookkeeping(error_info)
          @client_rate_limiter.update_sending_rate(
            error_info.error_type == 'Throttling'
          )
        end

        def acquire_initial_retry_token(_token_scope = nil)
          @client_rate_limiter.token_bucket_acquire(1, wait_to_fill: @wait_to_fill)
          Token.new
        end

        def refresh_retry_token(retry_token, error_info)
          return unless error_info.retryable?

          return if retry_token.retry_count >= @max_attempts - 1

          @client_rate_limiter.token_bucket_acquire(1, wait_to_fill: @wait_to_fill)

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
          @client_rate_limiter.update_sending_rate(false)
          @quota.release(retry_token.capacity_amount)
          retry_token
        end
      end
    end
  end
end
