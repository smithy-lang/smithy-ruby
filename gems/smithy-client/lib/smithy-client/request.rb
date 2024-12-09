# frozen_string_literal: true

require 'stringio'
require 'uri'

module Smithy
  module Client
    # Represents a base request.
    class Request
      # @option options [String, URI::HTTP, URI::HTTPS, nil] :endpoint (nil)
      # @option options [IO, StringIO, #read, #size, #rewind] :body (StringIO.new)
      def initialize(options = {})
        self.endpoint = options[:endpoint]
        self.body = options[:body] || StringIO.new
      end

      # @return [URI::HTTP, URI::HTTPS, nil]
      attr_reader :endpoint

      # @return [IO, StringIO]
      attr_reader :body

      # @param [String, URI::HTTP, URI::HTTPS, nil] endpoint
      def endpoint=(endpoint)
        endpoint = URI.parse(endpoint) if endpoint.is_a?(String)
        unless endpoint.nil? || endpoint.is_a?(URI::HTTP) || endpoint.is_a?(URI::HTTPS)
          msg = 'invalid endpoint, expected URI::HTTP, URI::HTTPS, or nil, '\
                "got #{endpoint.inspect}"
          raise ArgumentError, msg
        end

        @endpoint = endpoint
      end

      # @param [#read, #size, #rewind] io
      def body=(io)
        @body =
          case io
          when nil then StringIO.new
          when String then StringIO.new(io)
          else io
          end
      end
    end
  end
end
