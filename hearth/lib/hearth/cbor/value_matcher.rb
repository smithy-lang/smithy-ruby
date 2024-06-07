# frozen_string_literal: true

require 'rspec/expectations'

# Provides an rspec matcher for CBOR encoded values
RSpec::Matchers.define :match_cbor do |expected|
  match do |actual|
    # identical values don't need more comparison
    return true if actual == expected

    expect(actual.class).to eq(expected.class)
    def match_value(actual, expected)
      case actual
      when Hash
        actual.each do |key, value|
          expect(actual).not_to include(key) unless expected.key?(key)

          match_value(value, expected[key])
        end
      when Array
        actual.each_with_index do |value, index|
          match_value(value, expected[index])
        end
      when Float
        return if actual.nan? && expected.nan?
        return if actual.infinite? && expected.infinite?

        expect(actual).to be_within(0.0001).of(expected)
      when Time
        expect(actual.utc.iso8601).to eq(expected.utc.iso8601)
      else
        expect(actual).to eq(expected)
      end
    end

    match_value(actual, expected)
  end

  diffable
end
