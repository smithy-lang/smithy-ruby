# frozen_string_literal: true

require 'stringio'
require 'uri'

module Hearth
  # Represents a base request.
  # @api private
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
  end
end
