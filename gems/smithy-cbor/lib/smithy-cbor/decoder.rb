# frozen_string_literal: true

require_relative 'value_decoding'

module Smithy
  module Cbor
    # @api private
    class Decoder
      include ValueDecoding

      def decode
        return nil if @buffer.nil? || @buffer.empty?

        val = decode_item
        return val unless @pos != @buffer.bytesize

        raise ParseError, "Extra bytes follow after decoding item. Read #{@pos} / #{@buffer.bytesize} bytes"
      end
    end
  end
end
