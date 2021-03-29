# frozen_string_literal: true

module Seahorse
  module Middleware
    class Build

      def initialize(app, builder:, params:)
        @app = app
        @builder = builder
        @params = params
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, response:, context:)
        @builder.build(request, params: @params)
        @app.call(
          request: request,
          response: response,
          context: context
        )
      end

    end
  end
end
