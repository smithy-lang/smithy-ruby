# frozen_string_literal: true

module Smithy
  module Client
    module Retry
      # Represents a token that can be used to retry an operation.
      class Token
        def initialize
          @retry_count = 0
          @retry_delay = 0
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
