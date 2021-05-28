# frozen_string_literal: true

module Seahorse
  module Waiters
    module Errors

      class WaiterFailed < StandardError; end

      class FailureStateError < StandardError; end

      class UnexpectedError < StandardError; end

      class MaxWaitTimeExceeded < StandardError; end

    end
  end
end
