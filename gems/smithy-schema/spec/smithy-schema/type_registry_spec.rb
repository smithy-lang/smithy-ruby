# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe TypeRegistry do
      subject do
        registry = TypeRegistry.new
        registry.register(shape)
        registry
      end

      let(:runtime_shape) do
        Struct.new(:string, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      let(:fake_shape) do
        Struct.new(:foo, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      let(:shape) do
        shape = Shapes::StructureShape.new(id: 'thing')
        string = Shapes::StringShape.new(id: 'smithy.api#String')
        shape.add_member(:string, 'stringMember', string)
        shape.type = runtime_shape
        shape
      end

      describe '#initialize' do
        subject { TypeRegistry.new }
        it 'defaults to empty registry' do
          expect(subject.registry).to be_empty
        end
      end

      describe '#register' do
        it 'register a schema' do
          subject.register(Shapes::StructureShape.new(id: 'thing2'))
          expect(subject.registry).to include('thing2')
        end

        it 'register an array of schemas' do
          subject.register(
            Shapes::StructureShape.new(id: 'thing2'),
            Shapes::StructureShape.new(id: 'thing3')
          )
          expect(subject.registry).to include('thing2', 'thing3')
        end

        it 'raises when invalid input is given' do
          expect do
            subject.register(1, 2)
          end.to raise_error(ArgumentError)
        end
      end

      describe '#schema_by_id?' do
        it 'returns true if registered' do
          expect(subject.schema_by_id?('thing')).to be true
        end

        it 'returns false if not registered' do
          expect(subject.schema_by_id?('unknown')).to be false
        end
      end

      describe '#schema_by_id' do
        it 'returns schema' do
          expect(subject.schema_by_id('thing')).to be(shape)
        end

        it 'returns nil if schema is not found' do
          expect(subject.schema_by_id('unknown')).to be_nil
        end
      end

      describe '#schema_by_type?' do
        it 'returns true if registered' do
          expect(subject.schema_by_type?(runtime_shape)).to be true
        end

        it 'returns false if not registered' do
          expect(subject.schema_by_type?(fake_shape)).to be false
        end
      end

      describe '#schema_by_type' do
        it 'returns schema' do
          expect(subject.schema_by_type(runtime_shape)).to be(shape)
        end

        it 'returns nil if schema is not found' do
          expect(subject.schema_by_type(fake_shape)).to be_nil
        end
      end

      describe '#convert_as_typed' do
        it 'returns a typed shape' do
          document = Document.new(runtime_shape.new(string: 'foo'), schema: shape)
          typed_shape = subject.convert_as_typed(document)
          expect(typed_shape).to be_a(runtime_shape)
          expect(typed_shape[:string]).to eq('foo')
        end

        it 'raises when given document does not have a discriminator' do
          expect do
            subject.convert_as_typed(Document.new('foo'))
          end.to raise_error(ArgumentError)
        end

        it 'raises when given document discriminator is not found' do
          shape = Shapes::StructureShape.new(id: 'thing2')
          shape.type = runtime_shape
          doc = Document.new(runtime_shape.new(string: 'foo'), schema: shape)
          expect do
            subject.convert_as_typed(doc)
          end.to raise_error(ArgumentError)
        end
      end

      describe '.compose' do
        it 'returns a combined registry' do
          registry = TypeRegistry.new
          registry.register(Shapes::StructureShape.new(id: 'thing2'))
          new_registry = TypeRegistry.compose(subject, registry)
          expect(new_registry.registry).to include('thing', 'thing2')
        end

        it 'raises when invalid input is given' do
          expect do
            TypeRegistry.compose(1, 2)
          end.to raise_error(ArgumentError)
        end
      end
    end
  end
end
