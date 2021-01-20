# frozen_string_literal: true

module Seahorse
  module Middleware
    class Build

      def initialize(app, builder:, params:)
        @app = app
        @builder = builder
        @params = params
      end

      # @param http_req
      # @param http_resp
      # @param metadata
      # @return [Response]
      def call(http_req:, http_resp:, metadata:)
        @builder.build(
          http_req: http_req,
          params: @params
        )
        @app.call(
          http_req: http_req,
          http_resp: http_resp,
          metadata: metadata
        )
      end

    end
  end
end
