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
      def call(request:, response:, context:)
        @builder.build(request, input: @input)
        @app.call(
          request: request,
          response: response,
          context: context
        )
      end

    end
  end
end
