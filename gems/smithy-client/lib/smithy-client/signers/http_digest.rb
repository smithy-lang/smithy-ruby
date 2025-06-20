# frozen_string_literal: true

module Smithy
  module Client
    module Signers
      # A signer that signs requests using the HTTP Digest Auth scheme.
      class HttpDigest < Signer
        def sign(context)
          # TODO: requires a nonce from the server - this cannot
          # be implemented unless we rescue from a 401 and retry
          # with the nonce
          raise NotImplementedError
        end

        def reset(context)
          raise NotImplementedError
        end
      end
    end
  end
end
