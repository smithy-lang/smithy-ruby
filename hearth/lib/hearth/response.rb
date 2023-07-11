# frozen_string_literal: true

require 'stringio'

module Hearth
  # Represents a base response.
  # @api private
  class Response
    # @param [IO] body (StringIO.new)
    def initialize(body: StringIO.new)
      @body = body
    end

    # @return [IO]
    attr_accessor :body

    # Replace attributes from other response
    # @param [Response] other
    # @return [Response]
    def replace(other)
      IO.copy_stream(other.body, body)
      self
    end

    # Resets the response.
    # @return [Response]
    def reset
      @body.truncate(0)
      self
    end
  end
end
