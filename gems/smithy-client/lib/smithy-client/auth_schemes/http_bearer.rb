# frozen_string_literal: true

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for HTTP Bearer tokens.
      class HttpBearer < AuthScheme
        def initialize(options = {})
          super(
            scheme_id: 'smithy.api#httpBearerAuth',
            signer: options.fetch(:signer, Signers::HttpBearer.new),
            identity_type: Identities::HttpBearer
          )
        end
      end
    end
  end
end
