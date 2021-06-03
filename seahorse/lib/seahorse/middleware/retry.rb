# frozen_string_literal: true

module Seahorse
  module Middleware
    class Retry

      def initialize(app, max_attempts:, max_delay:)
        @app = app
        @max_attempts = max_attempts
        @max_delay = max_delay
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        attempt = 1
        begin
          @app.call(input, context)
        rescue Seahorse::HTTP::NetworkingError => e
          if attempt < @max_attempts
            Kernel.sleep(backoff_with_jitter(attempt))
            attempt += 1
            retry
          else
            raise e
          end
        end
      end

      private

      # https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/
      def backoff_with_jitter(attempt)
        # scales like 1,2,4,8
        Kernel.rand * [@max_delay, 2**(attempt - 1)].min
      end

    end
  end
end
