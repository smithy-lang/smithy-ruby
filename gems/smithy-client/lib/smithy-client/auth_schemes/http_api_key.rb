# frozen_string_literal: true

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for HTTP API keys.
      class HttpApiKey < AuthScheme
        def initialize(options = {})
          super(
            scheme_id: 'smithy.api#httpApiKeyAuth',
            signer: options.fetch(:signer, Signers::HttpApiKey.new),
            identity_type: Identities::HttpApiKey
          )
        end
      end
    end
  end
end
