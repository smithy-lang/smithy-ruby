# frozen_string_literal: true

module Seahorse
  describe TimeHelper do
    let(:time) { Time.utc(1970, 1, 1) }

    describe '.to_date_time' do
      it 'converts a time object to date time format' do
        expect(subject.to_date_time(time)).to eq '1970-01-01T00:00:00.000Z'
      end
    end

    describe '.to_epoch_seconds' do
      it 'converts a time object to epoch seconds format' do
        expect(subject.to_epoch_seconds(time)).to eq 0.0
      end
    end

    describe '.to_http_date' do
      it 'converts a time object to http date format' do
        expect(subject.to_http_date(time)).to eq 'Thu, 01 Jan 1970 00:00:00 GMT'
      end
    end
  end
end
