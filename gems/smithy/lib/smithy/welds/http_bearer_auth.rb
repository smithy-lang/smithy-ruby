# frozen_string_literal: true

require 'smithy-client/plugins/http_bearer_auth'

module Smithy
  module Welds
    # Adds the HTTP Bearer Auth plugin if the service requires it.
    class HTTPBearerAuth < Weld
      def for?(service)
        _id, service = service.first
        return false unless service.fetch('traits', {}).include?('smithy.api#httpBearerAuth')

        say_status :insert, 'Adding the HTTPBearerAuth plugin', @plan.quiet
        true
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HTTPBearerAuth => { require_path: 'smithy-client/plugins/http_bearer_auth' }
        }
      end

      def auth_schemes
        {
          'smithy.api#httpBearerAuth' => {
            class: Smithy::Client::AuthSchemes::HTTPBearer,
            provider_config_option: :http_bearer_token_provider
          }
        }
      end
    end
  end
end
