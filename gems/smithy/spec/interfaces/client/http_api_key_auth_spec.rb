# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: HttpApiKeyAuth' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'HttpApiKeyAuth', fixture: 'auth/http_api_key_auth'

      it 'adds the http api key auth plugin' do
        expect(HttpApiKeyAuth::Client.plugins).to include(Smithy::Client::Plugins::HttpApiKeyAuth)
      end

      it 'adds the http api key auth scheme' do
        client = HttpApiKeyAuth::Client.new(stub_responses: true)
        expect(client.config.auth_schemes).to include('smithy.api#httpApiKeyAuth')
      end
    end
  end
end
