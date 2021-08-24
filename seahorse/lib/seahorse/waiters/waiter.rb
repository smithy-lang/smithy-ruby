# frozen_string_literal: true

module Seahorse
  module Waiters

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
        @before_attempt = Array(options[:before_attempt])
        @before_wait = Array(options[:before_wait])

        @remaining_time = @max_wait_time
      end

      attr_reader :max_wait_time, :min_delay, :max_delay

      # Register a callback that is invoked before every polling attempt.
      # Yields the number of attempts made so far.
      #
      #     waiter.before_attempt do |attempts|
      #       puts "#{attempts} made, about to make attempt #{attempts + 1}"
      #     end
      #
      # Throwing `:success` or `:failure` from the given block will stop
      # the waiter and return or raise. You can pass a custom message to the
      # throw:
      #
      #     # raises Seahorse::Waiters::Errors::WaiterFailed
      #     waiter.before_attempt do |attempts|
      #       throw :failure, 'custom-error-message'
      #     end
      #
      #     # cause the waiter to stop polling and return
      #     waiter.before_attempt do |attempts|
      #       throw :success
      #     end
      #
      # @yieldparam [Integer] attempts The number of attempts made.
      def before_attempt(&block)
        @before_attempt << block if block_given?
      end

      # Register a callback that is invoked after an attempt but before
      # sleeping. Yields the number of attempts made and the previous response.
      #
      #     waiter.before_wait do |attempts, response|
      #       puts "#{attempts} made"
      #       puts response.inspect
      #     end
      #
      # Throwing `:success` or `:failure` from the given block will stop
      # the waiter and return or raise. You can pass a custom message to the
      # throw:
      #
      #     # raises Seahorse::Waiters::Errors::WaiterFailed
      #     waiter.before_wait do |attempts, response|
      #       throw :failure, 'custom-error-message'
      #     end
      #
      #     # cause the waiter to stop polling and return
      #     waiter.before_wait do |attempts, response|
      #       throw :success
      #     end
      #
      #
      # @yieldparam [Integer] attempts The number of attempts already made.
      # @yieldparam [Struct] response The response struct from the previous
      #   polling attempts.
      def before_wait(&block)
        # TODO - how does this work for errors since response doesn't have it anymore??
        @before_wait << block if block_given?
      end

      # @param [Client] client The client to poll with.
      # @param [Hash] params The params for the operation.
      # @param [Hash] options Any operation options.
      def wait(client, params = {}, options = {})
        catch(:success) do
          failure_msg = catch(:failure) do
            return poll(client, params, options)
          end
          raise Errors::WaiterFailed, failure_msg || 'waiter failed'
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
          when :failure then raise Errors::FailureStateError, resp
          when :error   then raise UnexpectedError, resp # TODO - should be error...
          end

          # TODO bug here, remaining time never zero
          raise Errors::MaxWaitTimeExceeded if @remaining_time == 0

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
        attempt_ceiling = (
          Math.log(max_delay.to_f / min_delay) / Math.log(2)
        ) + 1

        delay = if attempt > attempt_ceiling
                  max_delay
                else
                  min_delay * 2**(attempt - 1)
                end

        delay = rand(min_delay..delay)

        if @remaining_time - delay <= min_delay
          delay = @remaining_time - min_delay
        end

        delay
      end

    end
  end
end
