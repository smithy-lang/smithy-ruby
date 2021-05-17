# frozen_string_literal: true

module Seahorse
  module Middleware
    class RequestHandler

      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param request
      # @param context
      # @return [Output, Response]
      def call(request, context)
        @handler.call(request, context)
        @app.call(request, context)
      end

    end
  end
end
