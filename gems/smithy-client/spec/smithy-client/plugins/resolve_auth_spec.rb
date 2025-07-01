# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/resolve_auth'

module Smithy
  module Client
    module Plugins
      describe ResolveAuth do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(AnonymousAuth)
          client_class.add_plugin(Protocol)
          client_class.add_plugin(ResolveAuth)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        it 'adds an :auth_resolver option to config' do
          expect(client.config).to respond_to(:auth_resolver)
        end

        it 'adds scheme ids to auth scheme hash' do
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(HttpBasicAuth)
          client_class.add_plugin(HttpBearerAuth)
          client_class.add_plugin(HttpDigestAuth)
          client
          expect(client.config.auth_schemes['smithy.api#noAuth']).to equal(:anonymous_provider)
          expect(client.config.auth_schemes['smithy.api#httpApiKeyAuth']).to equal(:http_api_key_provider)
          expect(client.config.auth_schemes['smithy.api#httpBasicAuth']).to equal(:http_login_provider)
          expect(client.config.auth_schemes['smithy.api#httpBearerAuth']).to equal(:http_bearer_provider)
          expect(client.config.auth_schemes['smithy.api#httpDigestAuth']).to equal(:http_login_provider)
        end

        context 'resolving auth' do
          it 'resolves auth for anonymous auth' do
            handler = ResolveAuth::Handler
            expect_any_instance_of(handler).to receive(:try_load_auth_scheme).and_wrap_original do |method, *args|
              resolved_auth = method.call(*args)
              expect(resolved_auth[:scheme_id]).to equal('smithy.api#noAuth')
              expect(resolved_auth[:identity]).to be_a(Identities::Anonymous)
              resolved_auth
            end
            client.operation
          end

          it 'resolves auth for http api key auth' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
            client_class.add_plugin(HttpApiKeyAuth)
            handler = ResolveAuth::Handler
            expect_any_instance_of(handler).to receive(:try_load_auth_scheme).and_wrap_original do |method, *args|
              resolved_auth = method.call(*args)
              expect(resolved_auth[:scheme_id]).to equal('smithy.api#httpApiKeyAuth')
              expect(resolved_auth[:identity]).to be_a(Identities::HttpApiKey)
              resolved_auth
            end
            client.operation
          end

          it 'resolves auth for http basic auth' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBasicAuth'] = {}
            client_class.add_plugin(HttpBasicAuth)
            handler = ResolveAuth::Handler
            expect_any_instance_of(handler).to receive(:try_load_auth_scheme).and_wrap_original do |method, *args|
              resolved_auth = method.call(*args)
              expect(resolved_auth[:scheme_id]).to equal('smithy.api#httpBasicAuth')
              expect(resolved_auth[:identity]).to be_a(Identities::HttpLogin)
              resolved_auth
            end
            client.operation
          end

          it 'resolves auth for http bearer auth' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
            client_class.add_plugin(HttpBearerAuth)
            handler = ResolveAuth::Handler
            expect_any_instance_of(handler).to receive(:try_load_auth_scheme).and_wrap_original do |method, *args|
              resolved_auth = method.call(*args)
              expect(resolved_auth[:scheme_id]).to equal('smithy.api#httpBearerAuth')
              expect(resolved_auth[:identity]).to be_a(Identities::HttpBearer)
              resolved_auth
            end
            client.operation
          end

          it 'resolves auth for http digest auth' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpDigestAuth'] = {}
            client_class.add_plugin(HttpDigestAuth)
            handler = ResolveAuth::Handler
            expect_any_instance_of(handler).to receive(:try_load_auth_scheme).and_wrap_original do |method, *args|
              resolved_auth = method.call(*args)
              expect(resolved_auth[:scheme_id]).to equal('smithy.api#httpDigestAuth')
              expect(resolved_auth[:identity]).to be_a(Identities::HttpLogin)
              resolved_auth
            end
            expect { client.operation }.to raise_error(NotImplementedError)
          end

          it 'resolves the first supported auth scheme' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBasicAuth'] = {}
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
            # Skip adding HttpApiKeyAuth plugin to mimic unsupported auth
            client_class.add_plugin(HttpBasicAuth)
            client_class.add_plugin(HttpBearerAuth)
            handler = ResolveAuth::Handler
            expect_any_instance_of(handler).to receive(:try_load_auth_scheme).and_wrap_original do |method, *args|
              resolved_auth = method.call(*args)
              expect(resolved_auth[:scheme_id]).to equal('smithy.api#httpBasicAuth')
              expect(resolved_auth[:identity]).to be_a(Identities::HttpLogin)
              resolved_auth
            end
            client.operation
          end
        end

        context 'errors' do
          it 'raises an error when no auth options were resolved' do
            client_class.add_plugin(HttpApiKeyAuth)
            handler = ResolveAuth::Handler
            expect_any_instance_of(handler).to receive(:resolve_auth).and_wrap_original do |method, *args|
              args[1] = []
              method.call(*args)
            end
            expect { client.operation }.to raise_error(/No auth options were resolved/)
          end

          it 'raises an error when auth scheme is not enabled' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
            # Skip adding HttpApiKeyAuth plugin to disable auth type
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
end
