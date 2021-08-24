# frozen_string_literal: true

module Seahorse
  # @api private
  module Stubbing
    # Provides a thread safe data structure for adding and getting stubs
    # per operation.
    class Stubs
      def initialize
        @stubs = {}
        @stub_mutex = Mutex.new
      end

      def add_stubs(operation_name, stubs)
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
end
