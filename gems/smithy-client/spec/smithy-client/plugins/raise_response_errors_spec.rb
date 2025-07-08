# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe RaiseResponseErrors do
        let(:sample_client) { ClientHelper.sample_client }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

        it 'adds a :raise_response_errors option to config' do
          expect(client.config).to respond_to(:raise_response_errors)
        end

        it 'defaults :raise_response_errors to true' do
          expect(client.config.raise_response_errors).to be(true)
        end

        it 'does not add the handler if :raise_response_errors is false' do
          client = client_class.new(raise_response_errors: false)
          expect(client.handlers).not_to include(RaiseResponseErrors::Handler)
        end

        it 'adds the handler if :raise_response_errors is true' do
          expect(client.handlers).to include(RaiseResponseErrors::Handler)
        end

        it 'returns the response' do
          response = client.operation
          expect(response).to be_kind_of(Response)
        end

        it 'raises the response error when :raise_response_errors is true' do
          error = StandardError.new('msg')
          client.stub_responses(:operation, error)
          expect { client.operation }.to raise_error(error)
        end

        it 'puts the error on the response when :raise_response_errors is false' do
          error = StandardError.new('msg')
          client = client_class.new(raise_response_errors: false, stub_responses: true)
          client.stub_responses(:operation, error)
          response = client.operation
          expect(response.error).to be(error)
        end
      end
    end
  end
end
