# frozen_string_literal: true

# This is generated code!

require 'smithy-client/auth/auth'

module Weather
  module Plugins
    # @api private
    class Auth < Smithy::Client::Plugin
      option(
        :auth_resolver,
        doc_type: 'Weather::AuthResolver',
        docstring: <<~DOCS) do |config|
          The auth resolver used to resolve authentication. Any object that responds to `#resolve(parameters)`.
        DOCS
        AuthResolver.new
      end

      option(
        :auth_schemes,
        doc_type: Hash,
        rbs_type: 'Hash[String, Smithy::Client::AuthScheme]',
        docstring: <<~DOCS) do |config|
          The auth schemes used to resolve authentication. The key is the scheme name as a String,
          and the value is an initialized auth scheme class.
        DOCS
        {
          'smithy.api#noAuth' => config.anonymous_auth_scheme,
        }
      end

      handler(Smithy::Client::Auth::Handler, step: :sign, priority: 70)
    end
  end
end
