require 'seahorse/api_error'

module Seahorse
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

    describe '#error_code' do
      it 'gets the error_code field' do
        expect(subject.error_code).to be error_code
      end
    end
  end
end
