# frozen_string_literal: true

module Smithy
  module Client
    module Errors

      # Raised when a waiter detects a condition where the waiter can never
      # succeed.
      class WaiterFailed < StandardError; end

      class FailureStateError < WaiterFailed
        MSG = "stopped waiting, encountered a failure state"

        def initialize(response)
          @response = response
          super(MSG)
        end

        attr_reader :response
      end

      class MaxWaitTimeExceededError < WaiterFailed
        MSG = "stopped waiting after maximum wait time was exceeded"

        def initialize
          super(MSG)
        end
      end

      class UnexpectedError < WaiterFailed
        MSG = "stopped waiting due to an unexpected error: %s"

        def initialize(error)
          @error = error
          super(MSG % [error.message])
        end

        attr_reader :error
      end

      # Raised when attempting to get a waiter by name and the waiter has not
      # been defined.
      class NoSuchWaiterError < ArgumentError
        MSG = "no such waiter"

        def initialize
          super(MSG)
        end
      end
    end
  end
end
