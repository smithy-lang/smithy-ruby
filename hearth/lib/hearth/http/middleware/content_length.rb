# frozen_string_literal: true

module Hearth
  module HTTP
    module Middleware
      # A middleware that sets Content-Length for any body that has a size.
      # @api private
      class ContentLength
        include Hearth::Middleware::Logging

        def initialize(app, _ = {})
          @app = app
        end

        # @param input
        # @param context
        # @return [Output]
        def call(input, context)
          request = context.request
          body = request.body
          if !request.headers.key?('Content-Length') &&
            (body.respond_to?(:size) && body.size.positive?)
            length = body.size
            request.headers['Content-Length'] = length
            log_debug(context, "Set Content-Length to #{length}")
          end

          @app.call(input, context)
        end
      end
    end
  end
end
