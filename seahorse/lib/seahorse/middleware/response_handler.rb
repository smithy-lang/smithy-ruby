# frozen_string_literal: true

module Seahorse
  module Middleware
    class ResponseHandler

      def initialize(app, handler)
        @app = app
        @handler = handler
      end

      # @param http_req
      # @param http_resp
      # @param metadata
      # @return [Response]
      def call(http_req:, http_resp:, metadata:)
        response = @app.call(
          http_req: http_req,
          http_resp: http_resp,
          metadata: metadata
        )
        @handler.call(response, http_req, http_resp)
        response
      end

    end

  end
end
