# frozen_string_literal: true

module Seahorse
  module Middleware
    # A class used to register middleware around a request.
    class AroundHandler
      # @param [Class] app The next middleware in the stack.
      # @param [Proc] handler A proc object that is called around the request.
      #   The proc must return the next middleware.
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
