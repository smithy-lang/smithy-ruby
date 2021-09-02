# frozen_string_literal: true

module Seahorse
  module Waiters
    # Abstract waiter class with high level logic for polling and waiting.
    class Waiter

      # @api private
      def initialize(options = {})
        unless options[:max_wait_time].is_a?(Integer)
          raise ArgumentError,
                'Waiter must be initialized with `:max_wait_time`'
        end

        @max_wait_time = options[:max_wait_time]
        @min_delay = options[:min_delay]
        @max_delay = options[:max_delay]
        @poller = options[:poller]

        @remaining_time = @max_wait_time
        @one_more_retry = false
      end

      attr_reader :max_wait_time, :min_delay, :max_delay

      # @param [Client] client The client to poll with.
      # @param [Hash] params The params for the operation.
      # @param [Hash] options Any operation options.
      def wait(client, params = {}, options = {})
        poll(client, params, options)
        true
      end

      private

      def poll(client, params, options)
        n = 0
        loop do
          state, resp_or_error = @poller.call(client, params, options)
          n += 1

          case state
          when :retry then nil
          when :success then return resp_or_error
          when :failure then raise Errors::FailureStateError, resp_or_error
          when :error   then raise Errors::UnexpectedError, resp_or_error
          end

          raise Errors::MaxWaitTimeExceeded if @one_more_retry

          delay = delay(n)
          @remaining_time -= delay
          Kernel.sleep(delay)
        end
      end

      def delay(attempt)
        delay = if attempt > attempt_ceiling
                  max_delay
                else
                  min_delay * 2**(attempt - 1)
                end

        delay = rand(min_delay..delay)

        if @remaining_time - delay <= min_delay
          delay = @remaining_time - min_delay
          @one_more_retry = true
        end

        delay
      end

      def attempt_ceiling
        (Math.log(max_delay.to_f / min_delay) / Math.log(2)) + 1
      end

    end
  end
end
