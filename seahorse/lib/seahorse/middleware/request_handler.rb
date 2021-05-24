# frozen_string_literal: true

module Seahorse
  module Middleware
    class RequestHandler

      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param input
      # @param context
      # @return [Types::<Operation>Output]
      def call(input, context)
        @handler.call(input, context.request, context)
        @app.call(input, context)
      end

    end
  end
end
