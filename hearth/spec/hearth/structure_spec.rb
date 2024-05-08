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
        :default_value,
        keyword_init: true
      ) do
        include Hearth::Structure

        private

        def _defaults
          {
            default_value: 'default'
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
        expect(subject.default_value).to eq('default')
      end
    end

    describe '#to_hash' do
      it 'serializes nested structs to a hash' do
        expected = {
          struct_value: { value: 'foo', default_value: 'default' },
          array_value: [
            { value: 'foo', default_value: 'default' },
            { value: 'bar', default_value: 'default' }
          ],
          hash_value: {
            key: { value: 'value', default_value: 'default' }
          },
          value: 'value',
          union_value: { string_value: 'union' },
          some_object: subject.some_object,
          default_value: 'default'
        }
        expect(subject.to_h).to eq expected
      end
    end
  end
end
