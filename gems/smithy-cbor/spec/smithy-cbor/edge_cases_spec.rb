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
    end
  end
end
