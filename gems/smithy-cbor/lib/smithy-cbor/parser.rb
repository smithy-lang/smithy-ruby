# frozen_string_literal: true

require_relative 'reader'

module Smithy
  module Cbor
    # @api private
    class Parser
      EMPTY_MAP = 0xa0

      def initialize(_options = {}); end

      # The body is read by byte offset and left unchanged, so it may be frozen or in any encoding.
      def parse(shape, bytes, result = nil)
        return {} if bytes.empty?

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
