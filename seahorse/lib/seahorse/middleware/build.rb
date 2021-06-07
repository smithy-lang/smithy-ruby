# frozen_string_literal: true

module Seahorse
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
        @builder.build(context.request, input: input)
        @app.call(input, context)
      end
    end
  end
end
