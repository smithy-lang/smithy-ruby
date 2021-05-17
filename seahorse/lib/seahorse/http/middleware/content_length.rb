# frozen_string_literal: true

module Seahorse
  module HTTP
    module Middleware
      # @api private
      class ContentLength

        def initialize(app)
          @app = app
        end

        # @param request
        # @param context
        # @return [Output, Response]
        def call(request, context)
          if request&.body&.respond_to?(:size)
            length = request.body.size
            request.headers['Content-Length'] = length
          end

          @app.call(request, context)
        end
      end
    end
  end
end
