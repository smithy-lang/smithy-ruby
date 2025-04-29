# frozen_string_literal: true

require_relative '../spec_helper'
require 'time'

module Smithy
  module Schema
    describe TimeHelper do
      describe '#time' do
        let(:time) { Time.utc(2002, 10, 31) }

        it 'returns as http-date format' do
          expect(subject.time(time, 'http-date')).to eq('Thu, 31 Oct 2002 00:00:00 GMT')
        end

        it 'returns as date-time format' do
          expect(subject.time(time, 'date-time')).to eq('2002-10-31T00:00:00Z')
        end

        it 'returns as epoch-seconds format' do
          expect(subject.time(time, 'epoch-seconds')).to eq(1_036_022_400)
        end

        it 'raises when given time is invalid ' do
          expect { subject.time('time', 'http-date') }.to raise_error(ArgumentError)
        end

        it 'raises when given timestamp trait is unhandled' do
          expect { subject.time(time, 'foo') }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
