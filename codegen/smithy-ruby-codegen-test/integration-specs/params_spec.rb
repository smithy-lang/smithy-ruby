# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.shared_examples "validates types" do |*types|

  it "validates input as #{types}" do
    value = types.include?(Hash) ? [] : {} # value can't be nil, so use something that we don't expect
    expect do
      shape = Object.const_get(self.class.description)
      shape.build(value, context: 'params')
    end.to raise_error(ArgumentError, "Expected params to be in #{types}, got #{value.class}.")
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
    end

    describe ListOfListOfStrings do
      include_examples "validates types", Array
    end

    describe ListOfMapsOfStrings do
      include_examples "validates types", Array
    end

    describe ListOfStrings do
      include_examples "validates types", Array
    end

    describe ListOfStructs do
      include_examples "validates types", Array
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
