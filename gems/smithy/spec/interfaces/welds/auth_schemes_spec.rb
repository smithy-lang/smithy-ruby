# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Auth Schemes' do
  before(:all) do
    Class.new(Smithy::Weld) do
      def for?(service)
        service.keys.first == 'smithy.ruby.tests#Weather'
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HttpBasicAuth => { require_path: 'smithy-client/plugins/http_basic_auth' },
          Smithy::Client::Plugins::HttpBearerAuth => { require_path: 'smithy-client/plugins/http_bearer_auth' }
        }
      end

      def add_auth_schemes
        {
          'smithy.api#httpBasicAuth' => {
            auth_scheme_config_option: :http_basic_auth_scheme,
            identity_provider_config_option: :http_login_provider,
            identity_type: Smithy::Client::Identities::HttpLogin
          },
          'smithy.api#httpBearerAuth' => {
            auth_scheme_config_option: :http_bearer_auth_scheme,
            identity_provider_config_option: :http_bearer_provider,
            identity_type: Smithy::Client::Identities::HttpBearer
          }
        }
      end

      def remove_auth_schemes
        ['smithy.api#httpBearerAuth']
      end
    end
  end

  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'Weather'

      let(:client) { Weather::Client.new }

      it 'adds auth schemes to the client' do
        expect(client.config.auth_schemes).to include('smithy.api#httpBasicAuth')
      end

      it 'removes auth schemes from the client' do
        expect(client.config.auth_schemes).to include('smithy.api#httpBearerAuth')
      end
    end
  end
end
