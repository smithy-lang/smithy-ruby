# frozen_string_literal: true

module Smithy
  module Client
    module Retry
      # Represents a token that can be used to retry an operation.
      class Token
        def initialize
          @retry_count = 0
          @retry_delay = 0
          @capacity_amount = nil
          @no_retry_reason = nil
        end

        # The number of times the operation has been retried.
        # @return [Integer]
        attr_accessor :retry_count

        # The delay before the next retry.
        # @return [Numeric]
        attr_accessor :retry_delay

        # The quota capacity token has taken.
        # @return [Integer]
        attr_accessor :capacity_amount

        # The reason for no-retry.
        # @return [Symbol, nil] :quota_exhausted, or nil
        attr_accessor :no_retry_reason
      end
    end
  end
end
