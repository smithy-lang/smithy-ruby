# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: HttpApiKeyAuth' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'HttpApiKeyAuth', fixture: 'auth/http_api_key_auth'

      let(:client) { HttpApiKeyAuth::Client.new(stub_responses: true) }

      it 'adds the http api key auth plugin' do
        expect(HttpApiKeyAuth::Client.plugins).to include(Smithy::Client::Plugins::HttpApiKeyAuth)
      end

      it 'adds the http api key auth scheme' do
        expect(client.config.auth_schemes).to include('smithy.api#httpApiKeyAuth')
      end

      it 'resolves http api key auth' do
        output = client.operation
        resolved_auth = output.context[:auth]
        expect(resolved_auth.scheme_id).to eq('smithy.api#httpApiKeyAuth')
      end

      context 'query string' do
        include_context context, 'HttpApiKeyAuthQuery', fixture: 'auth/http_api_key_auth_query'

        let(:client) { HttpApiKeyAuthQuery::Client.new(stub_responses: true) }

        it 'signs the request' do
          output = client.operation
          expect(output.context.request.endpoint.query).to include('x-api-key=stubbed-api-key')
        end
      end

      context 'header' do
        include_context context, 'HttpApiKeyAuthHeader', fixture: 'auth/http_api_key_auth_header'

        let(:client) { HttpApiKeyAuthHeader::Client.new(stub_responses: true) }

        it 'signs the request' do
          output = client.operation
          expect(output.context.request.headers['x-api-key']).to eq('ApiKey stubbed-api-key')
        end
      end
    end
  end
end
