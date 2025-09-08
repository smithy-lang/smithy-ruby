# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe ResolveAuth do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

        it 'adds an :auth_resolver option to config' do
          expect(client.config).to respond_to(:auth_resolver)
        end

        it 'adds scheme ids to auth scheme config hash' do
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(HttpBasicAuth)
          client_class.add_plugin(HttpBearerAuth)
          client_class.add_plugin(HttpDigestAuth)
          expect(client.config.auth_schemes['smithy.api#httpApiKeyAuth']).to be_a(HttpApiKeyProvider)
          expect(client.config.auth_schemes['smithy.api#httpBasicAuth']).to be_a(HttpLoginProvider)
          expect(client.config.auth_schemes['smithy.api#httpBearerAuth']).to be_a(HttpBearerProvider)
          expect(client.config.auth_schemes['smithy.api#httpDigestAuth']).to be_a(HttpLoginProvider)
        end

        it 'resolves auth for anonymous auth' do
          resp = client.operation
          expect(resp.context.auth[:scheme_id]).to equal('smithy.api#noAuth')
        end

        it 'resolves auth for http api key auth' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          resp = client.operation
          expect(resp.context.auth[:scheme_id]).to equal('smithy.api#httpApiKeyAuth')
          expect(resp.context.auth[:identity]).to be_a(Identities::ApiKey)
        end

        it 'resolves auth for http basic auth' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBasicAuth'] = {}
          client_class.add_plugin(HttpBasicAuth)
          resp = client.operation
          expect(resp.context.auth[:scheme_id]).to equal('smithy.api#httpBasicAuth')
          expect(resp.context.auth[:identity]).to be_a(Identities::HttpLogin)
        end

        it 'resolves auth for http bearer auth' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
          client_class.add_plugin(HttpBearerAuth)
          resp = client.operation
          expect(resp.context.auth[:scheme_id]).to equal('smithy.api#httpBearerAuth')
          expect(resp.context.auth[:identity]).to be_a(Identities::Token)
        end

        it 'resolves auth for http digest auth' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpDigestAuth'] = {}
          client_class.add_plugin(HttpDigestAuth)
          expect { client.operation }.to raise_error(NotImplementedError)
        end

        it 'resolves the first supported auth scheme' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#auth'] =
            %w[smithy.api#httpBasicAuth smithy.api#httpApiKeyAuth]
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBasicAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(HttpBasicAuth)
          resp = client.operation
          expect(resp.context.auth[:scheme_id]).to equal('smithy.api#httpBasicAuth')
          expect(resp.context.auth[:identity]).to be_a(Identities::HttpLogin)
        end

        it 'raises an error when no auth options were resolved' do
          client_class.add_plugin(HttpApiKeyAuth)
          auth_resolver = Class.new do
            def resolve(_)
              []
            end
          end
          client = client_class.new(stub_responses: true, auth_resolver: auth_resolver.new)
          expect { client.operation }.to raise_error(/No auth options were resolved/)
        end

        it 'raises an error when auth scheme is not enabled' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.remove_plugin(HttpApiKeyAuth)
          expect { client.operation }.to raise_error(/was not enabled/)
        end

        it 'raises an error when identity resolver is not configured' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client = client_class.new(stub_responses: true, http_api_key_provider: nil)
          expect { client.operation }.to raise_error(/did not have an identity resolver configured/)
        end

        it 'raises an error when identity resolver fails to resolve identity' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          provider = HttpApiKeyProvider.new('stubbed_key')
          expect(provider).to receive(:identity).and_return(nil)
          client = client_class.new(stub_responses: true, http_api_key_provider: provider)
          expect { client.operation }.to raise_error(/failed to resolve identity/)
        end
      end
    end
  end
end
