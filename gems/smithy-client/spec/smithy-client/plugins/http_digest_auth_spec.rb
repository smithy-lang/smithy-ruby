# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe HttpDigestAuth do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.add_plugin(HttpDigestAuth)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        before do
          shapes['smithy.ruby.tests#SampleClient']['traits']['smithy.api#httpDigestAuth'] = {}
        end

        it 'adds an :login_username option to config' do
          expect(client.config).to respond_to(:login_username)
        end

        it 'adds an :login_password option to config' do
          expect(client.config).to respond_to(:login_password)
        end

        it 'adds an :login_provider option to config' do
          expect(client.config).to respond_to(:login_provider)
        end

        it 'does not default an :login_username or :login_password' do
          client = client_class.new
          expect(client.config.login_username).to be_nil
          expect(client.config.login_password).to be_nil
        end

        it 'does not default a :login_provider' do
          client = client_class.new
          expect(client.config.login_provider).to be_nil
        end

        it 'has a default :login_username and :login_password when :stub_responses is true' do
          expect(client.config.login_username).to eq('stubbed-username')
          expect(client.config.login_password).to eq('stubbed-password')
        end

        it 'has a default :login_provider when :stub_responses is true' do
          provider = client.config.login_provider
          expect(provider).to be_a(LoginProvider)
          identity = provider.identity
          expect(identity.username).to eq('stubbed-username')
          expect(identity.password).to eq('stubbed-password')
        end

        it 'defaults a :login_provider when :login_username and :login_password are set' do
          client = client_class.new(login_username: 'username', login_password: 'password')
          provider = client.config.login_provider
          expect(provider).to be_a(LoginProvider)
          identity = provider.identity
          expect(identity.username).to eq('username')
          expect(identity.password).to eq('password')
        end

        it 'does not default a :login_provider when one of the parts is set' do
          client = client_class.new(login_username: 'username')
          provider = client.config.login_provider
          expect(provider).to be_nil

          client = client_class.new(login_password: 'password')
          provider = client.config.login_provider
          expect(provider).to be_nil
        end

        context 'signing' do
          it 'is not supported' do
            expect { client.operation }.to raise_error(NotImplementedError)
          end
        end
      end
    end
  end
end
