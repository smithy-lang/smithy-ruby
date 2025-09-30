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

        it 'adds an :auth_scheme_preference option to config' do
          expect(client.config).to respond_to(:auth_scheme_preference)
        end

        it 'adds auth schemes to the auth scheme config hash' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBasicAuth'] = {}
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpDigestAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(HttpBasicAuth)
          client_class.add_plugin(HttpBearerAuth)
          client_class.add_plugin(HttpDigestAuth)
          expect(client.config.auth_schemes.values).to all be_a(AuthScheme)
          expect(client.config.auth_schemes.size).to eq(4)
          expect(client.config.auth_schemes).to have_key('smithy.api#httpApiKeyAuth')
          expect(client.config.auth_schemes).to have_key('smithy.api#httpBasicAuth')
          expect(client.config.auth_schemes).to have_key('smithy.api#httpBearerAuth')
          expect(client.config.auth_schemes).to have_key('smithy.api#httpDigestAuth')
        end

        it 'supports anonymous auth' do
          resp = client.operation
          expect(resp.context.auth).to be_a(Auth::ResolvedAuth)
          expect(resp.context.auth.scheme_id).to eq('smithy.api#noAuth')
        end

        it 'supports http api key auth' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          resp = client.operation
          expect(resp.context.auth).to be_a(Auth::ResolvedAuth)
          expect(resp.context.auth.scheme_id).to eq('smithy.api#httpApiKeyAuth')
        end

        it 'supports http basic auth' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBasicAuth'] = {}
          client_class.add_plugin(HttpBasicAuth)
          resp = client.operation
          expect(resp.context.auth).to be_a(Auth::ResolvedAuth)
          expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBasicAuth')
        end

        it 'supports http bearer auth' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
          client_class.add_plugin(HttpBearerAuth)
          resp = client.operation
          expect(resp.context.auth).to be_a(Auth::ResolvedAuth)
          expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
        end

        it 'resolves the first supported auth scheme' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#auth'] =
            %w[smithy.api#httpBearerAuth smithy.api#httpApiKeyAuth]
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(HttpBearerAuth)
          resp = client.operation
          expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
        end

        it 'resolves the first supported auth scheme with an identity provider configured' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#auth'] =
            %w[smithy.api#httpBearerAuth smithy.api#httpApiKeyAuth]
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(HttpBearerAuth)
          client = client_class.new(stub_responses: true, bearer_token_provider: nil)
          resp = client.operation
          expect(resp.context.auth.scheme_id).to eq('smithy.api#httpApiKeyAuth')
        end

        it 'resolves the first supported auth scheme with a resolved identity' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#auth'] =
            %w[smithy.api#httpBearerAuth smithy.api#httpApiKeyAuth]
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBearerAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client_class.add_plugin(HttpBearerAuth)
          client = client_class.new(stub_responses: true, bearer_token_provider: BearerTokenProvider.new)
          resp = client.operation
          expect(resp.context.auth.scheme_id).to eq('smithy.api#httpApiKeyAuth')
        end

        it 'forwards signer properties from auth options' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          auth_resolver = Class.new do
            def resolve(_)
              [
                {
                  scheme_id: 'smithy.api#httpApiKeyAuth',
                  signer_properties: { 'location' => 'query', 'name' => 'api_key' }
                }
              ]
            end
          end
          client = client_class.new(stub_responses: true, auth_resolver: auth_resolver.new)
          resp = client.operation
          expect(resp.context.auth.scheme_id).to eq('smithy.api#httpApiKeyAuth')
          expect(resp.context.auth.signer_properties).to eq('location' => 'query', 'name' => 'api_key')
        end

        it 'raises an error when no auth options were resolved' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
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
          expect { client.operation }.to raise_error(/was not enabled for this request/)
        end

        it 'raises an error when identity provider is not configured' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client = client_class.new(stub_responses: true, api_key_provider: nil)
          expect { client.operation }.to raise_error(/did not have an identity provider configured/)
        end

        it 'raises an error when identity provider fails to resolve identity' do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
          client_class.add_plugin(HttpApiKeyAuth)
          client = client_class.new(stub_responses: true, api_key_provider: ApiKeyProvider.new)
          expect { client.operation }.to raise_error(/failed to resolve identity/)
        end

        context 'with auth scheme preference' do
          before do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#auth'] =
              %w[smithy.api#httpApiKeyAuth smithy.api#httpBasicAuth]
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpBasicAuth'] = {}
            client_class.add_plugin(HttpApiKeyAuth)
            client_class.add_plugin(HttpBasicAuth)
          end

          it 'uses the preferred auth scheme when multiple schemes are supported' do
            client = client_class.new(
              stub_responses: true,
              auth_scheme_preference: ['smithy.api#httpBasicAuth']
            )
            resp = client.operation
            expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBasicAuth')
          end

          it 'ignores unsupported preferred auth schemes' do
            client = client_class.new(
              stub_responses: true,
              auth_scheme_preference: ['smithy.api#httpDigestAuth', 'smithy.api#httpBasicAuth']
            )
            resp = client.operation
            expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBasicAuth')
          end

          it 'falls back to modeled order when no preferred auth schemes are supported' do
            client = client_class.new(
              stub_responses: true,
              auth_scheme_preference: ['smithy.api#httpDigestAuth']
            )
            resp = client.operation
            expect(resp.context.auth.scheme_id).to eq('smithy.api#httpApiKeyAuth')
          end
        end

        context 'endpoint auth schemes' do
          def endpoint_rules(auth_schemes = [])
            {
              'version' => '1.0',
              'parameters' => {
                'endpoint' => {
                  'type' => 'string',
                  'builtIn' => 'SDK::Endpoint',
                  'documentation' => 'Endpoint used for making requests. Should be formatted as a URI.'
                }
              },
              'rules' => [
                {
                  'conditions' => [{ 'fn' => 'isSet', 'argv' => [{ 'ref' => 'endpoint' }] }],
                  'endpoint' => {
                    'url' => { 'ref' => 'endpoint' },
                    'properties' => {
                      'authSchemes' => auth_schemes
                    }
                  },
                  'type' => 'endpoint'
                },
                {
                  'conditions' => [],
                  'error' => 'Endpoint is not set - you must configure an endpoint.',
                  'type' => 'error'
                }
              ]
            }
          end

          it 'uses endpoint auth schemes instead of modeled auth' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.rules#endpointRuleSet'] =
              endpoint_rules([{ 'name' => 'bearer' }])
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#auth'] = %w[smithy.api#httpApiKeyAuth]
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpApiKeyAuth'] = {}
            client_class.add_plugin(HttpApiKeyAuth)
            client_class.add_plugin(HttpBearerAuth) # to register the endpoint auth scheme
            client = client_class.new(stub_responses: true)
            resp = client.operation
            expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
          end

          it 'selects the first supported endpoint auth scheme' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.rules#endpointRuleSet'] =
              endpoint_rules([{ 'name' => 'other' }, { 'name' => 'bearer' }])
            client_class.add_plugin(HttpBearerAuth) # to register the endpoint auth scheme
            client = client_class.new(stub_responses: true)
            resp = client.operation
            expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
          end

          it 'forwards additional auth scheme properties from the endpoint' do
            shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.rules#endpointRuleSet'] =
              endpoint_rules([{ 'name' => 'bearer', 'foo' => 'bar' }])
            client_class.add_plugin(HttpBearerAuth) # to register the endpoint auth scheme
            client = client_class.new(stub_responses: true)
            resp = client.operation
            expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
            expect(resp.context.auth.signer_properties).to eq('foo' => 'bar')
          end

          context 'with auth scheme preference' do
            it 'uses the preference list to prioritize endpoint auth schemes' do
              shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.rules#endpointRuleSet'] =
                endpoint_rules([{ 'name' => 'other' }, { 'name' => 'bearer' }])
              client_class.add_plugin(HttpBearerAuth) # to register the endpoint auth scheme
              client = client_class.new(
                stub_responses: true,
                auth_scheme_preference: ['smithy.api#noAuth', 'smithy.api#httpBearerAuth']
              )
              resp = client.operation
              expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
            end

            it 'ignores unsupported preferred auth schemes' do
              shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.rules#endpointRuleSet'] =
                endpoint_rules([{ 'name' => 'other' }, { 'name' => 'bearer' }])
              client_class.add_plugin(HttpBearerAuth) # to register the endpoint auth scheme
              client = client_class.new(
                stub_responses: true,
                auth_scheme_preference: ['smithy.api#httpDigestAuth', 'smithy.api#httpBearerAuth']
              )
              resp = client.operation
              expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
            end

            it 'falls back to endpoint auth scheme order when no preferred auth schemes are supported' do
              shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.rules#endpointRuleSet'] =
                endpoint_rules([{ 'name' => 'bearer' }])
              client_class.add_plugin(HttpBearerAuth) # to register the endpoint auth scheme
              client = client_class.new(
                stub_responses: true,
                auth_scheme_preference: ['smithy.api#httpDigestAuth']
              )
              resp = client.operation
              expect(resp.context.auth.scheme_id).to eq('smithy.api#httpBearerAuth')
            end
          end
        end
      end
    end
  end
end
