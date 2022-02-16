# frozen_string_literal: true

require 'spec_helper'

module WhiteLabel
  module Errors
    describe ApiError do
      it 'inherits the base protocol api error' do
        http_resp = Hearth::HTTP::Response.new
        error = ApiError.new(http_resp: http_resp, error_code: 'error')
        expect(error).to be_a(Hearth::HTTP::ApiError)
      end
    end

    describe ApiClientError do
      it 'inherits the base client api error' do
        http_resp = Hearth::HTTP::Response.new
        error = ApiClientError.new(http_resp: http_resp, error_code: 'error')
        expect(error).to be_a(ApiError)
      end
    end

    describe ApiServerError do
      it 'inherits the base client api error' do
        http_resp = Hearth::HTTP::Response.new
        error = ApiServerError.new(http_resp: http_resp, error_code: 'error')
        expect(error).to be_a(ApiError)
      end
    end

    describe ApiRedirectError do
      it 'inherits the base client api error' do
        http_resp = Hearth::HTTP::Response.new
        error = ApiRedirectError.new(location: nil, http_resp: http_resp, error_code: 'error')
        expect(error).to be_a(ApiError)
      end

      it 'stores a location' do
        http_resp = Hearth::HTTP::Response.new
        error = ApiRedirectError.new(
          http_resp: http_resp,
          location: 'location',
          error_code: 'error',
          message: 'error message'
        )
        expect(error.location).to eq('location')
      end
    end

    describe ClientError do
      it 'parses the data with a modeled message' do
        http_resp = Hearth::HTTP::Response.new(body: StringIO.new('error message'))
        data = Types::ClientError.new(message: 'error message')
        # don't test fakeProtocol parsers
        expect(Parsers::ClientError).to receive(:parse).with(http_resp).and_return(data)
        error = ClientError.new(http_resp: http_resp, error_code: 'error')
        expect(error.data).to eq(data)
        expect(error).to be_a(ApiClientError)
        expect(error.message).to eq('error message')
      end
    end

    describe ServerError do
      it 'parses the data without a modeled message' do
        http_resp = Hearth::HTTP::Response.new(body: StringIO.new('hidden error message'))
        data = Types::ServerError.new
        # don't test fakeProtocol parsers
        expect(Parsers::ServerError).to receive(:parse).with(http_resp).and_return(data)
        error = ServerError.new(http_resp: http_resp, error_code: 'error')
        expect(error.data).to eq(data)
        expect(error).to be_a(ApiServerError)
        expect(error.message).to eq("WhiteLabel::Errors::ServerError")
      end
    end
  end
end