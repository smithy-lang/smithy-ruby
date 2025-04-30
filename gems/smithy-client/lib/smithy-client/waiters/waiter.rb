# frozen_string_literal: true

module Smithy
  module Client
    module Waiters
      class Waiter
        def initialize(options = {})
          @max_wait_time = options[:max_wait_time]
          @remaining_time = @max_wait_time
          @min_delay = options[:min_delay]
          @max_delay = options[:max_delay]
          @poller = options[:poller]
          @client = options[:client] # custom waiter approach
        end

        def wait(client, params)
          poll(client, params)
        end

        def wait_custom(params)
          poll(@client, params)
        end

        private

        def poll(client, params)
          attempts = 0
          loop do
            resp, status = @poller.call(client, params)
            attempts += 1

            case status.to_sym
            when :retry
            when :success then return resp
            when :failure then raise Errors::FailureStateError.new(resp)
            when :error then raise Errors::UnexpectedError.new(resp)
            end

            raise Errors::MaxWaitTimeExceededError.new(@max_wait_time) if @remaining_time == 0

            delay = delay(attempts)
            @remaining_time -= delay
            sleep(delay)
          end
        end

        def delay(attempts)
          attempt_ceiling = (Math.log(@max_delay / @min_delay) / Math.log(2)) + 1
          delay = attempts > attempt_ceiling ? @max_delay : @min_delay * 2 ** (attempts - 1)
          delay = rand(@min_delay..delay)
          delay = @remaining_time if @remaining_time - delay <= @min_delay
          puts "delay for #{delay} seconds"
          delay
        end
      end
    end
  end
end