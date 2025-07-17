# frozen_string_literal: true

module Smithy
  module Client
    # Context that is passed to handlers during execution.
    class HandlerContext
      # @option options [Symbol] :operation_name (nil)
      # @option options [OperationShape] :operation (nil)
      # @option options [Base] :client (nil)
      # @option options [Hash] :params ({})
      # @option options [Configuration] :config (nil)
      # @option options [Http::Request] :http_request (Http::Request.new)
      # @option options [Http::Response] :http_response (Http::Response.new)
      # @option options [Hash] :auth (nil)
      # @option options [Hash] :metadata ({})
      def initialize(options = {})
        @operation_name = options[:operation_name]
        @operation = options[:operation]
        @client = options[:client]
        @params = options[:params] || {}
        @config = options[:config]
        @http_request = options[:http_request] || Http::Request.new
        @http_response = options[:http_response] || Http::Response.new
        @auth = options[:auth]
        @retries = 0
        @metadata = {}
      end

      # @return [Symbol] Name of the API operation called.
      attr_accessor :operation_name

      # @return [OperationShape] Shape of the Operation called.
      attr_accessor :operation

      # @return [Base]
      attr_accessor :client

      # @return [Hash] The request parameters as a Hash.
      attr_accessor :params

      # @return [Struct] The client configuration.
      attr_accessor :config

      # @return [Http::Request]
      attr_accessor :http_request

      # @return [Http::Response]
      attr_accessor :http_response

      # @return [Hash]
      attr_accessor :auth

      # @return [Integer]
      attr_accessor :retries

      # @return [Hash]
      attr_reader :metadata

      # @param [Symbol] key
      # @return [Object]
      def [](key)
        @metadata[key]
      end

      # @param [Symbol] key
      # @param [Object] value
      def []=(key, value)
        @metadata[key] = value
      end
    end
  end
end
