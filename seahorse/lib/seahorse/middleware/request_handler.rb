# frozen_string_literal: true

module Seahorse
  module Middleware
    # A class used to register middleware before a request is sent.
    class RequestHandler
      # @param [Class] app The next middleware in the stack.
      # @param [Proc] handler A proc object that is called before the request.
      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        @handler.call(input, context)
        @app.call(input, context)
      end
    end
  end
end
