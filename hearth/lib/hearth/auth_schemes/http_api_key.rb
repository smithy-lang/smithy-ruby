# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP API Key authentication scheme.
    class HTTPApiKey < AuthSchemes::Base
      def initialize
        super(
          scheme_id: 'smithy.api#httpApiKeyAuth',
          signer: Signers::HTTPApiKey.new,
          identity_type: Identities::HTTPApiKey
        )
      end
    end
  end
end
