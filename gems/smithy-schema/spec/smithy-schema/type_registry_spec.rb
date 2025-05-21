# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/schema_helper'

module Smithy
  module Schema
    describe TypeRegistry do
      let(:sample_schema) do
        shapes = SchemaHelper.sample_shapes
        shapes['smithy.ruby.tests#Foo'] = shapes['smithy.ruby.tests#Structure']
        shapes['smithy.ruby.tests#Structure']['members']['foo'] = { 'target' => 'smithy.ruby.tests#Foo' }
        SchemaHelper.sample_schema(shapes: shapes)
      end

      let(:shape) { sample_schema.const_get(:Foo) }

      let(:fake_type) do
        Struct.new(:foo, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      subject { TypeRegistry.new([shape]) }

      describe '#initialize' do
        subject { TypeRegistry.new }

        it 'defaults to empty registry' do
          expect(subject.to_a).to be_empty
        end
      end

      describe '#each' do
        it 'is enumerable' do
          expect(subject).to be_kind_of(Enumerable)
        end
      end

      describe '#[]' do
        it 'returns shape' do
          expect(subject['smithy.ruby.tests#Foo']).to be(shape)
        end

        it 'returns nil if shape is not found' do
          expect(subject['unknown']).to be_nil
        end
      end

      describe '#[]=' do
        it 'adds a shape' do
          subject['thing2'] = shape
          expect(subject['thing2']).to eq(shape)
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
          expect(subject.key?('smithy.ruby.tests#Foo')).to be true
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

        it 'returns nil if not found' do
          expect(subject.shape_by_type(fake_type)).to be_nil
        end
      end

      describe '#concat' do
        it 'returns a new registry' do
          first_shape = Shapes::StructureShape.new(id: 'first')
          second_shape = Shapes::StructureShape.new(id: 'second')
          first_shape.type = fake_type
          second_shape.type = fake_type

          registry = TypeRegistry.new([shape])
          another_registry = TypeRegistry.new([shape, first_shape, second_shape])

          new_registry = subject.concat(registry, another_registry)
          expect(new_registry.to_h.keys).to include('smithy.ruby.tests#Foo', 'first', 'second')
        end

        it 'raises when invalid input is given' do
          expect do
            subject.concat(subject, 2)
          end.to raise_error(ArgumentError)
        end
      end
    end
  end
end
