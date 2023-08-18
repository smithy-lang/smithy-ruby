# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP Digest authentication scheme.
    class HTTPDigest < AuthSchemes::Base
      def initialize
        super(
          scheme_id: 'smithy.api#httpDigestAuth',
          signer: Signers::HTTPDigest.new,
          identity_type: Identities::HTTPLogin
        )
      end
    end
  end
end
