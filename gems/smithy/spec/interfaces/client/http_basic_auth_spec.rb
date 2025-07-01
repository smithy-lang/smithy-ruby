# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: HttpBasicAuth' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'HttpBasicAuth', fixture: 'auth/http_basic_auth'

      it 'adds the http basic auth plugin' do
        expect(HttpBasicAuth::Client.plugins).to include(Smithy::Client::Plugins::HttpBasicAuth)
      end

      it 'adds the http basic auth scheme' do
        client = HttpBasicAuth::Client.new(stub_responses: true)
        expect(client.config.auth_schemes).to include('smithy.api#httpBasicAuth')
      end
    end
  end
end
