# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Json
    describe Codec do
      let(:shapes) { SchemaHelper.sample_shapes }
      let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
      let(:structure_shape) { sample_schema.const_get(:Structure) }

      it 'parses returns an empty hash when given json is empty' do
        expect(subject.parse(Schema::Shapes::Prelude::String, '')).to eq({})
      end

      it 'parses returns an empty hash when given a unit shape' do
        expect(subject.parse(Schema::Shapes::Prelude::Unit, '')).to eq({})
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
        json = subject.build(structure_shape, data)
        expect(subject.parse(structure_shape, json).to_h).to eq(data)
      end

      context 'structures' do
        it 'builds and parses structures as a type' do
          type = structure_shape.type.new(string: 'string')
          json = subject.build(structure_shape, type)
          expect(subject.parse(structure_shape, json).string).to eq('string')
        end

        it 'builds and parses structures as a hash' do
          data = { string: 'string' }
          json = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, json).to_h).to eq(data)
        end

        it 'builds and parses structures with jsonName' do
          subject = described_class.new(json_name: true)
          shapes['smithy.ruby.tests#Structure']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => 'NewString' }
          }
          data = { string: 'string' }
          json = subject.build(structure_shape, data)
          expect(json).to include('"NewString":"string"')
          expect(subject.parse(structure_shape, json).to_h).to eq(data)
        end
      end

      context 'unions' do
        it 'builds and parses union as a type' do
          union = structure_shape.member(:union).shape.member_type(:string).new(string: 'string')
          type = structure_shape.type.new(union: union)
          json = subject.build(structure_shape, type)
          expect(subject.parse(structure_shape, json).union).to eq(union)
        end

        it 'builds and parses unions as a hash' do
          data = { union: { string: 'string' } }
          json = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, json).to_h).to eq(data)
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

        it 'builds and parses a nil union' do
          data = { union: nil }
          json = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, json).union).to eq(nil)
        end

        it 'parses unknown union members' do
          unknown_union_type = structure_shape.member(:union).shape.member_type(:unknown)
          data = { 'union' => { 'someThing' => 'someValue' } }.to_json
          parsed = subject.parse(structure_shape, data)
          expect(parsed.union).to be_a(unknown_union_type)
          expect(parsed.union.to_h).to eq(unknown: { 'someThing' => 'someValue' })
        end

        it 'ignores extra __type key when deserializing' do
          data = { 'union' => { '__type' => 'ignored', 'string' => 'string' } }.to_json
          parsed = subject.parse(structure_shape, data)
          expect(parsed.union).to be_a(structure_shape.member(:union).shape.member_type(:string))
          expect(parsed.union.to_h).to eq(string: 'string')
        end

        it 'does not ignore __type if it is a jsonName member' do
          subject = described_class.new(json_name: true)
          shapes['smithy.ruby.tests#Union']['members']['string'] = {
            'target' => 'smithy.api#String',
            'traits' => { 'smithy.api#jsonName' => '__type' }
          }
          structure_shape = sample_schema.const_get(:Structure)
          data = { 'union' => { '__type' => 'string' } }.to_json
          parsed = subject.parse(structure_shape, data)
          expect(parsed.union).to be_a(structure_shape.member(:union).shape.member_type(:string))
          expect(parsed.union.to_h).to eq(string: 'string')
        end
      end

      context 'lists' do
        it 'builds and parses lists' do
          data = { list: ['string'] }
          json = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, json).to_h).to eq(data)
        end

        it 'builds and parses sparse lists' do
          shapes['smithy.ruby.tests#List']['traits'] = { 'smithy.api#sparse' => {} }
          data = { list: [nil] }
          json = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, json).to_h).to eq(data)
        end
      end

      context 'maps' do
        it 'builds and parses maps' do
          data = { map: { 'key' => 'value' } }
          json = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, json).to_h).to eq(data)
        end

        it 'builds and parses sparse maps' do
          shapes['smithy.ruby.tests#Map']['traits'] = { 'smithy.api#sparse' => {} }
          data = { map: { 'key' => nil } }
          json = subject.build(structure_shape, data)
          expect(subject.parse(structure_shape, json).to_h).to eq(data)
        end
      end
    end
  end
end
