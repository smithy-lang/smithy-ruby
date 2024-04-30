# frozen_string_literal: true

require 'rspec/expectations'

# Provides an rspec matcher for CGI.parse to check Float precision.
RSpec::Matchers.define :match_query_params do |expected|
  match do |actual|
    return true if actual == expected
    return false unless actual.instance_of?(expected.class)

    expect(actual.keys.length).to eq(expected.keys.length)
    expect(actual.values.length).to eq(expected.values.length)

    expected.each do |ek, e|
      expect(actual.keys).to include(ek)
      a = actual[ek]
      expect(e.length).to eq(a.length)

      a.zip(e).each do |a0, e0|
        # Timestamps can have optional precision.
        begin
          float = Float(a0)
          expect(float).to eq(e0.to_f)
        rescue
          expect(a0).to eq(e0)
        end
      end
    end
  end

  diffable
end
