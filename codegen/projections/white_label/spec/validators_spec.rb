# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  module Validators
    describe Document do
      it 'validates against document types' do
        expect { Document.validate!(Set.new, context: 'input') }
          .to raise_error(
            ArgumentError,
            'Expected input to be in ' \
            '[Hash, String, Array, TrueClass, FalseClass, Numeric], got Set.'
          )
      end

      it 'validates a valid document' do
        document = {
          'hash' => { 'key' => 'value' },
          'array' => %w[dank memes],
          'string' => 'string',
          'boolean' => true,
          'integer' => 420,
          'float' => 69.69
        }
        Document.validate!(document, context: 'input')
      end

      it 'raises when hash values are not document types' do
        document = { 'hash' => { 'key' => Set.new } }
        expect { Document.validate!(document, context: 'input') }
          .to raise_error(
            ArgumentError,
            "Expected input['hash']['key'] to be in " \
            '[Hash, String, Array, TrueClass, FalseClass, Numeric], got Set.'
          )
      end

      it 'raises when array elements are not document types' do
        document = { 'array' => [Set.new] }
        expect { Document.validate!(document, context: 'input') }
          .to raise_error(
            ArgumentError,
            "Expected input['array'][0] to be in " \
            '[Hash, String, Array, TrueClass, FalseClass, Numeric], got Set.'
          )
      end
    end

    describe ListOfStrings do
      it 'validates an array' do
        expect { ListOfStrings.validate!({}, context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input to be in [Array], got Hash.')
      end

      it 'validates an array of simple elements' do
        input = %w[dank memes]
        ListOfStrings.validate!(input, context: 'input')
      end

      it 'raises when element is not an expected type' do
        input = ['dank', 'memes', 420]
        expect { ListOfStrings.validate!(input, context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input[2] to be in [String], got Integer.')
      end
    end

    describe ListOfStructs do
      let(:struct1) { Types::Struct.new }
      let(:struct2) { Types::Struct.new }

      it 'validates an array' do
        expect { ListOfStructs.validate!({}, context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input to be in [Array], got Hash.')
      end

      it 'validates an array of complex elements' do
        input = [struct1, struct2]
        ListOfStructs.validate!(input, context: 'input')
      end

      it 'raises when element is not an expected type' do
        input = [struct1, struct2, 'struct_3']
        expect { ListOfStructs.validate!(input, context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input[2] to be in ' \
                          '[WhiteLabel::Types::Struct], got String.')
      end
    end

    describe MapOfStrings do
      it 'validates a hash' do
        expect { MapOfStrings.validate!([], context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input to be in [Hash], got Array.')
      end

      it 'validates a hash of simple values' do
        input = { 'key' => 'value', 'other_key' => 'other value' }
        MapOfStrings.validate!(input, context: 'input')
      end

      it 'raises when key is not a String' do
        input = { 'key' => 'value', 4 => 'other value' }
        expect { MapOfStrings.validate!(input, context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input.keys to be in [String], got Integer.')
      end

      it 'raises when value is not an expected type' do
        input = { 'key' => 'value', 'other_key' => ['array element'] }
        expect { MapOfStrings.validate!(input, context: 'input') }
          .to raise_error(ArgumentError,
                          "Expected input['other_key'] to " \
                          'be in [String], got Array.')
      end
    end

    describe MapOfStructs do
      let(:struct1) { Types::Struct.new }
      let(:struct2) { Types::Struct.new }

      it 'validates a hash' do
        expect { MapOfStructs.validate!([], context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input to be in [Hash], got Array.')
      end

      it 'validates a hash of complex values' do
        input = { 'key' => struct1, 'other_key' => struct2 }
        MapOfStructs.validate!(input, context: 'input')
      end

      it 'raises when key is not a string or symbol' do
        input = { 'key' => struct1, 4 => struct2 }
        expect { MapOfStructs.validate!(input, context: 'input') }
          .to raise_error(ArgumentError,
                          'Expected input.keys to be in [String], got Integer.')
      end

      it 'raises when value is not an expected type' do
        input = { 'key' => struct1, 'other_key' => 'struct_2' }
        expect { MapOfStructs.validate!(input, context: 'input') }
          .to raise_error(ArgumentError,
                          "Expected input['other_key'] to be in " \
                          '[WhiteLabel::Types::Struct], got String.')
      end
    end

    describe KitchenSinkInput do
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

      it 'validates all member input' do
        input = Params::KitchenSinkInput.build(params, context: 'params')
        KitchenSinkInput.validate!(input, context: 'input')
      end
    end

    describe Struct do
      it 'validates the members' do
        input = Types::Struct.new({ value: 'foo' })
        Struct.validate!(input, context: 'input')
      end
    end

    describe Union do
      let(:struct) { Types::Struct.new(value: 'struct') }

      it 'validates simple members' do
        expect do
          Union.validate!(Types::Union::String.new({}), context: 'input')
        end
          .to raise_error(ArgumentError,
                          'Expected input to be in [String], got Hash.')
      end

      it 'validates complex members' do
        expect do
          Union.validate!(Types::Union::Struct.new('string'), context: 'input')
        end
          .to raise_error(ArgumentError,
                          'Expected input to be in ' \
                          '[WhiteLabel::Types::Struct], got String.')
      end

      it 'validates unknown type' do
        expect do
          Union.validate!(Types::Union::Unknown.new(['some data']),
                          context: 'input')
        end
          .to raise_error(ArgumentError)
      end

      it 'raises when input is not of Types::Union' do
        expect { Union.validate!(struct, context: 'input') }
          .to raise_error(
            ArgumentError,
            'Expected input to be a union member of Types::Union, ' \
            'got WhiteLabel::Types::Struct.'
          )
      end
    end

    describe StreamingInput do
      it 'validates io like', rbs_test: :skip do
        expect do
          StreamingInput.validate!(
            Types::StreamingInput.new(stream: ''), context: 'input'
          )
        end
          .to raise_error(ArgumentError,
                          'Expected input to be an IO like object, got String')
      end
    end

    describe StreamingWithLengthInput do
      it 'validates responds_to(:size)' do
        rd, wr = IO.pipe
        wr.puts 'data'
        wr.close
        expect do
          StreamingWithLengthInput.validate!(
            Types::StreamingWithLengthInput.new(stream: rd), context: 'input'
          )
        end
          .to raise_error(ArgumentError,
                          'Expected input to respond_to(:size)')
        rd.close
      end
    end

    describe EndpointWithHostLabelOperationInput do
      let(:input) { Types::EndpointWithHostLabelOperationInput.new }

      it 'validates required', rbs_test: :skip do
        expect do
          EndpointWithHostLabelOperationInput.validate!(input, context: 'input')
        end
          .to raise_error(ArgumentError,
                          'Expected input[:label_member] to be set.')
      end
    end
  end
end
