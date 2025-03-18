# frozen_string_literal: true

require_relative '../signers/anonymous'
require_relative '../identities/anonymous'

module Smithy
  module Client
    module AuthSchemes
      # Auth scheme for HTTP Basic.
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
