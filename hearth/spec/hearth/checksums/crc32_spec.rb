# frozen_string_literal: true

module Hearth
  module Checksums
    describe CRC32 do
      let(:zero_digest) { 'AAAAAA==' }

      describe '#digest_length' do
        it 'returns the digest_length' do
          expect(subject.digest_length).to eq(32)
        end
      end

      describe '#base64digest' do
        it 'returns the zero digest' do
          expect(subject.base64digest).to eq(zero_digest)
        end
      end

      describe '#update' do
        it 'updates the digest' do
          subject.update('chunk1')
          expect(subject.base64digest).to eq('X5/kCQ==')
        end
      end

      describe '#reset' do
        it 'resets the digest' do
          subject.update('chunk1')
          subject.reset
          expect(subject.base64digest).to eq(zero_digest)
        end
      end
    end
  end
end
