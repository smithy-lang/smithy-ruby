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
        interceptor_error = context.interceptors.apply(
          hook: :read_before_execution,
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

        context.interceptors.apply(
          hook: :modify_before_completion,
          input: input,
          context: context,
          output: output,
          aggregate_errors: false
        )

        context.interceptors.apply(
          hook: :read_after_execution,
          input: input,
          context: context,
          output: output,
          aggregate_errors: true
        )

        output
      end
    end
  end
end
