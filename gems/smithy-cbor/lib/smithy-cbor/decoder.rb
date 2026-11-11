# frozen_string_literal: true

require_relative 'item_reader'

module Smithy
  module Cbor
    # @api private
    class Decoder
      include ItemReader

      def decode
        return nil if @buffer.nil? || @buffer.empty?

        val = decode_item
        return val unless @pos != @buffer.size

        raise ParseError, "Extra bytes follow after decoding item. Read #{@pos} / #{@buffer.size} bytes"
      end
    end
  end
end
