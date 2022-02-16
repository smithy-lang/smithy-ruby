# frozen_string_literal: true

module Hearth
  module HTTP
    describe ApiError do
      let(:http_status) { 404 }
      let(:http_headers) do
        Headers.new(headers: { 'x-request-id' => request_id })
      end
      let(:request_id) { '123' }
      let(:http_body) { 'body' }

      let(:http_resp) do
        Response.new(
          status: http_status,
          headers: http_headers,
          body: http_body
        )
      end
      let(:error_code) { 'error_code' }
      let(:message) { 'message' }

      subject do
        ApiError.new(
          http_resp: http_resp,
          error_code: error_code,
          message: message
        )
      end

      it 'subclasses Hearth::ApiError' do
        expect(subject).to be_a Hearth::ApiError
      end

      it 'raises with the message' do
        expect { raise subject }.to raise_error(ApiError, message)
      end
    end
  end
end
