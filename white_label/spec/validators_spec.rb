# frozen_string_literal: true

require_relative 'spec_helper'

# TODO -
#  * don't do if input[], but do unless input[].nil? - this prevents false values from skipping validation
#  * fix TypeError: no implicit conversion of Symbol into Integer
#    this is happening because validation is needed before delegating to another structure.
#    decide if it should be in the delegated structure or context around it?
#  * larger task - use :: for root namespaces everywhere
module WhiteLabel
  module Validators
    describe Document do
      it 'validates against document types' do
        expect { Document.validate!(Set.new, context: 'input') }
          .to raise_error(
            ArgumentError,
            "Expected input to be in [Hash, String, Array, TrueClass, FalseClass, Numeric], got Set."
          )
      end

      it 'validates a valid document' do
        document = {
          boolean: true,
          hash: { key: 'value' },
          array: ['dank', 'memes'],
          integer: 420,
          float: 69.69,
          not_boolean: false
        }
        Document.validate!(document, context: 'input')
      end

      it 'raises when hash values are not document types' do
        expect { Document.validate!({ hash: { key: Set.new }}, context: 'input') }
          .to raise_error(
            ArgumentError,
            "Expected input[:hash][:key] to be in [Hash, String, Array, TrueClass, FalseClass, Numeric], got Set."
          )
      end

      it 'raises when array elements are not document types' do
        expect { Document.validate!({ array: [Set.new] }, context: 'input') }
          .to raise_error(
            ArgumentError,
            "Expected input[:array][0] to be in [Hash, String, Array, TrueClass, FalseClass, Numeric], got Set."
          )
      end
    end

    describe ListOfStrings do
      it 'validates an array' do
        expect { ListOfStrings.validate!({}, context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [Array], got Hash.")
      end

      it 'validates an array of simple elements' do
        input = ['dank', 'memes']
        ListOfStrings.validate!(input, context: 'input')
      end

      it 'raises when element is not an expected type' do
        input = ['dank', 'memes', 420]
        expect { ListOfStrings.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input[2] to be in [String], got Integer.")
      end
    end

    describe ListOfStructs do
      let(:struct_1) { Types::Struct.new }
      let(:struct_2) { Types::Struct.new }

      it 'validates an array' do
        expect { ListOfStructs.validate!({}, context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [Array], got Hash.")
      end

      it 'validates an array of complex elements' do
        input = [struct_1, struct_2]
        ListOfStructs.validate!(input, context: 'input')
      end

      it 'raises when element is not an expected type' do
        input = [struct_1, struct_2, 'struct_3']
        expect { ListOfStructs.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input[2] to be in [WhiteLabel::Types::Struct], got String.")
      end
    end

    describe MapOfStrings do
      it 'validates a hash' do
        expect { MapOfStrings.validate!([], context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [Hash], got Array.")
      end

      it 'validates a hash of simple values' do
        input = { key: 'value', other_key: 'other value' }
        MapOfStrings.validate!(input, context: 'input')
      end

      it 'raises when key is not a string or symbol' do
        input = { key: 'value', 4 => 'other value' }
        expect { MapOfStrings.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input.keys to be in [String, Symbol], got Integer.")
      end

      it 'raises when value is not an expected type' do
        input = { key: 'value', other_key: ['array element'] }
        expect { MapOfStrings.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input[:other_key] to be in [String], got Array.")
      end
    end

    describe MapOfStructs do
      let(:struct_1) { Types::Struct.new }
      let(:struct_2) { Types::Struct.new }

      it 'validates a hash' do
        expect { MapOfStructs.validate!([], context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [Hash], got Array.")
      end

      it 'validates a hash of complex values' do
        input = { key: struct_1, other_key: struct_2 }
        MapOfStructs.validate!(input, context: 'input')
      end

      it 'raises when key is not a string or symbol' do
        input = { key: struct_1, 4 => struct_2 }
        expect { MapOfStructs.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input.keys to be in [String, Symbol], got Integer.")
      end

      it 'raises when value is not an expected type' do
        input = { key: struct_1, other_key: 'struct_2' }
        expect { MapOfStructs.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input[:other_key] to be in [WhiteLabel::Types::Struct], got String.")
      end
    end

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
      let(:input) { Params::KitchenSinkInput.build(params, context: 'params') }
      let(:struct) { Types::Struct.new(value: 'struct value') }

      it 'validates all member input' do
        KitchenSinkInput.validate!(input, context: 'input')
      end
    end

    describe SetOfStrings do
      it 'validates input is a set' do
        expect { SetOfStrings.validate!({}, context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [Set], got Hash.")
      end

      it 'validates a set of simple elements' do
        input = Set.new(['dank', 'memes'])
        SetOfStrings.validate!(input, context: 'input')
      end

      it 'raises when element is not an expected type' do
        input = Set.new(['dank', 'memes', 420])
        expect { SetOfStrings.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input[2] to be in [String], got Integer.")
      end
    end

    describe SetOfStructs do
      let(:struct_1) { Types::Struct.new(value: 'one') }
      let(:struct_2) { Types::Struct.new(value: 'two') }

      it 'validates input is a set' do
        expect { SetOfStructs.validate!({}, context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [Set], got Hash.")
      end

      it 'validates a set of complex elements' do
        input = Set.new([struct_1, struct_2])
        SetOfStructs.validate!(input, context: 'input')
      end

      it 'raises when element is not an expected type' do
        input = Set.new([struct_1, struct_2, 'struct_3'])
        expect { SetOfStructs.validate!(input, context: 'input') }
          .to raise_error(ArgumentError, "Expected input[2] to be in [WhiteLabel::Types::Struct], got String.")
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
        expect { Union.validate!(Types::Union::String.new({}), context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [String], got Hash.")
      end

      it 'validates complex members' do
        expect { Union.validate!(Types::Union::Struct.new('string'), context: 'input') }
          .to raise_error(ArgumentError, "Expected input to be in [WhiteLabel::Types::Struct], got String.")
      end

      it 'validates unknown type' do
        expect { Union.validate!(Types::Union::Unknown.new(['some data']), context: 'input') }
          .to raise_error(ArgumentError)
      end

      it 'raises when input is not of Types::Union' do
        expect { Union.validate!(struct, context: 'input') }
          .to raise_error(
            ArgumentError,
            "Expected input to be a union member of Types::Union, got WhiteLabel::Types::Struct."
          )
      end
    end
  end
end
