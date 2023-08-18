# frozen_string_literal: true

module Hearth
  module Middleware
    describe Auth do
      let(:app) { double('app', call: output) }
      let(:auth_resolver) { double('auth_resolver') }
      let(:auth_params) { double('auth_params') }

      let(:http_api_key_auth_scheme) { AuthSchemes::HTTPApiKey.new }
      let(:http_bearer_auth_scheme) { AuthSchemes::HTTPBearer.new }
      let(:http_basic_auth_scheme) { AuthSchemes::HTTPBasic.new }
      let(:anonymous_auth_scheme) { AuthSchemes::Anonymous.new }

      let(:auth_schemes) do
        [
          http_api_key_auth_scheme,
          http_bearer_auth_scheme,
          http_basic_auth_scheme
        ]
      end

      let(:anonymous_auth_option) do
        AuthOption.new(scheme_id: anonymous_auth_scheme.scheme_id)
      end

      let(:http_basic_auth_option) do
        AuthOption.new(scheme_id: http_basic_auth_scheme.scheme_id)
      end

      let(:auth_options) do
        [
          AuthOption.new(scheme_id: http_bearer_auth_scheme.scheme_id),
          AuthOption.new(scheme_id: http_api_key_auth_scheme.scheme_id),
          anonymous_auth_option
        ]
      end

      let(:identity_resolvers) do
        {
          http_api_key_identity_resolver:
            double('http_api_key_identity_resolver'),
          http_bearer_identity_resolver: http_bearer_identity_resolver,
          http_login_identity_resolver:
            double('http_login_identity_resolver')
        }
      end

      let(:http_bearer_identity_resolver) do
        double('http_bearer_identity_resolver')
      end

      let(:anonymous_identity_resolver) do
        double('anonymous_identity_resolver')
      end

      subject do
        Auth.new(
          app,
          auth_resolver: auth_resolver,
          auth_params: auth_params,
          auth_schemes: auth_schemes,
          **identity_resolvers
        )
      end

      before do
        expect(IdentityResolver).to receive(:new)
          .and_return(anonymous_identity_resolver)
      end

      describe '#initialize' do
        it 'converts auth schemes to a hash for lookup' do
          schemes = subject.instance_variable_get(:@auth_schemes)
          expect(schemes).to be_a(Hash)
          expect(schemes.keys).to eq(auth_schemes.map(&:scheme_id))
          expect(schemes.values).to eq(auth_schemes)
        end

        it 'converts identity resolvers to a hash for lookup' do
          resolvers = subject.instance_variable_get(:@identity_resolvers)
          expect(resolvers).to be_a(Hash)
          expect(resolvers.keys).to eq [
            Identities::Anonymous,
            Identities::HTTPApiKey,
            Identities::HTTPBearer,
            Identities::HTTPLogin
          ]
          expect(resolvers.values).to eq [
            anonymous_identity_resolver,
            identity_resolvers[:http_api_key_identity_resolver],
            identity_resolvers[:http_bearer_identity_resolver],
            identity_resolvers[:http_login_identity_resolver]
          ]
        end

        it 'ignores keys that do not end with _identity_resolver' do
          auth = Auth.new(
            app,
            auth_resolver: auth_resolver,
            auth_params: auth_params,
            auth_schemes: auth_schemes,
            some_kwarg: double('some_kwarg')
          )
          resolvers = auth.instance_variable_get(:@identity_resolvers)
          expect(resolvers).to be_a(Hash)
          expect(resolvers.keys).to eq([Identities::Anonymous])
          expect(resolvers.values).to eq([anonymous_identity_resolver])
        end

        it 'raises an error for unknown identity types' do
          expect do
            Auth.new(
              app,
              auth_resolver: auth_resolver,
              auth_params: auth_params,
              auth_schemes: auth_schemes,
              foo_identity_resolver: double('foo_identity_resolver')
            )
          end.to raise_error(/foo_identity_resolver/)
        end
      end

      describe '#call' do
        let(:input) { double('input') }
        let(:output) { double('output') }
        let(:request) { double('request') }
        let(:response) { double('response') }

        let(:context) do
          Context.new(
            request: request,
            response: response
          )
        end

        let(:identity_resolvers) do
          {
            http_api_key_identity_resolver:
              double('http_api_key_identity_resolver'),
            http_bearer_identity_resolver: http_bearer_identity_resolver
          }
        end

        # bearer is the first auth option and the
        # identity resolver is configured.
        it 'selects the auth scheme then calls the next middleware' do
          expect(auth_resolver).to receive(:resolve)
            .with(auth_params).and_return(auth_options).ordered

          expect(http_bearer_identity_resolver)
            .to receive(:identity).and_return(double('identity')).ordered

          resp = subject.call(input, context)
          expect(resp).to be(output)
        end

        # only auth option is anonymous and the
        # auth schemes does not include it.
        it 'raises when auth scheme was not enabled' do
          expect(auth_resolver).to receive(:resolve)
            .with(auth_params).and_return([anonymous_auth_option])
            .ordered

          scheme_id = anonymous_auth_scheme.scheme_id
          expect { subject.call(input, context) }.to raise_error(
            /Auth scheme #{scheme_id} was not enabled/
          )
        end

        # only auth option is http basic and the auth schemes do
        # include it, however, there is no identity resolver configured.
        it 'raises when auth scheme does not have an identity resolver' do
          expect(auth_resolver).to receive(:resolve)
            .with(auth_params).and_return([http_basic_auth_option])
            .ordered

          scheme_id = http_basic_auth_option.scheme_id
          expect { subject.call(input, context) }.to raise_error(
            /Auth scheme #{scheme_id} did not have an identity resolver/
          )
        end
      end
    end
  end
end