# frozen_string_literal: true

module Hearth
  # Represents a base response.
  class Response
    # @param [IO, nil] body (nil)
    def initialize(body: nil)
      @body = body
    end

    # @return [IO, nil]
    attr_accessor :body
  end
end
