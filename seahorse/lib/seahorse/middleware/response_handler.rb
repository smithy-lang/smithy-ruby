# frozen_string_literal: true

module Seahorse
  module Middleware
    class ResponseHandler

      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param request
      # @param context
      # @return [Output, Response]
      def call(request, context)
        output, response = @app.call(request, context)
        @handler.call(request, context, output, response)
        [output, response]
      end

    end

  end
end
