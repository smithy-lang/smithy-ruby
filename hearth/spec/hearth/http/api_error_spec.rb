# frozen_string_literal: true

module Hearth
  module HTTP
    describe ApiError do
      let(:http_status) { 404 }
      let(:http_fields) { Fields.new }
      let(:http_body) { 'body' }
      let(:http_resp) do
        Response.new(
          status: http_status,
          fields: http_fields,
          body: http_body
        )
      end
      let(:message) { 'message' }

      subject do
        ApiError.new(
          http_resp: http_resp,
          error_code: 'error_code',
          metadata: {},
          message: message
        )
      end

      it 'subclasses Hearth::ApiError' do
        expect(subject).to be_a Hearth::ApiError
      end

      describe '#http_status' do
        it 'returns the http status' do
          expect(subject.http_status).to eq(http_status)
        end
      end

      describe '#http_fields' do
        it 'returns the http fields' do
          expect(subject.http_fields).to eq(http_fields)
        end
      end

      describe '#http_body' do
        it 'returns the http body' do
          expect(subject.http_body).to eq(http_body)
        end
      end
    end
  end
end
