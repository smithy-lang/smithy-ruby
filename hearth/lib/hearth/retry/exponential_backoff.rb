# frozen_string_literal: true

module Hearth
  module Retry
    # @api private
    # Computes an exponential backoff delay for a retry attempt.
    class ExponentialBackoff
      # Max backoff (in seconds)
      MAX_BACKOFF = 20

      def call(attempts)
        [Kernel.rand * (2**attempts), MAX_BACKOFF].min
      end
    end
  end
end
