# frozen_string_literal: true

require 'stringio'

module Hearth
  # Represents a base request.
  # @api private
  class Request
    # @param [String] destination
    # @param [IO, nil] (nil) body
    def initialize(destination:, body: nil)
      @destination = destination
      @body = body
    end

    # @return [String]
    attr_accessor :destination

    # @return [IO, nil]
    attr_accessor :body
  end
end
