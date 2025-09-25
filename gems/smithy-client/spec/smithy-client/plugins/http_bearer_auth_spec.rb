# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe HttpBearerAuth do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.add_plugin(HttpBearerAuth)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        it 'adds an :bearer_token option to config' do
          expect(client.config).to respond_to(:bearer_token)
        end

        it 'adds an :bearer_token_provider option to config' do
          expect(client.config).to respond_to(:bearer_token_provider)
        end

        it 'does not default a :bearer_token' do
          client = client_class.new
          expect(client.config.bearer_token).to be_nil
        end

        it 'does not default a :bearer_token_provider' do
          client = client_class.new
          expect(client.config.bearer_token_provider).to be_nil
        end

        it 'has a default :bearer_token when :stub_responses is true' do
          expect(client.config.bearer_token).to eq('stubbed-bearer-token')
        end

        it 'has a default :bearer_token_provider when :stub_responses is true' do
          provider = client.config.bearer_token_provider
          expect(provider).to be_a(BearerTokenProvider)
          expect(provider.identity.token).to eq('stubbed-bearer-token')
        end

        it 'defaults a :bearer_token_provider when :bearer_token is set' do
          client = client_class.new(bearer_token: 'bearer')
          provider = client.config.bearer_token_provider
          expect(provider).to be_a(BearerTokenProvider)
          expect(provider.identity.token).to eq('bearer')
        end

        context 'signing' do
          it 'signs in the header' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}

            response = client.operation
            expect(response.context.http_request.headers['Authorization'])
              .to eq("Bearer #{client.config.bearer_token}")
          end
        end
      end
    end
  end
end
