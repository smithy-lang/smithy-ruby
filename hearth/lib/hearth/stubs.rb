# frozen_string_literal: true

module Hearth
  # Provides a thread safe data structure for adding and getting stubs
  # per operation.
  # TODO: add documentation
  class Stubs
    def initialize(stubs = {})
      # TODO: initialize stubs
      @stubs = stubs
      @stub_mutex = Mutex.new
    end

    def set_stubs(operation_name, stubs)
      @stub_mutex.synchronize do
        @stubs[operation_name.to_sym] = stubs
      end
    end

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
