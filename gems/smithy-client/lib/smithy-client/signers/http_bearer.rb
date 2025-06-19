# frozen_string_literal: true

module Smithy
  module Client
    module Signers
      # A signer that signs requests using the HTTP Bearer Auth scheme.
      class HttpBearer < Signer
        def sign(context)
          # TODO: does not handle realm or other properties
          context.http_request.headers['Authorization'] = "Bearer #{context[:auth].identity.token}"
        end

        def reset(request:, **_options)
          request.headers.delete('Authorization')
        end
      end
    end
  end
end
