# frozen_string_literal: true

require 'rspec/expectations'

# Provides an rspec matcher for CGI.parse to check Float precision.
# @api private
RSpec::Matchers.define :match_query_params do |expected|
  match do |actual|
    return true if actual == expected
    return false unless actual.instance_of?(expected.class)

    expect(actual.keys.length).to eq(expected.keys.length)
    expect(actual.values.length).to eq(expected.values.length)

    expected.values.sort.zip(actual.values.sort).each do |a, e|
      a.zip(e).each do |a0, e0|
        # Timestamps can have optional precision.
        if (float = Float(a0) rescue false)
          expect(float).to eq(e0.to_f)
        else
          expect(a0).to eq(e0)
        end
      end
    end
  end

  diffable
end
