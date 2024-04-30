# frozen_string_literal: true

require 'rspec/expectations'

# Provides an rspec matcher for Hearth::XML::Node
RSpec::Matchers.define :match_xml_node do |expected|
  match do |actual|
    return true if actual == expected
    return false unless actual.instance_of?(expected.class)

    expect(actual.name).to eq(expected.name)
    expect(actual.text).to eq(expected.text)
    expect(actual.attributes).to eq(expected.attributes)

    expect(actual.children.length).to eq(expected.children.length)

    expected.children.zip(actual.children).each do |a, e|
      expect(a).to match_xml_node(e)
    end
  end

  diffable
end
