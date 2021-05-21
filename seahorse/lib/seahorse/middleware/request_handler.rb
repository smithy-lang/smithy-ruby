# frozen_string_literal: true

module Seahorse
  module Middleware
    class RequestHandler

      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, context:)
        @handler.call(request, context)
        @app.call(
          request: request,
          context: context
        )
      end

    end
  end
end
