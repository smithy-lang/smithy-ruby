# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: HttpBasicAuth' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'HttpBasicAuth'

      let(:client) { HttpBasicAuth::Client.new(stub_responses: true) }

      it 'adds the http basic auth plugin' do
        expect(HttpBasicAuth::Client.plugins).to include(Smithy::Client::Plugins::HttpBasicAuth)
      end

      it 'adds the http basic auth scheme' do
        expect(client.config.auth_schemes).to include('smithy.api#httpBasicAuth')
      end

      it 'resolves http basic auth' do
        output = client.operation
        resolved_auth = output.context[:auth]
        expect(resolved_auth.scheme_id).to eq('smithy.api#httpBasicAuth')
      end

      it 'signs the request' do
        output = client.operation
        identity_string = "#{client.config.http_login_username}:#{client.config.http_login_password}"
        expect(output.context.request.headers['Authorization'])
          .to eq("Basic #{Base64.strict_encode64(identity_string)}")
      end
    end
  end
end
