# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that signs requests using the resolved identity.
    # @api private
    class Sign
      # @param [Class] app The next middleware in the stack.
      def initialize(app)
        @app = app
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        @app.call(input, context)
      end
    end
  end
end
