# frozen_string_literal: true

require_relative 'retry/adaptive'
require_relative 'retry/capacity_not_available_error'
require_relative 'retry/client_rate_limiter'
require_relative 'retry/exponential_backoff'
require_relative 'retry/retry_quota'
require_relative 'retry/standard'

module Hearth
  module Retry
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
