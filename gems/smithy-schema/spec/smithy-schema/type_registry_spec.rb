# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/schema_helper'

module Smithy
  module Schema
    describe TypeRegistry do
      subject { TypeRegistry.new({ 'thing' => shape }) }

      let(:shape) { SchemaHelper.sample_schema.const_get(:Structure) }

      let(:fake_type) do
        Struct.new(:foo, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      describe '#initialize' do
        subject { TypeRegistry.new }

        it 'defaults to empty registry' do
          expect(subject.registry).to be_empty
        end
      end

      describe '#each' do
        it 'is enumerable' do
          expect(subject).to be_kind_of(Enumerable)
        end
      end

      describe '#[]' do
        it 'returns shape' do
          expect(subject['thing']).to be(shape)
        end

        it 'returns nil if shape is not found' do
          expect(subject['unknown']).to be_nil
        end
      end

      describe '#[]=' do
        it 'adds a shape' do
          subject['thing2'] = shape
          expect(subject.registry).to include('thing2')
        end

        it 'raises when an invalid shape is given' do
          expect do
            subject['thing2'] = Shapes::StringShape.new
          end.to raise_error(ArgumentError)
          expect do
            subject['thing2'] = Shapes::StructureShape.new
          end.to raise_error(ArgumentError)
        end
      end

      describe '#key?' do
        it 'returns true if shape is registered' do
          expect(subject.key?('thing')).to be true
        end

        it 'returns false if shape is not registered' do
          expect(subject.key?('unknown')).to be false
        end
      end

      describe '#shape_by_type?' do
        it 'returns true if registered' do
          expect(subject.shape_by_type?(shape.type)).to be true
        end

        it 'returns false if not registered' do
          expect(subject.shape_by_type?(fake_type)).to be false
        end
      end

      describe '#shape_by_type' do
        it 'returns shape' do
          expect(subject.shape_by_type(shape.type)).to be(shape)
        end

        it 'returns nil if shape is not found' do
          expect(subject.shape_by_type(fake_type)).to be_nil
        end
      end

      describe '.concat' do
        it 'returns a combined registry' do
          registry = TypeRegistry.new('foo' => shape)
          another_registry = TypeRegistry.new({ 'bar' => shape, 'baz' => shape })
          new_registry = TypeRegistry.concat(subject, registry, another_registry)
          expect(new_registry.registry.keys).to include('foo', 'bar', 'baz')
        end

        it 'raises when invalid input is given' do
          expect do
            TypeRegistry.concat(subject, 2)
          end.to raise_error(ArgumentError)
        end
      end
    end
  end
end
