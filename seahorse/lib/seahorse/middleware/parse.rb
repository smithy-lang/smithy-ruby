# frozen_string_literal: true

module Seahorse
  module Middleware
    class Parse

      def initialize(app, error_parser:, data_parser:)
        @app = app
        @error_parser = error_parser
        @data_parser = data_parser
      end

      # @param http_req
      # @param http_resp
      # @param metadata
      # @return [Response]
      def call(http_req:, http_resp:, metadata:)
        resp = @app.call(
          http_req: http_req,
          http_resp: http_resp,
          metadata: metadata
        )
        parse_error(http_resp, resp) unless resp.error
        parse_data(http_resp, resp) unless resp.error
        resp
      end

      private

      def parse_error(http_resp, resp)
        resp.error = @error_parser.parse(http_resp: http_resp)
        if resp.error.is_a?(Seahorse::ApiError)
          resp.metadata[:request_id] = resp.error.request_id
        end
      end

      def parse_data(http_resp, resp)
        return unless (200..299).cover?(http_resp.status_code)
        @data_parser.parse(
          http_resp: http_resp,
          resp: resp
        )
      end

    end
  end
end
