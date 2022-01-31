# frozen_string_literal: true
require 'rspec/expectations'

RSpec::Matchers.define :be_equal_xml do |expected|
  match do |actual|
    return true if actual == expected
    return false unless actual.class == expected.class

    expect(actual.name).to eq(expected.name)
    expect(actual.text).to eq(expected.text)
    expect(actual.attributes).to eq(expected.attributes)

    expect(actual.children.length).to eq(expected.children.length)

    expected.children.zip(actual.children).each do | a,e |
      expect(a).to be_equal_xml(e)
    end

  end

  diffable
end

