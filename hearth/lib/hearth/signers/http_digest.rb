# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that signs requests using the HTTP Digest Auth scheme.
    class HTTPDigest < Signers::Base
      def sign(request:, identity:, properties:)
        # TODO: requires a nonce from the server - this cannot
        # be implemented unless we rescue from a 401 and retry
        # with the nonce
      end
    end
  end
end
