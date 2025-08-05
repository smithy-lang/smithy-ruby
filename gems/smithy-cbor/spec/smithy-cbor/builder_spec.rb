# frozen_string_literal: true

require_relative '../spec_helper'

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
      end

      context 'unions' do
        it 'builds unions as a type' do
          union = structure_shape.member(:union).shape.member_type(:string).new(string: 'string')
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
          union = structure_shape.member(:union).shape.member_type(:unit).new(unit: Schema::EmptyStructure.new)
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
    end
  end
end
