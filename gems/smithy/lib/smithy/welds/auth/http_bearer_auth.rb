# frozen_string_literal: true

require 'smithy-client/plugins/http_bearer_auth'

module Smithy
  module Welds
    # Adds the HTTP Bearer Auth plugin if the service requires it.
    class HttpBearerAuth < Weld
      def for?(service)
        _id, service = service.first
        return false unless service.fetch('traits', {}).key?('smithy.api#httpBearerAuth')

        say_status :insert, 'Adding the HttpBearerAuth plugin', :yellow unless @plan.quiet
        true
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HttpBearerAuth => { require_path: 'smithy-client/plugins/http_bearer_auth' }
        }
      end

      def add_auth_schemes
        {
          'smithy.api#httpBearerAuth' => {
            auth_scheme_config_option: :http_bearer_auth_scheme,
            identity_provider_config_option: :http_bearer_provider,
            identity_type: Smithy::Client::Identities::HttpBearer
          }
        }
      end
    end
  end
end
