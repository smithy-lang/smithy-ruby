# frozen_string_literal: true

module Seahorse
  # @api private
  module Middleware
    class Sign

      def initialize(app, signer:)
        @app = app
        @signer = signer
      end

      # @param http_req
      # @param http_resp
      # @param metadata
      # @return [Response]
      def call(http_req:, http_resp:, metadata:)
        @signer.sign_request(http_req) if @signer
        @app.call(
          http_req: http_req,
          http_resp: http_resp,
          metadata: metadata
        )
      end

    end
  end
end
