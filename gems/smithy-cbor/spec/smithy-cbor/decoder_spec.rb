# frozen_string_literal: true

require_relative '../spec_helper'
require 'base64'

module Smithy
  module Cbor
    # covers cases not included in test suite from cbor_spec
    describe Decoder do
      def cbor64_decode(value)
        Decoder.new(Base64.decode64(value)).decode
      end

      def encode_decode(value)
        Decoder.new(Encoder.new.add(value).bytes).decode
      end

      describe '#decode' do
        it 'raises when there are extra bytes' do
          expect { cbor64_decode('AAA==') }.to raise_error(ParseError, /Extra bytes/)
        end

        it 'raises for undefined reserved' do
          buffer = String.new
          buffer << 0xf8 # 111_11000- Major type 7 (Float) + value: 24
          expect { Decoder.new(buffer).decode }.to raise_error(ParseError, /Undefined reserved/)
        end

        context 'half precision floats' do
          def decode_half_bytes(half)
            half_bytes = 0xf9 # 111_11001 - Major type 7 (Float) + value: 25
            buffer = String.new
            buffer << half_bytes << [half].pack('n')
            Decoder.new(buffer).decode
          end

          it 'decodes Half precision floats' do
            expect(decode_half_bytes(0)).to eq(0)
            expect(decode_half_bytes(0x3c00)).to eq(1)
            expect(decode_half_bytes(0x7bff)).to eq(65_504)
            expect(decode_half_bytes(0x3555)).to be_within(0.0001).of(0.3333)
          end

          it 'decodes half precision infinity' do
            expect(decode_half_bytes(0x7c00)).to eq(Float::INFINITY)
            expect(decode_half_bytes(0xfc00)).to eq(-Float::INFINITY)
          end

          it 'decodes half precision NaN' do
            expect(decode_half_bytes(0x7c01).nan?).to be true
          end
        end

        it 'decodes undefined' do
          undefined_bytes = 0xf7 # 111_10111- Major type 7 (Float) + value: 23
          buffer = String.new
          buffer << undefined_bytes
          expect(Decoder.new(buffer).decode).to eq(:undefined)
        end

        it 'decodes integer times' do
          expect(cbor64_decode('wftB14MjtYAAAA==')).to eq(Time.parse('2020-01-01 12:21:42Z'))
        end

        it 'decodes positive BigNums' do
          value = (2**64) + 1
          expect(encode_decode(value)).to eq(value)
        end

        it 'decodes negative BigNums' do
          value = -1 * ((2**64) + 1)
          expect(encode_decode(value)).to eq(value)
        end

        it 'decodes BigDecimals' do
          value = BigDecimal('273.15')
          expect(encode_decode(value)).to eq(value)
        end

        it 'decodes BigDecimals with a bignum mantissa' do
          value = BigDecimal('123456789012345678901234.5')
          expect(encode_decode(value)).to eq(value)
        end

        it 'reads a frozen buffer in any encoding and leaves it unchanged' do
          buffer = Encoder.new.add('é' => "\xff".b).bytes.force_encoding(Encoding::UTF_8).freeze
          expect(Decoder.new(buffer).decode).to eq('é' => "\xff".b)
          expect(buffer.encoding).to eq(Encoding::UTF_8)
        end

        it 'raises on invalid BigDecimals' do
          # https://www.rfc-editor.org/rfc/rfc8949.html#name-decimal-fractions-and-bigfl
          # C4 83 21 19 6A B3
          # array length of 3
          expect do
            Decoder.new(['c48321196ab3'].pack('H*')).decode
          end.to raise_error(ParseError, /Expected array of length 2 but length is: 3/)
        end

        it 'raises ParseError when nesting depth exceeds MAX_DEPTH' do
          # 0xc6 = CBOR tag(6), each one recurses into decode_item.
          # 128 tags + terminal value = 129 calls to decode_item.
          payload = ("\xc6".b * 128) + "\x00".b
          expect { Decoder.new(payload).decode }.to raise_error(ParseError, /Maximum nesting depth/)
        end

        it 'decodes payloads within the depth limit' do
          # 127 tags + terminal value = 128 calls to decode_item (at the limit).
          payload = ("\xc6".b * 127) + "\x00".b
          expect { Decoder.new(payload).decode }.not_to raise_error
        end

        # Complete items with exactly one fault each, so the message can only come from that fault.
        context 'malformed items' do
          {
            'a map key that is not a text string' =>
              ['a10001', 'Unexpected major type 0, expected a text string'],
            'an indefinite-length map key that is not a text string' =>
              ['bf4101 01ff', 'Unexpected major type 2, expected a text string'],
            'a byte string chunk in a text string' =>
              ['7f4161ff', 'Unexpected major type 2, expected a text string chunk'],
            'a text string chunk in a byte string' =>
              ['5f6161ff', 'Unexpected major type 3, expected a byte string chunk'],
            'a nested indefinite-length chunk' =>
              ['7f7f6161ffff', 'Unexpected nested indefinite-length string chunk'],
            'a bignum with a text payload' =>
              ['c26161', 'Unexpected major type 3, expected a byte string'],
            'a negative bignum with an integer payload' =>
              ['c301', 'Unexpected major type 0, expected a byte string'],
            'a decimal with a byte string payload' =>
              ['c4420000', 'Unexpected major type 2, expected an array'],
            'a decimal with a text exponent' =>
              ['c4826161 01', 'Unexpected major type 3, expected an integer'],
            'a decimal with a float mantissa' =>
              ['c48201f93c00', 'Unexpected major type 7, expected an integer'],
            'an epoch timestamp with a text payload' =>
              ['c16161', 'Expected a number for an epoch timestamp, got String'],
            'invalid UTF-8 in a short text string' =>
              ['61ff', 'Invalid UTF-8 in a text string'],
            'invalid UTF-8 in a long text string' =>
              ["7818#{'61' * 23}ff", 'Invalid UTF-8 in a text string'],
            'invalid UTF-8 in a text string chunk' =>
              ['7f61ffff', 'Invalid UTF-8 in a text string'],
            'a character split across text string chunks' =>
              ['7f61c361a9ff', 'Invalid UTF-8 in a text string'],
            'invalid UTF-8 in a map key' =>
              ['a161ff00', 'Invalid UTF-8 in a text string'],
            'an array count larger than the buffer' =>
              ['9bffffffffffffffff', 'Out of bytes. Trying to read 18446744073709551615 array items but buffer ' \
                                     'contains only 0 bytes'],
            'an array count larger than the bytes left' =>
              ['83 0102', 'Out of bytes. Trying to read 3 array items but buffer contains only 2 bytes'],
            'a truncated short text string' =>
              ['656162', 'Out of bytes. Trying to read 5 bytes but buffer contains only 2'],
            'a truncated long text string' =>
              ['78056162', 'Out of bytes. Trying to read 5 bytes but buffer contains only 2'],
            'a truncated byte string' =>
              ['4501', 'Out of bytes. Trying to read 5 bytes but buffer contains only 1']
          }.each do |name, (hex, message)|
            it "raises for #{name}" do
              expect { Decoder.new([hex.delete(' ')].pack('H*')).decode }.to raise_error(ParseError, message)
            end
          end
        end
      end
    end
  end
end
