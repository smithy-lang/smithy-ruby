# frozen_string_literal: true

require_relative '../bearer_token'
require_relative '../bearer_token_provider'
require_relative '../bearer_token_signer'

module Smithy
  module Client
    module Plugins
      # @api private
      class HttpBearerAuth < Plugin
        option(
          :bearer_token,
          doc_type: String,
          docstring: 'The bearer token to use for authentication.'
        ) do |config|
          'stubbed-bearer-token' if config.stub_responses
        end

        option(
          :bearer_token_provider,
          doc_type: Smithy::Client::BearerTokenProvider,
          docstring: <<~DOCS) do |config|
            A bearer token identity provider. This can be an instance of a {Smithy::Client::BearerTokenProvider} or any
            class that responds to #identity and returns a {Smithy::Client::BearerToken}.
          DOCS
          provider = Smithy::Client::BearerTokenProvider.new(token: config.bearer_token)
          provider if provider.set?
        end

        option(:bearer_token_signer) do |_config|
          BearerTokenSigner.new
        end

        def after_initialize(client)
          client.config.auth_schemes['smithy.api#httpBearerAuth'] = AuthScheme.new(
            identity_provider: client.config.bearer_token_provider,
            scheme_id: 'smithy.api#httpBearerAuth',
            signer: client.config.bearer_token_signer
          )
        end
      end
    end
  end
end
