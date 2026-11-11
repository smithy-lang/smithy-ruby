# frozen_string_literal: true

require_relative '../spec_helper'
require 'bigdecimal'
require_relative '../support/edge_case_helper'

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

        it 'parses lists with nil values' do
          data = { 'list' => [nil] }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: [])
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

        it 'parses maps with nil values' do
          data = { 'map' => { 'key' => nil } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: {})
        end

        it 'parses sparse maps' do
          shapes['smithy.ruby.tests#Map']['traits'] = { 'smithy.api#sparse' => {} }
          data = { 'map' => { 'key' => nil, 'anotherKey' => 'value' } }
          bytes = Cbor.encode(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => nil, 'anotherKey' => 'value' })
        end
      end

      context 'input types and edge cases' do
        include EdgeCaseHelper

        let(:shapes) { EdgeCaseHelper.shapes }
        let(:shape) { SchemaHelper.sample_schema(shapes: shapes).const_get(:Structure) }
        let(:types) { shape.type.module_parent }

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

        it 'leaves a given result unchanged when the body cannot be read' do
          result = types::Structure.new(string: 'original')
          expect { parse(cbor('string' => 'modified') + cbor(1), result) }.to raise_error(ParseError, /Extra bytes/)
          expect(result.to_h).to eq(string: 'original')
        end

        it 'leaves a given result unchanged when a value is invalid' do
          result = types::Structure.new(string: 'original')
          bytes = b(0xa2, 0x66, 'string', 0x68, 'modified',
                    0x63, 'map', 0xa2, 0x61, 'k', 0x61, 'v', 0x61, 'k', 0x61, 'w')
          expect { parse(bytes, result) }.to raise_error(ParseError, 'Duplicate map key: "k"')
          expect(result.to_h).to eq(string: 'original')
        end

        it 'appends to a given list' do
          list = ['old']
          expect(Parser.new.parse(shape.member(:list), cbor(%w[a b]), list)).to equal(list)
          expect(list).to eq(%w[old a b])
        end

        it 'builds union members like the generated constructor, even when the class customizes #[]=' do
          member_class = shape.member(:union).target.member_type(:string)
          member_class.class_eval do
            def []=(name, value)
              super(name, value.upcase)
            end
          end
          expect(parse(cbor('union' => { 'string' => 'hello' })).union.string).to eq('hello')
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
