# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module CBOR
    describe Codec do
      let(:sample_service) { ClientHelper.sample_service }
      let(:service) { sample_service.const_get(:Schema).const_get(:SERVICE) }

      it 'serialize returns nil when given a unit shape' do
        expect(subject.serialize(Schema::Shapes::Prelude::Unit, '')).to be_nil
      end

      it 'deserializes returns an empty hash when given bytes are empty' do
        expect(subject.deserialize(Schema::Shapes::Prelude::String, '')).to be_empty
      end

      it 'deserializes returns an empty hash when given a unit shape' do
        expect(subject.deserialize(Schema::Shapes::Prelude::Unit, '')).to be_empty
      end

      it 'serializes and deserializes data' do
        shape = service.operation(:operation).input
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
        bytes = subject.serialize(shape, data)
        expect(subject.deserialize(shape, bytes).to_h).to eq(data)
      end

      context 'structures' do
        it 'serializes and deserializes structures as a type' do
          shape = service.operation(:operation).input
          type = shape.type.new(string: 'string')
          bytes = subject.serialize(shape, type)
          expect(subject.deserialize(shape, bytes).string).to eq('string')
        end

        it 'serializes and deserializes structures as a hash' do
          shape = service.operation(:operation).input
          data = { string: 'string' }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end
      end

      context 'unions' do
        it 'serializes and deserializes union as a type' do
          shape = service.operation(:operation).input
          union = shape.member(:union).shape.member_type(:string).new('string')
          type = shape.type.new(union: union)
          bytes = subject.serialize(shape, type)
          expect(subject.deserialize(shape, bytes).union).to eq(union)
        end

        it 'serializes and deserializes union as a hash' do
          shape = service.operation(:operation).input
          data = { union: { string: 'string' } }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end

        it 'serializes a nil union' do
          shape = service.operation(:operation).input
          data = { union: nil }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).union).to eq(nil)
        end

        it 'serializes an empty union' do
          shape = service.operation(:operation).input
          data = { union: {} }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).union).to eq(nil)
        end

        it 'serializes nil union values' do
          shape = service.operation(:operation).input
          data = { union: { string: nil } }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end

        it 'deserializes unknown union members' do
          shape = service.operation(:operation).input
          unknown_union_type = shape.member(:union).shape.member_type(:unknown)
          data = { union: { 'someThing' => 'someValue' } }
          deserialized = subject.deserialize(shape, CBOR.encode(data))
          expect(deserialized.union).to be_a(unknown_union_type)
          expect(deserialized.union.to_h).to eq(unknown: { name: 'someThing', value: 'someValue' })
        end
      end

      context 'lists' do
        it 'serializes and deserializes lists' do
          shape = service.operation(:operation).input
          data = { list: ['string'] }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end

        it 'can handle sparse lists' do
          shape = service.operation(:operation).input
          list_shape = shape.member(:list).shape
          list_shape.traits.merge!('smithy.api#sparse' => {})
          data = { list: [nil] }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end
      end

      context 'maps' do
        it 'serializes and deserializes maps' do
          shape = service.operation(:operation).input
          data = { map: { 'key' => 'value' } }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end

        it 'can handle sparse maps' do
          shape = service.operation(:operation).input
          map_shape = shape.member(:map).shape
          map_shape.traits.merge!('smithy.api#sparse' => {})
          data = { map: { 'key' => nil } }
          bytes = subject.serialize(shape, data)
          expect(subject.deserialize(shape, bytes).to_h).to eq(data)
        end
      end
    end
  end
end
