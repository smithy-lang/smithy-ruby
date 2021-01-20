# frozen_string_literal: true

module Seahorse
  # Base class for errors returned from an API. This excludes networking
  # errors and errors generated on the client-side.
  class ApiError < StandardError

    def initialize(
      error_code:,
      error_message:,
      http_status_code:,
      http_headers:,
      http_body:,
      request_id:
    )
      @error_code = error_code
      @http_status_code = http_status_code
      @http_headers = http_headers
      @http_body = http_body
      @request_id = request_id
      super("#{error_message}\n\n---\n#{http_body}".rstrip)
    end

    # @return [String]
    attr_reader :error_code

    # @return [Integer]
    attr_reader :http_status_code

    # @return [Hash<String, String>]
    attr_reader :http_headers

    # @return [String]
    attr_reader :http_body

    # @return [String]
    attr_reader :request_id

    # @api private
    def inspect
      parts = []
      parts << "message=#{message.split("\n\n---\n", 2).first.inspect}"
      parts << "http_status_code=#{http_status_code.inspect}"
      parts << "http_headers=#{http_headers.inspect}"
      parts << "http_body=#{http_body.inspect}"
      "#<#{self.class.name} #{parts.join(' ')}>"
    end

  end
end
