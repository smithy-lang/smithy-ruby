# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to initialize the request, called first in the stack
    # @api private
    class Initialize
      # @param [Class] app The next middleware in the stack.
      # @param [List] interceptors
      def initialize(app)
        @app = app
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        # if there are exceptions, execution proceeds to before_completion hooks
        before_execution_error = context.interceptors.apply(
          :read_before_execution, input, context, nil, aggregate_errors: true
        )

        output = if before_execution_error
                   Hearth::Output.new(error: before_execution_error)
                 else
                   @app.call(input, context)
                 end

        context.interceptors.apply(
          :modify_before_completion, input, context, output, aggregate_errors: false
        )

        context.interceptors.apply(
          :read_after_execution, input, context, output, aggregate_errors: true
        )

        output
      end
    end
  end
end
