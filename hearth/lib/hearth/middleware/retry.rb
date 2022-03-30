# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that retries the request.
    # @api private
    class Retry
      # @param [Class] app The next middleware in the stack.
      # @param [Integer] max_attempts The maximum number of attempts to make
      #  before giving up.
      # @param [Integer] max_delay The maximum delay between attempts.
      def initialize(app, max_attempts:, max_delay:)
        @app = app
        @max_attempts = max_attempts
        @max_delay = max_delay
      end

      # @param input
      # @param context
      # @return [Output]
      # rubocop:disable Metrics/MethodLength
      def call(input, context)
        attempt = 1
        begin
          output = @app.call(input, context)
          raise output.error if output.error

          output
        rescue Hearth::ApiError => e
          return output if !e.retryable? || attempt >= @max_attempts

          Kernel.sleep(backoff_with_jitter(attempt))
          attempt += 1
          retry
        rescue Hearth::HTTP::NetworkingError => e
          raise e if attempt >= @max_attempts

          Kernel.sleep(backoff_with_jitter(attempt))
          attempt += 1
          retry
        end
      end
      # rubocop:enable Metrics/MethodLength

      private

      # https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/
      def backoff_with_jitter(attempt)
        # scales like 1,2,4,8
        Kernel.rand * [@max_delay, 2**(attempt - 1)].min
      end
    end
  end
end
