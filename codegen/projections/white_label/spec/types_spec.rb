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
          list_of_strings: %w[dank memes],
          list_of_structs: [struct],
          map_of_strings: { key: 'value' },
          map_of_structs: { key: struct },
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
        unknown_union = Union::Unknown.new({ name: 'name', value: 'value' })
        expect(string_union.to_h).to eq({ string: 'simple string' })
        expect(struct_union.to_h).to eq({ struct: { value: 'struct value' } })
        expect(unknown_union.to_h).to eq({ unknown: { name: 'name',
                                                      value: 'value' } })
      end
    end

    describe DefaultsTestInput do
      it 'has a default value for default_number' do
        expect(subject.un_required_number).to be 0
      end

      it 'has a default value for default_bool' do
        expect(subject.un_required_bool).to be false
      end
    end

    describe 'SimpleEnum' do
      it 'is not defined' do
        expect(defined?(Types::SimpleEnum)).to be nil
      end
    end

    describe TypedEnum do
      it 'has typed enums' do
        expect(Types::TypedEnum::YES).to eq 'YES'
        expect(Types::TypedEnum::NO).to eq 'NO'
        expect(Types::TypedEnum::MAYBE).to eq 'MAYBE'
      end
    end
  end
end
