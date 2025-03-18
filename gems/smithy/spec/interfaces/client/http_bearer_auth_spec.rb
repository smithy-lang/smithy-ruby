# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: HttpBearerAuth' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'HttpBearerAuth'

      let(:client) { HttpBearerAuth::Client.new(stub_responses: true) }

      it 'adds the http bearer auth plugin' do
        expect(HttpBearerAuth::Client.plugins).to include(Smithy::Client::Plugins::HttpBearerAuth)
      end

      it 'adds the http bearer auth scheme' do
        expect(client.config.auth_schemes).to include('smithy.api#httpBearerAuth')
      end

      it 'resolves http bearer auth' do
        output = client.operation
        resolved_auth = output.context[:auth]
        expect(resolved_auth.scheme_id).to eq('smithy.api#httpBearerAuth')
      end
    end
  end
end
