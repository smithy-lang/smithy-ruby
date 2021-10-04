# frozen_string_literal: true

module Seahorse
  module HTTP
    module Middleware
      # A middleware that sets Content-Length for any body that has a size.
      # @api private
      class ContentLength
        def initialize(app, _ = {})
          @app = app
        end

        # @param input
        # @param context
        # @return [Output]
        def call(input, context)
          request = context.request
          if request&.body.respond_to?(:size)
            length = request.body.size
            request.headers['Content-Length'] = length
          end

          @app.call(input, context)
        end
      end
    end
  end
end
