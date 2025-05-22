# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/schema_helper'

module Smithy
  module Schema
    describe TypeRegistry do
      let(:sample_schema) { SchemaHelper.sample_schema }
      let(:shape) { sample_schema.const_get(:Structure) }

      subject { TypeRegistry.new([shape]) }

      describe '#initialize' do
        it 'defaults to an empty registry' do
          expect(TypeRegistry.new).to be_empty
        end

        it 'initializes a registry with shapes' do
          expect(subject).to include(shape.id)
        end
      end

      describe '#each' do
        it 'is enumerable' do
          expect(subject).to be_kind_of(Enumerable)
        end
      end

      describe '#[]' do
        it 'returns shape' do
          expect(subject['smithy.ruby.tests#Structure']).to be(shape)
        end

        it 'returns nil if shape is not found' do
          expect(subject['unknown']).to be_nil
        end
      end

      describe '#[]=' do
        it 'adds a shape' do
          subject['smithy.ruby.tests#NewShape'] = shape
          expect(subject['smithy.ruby.tests#NewShape']).to eq(shape)
        end

        it 'raises when an invalid shape is given' do
          expect do
            subject['smithy.ruby.tests#NewShape'] = Shapes::StringShape.new
          end.to raise_error(ArgumentError, /expected a StructureShape/)
          expect do
            subject['smithy.ruby.tests#NewShape'] = Shapes::StructureShape.new
          end.to raise_error(/with a type/)
        end
      end

      describe '#key?' do
        it 'returns true if shape is registered' do
          expect(subject.key?('smithy.ruby.tests#Structure')).to be true
        end

        it 'returns false if shape is not registered' do
          expect(subject.key?('unknown')).to be false
        end
      end

      describe '#keys' do
        it 'returns the keys' do
          expect(subject.keys).to eq([shape.id])
        end
      end

      describe '#values' do
        it 'returns the values' do
          expect(subject.values).to eq([shape])
        end
      end

      describe '#shape_by_type?' do
        it 'returns true if registered' do
          expect(subject.shape_by_type?(shape.type)).to be true
        end

        it 'returns false if not registered' do
          expect(subject.shape_by_type?(Struct.new)).to be false
        end
      end

      describe '#shape_by_type' do
        it 'returns shape' do
          expect(subject.shape_by_type(shape.type)).to be(shape)
        end

        it 'returns nil if not found' do
          expect(subject.shape_by_type(Struct.new)).to be_nil
        end
      end

      describe '#merge' do
        it 'returns a new registry' do
          shape1 = Shapes::StructureShape.new(id: 'smithy.ruby.tests#One')
          shape1.type = Struct.new
          registry1 = TypeRegistry.new([shape1])
          shape2 = Shapes::StructureShape.new(id: 'smithy.ruby.tests#Two')
          shape2.type = Struct.new
          registry2 = TypeRegistry.new([shape2])

          new_registry = subject.merge(registry1, registry2)
          expect(new_registry)
            .to include('smithy.ruby.tests#Structure', 'smithy.ruby.tests#One', 'smithy.ruby.tests#Two')
        end

        it 'raises when invalid input is given' do
          expect do
            subject.merge('invalid')
          end.to raise_error(ArgumentError, /expected TypeRegistry/)
        end
      end
    end
  end
end
