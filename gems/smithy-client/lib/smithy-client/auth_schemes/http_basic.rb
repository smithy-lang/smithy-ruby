# frozen_string_literal: true

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for HTTP Basic.
      class HttpBasic < AuthScheme
        def initialize(options = {})
          super(
            scheme_id: 'smithy.api#httpBasicAuth',
            signer: options.fetch(:signer, Signers::HttpBasic.new),
            identity_type: Identities::HttpLogin
          )
        end
      end
    end
  end
end
