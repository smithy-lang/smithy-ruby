# frozen_string_literal: true

module Smithy
  module Client
    module Waiters
      module Errors

        # Raised when a waiter detects a condition where the waiter can never
        # succeed.
        class WaiterFailed < StandardError; end

        class FailureStateError < WaiterFailed
          def initialize(error)
            msg = "stopped waiting, encountered a failure state: %s"
            super(msg % [error])
          end
        end

        class MaxWaitTimeExceededError < WaiterFailed
          def initialize(max_wait_time)
            msg = "stopped waiting after maximum wait time of %s seconds was exceeded"
            super(msg % [max_wait_time])
          end
        end

        class UnexpectedError < WaiterFailed
          def initialize(error)
            msg = "stopped waiting due to an unexpected error: %s"
            super(msg % [error])
          end
        end

        # Raised when attempting to get a waiter by name and the waiter has not
        # been defined.
        class NoSuchWaiterError < ArgumentError
          def initialize(waiter_name, valid_waiters)
            msg = "no such waiter: %s; valid waiter names are: %s"
            super(msg % [waiter_name, valid_waiters])
          end
        end
      end
    end
  end
end
