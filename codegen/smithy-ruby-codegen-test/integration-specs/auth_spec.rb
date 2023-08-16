# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  module Auth
    describe Params do
      it 'is a struct with operation_name' do
        params = Auth::Params.new(operation_name: :operation)
        expect(params.operation_name).to eq(:operation)
      end
    end

    describe SCHEMES do
      it 'is a constant with supported schemes' do
        actual = Auth::SCHEMES.map(&:scheme_id)
        expected = [
          'smithy.api#httpApiKeyAuth',
          'smithy.api#httpBasicAuth',
          'smithy.api#httpBearerAuth',
          'smithy.api#httpDigestAuth',
          'smithy.api#noAuth'
        ]
        expect(actual).to eq(expected)
      end
    end

    describe Resolver do
      context ':http_api_key_auth' do
        it 'resolves httpApiKeyAuth' do
          params = Params.new(operation_name: :http_api_key_auth)
          options = subject.resolve(params)
          expect(options.first.scheme_id).to eq('smithy.api#httpApiKeyAuth')
        end

        it 'has signing properties' do
          params = Params.new(operation_name: :http_api_key_auth)
          options = subject.resolve(params)
          expect(options.first.signer_properties).to eq(
            name: 'X-API-Key',
            in: 'header',
            scheme: 'Authorization'
          )
        end
      end

      context ':http_basic_auth' do
        it 'resolves httpBasicAuth' do
          params = Params.new(operation_name: :http_basic_auth)
          options = subject.resolve(params)
          expect(options.first.scheme_id).to eq('smithy.api#httpBasicAuth')
        end
      end

      context ':http_bearer_auth' do
        it 'resolves httpBearerAuth' do
          params = Params.new(operation_name: :http_bearer_auth)
          options = subject.resolve(params)
          expect(options.first.scheme_id).to eq('smithy.api#httpBearerAuth')
        end
      end

      context ':http_digest_auth' do
        it 'resolves httpDigestAuth' do
          params = Params.new(operation_name: :http_digest_auth)
          options = subject.resolve(params)
          expect(options.first.scheme_id).to eq('smithy.api#httpDigestAuth')
        end
      end

      context ':no_auth' do
        it 'resolves noAuth' do
          params = Params.new(operation_name: :no_auth)
          options = subject.resolve(params)
          expect(options.first.scheme_id).to eq('smithy.api#noAuth')
        end
      end

      context ':optional_auth' do
        let(:auth_option_schemes) do
          [
            'smithy.api#httpApiKeyAuth',
            'smithy.api#httpBasicAuth',
            'smithy.api#httpBearerAuth',
            'smithy.api#httpDigestAuth',
            'smithy.api#noAuth'
          ]
        end

        it 'resolves all auth including noAuth' do
          params = Params.new(operation_name: :optional_auth)
          options = subject.resolve(params)
          expect(options.size).to eq(5)
          expect(options.map(&:scheme_id)).to eq(auth_option_schemes)
        end
      end

      context ':ordered_auth' do
        let(:auth_option_schemes) do
          [
            'smithy.api#httpBasicAuth',
            'smithy.api#httpDigestAuth',
            'smithy.api#httpBearerAuth',
            'smithy.api#httpApiKeyAuth'
          ]
        end

        it 'resolves all auth in order' do
          params = Params.new(operation_name: :ordered_auth)
          options = subject.resolve(params)
          expect(options.size).to eq(4)
          expect(options.map(&:scheme_id)).to eq(auth_option_schemes)
        end
      end

      context 'operation without auth traits' do
        let(:auth_option_schemes) do
          [
            'smithy.api#httpApiKeyAuth',
            'smithy.api#httpBasicAuth',
            'smithy.api#httpBearerAuth',
            'smithy.api#httpDigestAuth'
          ]
        end

        it 'resolves all auth without noAuth' do
          params = Params.new(operation_name: :kitchen_sink)
          options = subject.resolve(params)
          expect(options.size).to eq(4)
          expect(options.map(&:scheme_id)).to eq(auth_option_schemes)
        end
      end
    end
  end

  describe Config do
    it 'adds identity resolvers to config' do
      expect(subject.respond_to?(:http_api_key_identity_resolver)).to be(true)
      expect(subject.respond_to?(:http_bearer_identity_resolver)).to be(true)
      expect(subject.respond_to?(:http_login_identity_resolver)).to be(true)
    end

    it 'validates identity resolvers' do
      msg = /to be in \[Hearth::IdentityResolver\], got String/
      expect do
        Config.new(http_api_key_identity_resolver: 'foo')
      end.to raise_error(ArgumentError, msg)

      expect do
        Config.new(http_bearer_identity_resolver: 'foo')
      end.to raise_error(ArgumentError, msg)

      expect do
        Config.new(http_login_identity_resolver: 'foo')
      end.to raise_error(ArgumentError, msg)
    end

    it 'does not set defaults' do
      expect(subject.http_api_key_identity_resolver).to be(nil)
      expect(subject.http_bearer_identity_resolver).to be(nil)
      expect(subject.http_login_identity_resolver).to be(nil)
    end

    context 'stub_responses' do
      subject { Config.new(stub_responses: true) }

      it 'sets default identities' do
        expect(subject.http_api_key_identity_resolver)
          .to be_a(Hearth::IdentityResolver)
        expect(subject.http_api_key_identity_resolver.identity)
          .to be_a(Hearth::Identities::HTTPApiKey)

        expect(subject.http_bearer_identity_resolver)
          .to be_a(Hearth::IdentityResolver)
        expect(subject.http_bearer_identity_resolver.identity)
          .to be_a(Hearth::Identities::HTTPBearer)

        expect(subject.http_login_identity_resolver)
          .to be_a(Hearth::IdentityResolver)
        expect(subject.http_login_identity_resolver.identity)
          .to be_a(Hearth::Identities::HTTPLogin)
      end
    end
  end

  describe Client do
    let(:config) do
      Config.new(**{ stub_responses: true }.merge(config_hash))
    end

    let(:identity_resolver) do
      Hearth::IdentityResolver.new(proc { identity })
    end

    let(:client) { Client.new(config) }

    let(:before_sign) do
      Class.new do
        def initialize(&block)
          @block = block
        end

        def read_before_signing(context)
          @block.call(context)
        end
      end
    end

    describe '#http_api_key_auth' do
      let(:config_hash) do
        { http_api_key_identity_resolver: identity_resolver }
      end

      let(:identity) do
        Hearth::Identities::HTTPApiKey.new(key: 'foo')
      end

      it 'resolves httpApiKeyAuth' do
        interceptor = before_sign.new do |context|
          auth_scheme = context.auth_scheme
          expect(auth_scheme).to be_a(Hearth::AuthSchemes::HTTPApiKey)
          expect(auth_scheme.identity).to be(identity)
          expect(auth_scheme.auth_option.scheme_id)
            .to eq('smithy.api#httpApiKeyAuth')
        end

        client.http_api_key_auth({}, interceptors: [interceptor])
      end
    end

    describe '#http_basic_auth' do
      let(:config_hash) do
        { http_login_identity_resolver: identity_resolver }
      end

      let(:identity) do
        Hearth::Identities::HTTPLogin.new(username: 'foo', password: 'bar')
      end

      it 'resolves httpBasicAuth' do
        interceptor = before_sign.new do |context|
          auth_scheme = context.auth_scheme
          expect(auth_scheme).to be_a(Hearth::AuthSchemes::HTTPBasic)
          expect(auth_scheme.identity).to be(identity)
          expect(auth_scheme.auth_option.scheme_id)
            .to eq('smithy.api#httpBasicAuth')
        end

        client.http_basic_auth({}, interceptors: [interceptor])
      end
    end

    describe '#http_bearer_auth' do
      let(:config_hash) do
        { http_bearer_identity_resolver: identity_resolver }
      end

      let(:identity) do
        Hearth::Identities::HTTPBearer.new(token: 'foo')
      end

      it 'resolves httpBearerAuth' do
        interceptor = before_sign.new do |context|
          auth_scheme = context.auth_scheme
          expect(auth_scheme).to be_a(Hearth::AuthSchemes::HTTPBearer)
          expect(auth_scheme.identity).to be(identity)
          expect(auth_scheme.auth_option.scheme_id)
            .to eq('smithy.api#httpBearerAuth')
        end

        client.http_bearer_auth({}, interceptors: [interceptor])
      end
    end

    describe '#http_digest_auth' do
      let(:config_hash) do
        { http_login_identity_resolver: identity_resolver }
      end

      let(:identity) do
        Hearth::Identities::HTTPLogin.new(username: 'foo', password: 'bar')
      end

      it 'resolves httpDigestAuth' do
        interceptor = before_sign.new do |context|
          auth_scheme = context.auth_scheme
          expect(auth_scheme).to be_a(Hearth::AuthSchemes::HTTPDigest)
          expect(auth_scheme.identity).to be(identity)
          expect(auth_scheme.auth_option.scheme_id)
            .to eq('smithy.api#httpDigestAuth')
        end

        client.http_basic_auth({}, interceptors: [interceptor])
      end
    end

    describe '#optional_auth' do
      context 'no resolvers' do
        let(:config_hash) do
          {
            http_login_identity_resolver: nil,
            http_bearer_identity_resolver: nil,
            http_api_key_identity_resolver: nil
          }
        end

        it 'resolves noAuth' do
          interceptor = before_sign.new do |context|
            auth_scheme = context.auth_scheme
            expect(auth_scheme).to be_a(Hearth::AuthSchemes::Anonymous)
            expect(auth_scheme.identity).to be_a(Hearth::Identities::Anonymous)
            expect(auth_scheme.auth_option.scheme_id).to eq('smithy.api#noAuth')
          end

          client.optional_auth({}, interceptors: [interceptor])
        end
      end

      context 'only anonymous auth scheme' do
        # default identity resolvers are configured
        let(:config_hash) do
          { auth_schemes: [Hearth::AuthSchemes::Anonymous.new] }
        end

        it 'resolves noAuth' do
          interceptor = before_sign.new do |context|
            auth_scheme = context.auth_scheme
            expect(auth_scheme).to be_a(Hearth::AuthSchemes::Anonymous)
            expect(auth_scheme.identity).to be_a(Hearth::Identities::Anonymous)
            expect(auth_scheme.auth_option.scheme_id).to eq('smithy.api#noAuth')
          end

          client.optional_auth({}, interceptors: [interceptor])
        end
      end
    end

    describe '#no_auth' do
      # default identity resolvers are configured
      let(:config_hash) { {} }

      it 'resolves noAuth' do
        interceptor = before_sign.new do |context|
          auth_scheme = context.auth_scheme
          expect(auth_scheme).to be_a(Hearth::AuthSchemes::Anonymous)
          expect(auth_scheme.identity).to be_a(Hearth::Identities::Anonymous)
          expect(auth_scheme.auth_option.scheme_id).to eq('smithy.api#noAuth')
        end

        client.no_auth({}, interceptors: [interceptor])
      end
    end

    describe '#ordered_auth' do
      let(:identity) do
        Hearth::Identities::HTTPLogin.new(username: 'foo', password: 'bar')
      end

      let(:config_hash) do
        {
          http_login_identity_resolver: identity_resolver,
          http_bearer_identity_resolver: nil,
          http_api_key_identity_resolver: nil
        }
      end

      it 'resolves httpDigestAuth' do
        interceptor = before_sign.new do |context|
          auth_scheme = context.auth_scheme
          expect(auth_scheme).to be_a(Hearth::AuthSchemes::HTTPDigest)
          expect(auth_scheme.identity).to be(identity)
          expect(auth_scheme.auth_option.scheme_id)
            .to eq('smithy.api#httpDigestAuth')
        end

        client.ordered_auth({}, interceptors: [interceptor])
      end
    end
  end
end
