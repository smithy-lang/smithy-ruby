# frozen_string_literal: true

require 'stringio'

module Seahorse
  module HTTP
    # Represents an HTTP Response.
    class Response

      # @param [Integer] status
      # @param [Headers] headers
      # @param [IO] body
      def initialize(status: 200, headers: Headers.new, body: StringIO.new)
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

    end
  end
end
