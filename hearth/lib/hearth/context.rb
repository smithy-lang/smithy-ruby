# frozen_string_literal: true

require 'securerandom'

module Hearth
  # Stores request and response objects, and other useful things used by
  # multiple Middleware.
  # @api private
  class Context
    def initialize(options = {})
      @invocation_id = SecureRandom.uuid
      @operation_name = options[:operation_name]
      @request = options[:request]
      @response = options[:response]
      @config = options[:config]
      @auth = options[:auth]
      @tracer = options[:tracer]
      @metadata = options[:metadata] || {}
    end

    # @return [String] The invocation ID for the request.
    attr_reader :invocation_id

    # @return [Symbol] The name of the API operation called.
    attr_reader :operation_name

    # @return [Request]
    attr_reader :request

    # @return [Response]
    attr_reader :response

    # @return [Configuration] An instance of operation configuration.
    attr_reader :config

    # @return [ResolvedAuth, nil] The resolved auth for the request.
    attr_accessor :auth

    # @return [Tracer] An instance of Tracer.
    attr_accessor :tracer

    # @return [Hash]
    attr_reader :metadata

    # Returns the metadata for the given `key`.
    # @param [Symbol] key
    # @return [Object]
    def [](key)
      @metadata[key]
    end

    # Sets metadata for the given `key`.
    # @param [Symbol] key
    # @param [Object] value
    def []=(key, value)
      @metadata[key] = value
    end
  end
end
