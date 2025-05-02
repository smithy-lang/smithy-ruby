# frozen_string_literal: true

module Smithy
  module Client
    module Waiters
      module Errors

        # Raised when a waiter detects a condition where the waiter can never
        # succeed.
        class WaiterFailed < StandardError; end

        class FailureStateError < WaiterFailed
          def initialize(response)
            msg = "stopped waiting, encountered a failure state"
            @response = response
            super(msg)
          end

          attr_reader :response
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
            @error = error
            super(msg % [error.message])
          end

          attr_reader :error
        end

        # Raised when attempting to get a waiter by name and the waiter has not
        # been defined.
        class NoSuchWaiterError < ArgumentError
          def initialize
            msg = "no such waiter"
            super(msg)
          end
        end
      end
    end
  end
end
