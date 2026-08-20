# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Json
    describe Builder do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

      it 'returns an empty JSON object for a unit shape' do
        expect(subject.build(Schema::Shapes::Prelude::Unit, {})).to eq('{}')
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
            'timestamp' => time.to_i,
            'union' => { 'string' => 'string' }
          }
        end

        it 'builds structures as a type' do
          type = structure_shape.type.new(data.merge(structure: data))
          bytes = subject.build(structure_shape, type)
          expect(Json.load(bytes)).to eq(expected.merge('structure' => expected))
        end

        it 'builds structures as a hash' do
          bytes = subject.build(structure_shape, data.merge(structure: data))
          expect(Json.load(bytes)).to eq(expected.merge('structure' => expected))
        end

        it 'builds structures with jsonName' do
          subject = described_class.new(json_name: true)
          shapes['smithy.ruby.tests#Structure']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => 'NewString' }
          }
          data = { string: 'string' }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq('NewString' => 'string')
        end

        it 'builds only the members present on a sparse input, iterating values not declared members' do
          data = { string: 'string', integer: 1 }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq('string' => 'string', 'integer' => 1)
        end

        it 'skips keys in the input that are not declared members of the shape' do
          data = { string: 'string', not_a_real_member: 'ignored' }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq('string' => 'string')
        end
      end

      context 'unions' do
        it 'builds unions as a type' do
          union = structure_shape.member(:union).target.member_type(:string).new(string: 'string')
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(Json.load(bytes)).to eq({ 'union' => { 'string' => 'string' } })
        end

        it 'builds unions as a hash' do
          data = { union: { string: 'string' } }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'union' => { 'string' => 'string' } })
        end

        it 'builds union unit members as a type' do
          union = structure_shape.member(:union).target.member_type(:unit).new(unit: Schema::EmptyStructure.new)
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(Json.load(bytes)).to eq('union' => { 'unit' => {} })
        end

        it 'builds union unit members as a hash' do
          data = { union: { unit: {} } }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq('union' => { 'unit' => {} })
        end

        it 'builds a nil union' do
          data = { union: nil }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({})
        end

        it 'builds union members with jsonName' do
          subject = described_class.new(json_name: true)
          shapes['smithy.ruby.tests#Union']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => 'NewString' }
          }
          data = { union: { string: 'string' } }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq('union' => { 'NewString' => 'string' })
        end
      end

      context 'lists' do
        it 'builds lists' do
          data = { list: ['string'] }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'list' => ['string'] })
        end

        it 'builds lists with nil values' do
          data = { list: [nil] }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'list' => [nil] })
        end
      end

      context 'maps' do
        it 'builds maps' do
          data = { map: { 'key' => 'value' } }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'map' => { 'key' => 'value' } })
        end

        it 'builds maps with nil values' do
          data = { map: { 'key' => nil } }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'map' => { 'key' => nil } })
        end
      end

      context 'floats' do
        it 'builds floats with Infinity' do
          data = { float: Float::INFINITY }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'float' => 'Infinity' })
        end

        it 'builds floats with -Infinity' do
          data = { float: -Float::INFINITY }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'float' => '-Infinity' })
        end

        it 'builds floats with NaN' do
          data = { float: Float::NAN }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'float' => 'NaN' })
        end
      end

      context 'timestamps' do
        it 'builds epoch seconds by default' do
          time = Time.now
          data = { timestamp: time }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'timestamp' => time.to_i })
        end

        it 'builds date-time format' do
          time = Time.now.utc
          shapes['smithy.ruby.tests#Structure']['members']['timestamp']['traits'] = {
            'smithy.api#timestampFormat' => 'date-time'
          }
          data = { timestamp: time }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'timestamp' => time.utc.iso8601 })
        end

        it 'builds http-date format' do
          time = Time.now.utc
          shapes['smithy.ruby.tests#Structure']['members']['timestamp']['traits'] = {
            'smithy.api#timestampFormat' => 'http-date'
          }
          data = { timestamp: time }
          bytes = subject.build(structure_shape, data)
          expect(Json.load(bytes)).to eq({ 'timestamp' => time.utc.httpdate })
        end
      end
    end
  end
end
