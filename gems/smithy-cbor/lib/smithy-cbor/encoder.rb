# frozen_string_literal: true

require 'bigdecimal'

module Smithy
  module Cbor
    # @api private
    class Encoder
      MAJOR_TYPE_UNSIGNED_INT = 0x00 # 000_00000 - Major Type 0 - unsigned int
      MAJOR_TYPE_NEGATIVE_INT = 0x20 # 001_00000 - Major Type 1 - negative int
      MAJOR_TYPE_BYTE_STR = 0x40 # 010_00000 - Major Type 2 (Byte String)
      MAJOR_TYPE_STR = 0x60 # 011_00000 - Major Type 3 (Text String)
      MAJOR_TYPE_ARRAY = 0x80 # 100_00000 - Major Type 4 (Array)
      MAJOR_TYPE_MAP = 0xa0 # 101_00000 - Major Type 5 (Map)
      MAJOR_TYPE_TAG = 0xc0 # 110_00000 - Major type 6 (Tag)
      MAJOR_TYPE_SIMPLE = 0xe0 # 111_00000 - Major type 7 (111) + 5 bit 0

      FLOAT_BYTES = 0xfa # 111_11010 - Major type 7 (Float) + value: 26
      DOUBLE_BYTES = 0xfb # 111_ 11011 - Major type 7 (Float) + value: 26

      # https://www.rfc-editor.org/rfc/rfc8949.html#tags
      TAG_TYPE_EPOCH = 1
      TAG_BIGNUM_BASE = 2
      TAG_TYPE_BIGDEC = 4

      MAX_INTEGER = 18_446_744_073_709_551_616 # 2^64
      BYTE_HEADERS = Array.new(256) { |byte| [byte].pack('C').freeze }.freeze
      EMPTY_MAP_HEADER = BYTE_HEADERS[MAJOR_TYPE_MAP]

      def initialize
        @buffer = String.new
      end

      # @return the encoded bytes in CBOR format for all added data
      def bytes
        @buffer
      end

      # generic method for adding generic Ruby data based on its type
      def add(value) # rubocop:disable Metrics
        case value
        when String then process_string(value)
        when Integer then add_auto_integer(value)
        when BigDecimal then add_big_decimal(value)
        when Numeric then add_auto_float(value)
        when true, false then add_boolean(value)
        when nil then add_nil
        when Hash then add_hash(value)
        when Array then add_array(value)
        when Symbol then add_string(value.to_s)
        when Time then add_time(value)
        when Tagged then process_tag(value)
        else raise BuildError, "Unable to encode #{value}"
        end
        self
      end

      # Appends bytes that are already CBOR encoded, such as a map key prepared once per shape.
      def add_encoded(bytes)
        @buffer << bytes
      end

      # Starts a map whose size is not known yet. Write its entries, then pass the returned position and the number
      # of entries to #finish_map.
      def begin_map
        position = @buffer.bytesize
        @buffer << EMPTY_MAP_HEADER
        position
      end

      # Sets the size of the map started by #begin_map.
      def finish_map(position, count)
        return @buffer.setbyte(position, MAJOR_TYPE_MAP + count) if count < 24

        header = Encoder.new # a longer header than the one-byte placeholder
        header.start_map(count)
        @buffer[position, 1] = header.bytes
      end

      def add_empty_map
        @buffer << EMPTY_MAP_HEADER
      end

      private

      def add_array(value)
        start_array(value.size)
        value.each { |di| add(di) }
      end

      def add_auto_float(value)
        if value.nan?
          @buffer << FLOAT_BYTES << [value].pack('g')
        else
          ss = [value].pack('g') # single-precision
          if ss.unpack1('g') == value
            @buffer << FLOAT_BYTES << ss
          else
            @buffer << [DOUBLE_BYTES, value].pack('CG') # double-precision
          end
        end
      end

      def add_auto_integer(value)
        major_type =
          if value.negative?
            value = -1 - value
            MAJOR_TYPE_NEGATIVE_INT
          else
            MAJOR_TYPE_UNSIGNED_INT
          end

        if value >= MAX_INTEGER
          s = bignum_to_bytes(value)
          head(MAJOR_TYPE_TAG, TAG_BIGNUM_BASE + (major_type >> 5))
          head(MAJOR_TYPE_BYTE_STR, s.bytesize)
          @buffer << s
        else
          head(major_type, value)
        end
      end

      # A decimal fraction or a bigfloat is represented as a tagged array
      # that contains exactly two integer numbers:
      # an exponent e and a mantissa m
      # decimal fractions are always represented with a base of 10
      # See: https://www.rfc-editor.org/rfc/rfc8949.html#name-decimal-fractions-and-bigfl
      def add_big_decimal(value)
        if value.infinite? == 1
          return add_float(value.infinite? * Float::INFINITY)
        elsif value.nan?
          return add_float(Float::NAN)
        end

        head(MAJOR_TYPE_TAG, TAG_TYPE_BIGDEC)
        sign, digits, _base, exp = value.split
        # Ruby BigDecimal digits of XXX are used as 0.XXX, convert
        exp -= digits.size
        digits = sign * digits.to_i
        start_array(2)
        add_auto_integer(exp)
        add_auto_integer(digits)
      end

      def add_boolean(value)
        value ? head(MAJOR_TYPE_SIMPLE, 21) : head(MAJOR_TYPE_SIMPLE, 20)
      end

      # Encoding MUST already be Encoding::BINARY
      def add_byte_string(value)
        head(MAJOR_TYPE_BYTE_STR, value.bytesize)
        @buffer << value
      end

      def add_double(value)
        @buffer << [DOUBLE_BYTES, value].pack('CG') # double-precision
      end

      def add_float(value)
        @buffer << [FLOAT_BYTES, value].pack('Cg') # single-precision
      end

      def add_hash(value)
        start_map(value.size)
        value.each do |k, v|
          add(k)
          add(v)
        end
      end

      def add_nil
        head(MAJOR_TYPE_SIMPLE, 22)
      end

      # ASCII-only text is appended as is. Other UTF-8 text is appended as a binary copy, keeping the buffer BINARY;
      # other encodings are transcoded first, which raises for invalid bytes.
      def add_string(value)
        if value.ascii_only?
          size = value.bytesize
          size < 24 ? @buffer << BYTE_HEADERS[MAJOR_TYPE_STR + size] : head(MAJOR_TYPE_STR, size)
          @buffer << value
        else
          value = value.encode(Encoding::UTF_8) unless value.encoding == Encoding::UTF_8
          head(MAJOR_TYPE_STR, value.bytesize)
          @buffer << value.b
        end
      end

      # Tag numbers are caller data (possibly negative or not Integers), so they keep the pack-based headers.
      def add_tag(tag)
        @buffer <<
          case tag
          when 0...24
            BYTE_HEADERS[MAJOR_TYPE_TAG + tag]
          when 0...256
            [MAJOR_TYPE_TAG + 24, tag].pack('CC')
          when 0...65_536
            [MAJOR_TYPE_TAG + 25, tag].pack('Cn')
          when 0...4_294_967_296
            [MAJOR_TYPE_TAG + 26, tag].pack('CN')
          when 0...MAX_INTEGER
            [MAJOR_TYPE_TAG + 27, tag].pack('CQ>')
          else
            raise BuildError, "Value is too large to encode: #{tag}"
          end
      end

      def add_time(value)
        head(MAJOR_TYPE_TAG, TAG_TYPE_EPOCH)
        epoch = value.to_f
        add_double(epoch)
      end

      def bignum_to_bytes(value)
        s = String.new
        while value != 0
          s << (value & 0xFF)
          value >>= 8
        end
        s.reverse!
      end

      # value is a non-negative Integer.
      def head(major_type, value) # rubocop:disable Metrics/AbcSize
        buffer = @buffer
        if value < 24
          buffer << BYTE_HEADERS[major_type + value]
        elsif value < 256
          buffer << BYTE_HEADERS[major_type + 24] << BYTE_HEADERS[value]
        elsif value < 65_536
          buffer << BYTE_HEADERS[major_type + 25] << BYTE_HEADERS[value >> 8] << BYTE_HEADERS[value & 0xFF]
        elsif value < 4_294_967_296
          buffer << BYTE_HEADERS[major_type + 26] << BYTE_HEADERS[value >> 24] <<
            BYTE_HEADERS[(value >> 16) & 0xFF] << BYTE_HEADERS[(value >> 8) & 0xFF] << BYTE_HEADERS[value & 0xFF]
        elsif value < MAX_INTEGER
          buffer << BYTE_HEADERS[major_type + 27] << [value].pack('Q>')
        else
          raise BuildError, "Value is too large to encode: #{value}"
        end
      end

      def process_string(value)
        if value.encoding == Encoding::BINARY
          add_byte_string(value)
        else
          add_string(value)
        end
      end

      def process_tag(value)
        add_tag(value.tag)
        add(value.value)
      end

      # caller is responsible for adding length values
      def start_array(length)
        head(MAJOR_TYPE_ARRAY, length)
      end

      # caller is responsible for adding length key/value pairs
      def start_map(length)
        head(MAJOR_TYPE_MAP, length)
      end

      # Typed writers for Builder.
      #
      # @api private
      public :start_map, :start_array, :add_string, :add_byte_string, :add_auto_integer,
             :add_auto_float, :add_boolean, :add_nil, :add_time
    end
  end
end
