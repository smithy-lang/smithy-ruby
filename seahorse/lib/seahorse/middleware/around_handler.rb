# frozen_string_literal: true

module Seahorse
  module Middleware
    class AroundHandler

      def initialize(app, handler)
        @app = app
        @handler = handler
      end

      # @param http_req
      # @param http_resp
      # @param metadata
      # @return [Response]
      def call(http_req:, http_resp:, metadata:)
        @handler.call(@app, http_req, http_resp, metadata)
      end

    end
  end
end
