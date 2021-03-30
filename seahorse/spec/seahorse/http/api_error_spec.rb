# frozen_string_literal: true

require 'seahorse/api_error'
require 'seahorse/http/api_error'
require 'seahorse/http/headers'
require 'seahorse/http/response'

module Seahorse
  module HTTP
    describe ApiError do
      let(:http_status_code) { 404 }
      let(:http_headers) do
        Headers.new(headers: { 'x-request-id' => request_id })
      end
      let(:request_id) { '123' }
      let(:http_body) { 'body' }

      let(:http_resp) do
        Response.new(
          status_code: http_status_code,
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

      it 'subclasses Seahorse::ApiError' do
        expect(subject).to be_a Seahorse::ApiError
      end

      it 'raises with the message' do
        expect { raise subject }.to raise_error(ApiError, message)
      end

      describe '#http_status_code' do
        it 'gets the http_status_code field' do
          expect(subject.http_status_code).to be http_status_code
        end
      end

      describe '#http_headers' do
        it 'gets the http_headers field' do
          expect(subject.http_headers).to be http_headers
        end
      end

      describe '#http_body' do
        it 'gets the http_body field' do
          expect(subject.http_body).to be http_body
        end
      end

      describe '#request_id' do
        it 'gets the request_id field' do
          expect(subject.request_id).to be request_id
        end
      end
    end
  end
end
