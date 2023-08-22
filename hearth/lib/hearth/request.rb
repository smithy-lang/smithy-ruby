# frozen_string_literal: true

require 'stringio'
require 'uri'

module Hearth
  # Represents a base request.
  class Request
    # @param [URI] uri (URI(''))
    # @param [IO] body (StringIO.new)
    def initialize(uri: URI(''), body: StringIO.new)
      @uri = uri
      @body = body
    end

    # @return [URI]
    attr_accessor :uri

    # @return [IO]
    attr_accessor :body

    # @api private
    def initialize_copy(other)
      @uri = other.uri.dup
      # body should not be copied
    end
  end
end
