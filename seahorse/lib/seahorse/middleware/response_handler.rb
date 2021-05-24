# frozen_string_literal: true

module Seahorse
  module Middleware
    class ResponseHandler

      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        output = @app.call(input, context)
        @handler.call(@app, input, context)
        output
      end

    end

  end
end
