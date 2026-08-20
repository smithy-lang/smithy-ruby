# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Json
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
            'blob' => 'YmxvYg==',
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
            'streamingBlob' => 'c3RyZWFtaW5nIGJsb2I=',
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
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(expected)
        end

        it 'parses structures with jsonName' do
          subject = described_class.new(json_name: true)
          shapes['smithy.ruby.tests#Structure']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => 'NewString' }
          }
          data = { 'NewString' => 'string' }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(string: 'string')
        end

        it 'resolves members keyed by jsonName even without the json_name option' do
          shapes['smithy.ruby.tests#Structure']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => 'NewString' }
          }
          data = { 'NewString' => 'string' }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(string: 'string')
        end

        it 'ignores wire keys that are not members' do
          data = { 'string' => 'string', 'notAMember' => 'ignored' }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(string: 'string')
        end
      end

      context 'unions' do
        it 'parses unions' do
          data = { 'union' => { 'string' => 'string' } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { string: 'string' })
        end

        it 'parses unit members' do
          data = { 'union' => { 'unit' => {} } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { unit: {} })
        end

        it 'parses nil unions' do
          data = { union: nil }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq({})
        end

        it 'parses unknown members' do
          data = { union: { 'someThing' => 'someValue' } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { unknown: { 'someThing' => 'someValue' } })
        end

        it 'parsing ignores an extra __type key' do
          data = { 'union' => { '__type' => 'ignored', 'string' => 'string' } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { string: 'string' })
        end

        it 'parsing does not ignore __type if it is a jsonName member' do
          subject = described_class.new(json_name: true)
          shapes['smithy.ruby.tests#Union']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => '__type' }
          }
          structure_shape = sample_schema.const_get(:Structure)
          data = { 'union' => { '__type' => 'string' } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(union: { string: 'string' })
        end
      end

      context 'lists' do
        it 'parses lists' do
          data = { 'list' => ['string'] }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: ['string'])
        end

        it 'parses lists with nil values' do
          data = { 'list' => [nil] }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: [])
        end

        it 'parses sparse lists' do
          shapes['smithy.ruby.tests#List']['traits'] = { 'smithy.api#sparse' => {} }
          data = { 'list' => [nil, 'string', nil] }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(list: [nil, 'string', nil])
        end
      end

      context 'maps' do
        it 'parses maps' do
          data = { 'map' => { 'key' => 'value' } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => 'value' })
        end

        it 'parses maps with nil values' do
          data = { 'map' => { 'key' => nil } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: {})
        end

        it 'parses sparse maps' do
          shapes['smithy.ruby.tests#Map']['traits'] = { 'smithy.api#sparse' => {} }
          data = { 'map' => { 'key' => nil, 'anotherKey' => 'value' } }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(map: { 'key' => nil, 'anotherKey' => 'value' })
        end
      end

      context 'floats' do
        it 'parses infinity' do
          data = { 'float' => 'Infinity' }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(float: Float::INFINITY)
        end

        it 'parses negative infinity' do
          data = { 'float' => '-Infinity' }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(float: -Float::INFINITY)
        end

        it 'parses NaN' do
          data = { 'float' => 'NaN' }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(float: Float::NAN)
        end
      end

      context 'timestamps' do
        before { allow(Time).to receive(:at).and_return(time) }
        let(:time) { Time.now }

        it 'parses epoch seconds' do
          data = { 'timestamp' => time.to_i }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(timestamp: time)
        end

        it 'parses date-time format' do
          data = { 'timestamp' => time.utc.iso8601 }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(timestamp: time)
        end

        it 'parses http-date format' do
          data = { 'timestamp' => time.utc.httpdate }
          bytes = Json.dump(data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(timestamp: time)
        end

        it 'handles unrecognized timestamp formats' do
          data = { 'timestamp' => 'unrecognized format' }
          bytes = Json.dump(data)
          expect { subject.parse(structure_shape, bytes) }.to raise_error(/unhandled timestamp format/)
        end
      end
    end
  end
end
