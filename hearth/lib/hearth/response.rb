# frozen_string_literal: true

require 'stringio'

module Hearth
  # Represents a base response.
  class Response
    # @param [IO, StringIO] body (StringIO.new)
    def initialize(body: StringIO.new)
      @body = body
    end

    # @return [IO, StringIO]
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
      # IO does not respond to #truncate but it does respond to #rewind
      # however it returns an illegal seek error.
      @body.truncate(0) if @body.respond_to?(:truncate)
      @body.rewind if @body.respond_to?(:rewind) && !@body.instance_of?(IO)
      self
    end
  end
end
