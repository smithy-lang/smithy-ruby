# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.shared_examples "validates types" do |*types|

  it "validates input as #{types}" do
    expect do
      shape = Object.const_get(self.class.description)
      value = types.include?(Hash) ? [] : {}
      shape.build(value, context: 'params')
    end.to raise_error(ArgumentError, "Expected params to be in #{types}, got #{value.class}.")
  end

end

module WhiteLabel
  module Params
    describe EmptyStruct do
      include_examples "validates types", Hash, WhiteLabel::Types::EmptyStruct
    end
  end
end
