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
    # @!attribute retry_count
    #   The number of times the operation has been retried.
    #   @return [Integer]
    # @!attribute retry_delay
    #   The delay before the next retry.
    #   @return [Numeric]
    Token = Struct.new(:retry_count, :retry_delay, keyword_init: true) do
      # @option args [Integer] :retry_count (0)
      # @option args [Numeric] :retry_delay (0)
      def initialize(*args)
        super
        self.retry_count ||= 0
        self.retry_delay ||= 0
      end
    end
  end
end
