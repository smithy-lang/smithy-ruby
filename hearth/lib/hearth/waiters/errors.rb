# frozen_string_literal: true

module Hearth
  module Waiters
    module Errors
      class WaiterFailed < StandardError; end

      class FailureStateError < StandardError; end

      class UnexpectedError < StandardError; end

      class MaxWaitTimeExceeded < StandardError; end
    end
  end
end
