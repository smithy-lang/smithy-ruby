# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/http_bearer_auth'

module Smithy
  module Client
    module Plugins
      describe HTTPBearerAuth do
        let(:sample_service) { ClientHelper.sample_service }

        let(:client_class) do
          client_class = sample_service.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(HTTPBearerAuth)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new }

        it 'adds an :http_bearer_token option to config' do
          expect(client.config).to respond_to(:http_bearer_token)
        end

        it 'adds an :http_bearer_token_provider option to config' do
          expect(client.config).to respond_to(:http_bearer_token_provider)
        end

        it 'does not default a :http_bearer_token' do
          expect(client.config.http_bearer_token).to be_nil
        end

        it 'has a default :http_bearer_token when :stub_responses is true' do
          client = client_class.new(stub_responses: true)
          expect(client.config.http_bearer_token).to eq('stubbed-bearer-token')
        end

        it 'does not default a :http_bearer_token_provider' do
          expect(client.config.http_bearer_token_provider).to be_nil
        end

        it 'defaults a :http_bearer_token_provider when :http_bearer_token is set' do
          client = client_class.new(http_bearer_token: 'bearer')
          provider = client.config.http_bearer_token_provider
          expect(provider).to be_a(IdentityProvider)
          expect(provider.identity({}).token).to eq('bearer')
        end

        it 'defaults a :http_bearer_token_provider when :stub_responses is true' do
          client = client_class.new(stub_responses: true)
          provider = client.config.http_bearer_token_provider
          expect(provider).to be_a(IdentityProvider)
          expect(provider.identity({}).token).to eq('stubbed-bearer-token')
        end
      end
    end
  end
end
