# frozen_string_literal: true

module Smithy
  module Client
    module Codecs
      class TestUnion < Schema::Union
        class StringValue < TestUnion
          def to_h
            { string_value: super(__getobj__) }
          end
        end

        class Unknown < TestUnion
          def initialize(name:, value:)
            super({ name: name || 'Unknown', value: value })
          end

          def to_h
            { unknown: super(__getobj__) }
          end
        end
      end

      describe CBOR do
        let(:string_shape) { Schema::Shapes::StringShape.new(id: 'string') }

        let(:list_shape) do
          shape = Schema::Shapes::ListShape.new(id: 'list')
          shape.set_member(Schema::Shapes::Prelude::String)
          shape
        end

        let(:map_shape) do
          shape = Schema::Shapes::MapShape.new(id: 'map')
          shape.set_key(Schema::Shapes::Prelude::String)
          shape.set_value(Schema::Shapes::Prelude::Blob)
          shape
        end

        let(:typed_struct) do
          Struct.new(:foo, :bar, :foo_bar, keyword_init: true) do
            include Schema::Structure
          end
        end

        let(:structure_shape) do
          struct = Schema::Shapes::StructureShape.new(id: 'structure')
          struct.add_member(:foo, 'foo', string_shape)
          struct.add_member(:bar, 'bar', list_shape)
          struct.add_member(:foo_bar, 'fooBar', map_shape)
          struct.type = typed_struct
          struct
        end

        let(:union_shape) do
          shape = Schema::Shapes::UnionShape.new(id: 'union')
          shape.add_member(:s, 's', string_shape, TestUnion::StringValue)
          shape.type = TestUnion
          shape
        end

        it 'serializes returns nil when given shape is Prelude::Unit' do
          expect(subject.serialize(Schema::Shapes::Prelude::Unit, '')).to be_nil
        end

        it 'deserializes returns an empty hash when given bytes are empty' do
          expect(subject.deserialize(string_shape, '')).to be_empty
        end

        it 'serializes and deserializes a complex data' do
          typed = typed_struct.new(foo: 'foo', bar: %w[foo bar], foo_bar: { 'foo' => 'bar'.dup })
          serialized = subject.serialize(structure_shape, typed)
          expect(subject.deserialize(structure_shape, serialized)).to eq(typed)
        end

        it 'serializes and deserializes a union data' do
          typed = { s: 'foo' }
          serialized = subject.serialize(union_shape, typed)
          expect(subject.deserialize(union_shape, serialized)).to eq(typed)
        end
      end
    end
  end
end
