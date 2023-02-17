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
      def initialize(app, builder:, interceptors:)
        @app = app
        @builder = builder
        @interceptors = interceptors
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        # modify_before_serialization hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeCompletion
        @interceptors.reverse.each do |i|
          if i.respond_to?(:modify_before_serialization)
            begin
              input = i.modify_before_serialization(context.interceptor_context(input, nil))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        # read_before_serialization hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeCompletion
        @interceptors.reverse.each do |i|
          if i.respond_to?(:modify_before_serialization)
            begin
              i.read_before_serialization(context.interceptor_context(input, nil))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        @builder.build(context.request, input: input)
        @app.call(input, context)
      end
    end
  end
end
