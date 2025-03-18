# frozen_string_literal: true

require 'smithy-client/plugins/http_login_auth'

module Smithy
  module Welds
    # Adds the HTTP Login Auth plugin if the service requires Basic or Digest auth.
    class HttpLoginAuth < Weld
      def for?(service)
        _id, service = service.first
        service_traits = service.fetch('traits', {})
        unless service_traits.include?('smithy.api#httpBasicAuth') ||
               service_traits.include?('smithy.api#httpDigestAuth')
          return false
        end

        say_status :insert, 'Adding the HttpLoginAuth plugin', @plan.quiet
        true
      end

      def add_plugins
        {
          Smithy::Client::Plugins::HttpLoginAuth => { require_path: 'smithy-client/plugins/http_login_auth' }
        }
      end
    end
  end
end
