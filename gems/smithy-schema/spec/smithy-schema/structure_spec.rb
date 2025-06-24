# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Structure do
      let(:structure) do
        Struct.new(
          :struct_value,
          :array_value,
          :hash_value,
          :value,
          :some_object,
          :union_value,
          keyword_init: true
        ) do
          include Structure
        end
      end

      let(:union) do
        Struct.new(:struct_value, keyword_init: true) do
          include Union
        end
      end
      let(:struct_value) { Class.new(union) }

      subject do
        structure.new(
          struct_value: structure.new(value: 'foo'),
          array_value: [
            structure.new(value: 'foo'),
            structure.new(value: 'bar')
          ],
          hash_value: { key: structure.new(value: 'value') },
          union_value: struct_value.new(struct_value: structure.new(value: 'value')),
          value: 'value',
          some_object: Object.new
        )
      end

      describe '#to_h' do
        it 'serializes nested structs to a hash' do
          expected = {
            struct_value: { value: 'foo' },
            array_value: [
              { value: 'foo' },
              { value: 'bar' }
            ],
            hash_value: {
              key: { value: 'value' }
            },
            union_value: { struct_value: { value: 'value' } },
            value: 'value',
            some_object: subject.some_object
          }
          expect(subject.to_h).to eq expected
        end
      end
    end
  end
end
