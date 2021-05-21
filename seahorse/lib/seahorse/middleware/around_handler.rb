# frozen_string_literal: true

module Seahorse
  module Middleware
    class AroundHandler

      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, response:, context:)
        @handler.call(@app, request, response, context)
      end

    end
  end
end
