# frozen_string_literal: true

require_relative '../signers/http_bearer'
require_relative '../identities/http_bearer'

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for HTTP Bearer tokens.
      class HTTPBearer < AuthScheme
        def initialize(options = {})
          super(
            'smithy.api#httpBearerAuth',
            signer: options.fetch(:signer, Signers::HTTPBearer.new),
            identity_type: Identities::HTTPBearer
          )
        end
      end
    end
  end
end
