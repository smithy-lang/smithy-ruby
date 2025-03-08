# frozen_string_literal: true

require_relative 'retry/adaptive'
require_relative 'retry/client_rate_limiter'
require_relative 'retry/quota'
require_relative 'retry/standard'

module Smithy
  module Client
    module Retry
      # The maximum backoff delay for retrying requests.
      MAX_BACKOFF = 20

      # Raised when the adaptive retry strategy is unable to acquire capacity.
      class CapacityNotAvailableError < RuntimeError; end

      # The default backoff for retrying requests.
      EXPONENTIAL_BACKOFF = lambda do |attempts|
        [Kernel.rand * (2**attempts), MAX_BACKOFF].min || 0
      end

      # Represents a token that can be used to retry an operation.
      class Token
        def initialize(retry_count: 0, retry_delay: 0)
          @retry_count = retry_count
          @retry_delay = retry_delay
        end

        # The number of times the operation has been retried.
        # @return [Integer]
        attr_accessor :retry_count

        # The delay before the next retry.
        # @return [Numeric]
        attr_accessor :retry_delay
      end
    end
  end
end
