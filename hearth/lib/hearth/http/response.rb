# frozen_string_literal: true

require 'stringio'

module Hearth
  module HTTP
    # Represents an HTTP Response.
    # @api private
    class Response
      # @param [Integer] status
      # @param [Headers] headers
      # @param [IO] body
      def initialize(status: 0, headers: Headers.new, body: StringIO.new)
        @status = status
        @headers = headers
        @body = body
      end

      # @return [Integer]
      attr_accessor :status

      # @return [Headers]
      attr_accessor :headers

      # @return [IO]
      attr_accessor :body

      # Resets the HTTP response.
      # @return [Response]
      def reset
        @status = 0
        @headers.clear
        @body.truncate(0)
        self
      end
    end
  end
end
