# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that signs requests using the HTTP Digest Auth scheme.
    class HTTPDigest < Signers::Base
      def sign(request:, identity:, properties: {})
        # TODO
      end
    end
  end
end
