# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module JSON
    describe Codec do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

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
        bytes = subject.serialize(structure_shape, data)
        expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
      end

      context 'structures' do
        it 'serializes and deserializes structures as a type' do
          type = structure_shape.type.new(string: 'string')
          bytes = subject.serialize(structure_shape, type)
          expect(subject.deserialize(structure_shape, bytes).string).to eq('string')
        end

        it 'serializes and deserializes structures as a hash' do
          data = { string: 'string' }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end
      end

      context 'unions' do
        it 'serializes and deserializes union as a type' do
          union = structure_shape.member(:union).shape.member_type(:string).new('string')
          type = structure_shape.type.new(union: union)
          bytes = subject.serialize(structure_shape, type)
          expect(subject.deserialize(structure_shape, bytes).union).to eq(union)
        end

        it 'serializes and deserializes unions as a hash' do
          data = { union: { string: 'string' } }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end

        it 'serializes and deserializes a nil union' do
          data = { union: nil }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).union).to eq(nil)
        end

        it 'serializes and deserializes an empty union' do
          data = { union: {} }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).union).to eq(nil)
        end

        it 'serializes and deserializes nil union values' do
          data = { union: { string: nil } }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end

        it 'serializes and deserializes unit shape members' do
          data = { union: { unit: {} } }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end

        it 'deserializes unknown union members' do
          unknown_union_type = structure_shape.member(:union).shape.member_type(:unknown)
          data = { 'union' => { 'someThing' => 'someValue' } }.to_json
          deserialized = subject.deserialize(structure_shape, data)
          expect(deserialized.union).to be_a(unknown_union_type)
          expect(deserialized.union.to_h).to eq(unknown: { name: 'someThing', value: 'someValue' })
        end

        it 'raises when deserializing unions with more than one member' do
          data = { 'union' => { 'string' => 'string', 'structure' => {} } }.to_json
          expect { subject.deserialize(structure_shape, data) }
            .to raise_error(ArgumentError, /union value includes more than one key/)

          data = { 'union' => { 'string' => 'string', 'someThing' => 'someValue' } }.to_json
          expect { subject.deserialize(structure_shape, data) }
            .to raise_error(ArgumentError, /union value includes more than one key/)
        end

        it 'ignores extra __type key when deserializing' do
          data = { 'union' => { '__type' => 'ignored', 'string' => 'string' } }.to_json
          deserialized = subject.deserialize(structure_shape, data)
          expect(deserialized.union).to be_a(structure_shape.member(:union).shape.member_type(:string))
          expect(deserialized.union.to_h).to eq(string: 'string')
        end

        it 'does not ignore __type if it is a jsonName member' do
          shapes['smithy.ruby.tests#Union']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => '__type' }
          }
          structure_shape = sample_schema.const_get(:Structure)
          data = { 'union' => { '__type' => 'string' } }.to_json
          deserialized = subject.deserialize(structure_shape, data)
          expect(deserialized.union).to be_a(structure_shape.member(:union).shape.member_type(:string))
          expect(deserialized.union.to_h).to eq(string: 'string')
        end

        it 'raises when deserializing unions with more than one member with __type as a jsonName' do
          shapes['smithy.ruby.tests#Union']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => '__type' }
          }
          structure_shape = sample_schema.const_get(:Structure)
          data = { 'union' => { '__type' => 'string', 'someThing' => 'someValue' } }.to_json
          expect { subject.deserialize(structure_shape, data) }
            .to raise_error(ArgumentError, /union value includes more than one key/)
        end
      end

      context 'lists' do
        it 'serializes and deserializes lists' do
          data = { list: ['string'] }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end

        it 'serializes and deserializes sparse lists' do
          shapes['smithy.ruby.tests#List']['traits'] = { 'smithy.api#sparse' => {} }
          data = { list: [nil] }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end
      end

      context 'maps' do
        it 'serializes and deserializes maps' do
          data = { map: { 'key' => 'value' } }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end

        it 'serializes and deserializes sparse maps' do
          shapes['smithy.ruby.tests#Map']['traits'] = { 'smithy.api#sparse' => {} }
          data = { map: { 'key' => nil } }
          bytes = subject.serialize(structure_shape, data)
          expect(subject.deserialize(structure_shape, bytes).to_h).to eq(data)
        end
      end
    end
  end
end
