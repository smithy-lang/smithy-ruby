# frozen_string_literal: true

module Smithy
  module Client
    # A signer that does not sign requests. Used for anonymous authentication.
    class NullSigner
      def sign_request(_context)
        # no-op
      end

      def presign_url(_context)
        # no-op
      end
    end
  end
end
