# frozen_string_literal: true

require 'stringio'
require 'uri'

module Hearth
  # Represents a base request.
  class Request
    # @param [URI] uri (URI(''))
    # @param [IO, StringIO] body (StringIO.new)
    def initialize(uri: URI(''), body: StringIO.new)
      @uri = uri
      @body = body
    end

    # @return [URI]
    attr_accessor :uri

    # @return [IO, StringIO]
    attr_accessor :body
  end
end
