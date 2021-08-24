# frozen_string_literal: true

module Seahorse
  module HTTP
    module Middleware
      # @api private
      class ContentLength

        def initialize(app)
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
