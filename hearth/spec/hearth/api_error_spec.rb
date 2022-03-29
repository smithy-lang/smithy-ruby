# frozen_string_literal: true

module Hearth
  describe ApiError do
    let(:error_code) { 'error_code' }
    let(:metadata) { { key: 'value' } }
    let(:message) { 'message' }

    subject do
      ApiError.new(
        error_code: error_code,
        metadata: metadata,
        message: message
      )
    end

    it 'subclasses StandardError' do
      expect(subject).to be_a StandardError
    end

    it 'raises with the message' do
      expect { raise subject }.to raise_error(ApiError, message)
    end

    describe '#error_code' do
      it 'returns the error code' do
        expect(subject.error_code).to eq(error_code)
      end
    end

    describe '#metadata' do
      it 'returns the metadata' do
        expect(subject.metadata).to eq(metadata)
      end
    end
  end
end
