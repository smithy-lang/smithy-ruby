# frozen_string_literal: true

module Smithy
  module Client
    module Signers
      # A signer that signs requests using the HTTP Digest Auth scheme.
      class HttpDigest < Signer
        def sign(request:, identity:, **_options)
          # TODO: requires a nonce from the server - this cannot
          # be implemented unless we rescue from a 401 and retry
          # with the nonce
          raise NotImplementedError
        end

        def reset(request:, **_options)
          raise NotImplementedError
        end
      end
    end
  end
end
