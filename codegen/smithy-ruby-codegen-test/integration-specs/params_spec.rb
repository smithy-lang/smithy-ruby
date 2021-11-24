# frozen_string_literal: true

require_relative 'spec_helper'

# guaranteed to trip validation
class BadType; end

RSpec.shared_examples "validates params" do |*types|
  it "validates params as #{types}" do
    expect do
      shape = Object.const_get(self.class.description)
      shape.build(BadType.new, context: 'params')
    end.to raise_error(ArgumentError, "Expected params to be in #{types}, got BadType.")
  end
end

module WhiteLabel
  module Params
    describe ListOfStrings do
      include_examples "validates params", Array

      let(:params) { ['dank', 'memes'] }

      it 'builds an array of simple elements' do
        data = ListOfStrings.build(params, context: 'params')
        expect(data).to be_a(Array)
        expect(data).to eq(params)
      end
    end

    describe ListOfStructs do
      include_examples "validates params", Array

      let(:struct_1) { Types::Struct.new }
      let(:struct_2) { Types::Struct.new }
      let(:params) { [struct_1, struct_2] }

      it 'builds an array of complex elements' do
        expect(Struct).to receive(:build)
          .with(struct_1, context: 'params[:list_of_structs][0]')
          .and_call_original
        expect(Struct).to receive(:build)
          .with(struct_2, context: 'params[:list_of_structs][1]')
          .and_call_original
        data = ListOfStructs.build(params, context: 'params[:list_of_structs]')
        expect(data).to be_a(Array)
        expect(data).to eq(params)
      end
    end

    describe MapOfStrings do
      include_examples "validates params", Hash

      let(:params) { { key: 'value', other_key: 'other value' } }

      it 'builds a map of simple values' do
        data = MapOfStrings.build(params, context: 'params')
        expect(data).to be_a(Hash)
        expect(data).to eq(params)
      end
    end

    describe MapOfStructs do
      include_examples "validates params", Hash

      let(:struct_1) { Types::Struct.new }
      let(:struct_2) { Types::Struct.new }
      let(:params) { { key: struct_1, other_key: struct_2 } }

      it 'builds a map of complex values' do
        expect(Struct).to receive(:build)
          .with(struct_1, context: 'params[:map_of_structs][:key]')
          .and_call_original
        expect(Struct).to receive(:build)
          .with(struct_2, context: 'params[:map_of_structs][:other_key]')
          .and_call_original
        data = MapOfStructs.build(params, context: 'params[:map_of_structs]')
        expect(data).to be_a(Hash)
        expect(data).to eq(params)
      end
    end

    describe KitchenSinkInput do
      include_examples "validates params", Hash, Types::KitchenSinkInput

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

      it 'builds all member input' do
        expect(Struct).to receive(:build)
          .with(params[:struct], context: 'params[:struct]')
          .and_call_original
        expect(ListOfStrings).to receive(:build)
          .with(params[:list_of_strings], context: 'params[:list_of_strings]')
          .and_call_original
        expect(ListOfStructs).to receive(:build)
          .with(params[:list_of_structs], context: 'params[:list_of_structs]')
          .and_call_original
        expect(Struct).to receive(:build)
          .with(struct, context: 'params[:list_of_structs][0]')
          .and_call_original
        expect(MapOfStrings).to receive(:build)
          .with(params[:map_of_strings], context: 'params[:map_of_strings]')
          .and_call_original
        expect(MapOfStructs).to receive(:build)
          .with(params[:map_of_structs], context: 'params[:map_of_structs]')
          .and_call_original
        expect(Struct).to receive(:build)
          .with(struct, context: 'params[:map_of_structs][:key]')
          .and_call_original
        expect(SetOfStrings).to receive(:build)
          .with(params[:set_of_strings], context: 'params[:set_of_strings]')
          .and_call_original
        expect(SetOfStructs).to receive(:build)
          .with(params[:set_of_structs], context: 'params[:set_of_structs]')
          .and_call_original
        expect(Struct).to receive(:build)
          .with(struct, context: 'params[:set_of_structs][0]')
          .and_call_original
        expect(Union).to receive(:build)
          .with(params[:union], context: 'params[:union]')
          .and_call_original

        data = KitchenSinkInput.build(params, context: 'params')
        expect(data).to be_a(Types::KitchenSinkInput)
        expected = {
          string: 'simple string',
          struct: { value: 'struct value' },
          document: { boolean: true },
          list_of_strings: ['dank', 'memes'],
          list_of_structs: [{ value: 'struct value' }],
          map_of_strings: { key: 'value' },
          map_of_structs: { key: { value: 'struct value' } },
          set_of_strings: ["dank", "memes"],
          set_of_structs: [{:value=>"struct value"}],
          union: { string: 'simple string' }
        }
        expect(data.to_h).to eq(expected)
      end
    end

    describe SetOfStrings do
      include_examples "validates params", Set, Array

      let(:params) { Set.new(['dank', 'memes']) }

      it 'builds a set of simple elements' do
        data = SetOfStrings.build(params, context: 'params')
        expect(data).to be_a(Set)
        expect(data).to eq(params)
      end
    end

    describe SetOfStructs do
      include_examples "validates params", Set, Array

      let(:struct_1) { Types::Struct.new(value: 'one') }
      let(:struct_2) { Types::Struct.new(value: 'two') }
      let(:params) { Set.new([struct_1, struct_2]) }

      it 'builds an array of complex elements' do
        expect(Struct).to receive(:build)
          .with(struct_1, context: 'params[:set_of_structs][0]')
          .and_call_original
        expect(Struct).to receive(:build)
          .with(struct_2, context: 'params[:set_of_structs][1]')
          .and_call_original
        data = SetOfStructs.build(params, context: 'params[:set_of_structs]')
        expect(data).to be_a(Set)
        expect(data).to eq(params)
      end
    end

    describe Struct do
      include_examples "validates params", Hash, Types::Struct

      let(:params) { { value: 'simple' } }

      it 'builds a structure with params' do
        data = Struct.build(params, context: 'params')
        expect(data).to be_a(Types::Struct)
        expect(data.to_h).to eq(params)
      end
    end

    describe Union do
      include_examples "validates params", Hash, Types::Union

      it 'builds a union structure with simple data' do
        params = { string: 'simple string' }
        data = Union.build(params, context: 'params')
        expect(data).to be_a(Types::Union)
        expect(data.to_h).to eq(params)
      end

      it 'builds a union structure with complex data' do
        struct = Types::Struct.new(value: 'simple struct')
        params = { struct: struct }
        expect(Struct).to receive(:build)
          .with(struct, context: 'params[:union][:struct]')
          .and_call_original
        data = Union.build(params, context: 'params[:union]')
        expect(data).to be_a(Types::Union)
        expect(data.to_h).to eq(struct: { value: 'simple struct' })
      end

      it 'validates exactly one member' do
        struct = Types::Struct.new
        params = { string: 'simple string', struct: struct }
        expect do
          Union.build(params, context: 'params')
        end.to raise_error(ArgumentError, /exactly one member/)
      end

      it 'validates against unknown members' do
        params = { unknown: 'poop emoji' }
        expect do
          Union.build(params, context: 'params')
        end.to raise_error(ArgumentError, /Expected params to have one of/)
      end
    end
  end
end
