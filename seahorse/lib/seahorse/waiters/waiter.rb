# frozen_string_literal: true

module Seahorse
  module Waiters

    class Waiter
      def initialize(options = {})
        unless options[:max_wait_time].is_a?(Integer)
          raise ArgumentError,
                'Waiter needs a maximum amount of time, as an Integer'
        end

        @max_wait_time = options[:max_wait_time]
        @min_delay = options[:min_delay]
        @max_delay = options[:max_delay]
        @remaining_time = @max_wait_time
        @poller = options[:poller]
        @before_attempt = Array(options[:before_attempt])
        @before_wait = Array(options[:before_wait])
      end

      attr_reader :max_wait_time, :min_delay, :max_delay, :remaining_time

      def before_attempt(&block)
        @before_attempt << block if block_given?
      end

      def before_wait(&block)
        @before_wait << block if block_given?
      end

      def wait(client, params = {}, options = {})
        catch(:success) do
          failure_msg = catch(:failure) do
            return poll(client, params, options)
          end
          raise (failure_msg || 'waiter failed') # todo
        end || true
      end

      private

      def poll(client, params, options)
        n = 0
        loop do
          trigger_before_attempt(n)

          state, resp = @poller.call(client, params, options)
          n += 1

          case state
          when :retry
          when :success then return resp
          when :failure then raise "TODO Failure with #{resp}"
          when :error   then raise "TODO unexpected with #{resp}"
          end

          puts "remaining_time: #{@remaining_time}"
          raise if @remaining_time == 0

          trigger_before_wait(n, resp)
          delay = delay(n)
          puts "delay is: #{delay}"
          @remaining_time -= delay
          Kernel.sleep(delay)
        end
      end

      def trigger_before_attempt(attempts)
        @before_attempt.each { |block| block.call(attempts) }
      end

      def trigger_before_wait(attempts, response)
        @before_wait.each { |block| block.call(attempts, response) }
      end

      def delay(attempt)
        attempt_ceiling = (Math.log(max_delay.to_f / min_delay) / Math.log(2)) + 1

        if attempt > attempt_ceiling
          max_delay
        else
          min_delay * 2**(attempt - 1)
        end => delay

        delay = rand(min_delay..delay)

        if remaining_time - delay <= min_delay
          delay = remaining_time - min_delay
        end

        delay
      end

    end
  end
end
