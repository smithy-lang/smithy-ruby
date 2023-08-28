# frozen_string_literal: true

module Hearth
  module Retry
    # Raised by Retry::Adaptive when the client rate limiter
    # doesn't have capacity.
    class CapacityNotAvailableError < RuntimeError; end
  end
end
