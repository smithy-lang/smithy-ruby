# frozen_string_literal: true

require_relative '../spec_helper'
require 'stringio'
require 'set'
require_relative '../support/edge_case_helper'

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

      context 'input types and edge cases' do
        include EdgeCaseHelper

        let(:shapes) { EdgeCaseHelper.shapes }
        let(:shape) { SchemaHelper.sample_schema(shapes: shapes).const_get(:Structure) }
        let(:types) { shape.type.module_parent }

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
    end
  end
end
