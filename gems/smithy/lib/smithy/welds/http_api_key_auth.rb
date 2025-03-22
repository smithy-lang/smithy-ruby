# frozen_string_literal: true

require 'smithy-client/plugins/http_api_key_auth'

module Smithy
  module Welds
    # Adds the HTTP API Key Auth plugin if the service requires it.
    class HttpApiKeyAuth < Weld
      def for?(service)
        _id, service = service.first
        return false unless service.fetch('traits', {}).include?('smithy.api#httpApiKeyAuth')

        say_status :insert, 'Adding the HttpApiKeyAuth plugin', @plan.quiet
        true
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HttpApiKeyAuth => { require_path: 'smithy-client/plugins/http_api_key_auth' }
        }
      end

      def add_auth_schemes
        {
          'smithy.api#httpApiKeyAuth' => {
            auth_scheme_config_option: :http_api_key_auth_scheme,
            identity_provider_config_option: :http_api_key_identity_provider,
            identity_type: Smithy::Client::Identities::HttpApiKey
          }
        }
      end
    end
  end
end
