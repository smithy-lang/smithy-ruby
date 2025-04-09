# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/http_api_key_auth'

module Smithy
  module Client
    module Plugins
      describe HttpApiKeyAuth do
        let(:sample_client) { ClientHelper.sample_client }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(sample_client::Plugins::Auth)
          client_class.add_plugin(AnonymousAuth)
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new }

        it 'adds an :http_api_key option to config' do
          expect(client.config).to respond_to(:http_api_key)
        end

        it 'adds an :http_api_key_provider option to config' do
          expect(client.config).to respond_to(:http_api_key_provider)
        end

        it 'does not default a :http_api_key' do
          expect(client.config.http_api_key).to be_nil
        end

        it 'does not default a :http_api_key_provider' do
          expect(client.config.http_api_key_provider).to be_nil
        end

        it 'has a default :http_api_key when :stub_responses is true' do
          client = client_class.new(stub_responses: true)
          expect(client.config.http_api_key).to eq('stubbed-api-key')
        end

        it 'has a default :http_api_key_provider when :stub_responses is true' do
          client = client_class.new(stub_responses: true)
          provider = client.config.http_api_key_provider
          expect(provider).to be_a(HttpApiKeyProvider)
          expect(provider.identity({}).key).to eq('stubbed-api-key')
        end

        it 'defaults a :http_api_key_provider when :http_api_key is set' do
          client = client_class.new(http_api_key: 'api-key')
          provider = client.config.http_api_key_provider
          expect(provider).to be_a(HttpApiKeyProvider)
          expect(provider.identity({}).key).to eq('api-key')
        end
      end
    end
  end
end
