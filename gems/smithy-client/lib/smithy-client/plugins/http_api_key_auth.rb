# frozen_string_literal: true

require_relative '../http_api_key_provider'
require_relative '../identities/http_api_key'
require_relative '../signers/http_api_key'

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
          :http_api_key_provider,
          doc_type: HttpApiKeyProvider,
          docstring: <<~DOCS) do |config|
            An API key identity provider. This can be an instance of a {Smithy::Client::HttpApiKeyProvider} or any
            class that responds to #identity and returns a {Smithy::Client::Identities::HttpApiKey}.
          DOCS
          HttpApiKeyProvider.new(config.http_api_key) if config.http_api_key
        end

        class Handler < Client::Handler
          def call(context)
            if context.auth[:scheme_id] == 'smithy.api#httpApiKeyAuth'
              Smithy::Client::Signers::HttpApiKey.new.sign(context)
            end
            @handler.call(context)
          end
        end

        handler(Handler, step: :sign)
      end
    end
  end
end
