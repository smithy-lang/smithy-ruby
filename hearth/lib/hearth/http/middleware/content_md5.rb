# frozen_string_literal: true

module Hearth
  module HTTP
    module Middleware
      # A middleware that sets Content-MD5 for any body.
      # @api private
      class ContentMD5
        def initialize(app, _ = {})
          @app = app
        end

        # @param input
        # @param context
        # @return [Output]
        def call(input, context)
          request = context.request
          unless request.fields.key?('Content-MD5')
            md5 = Hearth::Checksums.md5(request.body)
            request.headers['Content-MD5'] = md5
          end

          @app.call(input, context)
        end
      end
    end
  end
end
