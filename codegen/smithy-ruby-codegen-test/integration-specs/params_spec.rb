# frozen_string_literal: true

require_relative 'spec_helper'

# guaranteed to trip validation
class BadType; end

RSpec.shared_examples "validates types" do |*types|
  it "validates input as #{types}" do
    expect do
      shape = Object.const_get(self.class.description)
      shape.build(BadType.new, context: 'params')
    end.to raise_error(ArgumentError, "Expected params to be in #{types}, got BadType.")
  end
end

module WhiteLabel
  module Params
    describe EmptyStruct do
      include_examples "validates types", Hash, Types::EmptyStruct
    end

    describe KitchenSink do
      include_examples "validates types", Hash, Types::KitchenSink
    end

    describe KitchenSinkOperationInput do
      include_examples "validates types", Hash, Types::KitchenSinkOperationInput
    end

    describe ListOfKitchenSinks do
      include_examples "validates types", Array

      let(:kitchen_sink) { Types::KitchenSink.new }

      it 'builds the list of members' do
        expect(KitchenSink).to receive(:build).and_return(kitchen_sink).twice
        shape = ListOfKitchenSinks.build([kitchen_sink, kitchen_sink], context: 'params')
        expect(shape).to be_a(Array)
        expect(shape).to eq [kitchen_sink, kitchen_sink]
      end
    end

    describe ListOfListOfStrings do
      include_examples "validates types", Array

      let(:list_of_strings) { ['string'] }

      it 'builds the list of members' do
        shape = ListOfListOfStrings.build([list_of_strings, list_of_strings], context: 'params')
        expect(shape).to be_a(Array)
        expect(shape).to eq [list_of_strings, list_of_strings]
      end
    end

    describe ListOfMapsOfStrings do
      include_examples "validates types", Array
    end

    describe ListOfStrings do
      include_examples "validates types", Array
    end

    # TODO replicate or genericize these tests?
    describe ListOfStructs do
      include_examples "validates types", Array

      let(:simple_struct) { Types::SimpleStruct.new }

      it 'builds all of the members' do
        shape = ListOfStructs.build([simple_struct, simple_struct])
        expect(shape).to be_a(Array)
        expect(shape).to eq [simple_struct, simple_struct]
      end

      it 'binds all of the members and raises when any are invalid' do
        expect do
          ListOfStructs.build([simple_struct, simple_struct, 1], context: 'params')
        end.to raise_error(ArgumentError, 'Expected params[2] to be in [Hash, WhiteLabel::Types::SimpleStruct(keyword_init: true)], got Integer.')
      end
    end

    describe MapOfKitchenSinks do
      include_examples "validates types", Hash
    end

    describe MapOfMapOfStrings do
      include_examples "validates types", Hash
    end

    describe MapOfStrings do
      include_examples "validates types", Hash
    end

    describe MapOfStructs do
      include_examples "validates types", Hash
    end

    describe SimpleStruct do
      include_examples "validates types", Hash, Types::SimpleStruct
    end

    describe StructWithLocationName do
      include_examples "validates types", Hash, Types::StructWithLocationName
    end
  end
end
