# frozen_string_literal: true

module Smithy
  module Client
    module Waiters
      # Abstract waiter class which waits for a resource to reach a desired
      # state.
      class Waiter
        def initialize(options = {})
          @max_wait_time = max_wait_time(options[:max_wait_time])
          @remaining_time = @max_wait_time
          @max_delay = max_delay(options[:max_delay])
          @min_delay = min_delay(options[:min_delay])
          @poller = options[:poller]
        end

        def wait(client, params)
          poll(client, params)
        end

        private

        def max_wait_time(time)
          raise ArgumentError, "expected `:max_wait_time` to be an integer, got: #{time}" unless time.is_a?(Integer)

          time
        end

        def max_delay(delay)
          raise ArgumentError, '`:max_delay` must be greater than 0' if delay < 1

          delay
        end

        def min_delay(delay)
          if delay < 1 || delay > @max_delay
            raise ArgumentError, '`:min_delay` must be greater than 0 and less than or equal to `:max_delay`'
          end

          delay
        end

        def poll(client, params)
          attempts = 0
          loop do
            output, status = @poller.call(client, params)
            attempts += 1

            case status
            when :success then return output.data
            when :failure then raise Smithy::Client::Errors::FailureStateError, output.error
            when :error then raise Smithy::Client::Errors::UnexpectedError, output.error
            when :retry
              raise Smithy::Client::Errors::MaxWaitTimeExceededError, @max_wait_time if @remaining_time.zero?

              delay = delay(attempts)
              @remaining_time -= delay
              sleep(delay)
            end
          end
        end

        def delay(attempts)
          attempt_ceiling = (Math.log(@max_delay / @min_delay) / Math.log(2)) + 1
          delay = attempts > attempt_ceiling ? @max_delay : @min_delay * (2**(attempts - 1))
          delay = rand(@min_delay..delay)
          delay = @remaining_time if @remaining_time - delay <= @min_delay
          delay
        end
      end
    end
  end
end
