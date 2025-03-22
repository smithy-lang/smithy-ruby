# frozen_string_literal: true

require 'smithy-client/plugins/http_digest_auth'

module Smithy
  module Welds
    # Adds the HTTP Digest Auth plugin if the service requires it.
    class HttpDigestAuth < Weld
      def for?(service)
        _id, service = service.first
        return false unless service.fetch('traits', {}).include?('smithy.api#httpDigestAuth')

        say_status :insert, 'Adding the HttpDigestAuth plugin', @plan.quiet
        true
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HttpDigestAuth => { require_path: 'smithy-client/plugins/http_digest_auth' }
        }
      end

      def add_auth_schemes
        {
          'smithy.api#httpDigestAuth' => {
            auth_scheme_config_option: :http_digest_auth_scheme,
            identity_provider_config_option: :http_login_provider,
            identity_type: Smithy::Client::Identities::HttpLogin
          }
        }
      end
    end
  end
end
