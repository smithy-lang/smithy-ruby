# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Cbor
    describe Codec do
      let(:structure_shape) { SchemaHelper.sample_schema.const_get(:Structure) }

      it 'build returns nil when given a unit shape' do
        expect(subject.build(Schema::Shapes::Prelude::Unit, '')).to be_nil
      end

      it 'parses returns an empty hash when given bytes are empty' do
        expect(subject.parse(Schema::Shapes::Prelude::String, '')).to be_empty
      end

      it 'parses returns an empty hash when given a unit shape' do
        expect(subject.parse(Schema::Shapes::Prelude::Unit, '')).to be_empty
      end

      it 'builds and parses data' do
        time = Time.now
        allow(Time).to receive(:at).and_return(time)
        data = {
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
        data = data.merge(structure: data)
        bytes = subject.build(structure_shape, data)
        expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
      end

      context 'structures' do
        it 'builds and parses structures as a type' do
          type = structure_shape.type.new(string: 'string')
          bytes = subject.build(structure_shape, type)
          expect(subject.parse(structure_shape, bytes).string).to eq('string')
        end

        it 'builds and parses structures as a hash' do
          data = { string: 'string' }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
        end
      end

      context 'unions' do
        it 'builds and parses union as a type' do
          union = structure_shape.member(:union).shape.member_type(:string).new(string: 'string')
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(subject.parse(structure_shape, bytes).union).to eq(union)
        end

        it 'builds and parses union as a hash' do
          data = { union: { string: 'string' } }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
        end

        it 'builds and parses unit members as a type' do
          union = structure_shape.member(:union).shape.member_type(:unit).new(unit: Schema::EmptyStructure.new)
          type = structure_shape.type.new(union: union)
          bytes = subject.build(structure_shape, type)
          expect(subject.parse(structure_shape, bytes).union).to eq(union)
        end

        it 'builds and parses unit members as a hash' do
          data = { union: { unit: {} } }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
        end

        it 'builds a nil union' do
          data = { union: nil }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).union).to eq(nil)
        end

        it 'parses unknown union members' do
          unknown_union_type = structure_shape.member(:union).shape.member_type(:unknown)
          data = { union: { 'someThing' => 'someValue' } }
          parsed = subject.parse(structure_shape, Cbor.encode(data))
          expect(parsed.union).to be_a(unknown_union_type)
          expect(parsed.union.to_h).to eq(unknown: { 'someThing' => 'someValue' })
        end
      end

      context 'lists' do
        it 'builds and parses lists' do
          data = { list: ['string'] }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
        end

        it 'can handle sparse lists' do
          list_shape = structure_shape.member(:list).shape
          list_shape.traits.merge!('smithy.api#sparse' => {})
          data = { list: [nil] }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
        end
      end

      context 'maps' do
        it 'builds and parses maps' do
          data = { map: { 'key' => 'value' } }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
        end

        it 'can handle sparse maps' do
          map_shape = structure_shape.member(:map).shape
          map_shape.traits.merge!('smithy.api#sparse' => {})
          data = { map: { 'key' => nil } }
          bytes = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, bytes).to_h).to eq(data)
        end
      end
    end
  end
end
