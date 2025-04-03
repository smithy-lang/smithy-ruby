# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/http_bearer_auth'

module Smithy
  module Client
    module Plugins
      describe HttpBasicAuth do
        let(:sample_service) { ClientHelper.sample_service }

        let(:client_class) do
          client_class = sample_service.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_service::Plugins::Endpoint)
          client_class.add_plugin(sample_service::Plugins::Auth)
          client_class.add_plugin(AnonymousAuth)
          client_class.add_plugin(HttpBasicAuth)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new }

        it 'adds an :http_login_username option to config' do
          expect(client.config).to respond_to(:http_login_username)
        end

        it 'adds an :http_login_password option to config' do
          expect(client.config).to respond_to(:http_login_password)
        end

        it 'adds an :http_login_provider option to config' do
          expect(client.config).to respond_to(:http_login_provider)
        end

        it 'does not default an :http_login_username or :http_login_password' do
          expect(client.config.http_login_username).to be_nil
          expect(client.config.http_login_password).to be_nil
        end

        it 'does not default a :http_login_provider' do
          expect(client.config.http_login_provider).to be_nil
        end

        it 'has a default :http_login_username and :http_login_password when :stub_responses is true' do
          client = client_class.new(stub_responses: true)
          expect(client.config.http_login_username).to eq('stubbed-username')
          expect(client.config.http_login_password).to eq('stubbed-password')
        end

        it 'has a default :http_login_provider when :stub_responses is true' do
          client = client_class.new(stub_responses: true)
          provider = client.config.http_login_provider
          expect(provider).to be_a(HttpLoginProvider)
          identity = provider.identity({})
          expect(identity.username).to eq('stubbed-username')
          expect(identity.password).to eq('stubbed-password')
        end

        it 'defaults a :http_login_provider when :http_login_username and :http_login_password are set' do
          client = client_class.new(http_login_username: 'username', http_login_password: 'password')
          provider = client.config.http_login_provider
          expect(provider).to be_a(HttpLoginProvider)
          identity = provider.identity({})
          expect(identity.username).to eq('username')
          expect(identity.password).to eq('password')
        end

        it 'does not default a:http_login_provider when one of the parts is set' do
          client = client_class.new(http_login_username: 'username')
          provider = client.config.http_login_provider
          expect(provider).to be_nil

          client = client_class.new(http_login_password: 'password')
          provider = client.config.http_login_provider
          expect(provider).to be_nil
        end
      end
    end
  end
end
