# frozen_string_literal: true

require 'stringio'

module Hearth
  # Represents a base request.
  # @api private
  class Request
    # @param [URI] uri
    # @param [IO] (StringIO.new) body
    def initialize(uri:, body: StringIO.new)
      @uri = uri
      @body = body
    end

    # @return [URI]
    attr_accessor :uri

    # @return [IO]
    attr_accessor :body
  end
end
