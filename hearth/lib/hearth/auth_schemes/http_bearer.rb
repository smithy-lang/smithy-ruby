# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP Bearer authentication scheme.
    class HTTPBearer < AuthSchemes::Base
      def initialize
        super(
          scheme_id: 'smithy.api#httpBearerAuth',
          signer: Signers::HTTPBearer.new,
          identity_type: Identities::HTTPBearer
        )
      end
    end
  end
end
