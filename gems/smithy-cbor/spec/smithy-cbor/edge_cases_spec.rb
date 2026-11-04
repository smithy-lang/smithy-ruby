# frozen_string_literal: true

require_relative '../spec_helper'
require 'bigdecimal'
require 'set'
require 'stringio'

module Smithy
  module Cbor
    describe 'Builder and Parser edge cases' do
      let(:shapes) do
        SchemaHelper.sample_shapes.merge(
          'smithy.ruby.tests#SparseList' => {
            'type' => 'list', 'member' => { 'target' => 'smithy.api#String' },
            'traits' => { 'smithy.api#sparse' => {} }
          },
          'smithy.ruby.tests#UnionMap' => {
            'type' => 'map', 'key' => { 'target' => 'smithy.api#String' },
            'value' => { 'target' => 'smithy.ruby.tests#Union' }
          },
          'smithy.ruby.tests#Wide' => {
            'type' => 'structure',
            'members' => (1..25).to_h { |i| ["w#{i}", { 'target' => 'smithy.api#String' }] }
          }
        ).tap do |all|
          all['smithy.ruby.tests#Structure'] = all['smithy.ruby.tests#Structure'].merge(
            'members' => all['smithy.ruby.tests#Structure']['members'].merge(
              'sparseList' => { 'target' => 'smithy.ruby.tests#SparseList' },
              'unionMap' => { 'target' => 'smithy.ruby.tests#UnionMap' },
              'wide' => { 'target' => 'smithy.ruby.tests#Wide' }
            )
          )
        end
      end
      let(:shape) { SchemaHelper.sample_schema(shapes: shapes).const_get(:Structure) }
      let(:types) { shape.type.module_parent }

      def cbor(value)
        Encoder.new.add(value).bytes
      end

      def b(*bytes)
        bytes.flat_map { |byte| byte.is_a?(String) ? byte.bytes : byte }.pack('C*').force_encoding(Encoding::BINARY)
      end

      describe Builder do
        def build(params)
          Builder.new.build(shape, params)
        end

        it 'writes the map header for structures of 23, 24 and 25 members' do
          { 23 => [0xb7], 24 => [0xb8, 24], 25 => [0xb8, 25] }.each do |count, header|
            bytes = build(wide: (1..count).to_h { |i| [:"w#{i}", 'v'] })
            expect(bytes.byteslice(6, header.size).bytes).to eq(header)
            expect(Cbor.decode(bytes)['wide'].size).to eq(count)
          end
        end

        it 'reads IO blobs' do
          expect(build(blob: StringIO.new('io bytes'))).to eq(cbor('blob' => 'io bytes'))
        end

        it 'accepts any Enumerable for a list and pairs for a map' do
          expect(build(list: Set['a', 'b'], map: [%w[k v]])).to eq(cbor('list' => %w[a b], 'map' => { 'k' => 'v' }))
        end

        it 'encodes map keys like Encoder#add' do
          map = { k: 'a', "\xfe".b => 'b', 1 => 'c' }
          expect(build(map: map)).to eq(cbor('map' => map))
        end

        it 'writes nil list elements and map values as null' do
          expected = cbor('list' => ['a', nil], 'map' => { 'k' => nil })
          expect(build(list: ['a', nil], map: { 'k' => nil })).to eq(expected)
        end

        it 'accepts compare_by_identity maps' do
          map = {}.compare_by_identity
          map['a'] = '1'
          map['b'] = '2'
          expect(build(map: map)).to eq(cbor('map' => { 'a' => '1', 'b' => '2' }))
        end

        it 'raises for map keys that collide' do
          map = {}.compare_by_identity
          map[+'k'] = '1'
          map[+'k'] = '2'
          expect { build(map: map) }.to raise_error(BuildError, 'Duplicate map key: "k"')
        end

        it 'accepts typed structures and unions' do
          params = types::Structure.new(string: 's', union: types::Union::String.new(string: 'u'))
          expect(build(params)).to eq(cbor('string' => 's', 'union' => { 'string' => 'u' }))
        end

        it 'uses a Struct with a custom #each_pair' do
          params = Struct.new(:string) { def each_pair = yield(:integer, 1) }.new('x')
          expect(build(params)).to eq(cbor('integer' => 1))
        end

        it 'raises for params that yield a member twice' do
          params = Struct.new(:string) { def each_pair = yield(:string, 'a') && yield(:string, 'b') }.new('x')
          expect { build(params) }.to raise_error(BuildError, 'Duplicate member: string')
        end

        it 'skips unknown and String member names' do
          expect(build(string: 'x', nope: 1, 'integer' => 2)).to eq(cbor('string' => 'x'))
        end

        it 'writes the first union member, and an empty map for no or an unknown member' do
          params = { union: { string: 'x', unit: {} },
                     union_map: { 'a' => {}, 'b' => { nope: 1 }, 'c' => { 'string' => 'x' }, 'd' => [[:string, 'y']] } }
          expected = { 'union' => { 'string' => 'x' },
                       'unionMap' => { 'a' => {}, 'b' => {}, 'c' => {}, 'd' => { 'string' => 'y' } } }
          expect(build(params)).to eq(cbor(expected))
        end

        it 'raises the NoMethodError of a structure value without #each_pair' do
          expect { build(structure: 5) }.to raise_error(NoMethodError, /each_pair/)
        end

        it 'raises for values it cannot encode' do
          expect { build(string: Object.new) }.to raise_error(BuildError, /Unable to encode/)
        end
      end

      describe Parser do
        def parse(bytes, result = nil)
          Parser.new.parse(shape, bytes, result)
        end

        it 'reads indefinite-length maps, arrays and strings' do
          bytes = b(0xbf, 0x66, 'string', 0x7f, 0x61, 'a', 0x61, 'b', 0xff, 0x64, 'list', 0x9f, 0x61, 'a', 0xff, 0xff)
          expect(parse(bytes).to_h).to eq(string: 'ab', list: ['a'])
        end

        it 'reads half floats, bignums, decimals and other tags' do
          bytes = b(0xa4, 0x66, 'double', 0xf9, 0x3c, 0x00, 0x6a, 'bigInteger', 0xc2, 0x49, 0x01, [0] * 8,
                    0x6a, 'bigDecimal', 0xc4, 0x82, 0x21, 0x19, 0x6a, 0xb3, 0x66, 'string', 0xc5, 0x61, 'x')
          result = parse(bytes)
          expect([result.double, result.big_integer, result.big_decimal]).to eq([1.0, 2**64, BigDecimal('273.15')])
          expect([result.string.tag, result.string.value]).to eq([5, 'x'])
        end

        it 'reads epoch timestamps' do
          result = parse(cbor('timestamp' => Time.at(5), 'structure' => { 'timestamp' => Time.at(1.5) }))
          expect([result.timestamp, result.structure.timestamp]).to eq([Time.at(5), Time.at(1.5)])
        end

        it 'keeps undefined values and drops nulls' do
          bytes = b(0xa3, 0x67, 'integer', 0xf7, 0x64, 'list', 0x82, 0xf6, 0xf7, 0x6a, 'sparseList', 0x81, 0xf6)
          expect(parse(bytes).to_h).to eq(integer: :undefined, list: [:undefined], sparse_list: [nil])
        end

        it 'skips unknown members, including nested containers' do
          expect(parse(cbor('nope' => [1, { 'x' => [2] }], 'string' => 'x')).to_h).to eq(string: 'x')
        end

        it 'reads unions' do
          bytes = cbor('unionMap' => { 'a' => {}, 'b' => { 'nope' => 1 }, 'c' => { '__type' => 't' },
                                       'd' => { 'string' => nil }, 'e' => { 'string' => 'x', 'unit' => {} } })
          expect(parse(bytes).to_h).to eq(
            union_map: { 'a' => { unknown: { nil => nil } }, 'b' => { unknown: { 'nope' => 1 } },
                         'c' => { unknown: { nil => nil } }, 'd' => { unknown: { 'string' => nil } },
                         'e' => { string: 'x' } }
          )
        end

        it 'fills a given result' do
          result = types::Structure.new(integer: 1, string: 'old')
          expect(parse(cbor('string' => 'new', 'list' => nil), result)).to equal(result)
          expect(result.to_h).to eq(integer: 1, string: 'new')
          expect(parse(b(0xa0), result)).to equal(result)
        end

        it 'sets the body encoding to BINARY in place' do
          body = (+"\xa1\x66string\x61x").force_encoding('UTF-8')
          parse(body)
          expect(body.encoding).to eq(Encoding::BINARY)
          expect { parse(cbor('string' => 'x').freeze) }.to raise_error(FrozenError)
        end

        {
          'a duplicate member' => [[0xa2, 0x66, 'string', 0x61, 'a', 0x66, 'string', 0xf6], '"string"'],
          'a duplicate unknown member' => [[0xa2, 0x64, 'nope', 0x01, 0x64, 'nope', 0x02], '"nope"'],
          'a duplicate map key' => [[0xa1, 0x63, 'map', 0xa2, 0x61, 'k', 0x61, 'v', 0x61, 'k', 0xf6], '"k"'],
          'a duplicate map key after a dropped null' => [[0xa1, 0x63, 'map', 0xa2, 0x61, 'k', 0xf6, 0x61, 'k', 0x61,
                                                          'v'], '"k"'],
          'a duplicate union key' => [[0xa1, 0x65, 'union', 0xa2, 0x66, 'string', 0x61, 'a', 0x66, 'string', 0x61,
                                       'b'], '"string"']
        }.each do |name, (bytes, key)|
          it "raises for #{name}" do
            expect { parse(b(*bytes)) }.to raise_error(ParseError, "Duplicate map key: #{key}")
          end
        end

        it 'raises for a collection of the wrong type' do
          expect { parse(cbor('structure' => [1])) }
            .to raise_error(ParseError, 'Expected a CBOR map for smithy.ruby.tests#Structure, got Array')
          expect { parse(cbor('list' => { 'a' => 'b' })) }
            .to raise_error(ParseError, 'Expected a CBOR array for smithy.ruby.tests#List, got Hash')
        end

        it 'raises the NoMethodError of a collection member that is a scalar' do
          expect { parse(cbor('list' => 5)) }.to raise_error(NoMethodError, /each/)
        end

        it 'raises for trailing bytes' do
          expect { parse(cbor('string' => 'x') + cbor(1)) }
            .to raise_error(ParseError, 'Extra bytes follow after decoding item. Read 10 / 11 bytes')
        end

        it 'raises for a truncated body' do
          expect { parse(cbor('string' => 'abcdef')[0..-3]) }
            .to raise_error(ParseError, 'Out of bytes. Trying to read 6 bytes but buffer contains only -2')
        end

        it 'applies the decoder nesting limit' do
          nested = ->(levels) { (1..levels).reduce('string' => 'leaf') { |inner, _| { 'structure' => inner } } }
          expect(parse(cbor(nested.call(126)))).to be_a(types::Structure)
          expect { parse(cbor(nested.call(127))) }.to raise_error(ParseError, 'Maximum nesting depth (128) exceeded')
        end
      end
    end
  end
end
