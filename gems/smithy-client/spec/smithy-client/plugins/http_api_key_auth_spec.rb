# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe HttpApiKeyAuth do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.add_plugin(HttpApiKeyAuth)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true, endpoint: 'https://example.com') }

        before do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
        end

        it 'adds an :api_key option to config' do
          expect(client.config).to respond_to(:api_key)
        end

        it 'adds an :api_key_provider option to config' do
          expect(client.config).to respond_to(:api_key_provider)
        end

        it 'does not default a :api_key' do
          client = client_class.new
          expect(client.config.api_key).to be_nil
        end

        it 'does not default a :api_key_provider' do
          client = client_class.new
          expect(client.config.api_key_provider).to be_nil
        end

        it 'has a default :api_key when :stub_responses is true' do
          expect(client.config.api_key).to eq('stubbed-api-key')
        end

        it 'has a default :api_key_provider when :stub_responses is true' do
          provider = client.config.api_key_provider
          expect(provider).to be_a(ApiKeyProvider)
          expect(provider.identity.key).to eq('stubbed-api-key')
        end

        it 'defaults a :api_key_provider when :api_key is set' do
          client = client_class.new(api_key: 'api-key')
          provider = client.config.api_key_provider
          expect(provider).to be_a(ApiKeyProvider)
          expect(provider.identity.key).to eq('api-key')
        end

        context 'signing' do
          it 'signs in the header' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {
              'name' => 'x-api-key', 'in' => 'header'
            }

            response = client.operation
            expect(response.context.http_request.headers['x-api-key']).to eq('stubbed-api-key')
          end

          it 'signs in the header with a custom scheme' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {
              'name' => 'x-api-key', 'in' => 'header', 'scheme' => 'ApiKey'
            }

            response = client.operation
            expect(response.context.http_request.headers['x-api-key']).to eq('ApiKey stubbed-api-key')
          end

          it 'can sign on the query string' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {
              'name' => 'x-api-key', 'in' => 'query'
            }

            response = client.operation
            expect(response.context.http_request.endpoint.query).to include('x-api-key=stubbed-api-key')
          end
        end
      end
    end
  end
end
