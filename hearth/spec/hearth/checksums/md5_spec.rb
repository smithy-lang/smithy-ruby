# frozen_string_literal: true

module Hearth
  module Checksums
    describe MD5 do
      ZERO_DIGEST = '1B2M2Y8AsgTpgAmY7PhCfg=='

      describe '#digest_length' do
        it 'returns the digest_length' do
          expect(subject.digest_length).to eq(16)
        end
      end

      describe '#block_length' do
        it 'returns the block_length' do
          expect(subject.block_length).to eq(64)
        end
      end

      describe '#base64digest' do
        it 'returns the zero digest' do
          expect(subject.base64digest).to eq(ZERO_DIGEST)
        end
      end

      describe '#update' do
        it 'updates the digest' do
          subject.update('chunk1')
          expect(subject.base64digest).to eq('jBWb++B+TOnlxhI+/CwtyA==')
        end
      end

      describe '#reset' do
        it 'resets the digest' do
          subject.update('chunk1')
          subject.reset
          expect(subject.base64digest).to eq(ZERO_DIGEST)
        end
      end
    end
  end
end
