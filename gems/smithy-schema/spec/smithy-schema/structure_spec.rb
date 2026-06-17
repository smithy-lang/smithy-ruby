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

      describe '#each' do
        it 'is undefined to prevent silent struct field iteration' do
          expect(subject.respond_to?(:each)).to be false
        end

        it 'raises NoMethodError when called' do
          expect { subject.each }.to raise_error(NoMethodError)
        end
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

      describe '#empty?' do
        it 'returns true if all values are nil' do
          empty_struct = structure.new
          expect(empty_struct.empty?).to be true
        end

        it 'returns false if any value is not nil' do
          expect(subject.empty?).to be false
          expect(structure.new(value: nil).empty?).to be true
          expect(structure.new(value: 'not nil').empty?).to be false
        end
      end

      describe '#key?' do
        it 'returns false if the value is nil' do
          empty_struct = structure.new
          expect(empty_struct.key?(:value)).to be false
        end

        it 'returns true if the value is not nil' do
          expect(subject.key?(:value)).to be true
        end
      end
    end
  end
end
