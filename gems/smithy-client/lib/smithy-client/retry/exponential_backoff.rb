# frozen_string_literal: true

module Smithy
  module Client
    module Retry
      # Default exponential backoff retry strategy for retrying requests.
      class ExponentialBackoff
        def initialize(options = {})
          @base_delay = options[:base_delay] || 2
          @max_delay = options[:max_delay] || 20
        end

        # Calculates a delay based on exponential backoff strategy. Uses full jitter approach.
        # @param [Integer] attempts
        # @return [Float] delay in seconds
        def call(attempts)
          delay = (@base_delay**attempts)
          [delay, @max_delay].min * Kernel.rand
        end
      end
    end
  end
end
