# frozen_string_literal: true

module Hearth
  module HTTP
    # Base class for HTTP errors returned from an API. Inherits from
    # {Hearth::ApiError}.
    class ApiError < Hearth::ApiError
      def initialize(http_resp:, **kwargs)
        @http_status = http_resp.status
        @http_headers = http_resp.headers
        @http_body = http_resp.body
        super(**kwargs)
      end

      # @return [Integer]
      attr_reader :http_status

      # @return [Hash<String, String>]
      attr_reader :http_headers

      # @return [String]
      attr_reader :http_body
    end
  end
end
