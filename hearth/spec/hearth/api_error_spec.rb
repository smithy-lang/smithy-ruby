# frozen_string_literal: true

module Hearth
  describe ApiError do
    let(:error_code) { 'error_code' }
    let(:message) { 'message' }

    subject do
      ApiError.new(
        error_code: error_code,
        message: message
      )
    end

    it 'subclasses StandardError' do
      expect(subject).to be_a StandardError
    end

    it 'raises with the message' do
      expect { raise subject }.to raise_error(ApiError, message)
    end
  end
end
