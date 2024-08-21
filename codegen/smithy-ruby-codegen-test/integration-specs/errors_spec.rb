# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  module Errors
    describe ApiError do
      it 'inherits the base protocol api error' do
        error = ApiError.new(metadata: {},
                             error_code: 'error')
        expect(error).to be_a(Hearth::ApiError)
      end
    end

    describe ApiClientError do
      it 'inherits the base client api error' do
        error = ApiClientError.new(metadata: {},
                                   error_code: 'error')
        expect(error).to be_a(ApiError)
      end
    end

    describe ApiServerError do
      it 'inherits the base client api error' do
        error = ApiServerError.new(metadata: {},
                                   error_code: 'error')
        expect(error).to be_a(ApiError)
      end
    end

    describe ApiRedirectError do
      it 'inherits the base client api error' do
        error = ApiRedirectError.new(
          location: 'location',
          metadata: {},
          error_code: 'error'
        )
        expect(error).to be_a(ApiError)
      end

      it 'stores a location' do
        error = ApiRedirectError.new(
          location: 'location',
          error_code: 'error',
          metadata: {},
          message: 'error message'
        )
        expect(error.location).to eq('location')
      end
    end

    describe ClientError do
      it 'is retryable without throttling' do
        error = ClientError.new(data: nil, metadata: {},
                                error_code: 'error')
        expect(error.retryable?).to be true
        expect(error.throttling?).to be false
      end
    end

    describe ServerError do
      it 'is retryable with throttling' do
        error = ServerError.new(data: nil, metadata: {},
                                error_code: 'error')
        expect(error.retryable?).to be true
        expect(error.throttling?).to be true
      end
    end
  end
end
