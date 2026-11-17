# frozen_string_literal: true

require_relative '../spec_helper'
require 'stringio'
require 'set'
require_relative '../support/cbor_spec_helper'

module Smithy
  module Cbor
    describe Builder do
      let(:structure_shape) { SchemaHelper.sample_schema.const_get(:Structure) }

      it 'returns nil when given a unit shape' do
        expect(subject.build(Schema::Shapes::Prelude::Unit, '')).to be_nil
      end

      context 'structures' do
        before { allow(Time).to receive(:at).and_return(time) }
        let(:time) { Time.now }
        let(:data) do
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
        let(:expected) do
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

        it 'builds structures as a type' do
          type = structure_shape.type.new(data.merge(structure: data))
          bytes = subject.build(structure_shape, type)
          expect(Cbor.decode(bytes)).to eq(expected.merge('structure' => expected))
        end

        it 'builds structures as a hash' do
          bytes = subject.build(structure_shape, data.merge(structure: data))
          expect(Cbor.decode(bytes)).to eq(expected.merge('structure' => expected))
        end

        it 'builds only the members present on a sparse input, iterating values not declared members' do
          bytes = subject.build(structure_shape, { string: 'string', integer: 1 })
          expect(Cbor.decode(bytes)).to eq('string' => 'string', 'integer' => 1)
        end

        it 'skips keys in the input that are not declared members of the shape' do
          bytes = subject.build(structure_shape, { string: 'string', not_a_real_member: 'ignored' })
          expect(Cbor.decode(bytes)).to eq('string' => 'string')
        end
      end

      context 'unions' do
        it 'builds unions as a type' do
          union = structure_shape.member(:union).target.member_type(:string).new(string: 'string')
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(Cbor.decode(bytes)).to eq({ 'union' => { 'string' => 'string' } })
        end

        it 'builds unions as a hash' do
          data = { union: { string: 'string' } }
          bytes = subject.build(structure_shape, data)
          expect(Cbor.decode(bytes)).to eq({ 'union' => { 'string' => 'string' } })
        end

        it 'builds union unit members as a type' do
          union = structure_shape.member(:union).target.member_type(:unit).new(unit: Schema::EmptyStructure.new)
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(Cbor.decode(bytes)).to eq('union' => { 'unit' => {} })
        end

        it 'builds union unit members as a hash' do
          data = { union: { unit: {} } }
          bytes = subject.build(structure_shape, data)
          expect(Cbor.decode(bytes)).to eq('union' => { 'unit' => {} })
        end

        it 'builds a nil union' do
          data = { union: nil }
          bytes = subject.build(structure_shape, data)
          expect(Cbor.decode(bytes)).to eq({})
        end
      end

      context 'lists' do
        it 'builds lists' do
          data = { list: ['string'] }
          bytes = subject.build(structure_shape, data)
          expect(Cbor.decode(bytes)).to eq({ 'list' => ['string'] })
        end

        it 'builds lists with nil values' do
          data = { list: [nil] }
          bytes = subject.build(structure_shape, data)
          expect(Cbor.decode(bytes)).to eq({ 'list' => [nil] })
        end
      end

      context 'maps' do
        it 'builds maps' do
          data = { map: { 'key' => 'value' } }
          bytes = subject.build(structure_shape, data)
          expect(Cbor.decode(bytes)).to eq({ 'map' => { 'key' => 'value' } })
        end

        it 'builds maps with nil values' do
          data = { map: { 'key' => nil } }
          bytes = subject.build(structure_shape, data)
          expect(Cbor.decode(bytes)).to eq({ 'map' => { 'key' => nil } })
        end
      end

      context 'with the extended sample schema' do
        include CborSpecHelper

        let(:shapes) { CborSpecHelper.schema_shapes }
        let(:shape) { SchemaHelper.sample_schema(shapes: shapes).const_get(:Structure) }
        let(:types) { shape.type.module_parent }

        def build(params)
          Builder.new.build(shape, params)
        end

        context 'wire fixtures' do
          it 'writes blobs as byte strings, whatever their encoding' do
            expect(build(blob: 'hi')).to eq(cbor_bytes(0xa1, 0x64, 'blob', 0x42, 'hi'))
            expect(build(blob: 'é')).to eq(cbor_bytes(0xa1, 0x64, 'blob', 0x42, 0xc3, 0xa9))
            expect(build(blob: "\xff".b)).to eq(cbor_bytes(0xa1, 0x64, 'blob', 0x41, 0xff))
          end

          it 'writes the contents of IO blobs as byte strings' do
            expect(build(blob: StringIO.new('io'))).to eq(cbor_bytes(0xa1, 0x64, 'blob', 0x42, 'io'))
          end

          it 'writes strings as text' do
            expect(build(string: 'hé')).to eq(cbor_bytes(0xa1, 0x66, 'string', 0x63, 'h', 0xc3, 0xa9))
          end

          it 'writes a union as a one-entry map' do
            expect(build(union: { string: 'u' }))
              .to eq(cbor_bytes(0xa1, 0x65, 'union', 0xa1, 0x66, 'string', 0x61, 'u'))
            expect(build(union: { unit: {} })).to eq(cbor_bytes(0xa1, 0x65, 'union', 0xa1, 0x64, 'unit', 0xa0))
          end

          it 'writes lists and maps with definite lengths' do
            expect(build(list: ['a'], map: { 'k' => 'v' }))
              .to eq(cbor_bytes(0xa2, 0x64, 'list', 0x81, 0x61, 'a', 0x63, 'map', 0xa1, 0x61, 'k', 0x61, 'v'))
          end

          it 'writes the map header for structures of 23, 24 and 25 members' do
            { 23 => [0xb7], 24 => [0xb8, 24], 25 => [0xb8, 25] }.each do |count, header|
              members = (1..count).flat_map { |i| [0x60 + "w#{i}".size, "w#{i}", 0x61, 'v'] }
              expect(build(wide: (1..count).to_h { |i| [:"w#{i}", 'v'] }))
                .to eq(cbor_bytes(0xa1, 0x64, 'wide', *header, *members))
            end
          end
        end

        context 'input types' do
          it 'accepts any Enumerable for a list and pairs for a map' do
            expect(build(list: Set['a', 'b'], map: [%w[k v]]))
              .to eq(encode_cbor('list' => %w[a b], 'map' => { 'k' => 'v' }))
          end

          it 'writes nil list elements and map values as null' do
            expected = encode_cbor('list' => ['a', nil], 'map' => { 'k' => nil })
            expect(build(list: ['a', nil], map: { 'k' => nil })).to eq(expected)
          end

          it 'accepts typed structures and unions' do
            params = types::Structure.new(string: 's', union: types::Union::String.new(string: 'u'))
            expect(build(params)).to eq(encode_cbor('string' => 's', 'union' => { 'string' => 'u' }))
          end

          it 'uses a Struct with a custom #each_pair' do
            params = Struct.new(:string) { def each_pair = yield(:integer, 1) }.new('x')
            expect(build(params)).to eq(encode_cbor('integer' => 1))
          end

          it 'skips unknown and String member names' do
            expect(build(string: 'x', nope: 1, 'integer' => 2)).to eq(encode_cbor('string' => 'x'))
          end

          it 'writes the first union member, and an empty map for no or an unknown member' do
            params = { union: { string: 'x', unit: {} },
                       union_map: { 'a' => {}, 'b' => { nope: 1 }, 'c' => { 'string' => 'x' },
                                    'd' => [[:string, 'y']] } }
            expected = { 'union' => { 'string' => 'x' },
                         'unionMap' => { 'a' => {}, 'b' => {}, 'c' => {}, 'd' => { 'string' => 'y' } } }
            expect(build(params)).to eq(encode_cbor(expected))
          end
        end

        context 'map keys' do
          it 'writes String and Symbol keys as text' do
            map = { k: 'a', 'é'.encode(Encoding::ISO_8859_1) => 'b', 'ab'.b => 'c' }
            expect(build(map: map)).to eq(
              cbor_bytes(0xa1, 0x63, 'map', 0xa3, 0x61, 'k', 0x61, 'a', 0x62, 0xc3, 0xa9, 0x61, 'b', 0x62, 'ab', 0x61,
                         'c')
            )
          end

          it 'accepts compare_by_identity maps' do
            map = {}.compare_by_identity
            map['a'] = '1'
            map['b'] = '2'
            expect(build(map: map)).to eq(encode_cbor('map' => { 'a' => '1', 'b' => '2' }))
          end

          it 'raises for keys that are not Strings or Symbols' do
            expect { build(map: { 1 => 'c' }) }
              .to raise_error(BuildError, 'Unable to encode 1 as a map key, expected a String or Symbol')
          end

          it 'raises for keys that are the same text' do
            identity = {}.compare_by_identity
            identity[+'k'] = '1'
            identity[+'k'] = '2'
            [identity, { k: '1', 'k' => '2' }, [[:k, '1'], %w[k 2]]].each do |map|
              expect { build(map: map) }.to raise_error(BuildError, /\ADuplicate map key: ("k"|:k)\z/)
            end
          end
        end

        context 'duplicate members' do
          it 'checks instances of other classes than the generated type for repeated members' do
            repeating = Class.new(types::Structure) { def each_pair = yield(:string, 'a') && yield(:string, 'b') }
            expect { build(repeating.new) }.to raise_error(BuildError, 'Duplicate member: string')
          end

          it 'does not trust a generated type whose #each_pair was replaced' do
            types::Structure.class_eval { def each_pair = yield(:string, 'a') && yield(:string, 'b') }
            expect { build(types::Structure.new(string: 'x')) }.to raise_error(BuildError, 'Duplicate member: string')
          end

          it 'raises for params that yield a member twice' do
            params = Struct.new(:string) { def each_pair = yield(:string, 'a') && yield(:string, 'b') }.new('x')
            expect { build(params) }.to raise_error(BuildError, 'Duplicate member: string')
          end
        end

        context 'invalid params' do
          it 'raises the NoMethodError of a structure value without #each_pair' do
            expect { build(structure: 5) }.to raise_error(NoMethodError, /each_pair/)
          end

          it 'raises for values it cannot encode' do
            expect { build(string: Object.new) }.to raise_error(BuildError, /Unable to encode/)
          end
        end
      end
    end
  end
end
