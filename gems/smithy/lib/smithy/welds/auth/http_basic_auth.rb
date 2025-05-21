# frozen_string_literal: true

require 'smithy-client/plugins/http_basic_auth'

module Smithy
  module Welds
    # Adds the HTTP Basic Auth plugin if the service requires it.
    class HttpBasicAuth < Weld
      def for?(service)
        _id, service = service.first
        return false unless service.fetch('traits', {}).include?('smithy.api#httpBasicAuth')

        say_status :insert, 'Adding the HttpBasicAuth plugin', :yellow unless @plan.quiet
        true
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HttpBasicAuth => { require_path: 'smithy-client/plugins/http_basic_auth' }
        }
      end

      def add_auth_schemes
        {
          'smithy.api#httpBasicAuth' => {
            auth_scheme_config_option: :http_basic_auth_scheme,
            identity_provider_config_option: :http_login_provider,
            identity_type: Smithy::Client::Identities::HttpLogin
          }
        }
      end
    end
  end
end
