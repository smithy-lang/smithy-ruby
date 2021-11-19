# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.shared_examples "validates types" do |types|
  let(:shape) { self.class.description }

  it "validates #{shape} is a #{types}" do
    expect do
      shape.build({}, context: 'params')
    end.to raise_error(ArgumentError, "Expected params to be in #{types}, got Hash.")
  end

end

module WhiteLabel
  module Params
    describe EmptyStruct do
      include_examples "validates types", [Hash, WhiteLabel::Types::EmptyStruct]
    end
  end
end
