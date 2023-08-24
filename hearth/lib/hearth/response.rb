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

    # Replace attributes from other response
    # @param [Response] other
    # @return [Response]
    def replace(other)
      @body.truncate(0)
      IO.copy_stream(other.body, @body)
      @body.rewind
      self
    end

    # Resets the response.
    # @return [Response]
    def reset
      @body.truncate(0) if @body.respond_to?(:truncate)
      self
    end
  end
end
