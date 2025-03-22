# frozen_string_literal: true

require_relative '../http_bearer_provider'
require_relative '../identities/http_bearer'
require_relative '../signers/http_bearer'
require_relative '../auth_schemes/http_bearer'

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
          :http_bearer_provider,
          doc_type: Smithy::Client::HttpBearerProvider,
          docstring: <<~DOCS) do |config|
            A bearer token identity provider. This can be an instance of a {Smithy::Client::HttpBearerProvider} or any
            class that responds to #identity(properties) and returns a {Smithy::Client::Identities::HttpBearer}.
          DOCS
          Smithy::Client::HttpBearerProvider.new(config.http_bearer_token) if config.http_bearer_token
        end

        option(:http_bearer_auth_scheme) do |_config|
          Smithy::Client::AuthSchemes::HttpBearer.new
        end
      end
    end
  end
end
