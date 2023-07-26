# frozen_string_literal: true

module Hearth
  module HTTP
    # Base class for HTTP errors returned from an API. Inherits from
    # {Hearth::ApiError}.
    class ApiError < Hearth::ApiError
      def initialize(http_resp:, **kwargs)
        @http_status = http_resp.status
        @http_fields = http_resp.fields
        @http_body = http_resp.body
        super(**kwargs)
      end

      # @return [Integer]
      attr_reader :http_status

      # @return [Fields]
      attr_reader :http_fields

      # @return [IO]
      attr_reader :http_body
    end
  end
end
