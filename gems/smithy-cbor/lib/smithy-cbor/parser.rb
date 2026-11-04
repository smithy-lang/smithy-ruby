# frozen_string_literal: true

require 'base64'
require_relative 'reader'

module Smithy
  module Cbor
    # @api private
    class Parser
      EMPTY_MAP = 0xa0

      def initialize(_options = {}); end

      def parse(shape, bytes, result = nil)
        return {} if bytes.empty?

        bytes.force_encoding(Encoding::BINARY) # in place, as Cbor.decode does
        target = shape.target
        # An empty output's body is a one-byte empty map.
        if bytes.bytesize == 1 && bytes.getbyte(0) == EMPTY_MAP && target.is_a?(Schema::Shapes::StructureShape)
          return result || target.type.new
        end

        Reader.new(bytes).read(target, result)
      end
    end
  end
end
