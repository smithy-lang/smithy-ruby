# frozen_string_literal: true

require 'stringio'

module Hearth
  # Represents a base response.
  class Response
    # @param [IO] body (StringIO.new)
    def initialize(body: StringIO.new)
      @body = body
    end

    # @return [IO]
    attr_accessor :body

    # Resets the response.
    # @return [Response]
    def reset
      @body.truncate(0) if @body.respond_to?(:truncate)
      self
    end
  end
end
