# frozen_string_literal: true

module Hearth
  module Retry
    # @api private
    # Computes the next backoff delay for a retry attempt.
    class RetryBackoffStrategy
      # Max backoff (in seconds)
      MAX_BACKOFF = 20

      def compute_next_backoff_delay(attempts)
        [Kernel.rand * (2**attempts), MAX_BACKOFF].min
      end
    end
  end
end
