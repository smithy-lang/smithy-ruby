# frozen_string_literal: true

require 'rspec/expectations'

# Provides an RSpec matcher for protocol specs.
# rubocop:disable Metrics/BlockLength
RSpec::Matchers.define :match_data do |expected|
  match do |actual|
    def match_hash(actual, expected)
      expect(actual).to be_a(Hash)
      expect(expected).to be_a(Hash)

      expected.each do |key, value|
        match_data(actual[key], value)
      end

      actual.each_key do |key|
        expect(expected).to include(key)
      end
    end

    def match_array(actual, expected)
      expect(actual).to be_a(Array)
      expect(expected).to be_a(Array)

      actual.each_with_index do |value, index|
        match_data(value, expected[index])
      end
    end

    def match_float(actual, expected)
      expect(actual).to be_a(Float)
      expect(expected).to be_a(Float)

      return if actual.nan? && expected.nan?
      return if actual.infinite? && expected.infinite?

      expect(actual).to be_within(0.0001).of(expected)
    end

    def match_data(actual, expected) # rubocop:disable Metrics/AbcSize
      case actual
      when Hash
        match_hash(actual, expected)
      when Array
        match_array(actual, expected)
      when Float
        match_float(actual, expected)
      when Time
        expect(actual.utc.iso8601).to eq(expected.utc.iso8601)
      when StringIO
        expect(actual.string).to eq(expected)
      else
        expect(actual).to eq(expected)
      end
    end

    match_data(actual, expected)
  end

  diffable
end
# rubocop:enable Metrics/BlockLength
