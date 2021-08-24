# frozen_string_literal: true

module Seahorse
  # A wrapper class that contains an error or data from the response.
  # @api private
  class Output
    # @param [StandardError] error The error class to be raised.
    # @param [Struct] data The data returned by a client.
    def initialize(error: nil, data: nil)
      @error = error
      @data = data
    end

    # @return [StandardError, nil]
    attr_accessor :error

    # @return [Struct, nil]
    attr_accessor :data
  end
end
