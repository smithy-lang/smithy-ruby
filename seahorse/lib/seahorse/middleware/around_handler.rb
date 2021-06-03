# frozen_string_literal: true

module Seahorse
  module Middleware
    class AroundHandler
      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        @handler.call(@app, input, context)
      end
    end
  end
end
