# frozen_string_literal: true

module Smithy::Client
  describe Structure do
    let(:structure) do
      Struct.new(
        :struct_value,
        :array_value,
        :hash_value,
        :value,
        :some_object,
        keyword_init: true
      ) do
        include Structure
      end
    end

    let(:union) do
      Struct.new()
    end

    subject do
      structure.new(
        struct_value: structure.new(value: 'foo'),
        array_value: [
          structure.new(value: 'foo'),
          structure.new(value: 'bar')
        ],
        hash_value: { key: structure.new(value: 'value') },
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
          value: 'value',
          some_object: subject.some_object
        }
        expect(subject.to_h).to eq expected
      end
    end
  end
end
