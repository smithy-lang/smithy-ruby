# frozen_string_literal: true

require 'smithy-client/auth_schemes/http_bearer'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpBearerAuth < Plugin
        option(
          :http_bearer_token,
          doc_type: String,
          docstring: 'The bearer token to use for authentication.'
        ) do |config|
          'stubbed-bearer-token' if config.stub_responses
        end

        option(
          :http_bearer_identity,
          doc_type: Identities::HttpBearer,
          docstring: 'The bearer token identity to use for authentication.'
        ) do |config|
          Identities::HttpBearer.new(token: config.http_bearer_token) if config.http_bearer_token
        end

        option(
          :http_bearer_token_provider,
          doc_type: '#identity(properties)',
          docstring: <<~DOCS) do |config|
            A bearer token identity provider. This can be an instance of a {Smithy::Client::IdentityProvider} or any
            class that responds to #identity(properties) and returns a {Smithy::Client::Identities::HttpBearer}.
          DOCS
          if config.http_bearer_identity
            IdentityProvider.new(proc { |_properties| config.http_bearer_identity })
          end
        end

        option(:http_bearer_signer) do |_config|
          Signers::HttpBearer.new
        end

        option(:http_bearer_auth_scheme) do |config|
          Smithy::Client::AuthSchemes::HttpBearer.new(signer: config.http_bearer_signer)
        end
      end
    end
  end
end
