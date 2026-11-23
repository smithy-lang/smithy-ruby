# frozen_string_literal: true

require_relative '../spec_helper'
require 'bigdecimal'
require_relative '../support/cbor_spec_helper'

module Smithy
  module Cbor
    describe Parser do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

      it 'returns an empty hash when given bytes are empty' do
        expect(subject.parse(Schema::Shapes::Prelude::String, '')).to eq({})
      end

      it 'returns an empty hash when given a unit shape' do
        expect(subject.parse(Schema::Shapes::Prelude::Unit, '')).to eq({})
      end

      context 'structures' do
        before { allow(Time).to receive(:at).and_return(time) }
        let(:time) { Time.now }
        let(:data) do
          {
            'bigDecimal' => 0.0,
            'bigInteger' => 0,
            'blob' => 'blob',
            'boolean' => false,
            'byte' => 0,
            'double' => 0.0,
            'enum' => 'enum',
            'float' => 0.0,
            'intEnum' => 0,
            'integer' => 0,
            'list' => [],
            'long' => 0,
            'map' => {},
            'short' => 0,
            'streamingBlob' => 'streaming blob',
            'string' => 'string',
            'structureList' => [],
            'structureMap' => {},
            'timestamp' => time,
            'union' => { 'string' => 'string' }
          }
        end
        let(:expected) do
          {
            big_decimal: 0.0,
            big_integer: 0,
            blob: 'blob',
            boolean: false,
            byte: 0,
            double: 0.0,
            enum: 'enum',
            float: 0.0,
            int_enum: 0,
            integer: 0,
            list: [],
            long: 0,
            map: {},
            short: 0,
            streaming_blob: 'streaming blob',
            string: 'string',
            structure_list: [],
            structure_map: {},
            timestamp: time,
            union: { string: 'string' }
          }
        end

        it 'parses structures' do
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(expected)
        end

        it 'ignores wire keys that are not members' do
          data = { 'string' => 'string', 'notAMember' => 'ignored' }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(string: 'string')
        end
      end

      context 'unions' do
        it 'parses unions' do
          data = { 'union' => { 'string' => 'string' } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { string: 'string' })
        end

        it 'parses unit members' do
          data = { 'union' => { 'unit' => {} } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { unit: {} })
        end

        it 'parses nil unions' do
          data = { union: nil }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq({})
        end

        it 'parses unknown members' do
          data = { union: { 'someThing' => 'someValue' } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { unknown: { 'someThing' => 'someValue' } })
        end
      end

      context 'lists' do
        it 'parses lists' do
          data = { 'list' => ['string'] }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: ['string'])
        end

        it 'preserves nil values in dense lists' do
          data = { 'list' => [nil] }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: [nil])
        end

        it 'parses sparse lists' do
          shapes['smithy.ruby.tests#List']['traits'] = { 'smithy.api#sparse' => {} }
          data = { 'list' => [nil, 'string', nil] }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: [nil, 'string', nil])
        end
      end

      context 'maps' do
        it 'parses maps' do
          data = { 'map' => { 'key' => 'value' } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => 'value' })
        end

        it 'preserves nil values in dense maps' do
          data = { 'map' => { 'key' => nil } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => nil })
        end

        it 'parses sparse maps' do
          shapes['smithy.ruby.tests#Map']['traits'] = { 'smithy.api#sparse' => {} }
          data = { 'map' => { 'key' => nil, 'anotherKey' => 'value' } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => nil, 'anotherKey' => 'value' })
        end
      end

      context 'with the extended sample schema' do
        let(:shapes) { CborSpecHelper.schema_shapes }
        let(:shape) { SchemaHelper.sample_schema(shapes: shapes).const_get(:Structure) }
        let(:types) { shape.type.module_parent }

        def parse(bytes, result = nil)
          Parser.new.parse(shape, bytes, result)
        end

        def parse_member(name, bytes, result)
          Parser.new.parse(shape.member(name), bytes, result)
        end

        context 'wire fixtures' do
          it 'reads byte strings as BINARY and text strings as UTF-8' do
            bytes = CborSpecHelper.cbor_bytes(0xa2, 0x64, 'blob', 0x42, 0x68, 0xff,
                                              0x66, 'string', 0x63, 'h', 0xc3, 0xa9)
            result = parse(bytes)
            expect([result.blob, result.blob.encoding]).to eq(["h\xff".b, Encoding::BINARY])
            expect([result.string, result.string.encoding]).to eq(['hé', Encoding::UTF_8])
          end

          it 'reads a union from a one-entry map' do
            result = parse(CborSpecHelper.cbor_bytes(0xa1, 0x65, 'union', 0xa1, 0x66, 'string', 0x61, 'u'))
            expect(result.union).to be_a(types::Union::String)
            expect(result.union.string).to eq('u')
          end

          it 'reads a unit union member from an empty map' do
            result = parse(CborSpecHelper.cbor_bytes(0xa1, 0x65, 'union', 0xa1, 0x64, 'unit', 0xa0))
            expect(result.union.to_h).to eq(unit: {})
          end
        end

        context 'CBOR representations' do
          it 'reads indefinite-length maps, arrays and strings' do
            bytes = CborSpecHelper.cbor_bytes(0xbf, 0x66, 'string', 0x7f, 0x61, 'a', 0x61, 'b', 0xff,
                                              0x64, 'list', 0x9f, 0x61, 'a', 0xff, 0xff)
            expect(parse(bytes).to_h).to eq(string: 'ab', list: ['a'])
          end

          it 'reads half floats, bignums, decimals and other tags' do
            bytes = CborSpecHelper.cbor_bytes(0xa4, 0x66, 'double', 0xf9, 0x3c, 0x00,
                                              0x6a, 'bigInteger', 0xc2, 0x49, 0x01, [0] * 8,
                                              0x6a, 'bigDecimal', 0xc4, 0x82, 0x21, 0x19, 0x6a, 0xb3,
                                              0x66, 'string', 0xc5, 0x61, 'x')
            result = parse(bytes)
            expect([result.double, result.big_integer, result.big_decimal]).to eq([1.0, 2**64, BigDecimal('273.15')])
            expect([result.string.tag, result.string.value]).to eq([5, 'x'])
          end

          it 'reads epoch timestamps' do
            data = { 'timestamp' => Time.at(5), 'structure' => { 'timestamp' => Time.at(1.5) } }
            bytes = CborSpecHelper.encode_cbor(data)
            result = parse(bytes)
            expect([result.timestamp, result.structure.timestamp]).to eq([Time.at(5), Time.at(1.5)])
          end

          it 'keeps undefined and null values' do
            bytes = CborSpecHelper.cbor_bytes(0xa3, 0x67, 'integer', 0xf7, 0x64, 'list', 0x82, 0xf6, 0xf7,
                                              0x6a, 'sparseList', 0x81, 0xf6)
            expect(parse(bytes).to_h).to eq(integer: :undefined, list: [nil, :undefined], sparse_list: [nil])
          end

          it 'skips unknown members, including nested containers' do
            bytes = CborSpecHelper.encode_cbor('nope' => [1, { 'x' => [2] }], 'string' => 'x')
            expect(parse(bytes).to_h).to eq(string: 'x')
          end
        end

        context 'unions' do
          it 'reads known, unknown, typed-only and null members' do
            union_map = { 'a' => {}, 'b' => { 'nope' => 1 }, 'c' => { '__type' => 't' },
                          'd' => { 'string' => nil }, 'e' => { 'string' => 'x', 'unit' => {} } }
            bytes = CborSpecHelper.encode_cbor('unionMap' => union_map)
            expect(parse(bytes).to_h).to eq(
              union_map: { 'a' => { unknown: { nil => nil } }, 'b' => { unknown: { 'nope' => 1 } },
                           'c' => { unknown: { nil => nil } }, 'd' => { unknown: { 'string' => nil } },
                           'e' => { string: 'x' } }
            )
          end

          it 'builds members like the generated constructor, even when the class customizes #[]=' do
            member_class = shape.member(:union).target.member_type(:string)
            member_class.class_eval do
              def []=(name, value)
                super(name, value.upcase)
              end
            end
            expect(parse(CborSpecHelper.encode_cbor('union' => { 'string' => 'hello' })).union.string).to eq('hello')
          end
        end

        context 'supplied results' do
          it 'fills a given structure' do
            result = types::Structure.new(integer: 1, string: 'old')
            expect(parse(CborSpecHelper.encode_cbor('string' => 'new', 'list' => nil), result)).to equal(result)
            expect(result.to_h).to eq(integer: 1, string: 'new')
            expect(parse(CborSpecHelper.cbor_bytes(0xa0), result)).to equal(result)
          end

          it 'leaves a given structure unchanged when the body cannot be read' do
            result = types::Structure.new(string: 'original')
            expect { parse(CborSpecHelper.encode_cbor('string' => 'modified') + CborSpecHelper.encode_cbor(1), result) }
              .to raise_error(ParseError, /Extra bytes/)
            expect(result.to_h).to eq(string: 'original')
          end

          it 'leaves a given structure unchanged when a value is invalid' do
            result = types::Structure.new(string: 'original')
            bytes = CborSpecHelper.cbor_bytes(0xa2, 0x66, 'string', 0x68, 'modified',
                                              0x63, 'map', 0xa2, 0x61, 'k', 0x61, 'v', 0x61, 'k', 0x61, 'w')
            expect { parse(bytes, result) }.to raise_error(ParseError, 'Duplicate map key: "k"')
            expect(result.to_h).to eq(string: 'original')
          end

          it 'appends to a given list' do
            list = ['old']
            expect(parse_member(:list, CborSpecHelper.encode_cbor(%w[a b]), list)).to equal(list)
            expect(list).to eq(%w[old a b])
          end

          it 'leaves a given list unchanged when the body cannot be read' do
            list = ['old']
            expect { parse_member(:list, CborSpecHelper.encode_cbor(%w[a b]) + CborSpecHelper.encode_cbor(1), list) }
              .to raise_error(ParseError, /Extra bytes/)
            expect(list).to eq(['old'])
          end

          it 'merges into a given map' do
            map = { 'old' => 'x' }
            expect(parse_member(:map, CborSpecHelper.encode_cbor('k' => 'v'), map)).to equal(map)
            expect(map).to eq('old' => 'x', 'k' => 'v')
          end

          it 'leaves a given map unchanged when the body cannot be read' do
            map = { 'old' => 'x' }
            expect { parse_member(:map, CborSpecHelper.encode_cbor('k' => 'v') + CborSpecHelper.encode_cbor(1), map) }
              .to raise_error(ParseError, /Extra bytes/)
            expect(map).to eq('old' => 'x')
          end

          it 'leaves a given map unchanged when a value is invalid' do
            map = { 'old' => 'x' }
            bytes = CborSpecHelper.cbor_bytes(0xa2, 0x61, 'k', 0x61, 'v', 0x61, 'k', 0x61, 'w')
            expect { parse_member(:map, bytes, map) }
              .to raise_error(ParseError, 'Duplicate map key: "k"')
            expect(map).to eq('old' => 'x')
          end
        end

        context 'body strings' do
          it 'reads a frozen body and leaves it unchanged' do
            body = CborSpecHelper.encode_cbor('string' => 'x').freeze
            expect(parse(body).string).to eq('x')
            expect(body.encoding).to eq(Encoding::BINARY)
          end

          it 'reads a body in another encoding by byte and keeps that encoding' do
            body = CborSpecHelper.encode_cbor('string' => 'é', 'blob' => "\xff".b).force_encoding(Encoding::UTF_8)
            result = parse(body)
            expect([result.string, result.blob]).to eq(['é', "\xff".b])
            expect(body.encoding).to eq(Encoding::UTF_8)
          end
        end

        context 'duplicate keys' do
          {
            'a duplicate member' => [[0xa2, 0x66, 'string', 0x61, 'a', 0x66, 'string', 0xf6], '"string"'],
            'a duplicate unknown member' => [[0xa2, 0x64, 'nope', 0x01, 0x64, 'nope', 0x02], '"nope"'],
            'a duplicate map key' => [[0xa1, 0x63, 'map', 0xa2, 0x61, 'k', 0x61, 'v', 0x61, 'k', 0xf6], '"k"'],
            'a duplicate map key after a dropped null' => [[0xa1, 0x63, 'map', 0xa2, 0x61, 'k', 0xf6, 0x61, 'k',
                                                            0x61, 'v'], '"k"'],
            'a duplicate union key' => [[0xa1, 0x65, 'union', 0xa2, 0x66, 'string', 0x61, 'a', 0x66, 'string', 0x61,
                                         'b'], '"string"']
          }.each do |name, (bytes, key)|
            it "raises for #{name}" do
              expect { parse(CborSpecHelper.cbor_bytes(*bytes)) }
                .to raise_error(ParseError, "Duplicate map key: #{key}")
            end
          end
        end

        context 'invalid bodies' do
          it 'raises for a collection of the wrong type' do
            expect { parse(CborSpecHelper.encode_cbor('structure' => [1])) }
              .to raise_error(ParseError, 'Expected a CBOR map for smithy.ruby.tests#Structure, got Array')
            expect { parse(CborSpecHelper.encode_cbor('list' => { 'a' => 'b' })) }
              .to raise_error(ParseError, 'Expected a CBOR array for smithy.ruby.tests#List, got Hash')
          end

          it 'raises for a scalar where a collection is expected' do
            expect { parse(CborSpecHelper.encode_cbor('list' => 5)) }
              .to raise_error(ParseError, 'Expected a CBOR array for smithy.ruby.tests#List, got Integer')
            expect { parse(CborSpecHelper.encode_cbor('union' => 'x')) }
              .to raise_error(ParseError, 'Expected a CBOR map for smithy.ruby.tests#Union, got String')
          end

          it 'raises for a member key that is not a text string' do
            expect { parse(CborSpecHelper.cbor_bytes(0xa1, 0x00, 0x01)) }
              .to raise_error(ParseError, 'Unexpected major type 0, expected a text string')
          end

          it 'raises for text that is not valid UTF-8' do
            expect { parse(CborSpecHelper.cbor_bytes(0xa1, 0x66, 'string', 0x61, 0xff)) }
              .to raise_error(ParseError, 'Invalid UTF-8 in a text string')
            expect { parse(CborSpecHelper.cbor_bytes(0xa1, 0x66, 'string', 0x78, 24, 'a' * 23, 0xff)) }
              .to raise_error(ParseError, 'Invalid UTF-8 in a text string')
            expect { parse(CborSpecHelper.cbor_bytes(0xa1, 0x63, 'map', 0xa1, 0x61, 0xff, 0x61, 'v')) }
              .to raise_error(ParseError, 'Invalid UTF-8 in a text string')
          end

          it 'raises for member and union keys that are not valid UTF-8' do
            expect { parse(CborSpecHelper.cbor_bytes(0xa1, 0x61, 0xff, 0x01)) }
              .to raise_error(ParseError, 'Invalid UTF-8 in a text string')
            expect { parse(CborSpecHelper.cbor_bytes(0xa1, 0x65, 'union', 0xa1, 0x61, 0xff, 0x01)) }
              .to raise_error(ParseError, 'Invalid UTF-8 in a text string')
            expect { parse(CborSpecHelper.cbor_bytes(0xa1, 0x65, 'union', 0xa2, 0x61, 0xff, 0x01, 0x61, 'x', 0x02)) }
              .to raise_error(ParseError, 'Invalid UTF-8 in a text string')
          end

          it 'raises for trailing bytes' do
            expect { parse(CborSpecHelper.encode_cbor('string' => 'x') + CborSpecHelper.encode_cbor(1)) }
              .to raise_error(ParseError, 'Extra bytes follow after decoding item. Read 10 / 11 bytes')
          end

          it 'raises for a truncated body with the bytes that remain' do
            expect { parse(CborSpecHelper.encode_cbor('string' => 'abcdef')[0..-3]) }
              .to raise_error(ParseError, 'Out of bytes. Trying to read 6 bytes but buffer contains only 4')
          end

          it 'applies the decoder nesting limit' do
            nested = ->(levels) { (1..levels).reduce('string' => 'leaf') { |inner, _| { 'structure' => inner } } }
            expect(parse(CborSpecHelper.encode_cbor(nested.call(126)))).to be_a(types::Structure)
            expect { parse(CborSpecHelper.encode_cbor(nested.call(127))) }
              .to raise_error(ParseError, 'Maximum nesting depth (128) exceeded')
          end
        end
      end
    end
  end
end
