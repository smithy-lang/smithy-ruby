# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Cbor
    describe Encoder do
      let(:time) { Time.parse('2020-01-01 12:21:42Z') }

      def cbor64_encode(value)
        Base64.strict_encode64(Encoder.new.add(value).bytes).strip.force_encoding('UTF-8')
      end

      describe '#add' do
        it 'encodes simple numbers' do
          expect(cbor64_encode(0)).to eq('AA==')
          expect(cbor64_encode(1)).to eq('AQ==')
          expect(cbor64_encode(-1)).to eq('IA==')
          expect(cbor64_encode(24)).to eq('GBg=')
          expect(cbor64_encode(65_535)).to eq('Gf//')
          expect(cbor64_encode(4_294_967_295)).to eq('Gv////8=')
          expect(cbor64_encode(18_446_744_073_709_551_615)).to eq('G///////////')
          expect(cbor64_encode(18_446_744_073_709_551_616)).to eq('wkkBAAAAAAAAAAA=')
        end

        it 'encodes floats' do
          expect(cbor64_encode(1.1)).to eq('+z/xmZmZmZma')
          expect(cbor64_encode(1.0e+300)).to eq('+3435DyIAHWc')
          expect(cbor64_encode(-4.1)).to eq('+8AQZmZmZmZm')
        end

        it 'encodes NAN/Infinity' do
          expect(cbor64_encode(Float::NAN)).to eq('+n/AAAA=')
          expect(cbor64_encode(Float::INFINITY)).to eq('+n+AAAA=')
        end

        it 'encodes booleans and nil' do
          expect(cbor64_encode(true)).to eq('9Q==')
          expect(cbor64_encode(false)).to eq('9A==')
          expect(cbor64_encode(nil)).to eq('9g==')
        end

        it 'encodes strings' do
          expect(cbor64_encode('a')).to eq('YWE=')
          expect(cbor64_encode('IETF')).to eq('ZElFVEY=')
          expect(cbor64_encode('"\\')).to eq('YiJc')
          expect(cbor64_encode('ü')).to eq('YsO8')
          expect(cbor64_encode('水')).to eq('Y+awtA==')
        end

        it 'encodes byte strings' do
          expect(cbor64_encode('a'.encode(Encoding::BINARY))).to eq('QWE=')
        end

        it 'encodes Symbols' do
          expect(cbor64_encode(:a)).to eq('YWE=')
        end

        it 'encodes Tagged items' do
          expect(cbor64_encode(Tagged.new(0, 0))).to eq('wAA=')
        end

        it 'encodes arrays' do
          expect(cbor64_encode([])).to eq('gA==')
          expect(cbor64_encode([1, 2, 3])).to eq('gwECAw==')
          expect(cbor64_encode([1, [2, 3], [4, 5]])).to eq('gwGCAgOCBAU=')
        end

        it 'encodes maps' do
          expect(cbor64_encode({ 'a' => 1, 'b' => [2, 3] })).to eq('omFhAWFiggID')
        end

        it 'encodes times' do
          expect(cbor64_encode(time)).to eq('wftB14MjtYAAAA==')
        end

        it 'encodes BigDecimals' do
          # see example at:
          # https://www.rfc-editor.org/rfc/rfc8949.html#name-decimal-fractions-and-bigfl
          expect(cbor64_encode(BigDecimal('273.15'))).to eq('xIIhGWqz') # C4 82 21 19 6AB3 in hex
          # encodes as floating point numbers
          expect(cbor64_encode(BigDecimal('Infinity'))).to eq('+n+AAAA=')
          expect(cbor64_encode(BigDecimal('NaN'))).to eq('+n/AAAA=')
        end

        it 'raises on unknown items' do
          expect do
            expect(cbor64_encode(Object.new))
          end.to raise_error(BuildError, /Unable to encode/)
        end
      end

      describe '#head' do
        it 'raises on values that are too large' do
          expect do
            Encoder.new.send(:head, 0x00, 18_446_744_073_709_551_617)
          end.to raise_error(BuildError, /Value is too large/)
        end
      end

      # Expected bytes and errors were captured from the encoder before the fast header and string writes.
      describe 'header and string encoding' do
        def hex(value)
          Encoder.new.add(value).bytes.unpack1('H*')
        end

        it 'encodes every header size' do
          expect(hex([23, 24, 255, 256, 258, 65_535, 65_536, 16_909_060, 4_294_967_295, 4_294_967_296, -259]))
            .to eq('8b17181818ff19010019010219ffff1a000100001a010203041affffffff1b0000000100000000390102')
          expect(hex('x' * 300)).to eq("79012c#{'78' * 300}")
          expect(hex([Tagged.new(300, 1), Tagged.new(70_000, 1)])).to eq('82d9012c01da0001117001')
        end

        it 'encodes non-ASCII text after non-ASCII headers and next to byte strings' do
          expect(hex('ключ' => 'значение', 'n' => 300, 'e' => 'é'))
            .to eq('a368d0bad0bbd18ed18770d0b7d0bdd0b0d187d0b5d0bdd0b8d0b5616e19012c616562c3a9')
          expect(hex(["\xff\xfe".b, 'héllo', "\x80".b, 'ñ'])).to eq('8442fffe6668c3a96c6c6f418062c3b1')
        end

        it 'transcodes non-UTF-8 strings, including ASCII-only ones' do
          expect(hex(["caf#{"\xe9".dup.force_encoding('ISO-8859-1')}".force_encoding('ISO-8859-1')]))
            .to eq('8165636166c3a9')
          expect(hex(['abc'.encode('US-ASCII'), 'abc'.encode('UTF-16LE')])).to eq('826361626363616263')
        end

        it 'raises for strings that cannot be transcoded to UTF-8' do
          expect { Encoder.new.add("a\xffb".dup.force_encoding('US-ASCII')) }
            .to raise_error(Encoding::InvalidByteSequenceError, /on US-ASCII/)
          expect { Encoder.new.add("a\x81b".dup.force_encoding('Windows-1252')) }
            .to raise_error(Encoding::UndefinedConversionError)
        end

        it 'keeps the buffer BINARY and leaves the caller string unchanged' do
          value = +'éa'
          encoder = Encoder.new.add([value, 'ü'])
          expect(encoder.bytes.encoding).to eq(Encoding::BINARY)
          expect(value.encoding).to eq(Encoding::UTF_8)
        end
      end

      describe 'maps written in pieces' do
        it 'sets the size of a map after its entries are written' do
          encoder = Encoder.new
          position = encoder.begin_map
          encoder.add('a').add(1)
          encoder.finish_map(position, 1)
          expect(encoder.bytes).to eq(Encoder.new.add('a' => 1).bytes)
        end

        it 'replaces the one-byte header when the map has 24 or more entries' do
          [23, 24, 255, 256].each do |count|
            map = (1..count).to_h { |i| [i.to_s, i] }
            encoder = Encoder.new
            position = encoder.begin_map
            map.each { |key, value| encoder.add(key).add(value) }
            encoder.finish_map(position, count)
            expect(encoder.bytes).to eq(Encoder.new.add(map).bytes)
          end
        end

        it 'appends encoded bytes and empty maps' do
          encoder = Encoder.new
          encoder.add_encoded(Encoder.new.add('key').bytes)
          encoder.add_empty_map
          expect(encoder.bytes).to eq(Encoder.new.add('key').add({}).bytes)
        end
      end
    end
  end
end
