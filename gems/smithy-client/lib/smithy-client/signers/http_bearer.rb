# frozen_string_literal: true

module Smithy
  module Client
    module Signers
      # A signer that signs requests using the HTTP Bearer Auth scheme.
      class HTTPBearer < Signer
        def sign(request:, identity:, **_options)
          # TODO: does not handle realm or other properties
          request.headers['Authorization'] = "Bearer #{identity.token}"
        end

        def reset(request:, **_options)
          request.headers.delete('Authorization')
        end
      end
    end
  end
end
