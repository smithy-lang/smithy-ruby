# frozen_string_literal: true

module Hearth
  describe BlockIO do
    let(:data) { 'data' }

    let(:callback) do
      proc { |d| expect(d).to eq(data) }
    end

    subject { BlockIO.new(callback) }

    describe '#write' do
      it 'writes the data' do
        subject.write(data)
        expect(subject.bytes_yielded).to eq(data.bytesize)
      end

      it 'returns the bytesize written' do
        bytes = subject.write(data)
        expect(bytes).to eq data.bytesize
      end

      it 'increments the bytes_yielded field' do
        subject.write(data)
        subject.write(data)
        expect(subject.bytes_yielded).to eq(data.bytesize * 2)
      end
    end

    describe '#bytes_yielded' do
      it 'returns the bytes_yielded field' do
        expect(subject.bytes_yielded).to eq 0
      end
    end
  end
end
