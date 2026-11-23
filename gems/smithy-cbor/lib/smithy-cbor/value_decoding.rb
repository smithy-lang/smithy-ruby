# frozen_string_literal: true

require 'bigdecimal'

module Smithy
  module Cbor
    # @api private
    #
    # Decodes CBOR from a byte buffer into generic Ruby values: Integers, Floats, Strings, Arrays, Hashes, Times,
    # Integers and BigDecimals for the bignum and decimal tags, and {Tagged} for other tags. It also reads the
    # headers, counts and text strings that make up those values, and enforces the nesting limit. It is shared by
    # the Decoder, which returns the generic value of a body, and the Reader, which reads typed results from the
    # same bytes and uses this decoding for scalars, map keys and unknown members.
    #
    # The buffer is read by byte offset and never modified, so it can be frozen and in any encoding. Malformed
    # input raises ParseError: a truncated item, a header of the wrong major type (such as a map key that is not a
    # text string or an indefinite-length string chunk of the other string type), a tag payload of the wrong type,
    # or a text string that is not valid UTF-8.
    module ValueDecoding # rubocop:disable Metrics/ModuleLength
      FIVE_BIT_MASK = 0x1F
      # Headers of text strings shorter than 24 bytes, whose length is in the header. Comparing the header byte to
      # these avoids Integer#>>, which is a method call in the interpreter, on the path of most keys.
      SHORT_TEXT_FIRST = 0x60
      SHORT_TEXT_END = 0x78
      TAG_TYPE_EPOCH = 1
      TAG_TYPE_BIGNUM = 2
      TAG_TYPE_NEG_BIGNUM = 3
      TAG_TYPE_BIGDEC = 4
      MAX_DEPTH = 128 # Value chosen to match other Smithy-based SDKs

      def initialize(bytes)
        @buffer = bytes
        @pos = 0
        @depth = 0
      end

      private

      # high level, generic decode. Based on the next type.
      # Consumes and returns the next item as a ruby object.
      def decode_item # rubocop:disable Metrics
        depth_exceeded if (@depth += 1) > MAX_DEPTH

        ib = @buffer.getbyte(@pos) || out_of_bytes(1, @buffer.bytesize - @pos)
        @pos += 1
        process_item(ib >> 5, ib & FIVE_BIT_MASK)
      ensure
        @depth -= 1
      end

      def process_item(major_type, add_info) # rubocop:disable Metrics
        case major_type
        when 0 then add_info < 24 ? add_info : read_count(add_info)
        when 1 then -1 - read_count(add_info)
        when 2
          add_info == 31 ? process_indefinite_binary : read_binary_string(add_info)
        when 3
          add_info == 31 ? process_indefinite_string : read_string(add_info)
        when 4
          add_info == 31 ? process_indefinite_array : process_array(add_info)
        when 5
          add_info == 31 ? process_indefinite_map : process_map(add_info)
        when 6 then process_tag(add_info)
        when 7 then process_major_type_simple(add_info)
        end
      end

      # Every item takes at least one byte, so a count larger than the bytes left cannot be read.
      def process_array(add_info)
        count = read_array(add_info)
        if count > (left = @buffer.bytesize - @pos)
          raise ParseError, "Out of bytes. Trying to read #{count} array items but buffer contains only #{left} bytes"
        end

        value = Array.new(count)
        index = 0
        while index < count
          value[index] = decode_item
          index += 1
        end
        value
      end

      def process_map(add_info)
        value = {}
        count = read_map(add_info)
        while count.positive?
          value[read_string] = decode_item
          count -= 1
        end
        value
      end

      # simple or float
      def process_major_type_simple(add_info) # rubocop:disable Metrics
        case add_info
        when 20 then false
        when 21 then true
        when 22 then nil
        when 23 then :undefined
        when 25 then read_half
        when 26 then unpack1('g', 4)
        when 27 then unpack1('G', 8)
        when 31 then raise ParseError, 'Unexpected break code'
        else raise ParseError, "Undefined reserved additional information: #{add_info}"
        end
      end

      def process_indefinite_array
        value = []
        value << decode_item until break_stop_code?
        read_end_indefinite_collection
        value
      end

      def process_indefinite_binary
        value = String.new
        value << read_chunk(2) until break_stop_code?
        read_end_indefinite_collection
        value
      end

      def process_indefinite_map
        value = {}
        value[read_string] = decode_item until break_stop_code?
        read_end_indefinite_collection
        value
      end

      # Each chunk is a complete text string, so each must be valid UTF-8 on its own.
      def process_indefinite_string
        value = String.new(encoding: Encoding::UTF_8)
        value << text(read_chunk(3)) until break_stop_code?
        read_end_indefinite_collection
        value
      end

      def process_tag(add_info)
        case (tag = read_count(add_info))
        when TAG_TYPE_EPOCH
          read_epoch
        when TAG_TYPE_BIGNUM, TAG_TYPE_NEG_BIGNUM
          read_bignum(tag)
        when TAG_TYPE_BIGDEC
          read_big_decimal
        else
          Tagged.new(tag, decode_item)
        end
      end

      # returns only the length of the array, caller must read the correct
      # number of values after this
      def read_array(add_info = nil)
        add_info = read_header(4, 'an array') if add_info.nil?
        read_count(add_info)
      end

      # A decimal fraction or a bigfloat is represented as a tagged array
      # that contains exactly two integer numbers:
      # an exponent e and a mantissa m. The mantissa may be a bignum.
      # See: https://www.rfc-editor.org/rfc/rfc8949.html#name-decimal-fractions-and-bigfl
      def read_big_decimal
        unless (s = read_array) == 2
          raise ParseError, "Expected array of length 2 but length is: #{s}"
        end

        e = read_integer
        m = read_mantissa
        BigDecimal(m) * (BigDecimal(10)**BigDecimal(e))
      end

      # tag type 2 or 3, followed by a definite-length byte string
      def read_bignum(tag_value)
        bstr = take(read_count(read_header(2, 'a byte string')))
        v = 0
        bstr.each_byte do |b|
          v <<= 8
          v += b
        end
        case tag_value
        when 2 then v
        when 3 then -1 - v
        end
      end

      def read_binary_string(add_info = nil)
        add_info = read_header(2, 'a byte string') if add_info.nil?
        take(read_count(add_info)).force_encoding(Encoding::BINARY)
      end

      # One chunk of an indefinite-length string: a definite-length string of the same major type.
      def read_chunk(major_type)
        add_info = read_header(major_type, major_type == 2 ? 'a byte string chunk' : 'a text string chunk')
        raise ParseError, 'Unexpected nested indefinite-length string chunk' if add_info == 31

        take(read_count(add_info))
      end

      # add_info is always a masked 5-bit value (0..31).
      def read_count(add_info)
        return add_info if add_info < 24

        case add_info
        when 24 then read_byte
        when 25 then unpack1('n', 2)
        when 26 then unpack1('N', 4)
        when 27 then unpack1('Q>', 8)
        else raise ParseError, "Unexpected additional information: #{add_info}"
        end
      end

      # returns nothing but consumes and checks the type/info.
      def read_end_indefinite_collection
        read_byte
      end

      # The payload must be an integer or a half, single or double float item, and finite.
      def read_epoch
        byte = peek_byte
        major_type = byte >> 5
        unless major_type <= 1 || (major_type == 7 && (byte & FIVE_BIT_MASK).between?(25, 27))
          unexpected_major_type(major_type, 'an integer or float for an epoch timestamp')
        end
        value = decode_item
        raise ParseError, "Epoch timestamp is not finite: #{value}" if value.is_a?(Float) && !value.finite?

        Time.at(value)
      end

      # 16 bit IEEE 754 half-precision floats
      # Support decoding only
      # format:
      # sign - 1 bit
      # exponent - 5 bits
      # precision - 10 bits
      def read_half
        b16 = unpack1('n', 2)
        exp = (b16 >> 10) & 0x1f
        mant = b16 & 0x3ff
        val =
          case exp
          when 0
            Math.ldexp(mant, -24)
          when 31
            mant.zero? ? Float::INFINITY : Float::NAN
          else
            # exp bias is 15, but to use ldexp we divide
            # by 1024 (2^10) to get exp-15-10
            Math.ldexp(1024 + mant, exp - 25)
          end
        if b16[15].zero?
          val
        else
          -val
        end
      end

      # Consumes a header byte of the given major type and returns its additional information.
      def read_header(major_type, expected)
        byte = read_byte
        unexpected_major_type(byte >> 5, expected) unless byte >> 5 == major_type
        byte & FIVE_BIT_MASK
      end

      def read_integer
        ib = read_byte
        major_type = ib >> 5
        unexpected_major_type(major_type, 'an integer') if major_type > 1
        val = read_count(ib & FIVE_BIT_MASK)
        major_type.zero? ? val : -1 - val
      end

      # returns only the length of the array, caller must read the correct
      # number of key value pairs after this
      def read_map(add_info = nil)
        add_info = read_header(5, 'a map') if add_info.nil?
        read_count(add_info)
      end

      # An integer or a bignum.
      def read_mantissa
        byte = peek_byte
        return read_integer unless byte.between?(0xc2, 0xc3) # tag 2 or 3

        @pos += 1
        read_bignum(byte & FIVE_BIT_MASK)
      end

      # A definite-length text string, such as a map key.
      def read_string(add_info = nil)
        string = read_unchecked_string(add_info)
        string.valid_encoding? ? string : invalid_text
      end

      # #read_string without the UTF-8 check, for keys the caller looks up first: a key equal to a known member
      # name is valid, and the caller checks any other key. #read_byte and #take are inlined.
      def read_unchecked_string(add_info = nil) # rubocop:disable Metrics
        if add_info
          n_bytes = add_info < 24 ? add_info : read_count(add_info)
        else
          byte = @buffer.getbyte(@pos) || out_of_bytes(1, @buffer.bytesize - @pos)
          @pos += 1
          if byte >= SHORT_TEXT_FIRST && byte < SHORT_TEXT_END
            n_bytes = byte - SHORT_TEXT_FIRST
          else
            unexpected_major_type(byte >> 5, 'a text string') unless byte >> 5 == 3
            n_bytes = read_count(byte & FIVE_BIT_MASK)
          end
        end
        start = @pos
        out_of_bytes(n_bytes, @buffer.bytesize - start) if start + n_bytes > @buffer.bytesize
        @pos = start + n_bytes
        @buffer.byteslice(start, n_bytes).force_encoding(Encoding::UTF_8)
      end

      # The bytes of a text string, labeled UTF-8; raises unless they are valid UTF-8.
      def text(bytes)
        bytes.force_encoding(Encoding::UTF_8)
        bytes.valid_encoding? ? bytes : invalid_text
      end

      def depth_exceeded
        raise ParseError, "Maximum nesting depth (#{MAX_DEPTH}) exceeded"
      end

      def invalid_text
        raise ParseError, 'Invalid UTF-8 in a text string'
      end

      def unexpected_major_type(major_type, expected)
        raise ParseError, "Unexpected major type #{major_type}, expected #{expected}"
      end

      def break_stop_code?
        peek_byte == 0xFF
      end

      def peek_byte
        @buffer.getbyte(@pos) || out_of_bytes(1, @buffer.bytesize - @pos)
      end

      def read_byte
        byte = @buffer.getbyte(@pos) || out_of_bytes(1, @buffer.bytesize - @pos)
        @pos += 1
        byte
      end

      def out_of_bytes(n_bytes, left)
        raise ParseError, "Out of bytes. Trying to read #{n_bytes} bytes but buffer contains only #{left}"
      end

      def unpack1(format, n_bytes)
        out_of_bytes(n_bytes, @buffer.bytesize - @pos) if @pos + n_bytes > @buffer.bytesize
        value = @buffer.unpack1(format, offset: @pos)
        @pos += n_bytes
        value
      end

      def take(n_bytes)
        start = @pos
        out_of_bytes(n_bytes, @buffer.bytesize - start) if start + n_bytes > @buffer.bytesize
        @pos = start + n_bytes
        @buffer.byteslice(start, n_bytes)
      end
    end
  end
end
