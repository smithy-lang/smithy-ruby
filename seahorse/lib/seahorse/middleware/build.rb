# frozen_string_literal: true

module Seahorse
  module Middleware
    class Build

      def initialize(app, builder:, input:)
        @app = app
        @builder = builder
        @input = input
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, context:)
        @builder.build(request, @input)
        @app.call(
          request: request,
          context: context
        )
      end

    end
  end
end
