# frozen_string_literal: true

require_relative '../api_key'
require_relative '../api_key_provider'
require_relative '../api_key_signer'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpApiKeyAuth < Plugin
        option(
          :api_key,
          doc_type: String,
          docstring: 'The API key to use for authentication.'
        ) do |config|
          'stubbed-api-key' if config.stub_responses
        end

        option(
          :api_key_provider,
          doc_type: ApiKeyProvider,
          docstring: <<~DOCS) do |config|
            An API key identity provider. This can be an instance of a {Smithy::Client::ApiKeyProvider} or any
            class that responds to #identity and returns a {Smithy::Client::ApiKey}.
          DOCS
          provider = ApiKeyProvider.new(key: config.api_key)
          provider if provider.set?
        end

        option(:api_key_signer) do |config|
          trait = config.service.traits['smithy.api#httpApiKeyAuth']
          ApiKeySigner.new(name: trait['name'], in: trait['in'], scheme: trait['scheme'])
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpApiKeyAuth'] = AuthScheme.new(
            identity_provider: client.config.api_key_provider,
            scheme_id: 'smithy.api#httpApiKeyAuth',
            signer: client.config.api_key_signer
          )
        end
      end
    end
  end
end
