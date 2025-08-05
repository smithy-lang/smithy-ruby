# frozen_string_literal: true

require_relative '../spec_helper'

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
    end
  end
end
