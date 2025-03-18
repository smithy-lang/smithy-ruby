# frozen_string_literal: true

require_relative '../signers/http_digest'
require_relative '../identities/http_login'

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for HTTP Digest.
      class HttpDigest < AuthScheme
        def initialize(options = {})
          super(
            scheme_id: 'smithy.api#HttpDigestAuth',
            signer: options.fetch(:signer, Signers::HttpDigest.new),
            identity_type: Identities::HttpLogin
          )
        end
      end
    end
  end
end
