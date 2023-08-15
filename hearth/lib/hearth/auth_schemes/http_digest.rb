# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # HTTP Digest authentication scheme.
    class HTTPDigest < AuthSchemes::Base
      def initialize
        super(scheme_id: 'smithy.api#httpDigestAuth')
        @identity_type = Identities::HTTPLogin
        @signer = Signers::HTTPDigest.new
      end
    end
  end
end
