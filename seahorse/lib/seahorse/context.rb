# frozen_string_literal: true

module Seahorse
  class Context
    def initialize(metadata = {})
      @metadata = metadata
    end

    # @return [Hash]
    def params
      @metadata[:params]
    end

    # @return [Logger]
    def logger
      @metadata[:logger]
    end

    def request
      @metadata[:request]
    end

    def response
      @metadata[:response]
    end

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
