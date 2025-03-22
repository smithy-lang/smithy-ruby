# frozen_string_literal: true

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for no authentication.
      class Anonymous < AuthScheme
        def initialize(options = {})
          super(
            scheme_id: 'smithy.api#noAuth',
            signer: options.fetch(:signer, Signers::Anonymous.new),
            identity_type: Identities::Anonymous
          )
        end
      end
    end
  end
end
