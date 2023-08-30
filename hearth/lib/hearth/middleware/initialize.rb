# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to initialize the request, called first in the stack
    # @api private
    class Initialize
      # @param [Class] app The next middleware in the stack.
      def initialize(app)
        @app = app
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        # if there are exceptions, execution proceeds to before_completion hooks
        interceptor_error = Interceptor.apply(
          hook: Interceptor::Hooks::READ_BEFORE_EXECUTION,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: true
        )

        output =
          if interceptor_error
            Hearth::Output.new(error: interceptor_error)
          else
            @app.call(input, context)
          end

        interceptor_error = Interceptor.apply(
          hook: Interceptor::Hooks::MODIFY_BEFORE_COMPLETION,
          input: input,
          context: context,
          output: output,
          aggregate_errors: false
        )
        output.error = interceptor_error if interceptor_error

        interceptor_error = Interceptor.apply(
          hook: Interceptor::Hooks::READ_AFTER_EXECUTION,
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
