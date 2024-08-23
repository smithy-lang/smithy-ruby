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

    # Contains attributes for Telemetry span to emit.
    # @return [Hash]
    def span_attributes
      {}
    end
  end
end
