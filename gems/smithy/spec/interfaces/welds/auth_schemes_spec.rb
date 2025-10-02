# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Auth Schemes' do
  before(:all) do
    Class.new(Smithy::Weld) do
      def for?(service)
        service.keys.first == 'smithy.ruby.tests#ServiceWithAuthTrait'
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HttpBasicAuth => { require_path: 'smithy-client/plugins/http_basic_auth' },
          Smithy::Client::Plugins::HttpBearerAuth => { require_path: 'smithy-client/plugins/http_bearer_auth' }
        }
      end

      def add_auth_schemes
        %w[smithy.api#httpBasicAuth smithy.api#httpBearerAuth]
      end

      def remove_auth_schemes
        ['smithy.api#httpBearerAuth']
      end
    end
  end

  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_context context, 'ServiceWithAuthTrait', fixture: 'auth/auth_trait'

      let(:client) { ServiceWithAuthTrait::Client.new }

      it 'adds auth schemes to the client' do
        auth_resolver = ServiceWithAuthTrait::AuthResolver.new
        auth_parameters = ServiceWithAuthTrait::AuthParameters.new(operation_name: :operation_c)
        resolved_auths = auth_resolver.resolve(auth_parameters)
        expect(resolved_auths.map(&:scheme_id)).to include('smithy.api#httpBasicAuth')
      end

      it 'removes auth schemes from the client' do
        auth_resolver = ServiceWithAuthTrait::AuthResolver.new
        auth_parameters = ServiceWithAuthTrait::AuthParameters.new(operation_name: :operation_d)
        resolved_auths = auth_resolver.resolve(auth_parameters)
        expect(resolved_auths.map(&:scheme_id)).to_not include('smithy.api#httpBearerAuth')
      end
    end
  end
end
