# frozen_string_literal: true

module Hearth
  module Middleware
    # A class used to register middleware after a request is sent.
    # @api private
    class ResponseHandler
      # @param [Class] app The next middleware in the stack.
      # @param [Proc] handler A proc object that is called after the request.
      def initialize(app, handler:)
        @app = app
        @handler = handler
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        output = @app.call(input, context)
        @handler.call(output, context)
        output
      end
    end
  end
end
