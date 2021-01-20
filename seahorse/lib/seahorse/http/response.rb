# frozen_string_literal: true

require 'stringio'

module Seahorse
  module HTTP
    # HTTP Response.
    class Response

      # @param [Integer] status_code
      # @param [Headers] headers
      # @param [IO] body
      def initialize(status_code: 0, headers: Headers.new, body: StringIO.new)
        @status_code = status_code
        @headers = headers
        @body = body
      end

      # @return [Integer]
      attr_accessor :status_code

      # @return [Headers]
      attr_accessor :headers

      # @return [IO]
      attr_accessor :body

    end
  end
end
