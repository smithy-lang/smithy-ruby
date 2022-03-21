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
      # @param [Boolean] disable_host_prefix When true, does not perform
      #   host prefix injection using @endpoint's hostPrefix property.
      def initialize(app, builder:, disable_host_prefix:)
        @app = app
        @builder = builder
        @disable_host_prefix = disable_host_prefix
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        @builder.build(
          context.request,
          input: input,
          disable_host_prefix: @disable_host_prefix
        )
        @app.call(input, context)
      end
    end
  end
end
