# frozen_string_literal: true

module Seahorse
  class Context
    def initialize(params:, logger:, metadata: {})
      @params = params
      @logger = logger
      @metadata = metadata
    end

    # @return [Hash]
    attr_accessor :params

    # @return [Logger]
    attr_accessor :logger

    # @return [Hash]
    attr_reader :metadata

    # Returns the metadata for the given `key`.
    # @param [Symbol] key
    # @return [Object]
    def [](key)
      @metadata[key]
    end

    # Sets the request context metadata for the given `key`. Metadata is
    # useful for middleware that need to keep state on the request, without
    # sending that data with the request over HTTP.
    # @param [Symbol] key
    # @param [Object] value
    def []=(key, value)
      @metadata[key] = value
    end
  end
end
