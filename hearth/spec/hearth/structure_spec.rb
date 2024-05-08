# frozen_string_literal: true

module Hearth
  class MyUnion < Hearth::Union
    class StringValue < MyUnion
      def to_h
        { string_value: super(__getobj__) }
      end
    end
  end

  describe Structure do
    let(:struct) do
      Struct.new(
        :struct_value,
        :array_value,
        :hash_value,
        :value,
        :union_value,
        :some_object,
        keyword_init: true
      ) do
        include Hearth::Structure
      end
    end

    let(:struct_with_default) do
      Struct.new(
        :value_no_default,
        :value_with_default,
        keyword_init: true
      ) do
        include Hearth::Structure

        private

        def _defaults
          {
            value_with_default: 'default'
          }
        end
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
        value: 'value',
        union_value: MyUnion::StringValue.new('union'),
        some_object: Object.new
      )
    end

    describe '#initialize' do
      it 'initializes with defaults' do
        obj = struct_with_default.new
        expect(obj.value_with_default).to eq('default')
        expect(obj.value_no_default).to be_nil
      end

      it 'initializes with user provided values' do
        obj = struct_with_default.new(value_with_default: 'custom')
        expect(obj.value_with_default).to eq('custom')
      end
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
          value: 'value',
          union_value: { string_value: 'union' },
          some_object: subject.some_object
        }
        expect(subject.to_h).to eq expected
      end
    end
  end
end
