# frozen_string_literal: true

require 'smithy-client/auth_schemes/http_api_key'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpApiKeyAuth < Plugin
        option(
          :http_api_key,
          doc_type: String,
          docstring: 'The API key to use for authentication.'
        ) do |config|
          'stubbed-api-key' if config.stub_responses
        end

        option(
          :http_api_key_identity,
          doc_type: Identities::HttpApiKey,
          docstring: 'The API key identity to use for authentication.'
        ) do |config|
          Identities::HttpApiKey.new(key: config.http_api_key) if config.http_api_key
        end

        option(
          :http_api_key_identity_provider,
          doc_type: Smithy::Client::IdentityProvider,
          docstring: <<~DOCS) do |config|
            An API key identity provider. This can be an instance of a {Smithy::Client::IdentityProvider} or any
            class that responds to #identity(properties) and returns a {Smithy::Client::Identities::HttpApiKey}.
          DOCS
          IdentityProvider.new(proc { |_properties| config.http_api_key_identity }) if config.http_api_key_identity
        end

        option(:http_api_key_auth_scheme) do |_config|
          Smithy::Client::AuthSchemes::HttpApiKey.new
        end
      end
    end
  end
end
