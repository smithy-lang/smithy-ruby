# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Utils do
      describe '.serialize_timestamp' do
        it 'returns an integer for whole seconds' do
          result = described_class.serialize_timestamp(Time.at(1_700_000_000), 'epoch-seconds')
          expect(result).to eql(1_700_000_000)
        end

        it 'preserves milliseconds and truncates finer precision for epoch seconds' do
          time = Time.at(1_700_000_000, 123_456_789, :nanosecond)
          expect(described_class.serialize_timestamp(time, 'epoch-seconds')).to eq(1_700_000_000.123)
        end

        it 'omits fractional seconds for whole seconds' do
          expect(described_class.serialize_timestamp(Time.at(1_700_000_000), 'date-time'))
            .to eq('2023-11-14T22:13:20Z')
        end

        it 'preserves milliseconds and truncates finer precision for date-time' do
          time = Time.at(1_700_000_000, 123_456_789, :nanosecond)
          expect(described_class.serialize_timestamp(time, 'date-time')).to eq('2023-11-14T22:13:20.123Z')
        end

        it 'serializes http-date at whole-second precision' do
          time = Time.at(1_700_000_000, 123_456_789, :nanosecond)
          expect(described_class.serialize_timestamp(time, 'http-date')).to eq('Tue, 14 Nov 2023 22:13:20 GMT')
        end

        it 'raises for unsupported formats' do
          expect do
            described_class.serialize_timestamp(Time.at(1_700_000_000), 'unsupported')
          end.to raise_error(ArgumentError, 'unsupported timestamp format: "unsupported"')
        end
      end

      describe '.deserialize_timestamp' do
        it 'truncates fractional numeric timestamps to milliseconds' do
          timestamp = described_class.deserialize_timestamp(1_700_000_000.123456, 'epoch-seconds')
          expect(timestamp.nsec).to eq(123_000_000)
        end

        it 'truncates fractional string timestamps to milliseconds' do
          timestamp = described_class.deserialize_timestamp('2023-11-14T22:13:20.123456789Z', 'date-time')
          expect(timestamp.nsec).to eq(123_000_000)
        end

        it 'normalizes date-time offsets to UTC' do
          timestamp = described_class.deserialize_timestamp('2023-11-14T14:13:20.123-08:00', 'date-time')
          expect(timestamp).to eq(Time.utc(2023, 11, 14, 22, 13, 20, 123_000))
        end

        it 'rejects fractional http-date timestamps' do
          expect do
            described_class.deserialize_timestamp('Tue, 14 Nov 2023 22:13:20.123 GMT', 'http-date')
          end.to raise_error(
            ArgumentError,
            'unhandled http-date timestamp: "Tue, 14 Nov 2023 22:13:20.123 GMT"'
          )
        end

        it 'rejects timestamps outside the supported Smithy range' do
          expect do
            described_class.deserialize_timestamp(253_402_300_800, 'epoch-seconds')
          end.to raise_error(ArgumentError, 'unhandled epoch-seconds timestamp: 253402300800')
        end
      end
    end
  end
end
