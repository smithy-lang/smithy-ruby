# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.shared_examples "validates types" do |types|

  it "validates input as #{types}" do
    expect do
      shape = self.class.description
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
