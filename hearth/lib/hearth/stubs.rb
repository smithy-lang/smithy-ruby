# frozen_string_literal: true

module Hearth
  # Provides a thread safe data structure for adding and getting stubs
  # per operation.
  class Stubs
    # Initializes the stubs with an optional hash of stubs.
    # For an example of stubs, see {ClientStubs}.
    # @param [Hash<Symbol, Array<Stub>>] stubs
    def initialize(stubs = {})
      @stubs = stubs
      @stub_mutex = Mutex.new
    end

    # Adds a stub or list of stubs to the given operation name.
    # @param [String] operation_name
    # @param [Array<Stub>] stubs
    def set_stubs(operation_name, stubs)
      @stub_mutex.synchronize do
        @stubs[operation_name.to_sym] = stubs
      end
    end

    # Returns the next stub for the given operation name.
    # @param [String] operation_name
    # @return [Stub, nil]
    def next(operation_name)
      @stub_mutex.synchronize do
        stubs = @stubs[operation_name] || []
        case stubs.length
        when 0 then nil
        when 1 then stubs.first
        else stubs.shift
        end
      end
    end
  end
end
