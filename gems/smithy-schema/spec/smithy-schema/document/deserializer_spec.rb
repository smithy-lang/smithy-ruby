# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../support/schema_helper'

module Smithy
  module Schema
    module Document
      describe Deserializer do
        let(:shapes) do
          shapes = SchemaHelper.sample_shapes
          shapes['smithy.ruby.tests#Foo'] = shapes['smithy.ruby.tests#Structure']
          shapes['smithy.ruby.tests#Operation']['output']['target'] = 'smithy.ruby.tests#Foo'
          shapes
        end

        let(:sample_schema) { SchemaHelper.sample_schema(shapes: shapes) }
        let(:type_registry) { sample_schema.const_get(:TYPE_REGISTRY) }
        let(:structure_shape) { sample_schema.const_get(:Structure) }
        let(:typed_shape) do
          structure_shape.type.new(
            big_decimal: 0,
            big_integer: 0,
            blob: StringIO.new('foo'),
            boolean: true,
            byte: 1,
            document: true,
            double: 1.1,
            float: 1.1,
            enum: 'enum',
            int_enum: 0,
            integer: 1,
            long: 1,
            list: %w[Item1 Item2],
            map: { color: 'red' },
            short: 1,
            streaming_blob: 'streaming blob',
            string: 'foo',
            structure_list: [{ integer: 1 }, { integer: 2 }, { integer: 3 }],
            structure_map: { 'key' => { map: { 'color' => 'blue' } } },
            timestamp: 1_735_084_800,
            union: { string: 'string' }
          )
        end

        subject { Deserializer.new(type_registry) }
        let(:typed_document) { Serializer.new(type_registry).create_document(typed_shape) }

        describe '#deserialize' do
          it 'deserializes document into correct runtime shape using discriminator' do
            runtime_shape = subject.deserialize(typed_document)
            pp runtime_shape
            expect(runtime_shape).to be_a_kind_of(Structure)
            expect(runtime_shape).to be_an_instance_of(structure_shape.type)
            expect(runtime_shape.to_h).to eq(
              big_decimal: 0,
              big_integer: 0,
              blob: 'foo',
              boolean: true,
              byte: 1,
              double: 1.1,
              enum: 'enum',
              float: 1.1,
              int_enum: 0,
              integer: 1,
              list: %w[Item1 Item2],
              long: 1,
              map: { 'color' => 'red' },
              document: true,
              short: 1,
              streaming_blob: 'streaming blob',
              structure_list: [{ integer: 1 }, { integer: 2 }, { integer: 3 }],
              structure_map: { 'key' => { map: { 'color' => 'blue' } } },
              string: 'foo',
              timestamp: Time.at(1_735_084_800).utc,
              union: { string: 'string' }
            )
          end

          it 'prioritizes provided shape over document discriminator when deserializing' do
            another_shape = sample_schema.const_get(:Foo)
            runtime_shape = subject.deserialize(typed_document, shape: another_shape)
            expect(runtime_shape).to be_a_kind_of(Structure)
            expect(runtime_shape).to be_an_instance_of(another_shape.type)
          end

          it 'raises when given invalid inputs' do
            expect { subject.deserialize('foo') }.to raise_error(ArgumentError)
            expect { subject.deserialize(Data.new({})) }.to raise_error(ArgumentError)
            expect do
              subject.deserialize(Data.new({}, discriminator: 'InvalidShape'))
            end.to raise_error(ArgumentError)
            expect do
              subject.deserialize(typed_document, shape: Shapes::StringShape.new)
            end.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
