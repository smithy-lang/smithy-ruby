# frozen_string_literal: true

require_relative '../spec_helper'
require 'smithy-client/protocol_spec_matcher'

describe 'match_data timestamp matching' do
  it 'compares timestamps at millisecond precision' do
    actual = Time.at(1_700_000_000, 123_456_789, :nanosecond)
    expected = Time.at(1_700_000_000, 123_999_999, :nanosecond)

    expect(actual).to match_data(expected)
  end

  it 'detects differences at millisecond precision' do
    actual = Time.at(1_700_000_000, 123_456_789, :nanosecond)
    expected = Time.at(1_700_000_000, 124_000_000, :nanosecond)

    expect { expect(actual).to match_data(expected) }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
  end
end
