# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to initialize the request, called first in the stack
    # @api private
    class Initialize
      include Hearth::Interceptor::Hook
      # @param [Class] app The next middleware in the stack.
      # @param [List] interceptors
      def initialize(app)
        @app = app
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        # read_before_execution hook
        # exception behavior - exceptions are stored and the latest is used.
        # if there are exceptions, execution proceeds to before_completion hooks
        before_execution_error = interceptor_hook(
          :read_before_execution, input, context, nil, aggregate_errors: true
        )

        output = if before_execution_error
                   Hearth::Output.new(error: before_execution_error)
                 else
                   @app.call(input, context)
                 end

        interceptor_hook(
          :modify_before_completion, input, context, output, aggregate_errors: false
        )

        interceptor_hook(
          :read_after_execution, input, context, output, aggregate_errors: true
        )

        output
      end
    end
  end
end
