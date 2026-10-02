# frozen_string_literal: true

require 'bigdecimal'

module Smithy
  module Cbor
    # @api private
    class Decoder # rubocop:disable Metrics/ClassLength
      FIVE_BIT_MASK = 0x1F
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

      def decode
        return nil if @buffer.nil? || @buffer.empty?

        val = decode_item
        return val unless @pos != @buffer.size

        raise ParseError, "Extra bytes follow after decoding item. Read #{@pos} / #{@buffer.size} bytes"
      end

      private

      # high level, generic decode. Based on the next type.
      # Consumes and returns the next item as a ruby object.
      def decode_item # rubocop:disable Metrics
        @depth += 1
        raise ParseError, "Maximum nesting depth (#{MAX_DEPTH}) exceeded" if @depth > MAX_DEPTH

        ib = read_byte
        add_info = ib & FIVE_BIT_MASK
        process_item(ib >> 5, add_info)
      ensure
        @depth -= 1
      end

      def process_item(major_type, add_info) # rubocop:disable Metrics
        case major_type
        when 0 then read_count(add_info)
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

      def process_array(add_info)
        count = read_array(add_info)
        value = Array.new(count)
        count.times { |index| value[index] = decode_item }
        value
      end

      def process_map(add_info)
        value = {}
        read_map(add_info).times { value[read_string] = decode_item }
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
        value << read_binary_string until break_stop_code?
        read_end_indefinite_collection
        value
      end

      def process_indefinite_map
        value = {}
        value[read_string] = decode_item until break_stop_code?
        read_end_indefinite_collection
        value
      end

      def process_indefinite_string
        value = String.new
        value << read_string until break_stop_code?
        read_end_indefinite_collection
        value.force_encoding(Encoding::UTF_8)
      end

      def process_tag(add_info)
        case (tag = read_count(add_info))
        when TAG_TYPE_EPOCH
          item = decode_item
          Time.at(item)
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
        add_info = read_byte & FIVE_BIT_MASK if add_info.nil?
        read_count(add_info)
      end

      # A decimal fraction or a bigfloat is represented as a tagged array
      # that contains exactly two integer numbers:
      # an exponent e and a mantissa m
      # See: https://www.rfc-editor.org/rfc/rfc8949.html#name-decimal-fractions-and-bigfl
      def read_big_decimal
        unless (s = read_array) == 2
          raise ParseError, "Expected array of length 2 but length is: #{s}"
        end

        e = read_integer
        m = read_integer
        BigDecimal(m) * (BigDecimal(10)**BigDecimal(e))
      end

      # tag type 2 or 3
      def read_bignum(tag_value)
        add_info = read_byte & FIVE_BIT_MASK
        bstr = take(read_count(add_info))
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
        add_info = read_byte & FIVE_BIT_MASK if add_info.nil?
        take(read_count(add_info)).force_encoding(Encoding::BINARY)
      end

      def read_count(add_info)
        case add_info
        when 0..23 then add_info
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

      def read_integer
        ib = read_byte
        val = read_count(ib & FIVE_BIT_MASK)
        (ib >> 5).zero? ? val : -1 - val
      end

      # returns only the length of the array, caller must read the correct
      # number of key value pairs after this
      def read_map(add_info = nil)
        add_info = read_byte & FIVE_BIT_MASK if add_info.nil?
        read_count(add_info)
      end

      def read_string(add_info = nil)
        add_info = read_byte & FIVE_BIT_MASK if add_info.nil?
        take(read_count(add_info)).force_encoding(Encoding::UTF_8)
      end

      def break_stop_code?
        peek_byte == 0xFF
      end

      def peek_byte
        byte = @buffer.getbyte(@pos)
        return byte unless byte.nil?

        left = @buffer.bytesize - @pos
        raise ParseError, "Out of bytes. Trying to read 1 bytes but buffer contains only #{left}"
      end

      def read_byte
        byte = peek_byte
        @pos += 1
        byte
      end

      def unpack1(format, n_bytes)
        if (@pos + n_bytes) > @buffer.bytesize
          left = @buffer.bytesize - @pos
          raise ParseError, "Out of bytes. Trying to read #{n_bytes} bytes but buffer contains only #{left}"
        end

        value = @buffer.unpack1(format, offset: @pos)
        @pos += n_bytes
        value
      end

      def take(n_bytes)
        opos = @pos
        @pos += n_bytes
        return @buffer[opos, n_bytes] if @pos <= @buffer.bytesize

        left = @buffer.bytesize - @pos
        raise ParseError, "Out of bytes. Trying to read #{n_bytes} bytes but buffer contains only #{left}"
      end
    end
  end
end
