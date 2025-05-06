# frozen_string_literal: true

module Smithy
  module Client
    module Waiters
      module Errors
        # Raised when a waiter detects a condition where the waiter can never
        # succeed.
        class WaiterFailed < StandardError; end

        # Raised when a waiter enters a failure state.
        class FailureStateError < WaiterFailed
          def initialize(error)
            msg = "stopped waiting, encountered a failure state: #{error}"
            super(msg)
          end
        end

        # Raised when the total wait time of a waiter exceeds the maximum
        # wait time.
        class MaxWaitTimeExceededError < WaiterFailed
          def initialize(max_wait_time)
            msg = "stopped waiting after maximum wait time of #{max_wait_time} seconds was exceeded"
            super(msg)
          end
        end

        # Raised when a waiter encounters an unexpected error.
        class UnexpectedError < WaiterFailed
          def initialize(error)
            msg = "stopped waiting due to an unexpected error: #{error}"
            super(msg)
          end
        end

        # Raised when attempting to get a waiter by name and the waiter has not
        # been defined.
        class NoSuchWaiterError < ArgumentError
          def initialize(waiter_name, valid_waiters)
            msg = "no such waiter: #{waiter_name}; valid waiter names are: #{valid_waiters}"
            super(msg)
          end
        end
      end
    end
  end
end
