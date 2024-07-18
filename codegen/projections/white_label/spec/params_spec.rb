# frozen_string_literal: true

require_relative 'spec_helper'

# guaranteed to trip validation
class BadType; end

RSpec.shared_examples 'validates params' do |*types|
  it "validates params as #{types}" do
    expect do
      shape = Object.const_get(self.class.description)
      shape.build(BadType.new, context: 'params')
    end.to raise_error(ArgumentError,
                       'Expected params to be in ' \
                       "[#{types.map(&:to_s).join(', ')}], got BadType.")
  end
end

module WhiteLabel
  module Params
    describe ListOfStrings do
      include_examples 'validates params', Array

      let(:params) { %w[dank memes] }

      it 'builds an array of simple elements' do
        data = ListOfStrings.build(params, context: 'params')
        expect(data).to be_a(Array)
        expect(data).to eq(params)
      end
    end

    describe ListOfStructs do
      include_examples 'validates params', Array

      it 'builds an array of complex elements' do
        params = [{}, {}]
        data = ListOfStructs.build(params, context: 'params[:list_of_structs]')
        expect(data).to be_a(Array)
        expect(data).to all(be_a(Types::Struct))
      end
    end

    describe MapOfStrings do
      include_examples 'validates params', Hash

      let(:params) { { key: 'value', other_key: 'other value' } }

      it 'builds a map of simple values' do
        data = MapOfStrings.build(params, context: 'params')
        expect(data).to be_a(Hash)
        expect(data).to eq(params)
      end
    end

    describe MapOfStructs do
      include_examples 'validates params', Hash

      it 'builds a map of complex values' do
        params = { key: {}, other_key: {} }
        data = MapOfStructs.build(params, context: 'params[:map_of_structs]')
        expect(data).to be_a(Hash)
        expect(data.values).to all(be_a(Types::Struct))
      end
    end

    describe KitchenSinkInput do
      include_examples 'validates params', Hash, Types::KitchenSinkInput

      let(:params) do
        {
          string: 'simple string',
          struct: { value: 'struct value' },
          document: { 'boolean' => true },
          list_of_strings: %w[dank memes],
          list_of_structs: [{ value: 'struct value' }],
          map_of_strings: { 'key' => 'value' },
          map_of_structs: { 'key' => { value: 'struct value' } },
          union: { string: 'simple string' }
        }
      end

      it 'builds all member input' do
        data = KitchenSinkInput.build(params, context: 'params')
        expect(data).to be_a(Types::KitchenSinkInput)
        expect(data.struct).to be_a(Types::Struct)
        expect(data.to_h).to eq(params)
      end
    end

    describe DefaultsTestInput do
      include_examples 'validates params', Hash, Types::DefaultsTestInput

      let(:params) { { defaults: {} } }

      it 'builds with empty params input' do
        data = DefaultsTestInput.build(params, context: 'params')
        expect(data).to be_a(Types::DefaultsTestInput)
        expected = {
          number: 0,
          bool: false,
          hello: 'world',
          simple_enum: 'YES',
          valued_enum: 'no',
          int_enum: 1,
          string_document: 'some string document',
          un_required_bool: false,
          un_required_number: 0,
          boolean_document: true,
          numbers_document: 1.23,
          list_document: [],
          map_document: {},
          list_of_strings: [],
          map_of_strings: {},
          epoch_timestamp: Time.at(1_515_531_081.1234),
          iso8601_timestamp: Time.parse('1985-04-12T23:20:50.52Z')
        }
        expect(data.defaults.to_h).to eq(expected)
      end
    end

    describe Struct do
      include_examples 'validates params', Hash, Types::Struct

      let(:params) { { value: 'simple' } }

      it 'builds a structure with params' do
        data = Struct.build(params, context: 'params')
        expect(data).to be_a(Types::Struct)
        expect(data.to_h).to eq(params)
      end

      it 'validates unknown params' do
        expect do
          Struct.build({ unknown: 'param' }, context: 'params')
        end.to raise_error(
          ArgumentError,
          'Unexpected members: [params[:unknown]]'
        )
      end
    end

    describe Union do
      include_examples 'validates params', Hash, Types::Union

      it 'builds a union structure with simple data' do
        params = { string: 'simple string' }
        data = Union.build(params, context: 'params')
        expect(data).to be_a(Types::Union)
        expect(data.to_h).to eq(params)
      end

      it 'builds a union structure with complex data' do
        params = { struct: { value: 'simple struct' } }
        data = Union.build(params, context: 'params[:union]')
        expect(data).to be_a(Types::Union)
        expect(data.to_h).to eq(params)
      end

      it 'validates exactly one member' do
        struct = Types::Struct.new
        params = { string: 'simple string', struct: struct }
        expect { Union.build(params, context: 'params') }
          .to raise_error(ArgumentError, /exactly one member/)
      end

      it 'validates against unknown members' do
        params = { unknown: 'poop emoji' }
        expect { Union.build(params, context: 'params') }
          .to raise_error(ArgumentError, /Expected params to have one of/)
      end
    end

    describe StreamingInput do
      it 'converts a string to StringIO' do
        data = StreamingInput.build({ stream: 'string' }, context: 'params')
        expect(data).to be_a(Types::StreamingInput)
        expect(data.stream).to be_a(StringIO)
        expect(data.stream.read).to eq('string')
      end

      it 'converts a nil to an empty StringIO' do
        data = StreamingInput.build({ stream: nil }, context: 'params')
        expect(data).to be_a(Types::StreamingInput)
        expect(data.stream).to be_a(StringIO)
        expect(data.stream.read).to eq('')
      end

      it 'does not convert a readable, io like object' do
        stream = StringIO.new('chunk')
        data = StreamingInput.build({ stream: stream }, context: 'params')
        expect(data).to be_a(Types::StreamingInput)
        expect(data.stream).to be(stream)
      end
    end

    describe MixinTestInput do
      it 'expects mixins input operation generated' do
        data = MixinTestInput.build({ user_id: 'abc123' }, context: 'params')
        expect(data).to be_a(Types::MixinTestInput)
        expect(data.user_id).to eq('abc123')
      end
    end

    describe MixinTestOutput do
      it 'expects mixins output operation generated' do
        data = MixinTestOutput.build({ username: 'ben', user_id: 'abc123' },
                                     context: 'params')
        expect(data).to be_a(Types::MixinTestOutput)
        expect(data.user_id).to eq('abc123')
        expect(data.username).to eq('ben')
      end
    end
  end
end
