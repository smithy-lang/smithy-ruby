# frozen_string_literal: true

require 'rspec/expectations'

# Provides an RSpec matcher for protocol specs.
# rubocop:disable-next Metrics/BlockLength
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

    def match_data(actual, expected)
      case actual
      when Hash
        match_hash(actual, expected)
      when Array
        match_array(actual, expected)
      when Float
        match_float(actual, expected)
      when Time
        actual = Smithy::Schema::Utils.serialize_timestamp(actual, 'date-time')
        expected = Smithy::Schema::Utils.serialize_timestamp(expected, 'date-time')
        expect(actual).to eq(expected)
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
