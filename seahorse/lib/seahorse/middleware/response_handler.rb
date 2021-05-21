# frozen_string_literal: true

module Seahorse
  module Middleware
    class ResponseHandler

      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, context:)
        output = @app.call(
          request: request,
          context: context
        )
        @handler.call(request, context)
        output
      end

    end

  end
end
