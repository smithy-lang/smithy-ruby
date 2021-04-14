# frozen_string_literal: true

module Seahorse
  module HTTP
    # Base class for HTTP errors returned from an API
    class ApiError < Seahorse::ApiError
      def initialize(http_resp:, **kwargs)
        @http_status_code = http_resp.status_code
        @http_headers = http_resp.headers
        @http_body = http_resp.body
        @request_id = http_resp.headers['x-request-id']
        super(**kwargs)
      end

      # @return [Integer]
      attr_reader :http_status_code

      # @return [Hash<String, String>]
      attr_reader :http_headers

      # @return [String]
      attr_reader :http_body

      # @return [String]
      attr_reader :request_id
    end
  end
end
