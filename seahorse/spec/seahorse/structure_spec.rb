# frozen_string_literal: true

module Seahorse
  describe Struct do

    let(:struct) do
      Struct.new(
        :struct_value,
        :array_value,
        :hash_value,
        :value,
        keyword_init: true
      ) do
        include Seahorse::Structure
      end
    end

    subject do
      struct.new(
        struct_value: struct.new(value: 'foo'),
        array_value: [
          struct.new(value: 'foo'),
          struct.new(value: 'bar')
        ],
        hash_value: { key: struct.new(value: 'value') },
        value: 'value'
      )
    end

    describe '#to_hash' do

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
          value: 'value'
        }
        expect(subject.to_h).to eq expected
      end

    end

  end
end
