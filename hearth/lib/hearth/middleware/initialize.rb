# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to initialize the request, called first in the stack
    # @api private
    class Initialize
      include Middleware::Logging

      # @param [Class] app The next middleware in the stack.
      def initialize(app)
        @app = app
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        interceptor_error = Interceptors.invoke(
          hook: Interceptor::READ_BEFORE_EXECUTION,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: true
        )

        output =
          if interceptor_error
            Hearth::Output.new(error: interceptor_error)
          else
            log_debug(context, 'Initializing request')
            @app.call(input, context)
          end
        log_debug(context, 'Finished request')

        interceptor_error = Interceptors.invoke(
          hook: Interceptor::MODIFY_BEFORE_COMPLETION,
          input: input,
          context: context,
          output: output,
          aggregate_errors: false
        )
        output.error = interceptor_error if interceptor_error

        interceptor_error = Interceptors.invoke(
          hook: Interceptor::READ_AFTER_EXECUTION,
          input: input,
          context: context,
          output: output,
          aggregate_errors: true
        )
        output.error = interceptor_error if interceptor_error

        output
      end
    end
  end
end
