# frozen_string_literal: true

module Hearth
  module HTTP
    describe Headers do
      let(:header1) { 'test-header' }
      let(:header1_normalized) { 'Test-Header' }
      let(:value1) { 'test header value' }

      let(:header2) { 'X-thing-Mixed' }
      let(:header2_normalized) { 'X-Thing-Mixed' }
      let(:value2) { 'mixed value' }

      let(:headers_hash) { { header1 => value1, header2 => value2 } }

      subject { Headers.new(headers_hash) }

      describe '#initialize' do
        it 'sets and normalizes the headers' do
          expect(subject.size).to eq(headers_hash.size)
          expect(subject.keys)
            .to include(header1_normalized, header2_normalized)
        end
      end

      describe '#[]' do
        it 'normalizes the key' do
          expect(subject[header1]).to eq(value1)
          expect(subject[header1_normalized]).to eq(value1)
        end
      end

      describe '#[]=' do
        let(:new_value) { 'new value' }
        let(:integer_value) { 1 }

        it 'normalizes the key and sets the value' do
          subject[header1] = new_value
          expect(subject[header1_normalized]).to eq(new_value)
        end

        it 'converts values to string' do
          subject[header1] = integer_value
          expect(subject[header1]).to eq(integer_value.to_s)
        end
      end

      describe '#key?' do
        it 'normalizes the key' do
          expect(subject.key?(header1)).to be(true)
        end

        it 'returns false when the key does not exist' do
          expect(subject.key?('not-found')).to be(false)
        end
      end

      describe '#delete' do
        it 'deletes the normalized key' do
          subject.delete(header1)
          expect(subject.keys).not_to include(header1_normalized)
        end
      end

      describe '#each' do
        it 'enumerates over its contents' do
          subject.each { |k, v| expect(subject[k]).to eq(v) }
        end
      end

      describe '#size' do
        it 'returns the size' do
          expect(subject.size).to eq(headers_hash.size)
        end
      end

      describe '#update' do
        it 'accepts a hash, updating self' do
          subject.update(:abc => 123, 'xyz' => '234', header2 => 'new')
          expect(subject['abc']).to eq('123')
          expect(subject['xyz']).to eq('234')
          expect(subject[header1]).to eq(value1)
          expect(subject[header2]).to eq('new')
        end
      end

      describe '#clear' do
        it 'clears the headers' do
          subject.clear
          expect(subject.size).to eq(0)
        end
      end
    end
  end
end
