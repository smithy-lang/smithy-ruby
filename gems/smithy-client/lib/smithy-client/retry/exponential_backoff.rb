# frozen_string_literal: true

module Smithy
  module Client
    module Retry
      # Default exponential backoff retry strategy for retrying requests.
      class ExponentialBackoff
        MAX_BACKOFF = 20
        EXPONENTIAL_BASE = 2

        # Calculates a delay based on exponential backoff strategy. Uses full jitter approach.
        # @param [Integer] attempts
        # @param [Smithy::Client::Http::ErrorInspector] error_info
        # @return [Numeric] delay in seconds
        def call(attempts, error_info)
          # From SEP: t_i = b * min(x * r^i, MAX_BACKOFF)
          calculated_delay = backoff_scalar_x(error_info) * (EXPONENTIAL_BASE**attempts)
          t_i = Kernel.rand * [calculated_delay, MAX_BACKOFF].min
          apply_retry_after(t_i, error_info)
        end

        private

        def apply_retry_after(t_i, error_info)
          retry_after = error_info.hints[:retry_after]
          return t_i unless retry_after

          # Clamp retry delay to t_i < delay < t_i + 5 per SEP.
          delay = [t_i, retry_after].max
          [delay, t_i + 5].min
        end

        def backoff_scalar_x(error_info)
          error_info.error_type == 'Throttling' ? 1 : 0.05
        end
      end
    end
  end
end
