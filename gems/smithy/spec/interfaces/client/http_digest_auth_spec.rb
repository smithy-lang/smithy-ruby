# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: HttpDigestAuth' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'HttpDigestAuth', fixture: 'auth/http_digest_auth'

      let(:client) { HttpDigestAuth::Client.new(stub_responses: true) }

      it 'adds the http digest auth plugin' do
        expect(HttpDigestAuth::Client.plugins).to include(Smithy::Client::Plugins::HttpDigestAuth)
      end

      it 'adds the http digest auth scheme' do
        expect(client.config.auth_schemes).to include('smithy.api#httpDigestAuth')
      end
    end
  end
end
