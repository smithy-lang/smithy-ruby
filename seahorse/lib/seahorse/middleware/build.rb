# frozen_string_literal: true

module Seahorse
  module Middleware
    class Build

      def initialize(app, builder:)
        @app = app
        @builder = builder
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        @builder.build(context.request, input.data)
        @app.call(input, context)
      end

    end
  end
end
