# frozen_string_literal: true

module Hearth
  # A wrapper class that contains an error or data from the response.
  class Output
    # @param [ApiError] error The error class to be raised.
    # @param [Struct] data The data returned by a client.
    # @param [Hash] metadata Response metadata set by client middleware.
    def initialize(error: nil, data: nil, metadata: {})
      @error = error
      @data = data
      @metadata = metadata
    end

    # @return [ApiError, nil]
    attr_accessor :error

    # @return [Struct, nil]
    attr_accessor :data

    # @return [Hash]
    attr_accessor :metadata
  end
end
