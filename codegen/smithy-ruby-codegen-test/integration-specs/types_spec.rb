# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  module Types
    describe KitchenSinkInput do
      let(:params) do
        {
          string: 'simple string',
          struct: { value: 'struct value' },
          document: { boolean: true },
          list_of_strings: %w[dank memes],
          list_of_structs: [{ value: 'struct value' }],
          map_of_strings: { key: 'value' },
          map_of_structs: { key: { value: 'struct value' } },
          union: { string: 'simple string' }
        }
      end

      subject { KitchenSinkInput.new(**params) }

      it 'is a hearth structure' do
        expect(subject).to be_a(Hearth::Structure)
      end

      it 'has a MEMBERS constant' do
        expect(KitchenSinkInput::MEMBERS).to be_a(Array)
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
        unknown_union = Union::Unknown.new(name: 'unknown', value: 'unknown')
        expect(string_union).to be_a(Union)
        expect(struct_union).to be_a(Union)
        expect(unknown_union).to be_a(Union)
      end

      it 'implements to_h for delegation' do
        string_union = Union::String.new('simple string')
        struct_union = Union::Struct.new(struct)
        unknown_union = Union::Unknown.new(name: 'name', value: 'value')
        expect(string_union.to_h).to eq({ string: 'simple string' })
        expect(struct_union.to_h).to eq({ struct: { value: 'struct value' } })
        expect(unknown_union.to_h).to eq({ unknown: { name: 'name',
                                                      value: 'value' } })
      end
    end

    describe Defaults do
      it 'has a default value for default_number' do
        expect(subject.un_required_number).to be 0
      end

      it 'has a default value for default_bool' do
        expect(subject.un_required_bool).to be false
      end
    end

    describe SimpleEnum do
      it 'has typed enums' do
        expect(Types::SimpleEnum::YES).to eq 'YES'
        expect(Types::SimpleEnum::NO).to eq 'NO'
      end
    end

    describe ValuedEnum do
      it 'has typed enums with new values' do
        expect(Types::ValuedEnum::YES).to eq 'yes'
        expect(Types::ValuedEnum::NO).to eq 'no'
      end
    end

    describe IntEnumType do
      it 'has typed enums' do
        expect(Types::IntEnumType::ONE).to eq 1
        expect(Types::IntEnumType::TWO).to eq 2
        expect(Types::IntEnumType::THREE).to eq 3
      end
    end
  end
end
