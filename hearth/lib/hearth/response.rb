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
  end
end
