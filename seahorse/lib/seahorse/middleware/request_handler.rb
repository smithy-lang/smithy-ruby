# frozen_string_literal: true

module Seahorse
  module Middleware
    class RequestHandler

      def initialize(app, handler)
        @app = app
        @handler = handler
      end

      # @param http_req
      # @param http_resp
      # @param metadata
      # @return [Response]
      def call(http_req:, http_resp:, metadata:)
        @handler.call(http_req, http_resp, metadata)
        @app.call(
          http_req: http_req,
          http_resp: http_resp,
          metadata: metadata
        )
      end

    end
  end
end
