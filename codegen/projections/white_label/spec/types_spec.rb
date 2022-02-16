# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  module Types
    describe KitchenSinkInput do
      let(:params) do
        {
          string: 'simple string',
          struct: struct,
          document: { boolean: true },
          list_of_strings: ['dank', 'memes'],
          list_of_structs: [struct],
          map_of_strings: { key: 'value' },
          map_of_structs: { key: struct },
          set_of_strings: Set.new(['dank', 'memes']),
          set_of_structs: Set.new([struct]),
          union: { string: 'simple string' }
        }
      end
      let(:struct) { Types::Struct.new(value: 'struct value') }
      subject { KitchenSinkInput.new(**params) }

      it 'is a Ruby struct' do
        expect(subject).to be_a(::Struct)
      end

      it 'is a hearth structure' do
        expect(subject).to be_a(Hearth::Structure)
      end
    end

    describe Union do
      subject { Union.new(nil) }
      let(:struct) { Types::Struct.new(value: 'struct value') }

      it 'is a hearth union' do
        expect(subject).to be_a(Hearth::Union)
        # implementation detail
        expect(subject).to be_a(SimpleDelegator)
      end

      it 'has subclasses' do
        string_union = Union::String.new('simple string')
        struct_union = Union::Struct.new(struct)
        unknown_union = Union::Unknown.new({ unknown: 'data' })
        expect(string_union).to be_a(Union)
        expect(struct_union).to be_a(Union)
        expect(unknown_union).to be_a(Union)
      end

      it 'implements to_h for delegation' do
        string_union = Union::String.new('simple string')
        struct_union = Union::Struct.new(struct)
        unknown_union = Union::Unknown.new({key: 'key', value: 'value'})
        expect(string_union.to_h).to eq({ string: 'simple string' })
        expect(struct_union.to_h).to eq({ struct: { value: 'struct value' } })
        expect(unknown_union.to_h).to eq({ unknown: { key: 'key', value: 'value' } })
      end
    end
  end
end
