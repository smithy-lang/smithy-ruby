# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that builds a request object.
    # @api private
    class Build
      # @param [Class] app The next middleware in the stack.
      # @param [Class] builder A builder object responsible for building the
      #  request. It must respond to #build and take the request and input as
      #  arguments.
      def initialize(app, builder:)
        @app = app
        @builder = builder
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        interceptor_error = Interceptor.apply(
          hook: Interceptor::Hooks::MODIFY_BEFORE_SERIALIZATION,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        interceptor_error = Interceptor.apply(
          hook: Interceptor::Hooks::READ_BEFORE_SERIALIZATION,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        @builder.build(context.request, input: input)

        interceptor_error = Interceptor.apply(
          hook: Interceptor::Hooks::READ_AFTER_SERIALIZATION,
          input: input,
          context: context,
          output: nil,
          aggregate_errors: false
        )
        return Hearth::Output.new(error: interceptor_error) if interceptor_error

        @app.call(input, context)
      end
    end
  end
end
