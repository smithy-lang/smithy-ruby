# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/http_bearer_auth'

module Smithy
  module Client
    module Plugins
      describe HttpBearerAuth do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Auth)
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(AnonymousAuth)
          client_class.add_plugin(HttpBearerAuth)
          client_class.add_plugin(Protocol)
          client_class.add_plugin(SignRequests)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        it 'adds an :http_bearer_token option to config' do
          expect(client.config).to respond_to(:http_bearer_token)
        end

        it 'adds an :http_bearer_provider option to config' do
          expect(client.config).to respond_to(:http_bearer_provider)
        end

        it 'does not default a :http_bearer_token' do
          client = client_class.new
          expect(client.config.http_bearer_token).to be_nil
        end

        it 'does not default a :http_bearer_provider' do
          client = client_class.new
          expect(client.config.http_bearer_provider).to be_nil
        end

        it 'has a default :http_bearer_token when :stub_responses is true' do
          expect(client.config.http_bearer_token).to eq('stubbed-bearer-token')
        end

        it 'has a default :http_bearer_provider when :stub_responses is true' do
          provider = client.config.http_bearer_provider
          expect(provider).to be_a(HttpBearerProvider)
          expect(provider.identity.token).to eq('stubbed-bearer-token')
        end

        it 'defaults a :http_bearer_provider when :http_bearer_token is set' do
          client = client_class.new(http_bearer_token: 'bearer')
          provider = client.config.http_bearer_provider
          expect(provider).to be_a(HttpBearerProvider)
          expect(provider.identity.token).to eq('bearer')
        end

        context 'signing' do
          it 'signs in the header' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}

            output = client.operation
            expect(output.context.http_request.headers['Authorization'])
              .to eq("Bearer #{client.config.http_bearer_token}")
          end
        end
      end
    end
  end
end
