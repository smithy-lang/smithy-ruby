# frozen_string_literal: true

require 'base64'

module Smithy
  module Client
    module Signers
      # A signer that signs requests using the HTTP Basic Auth scheme.
      class HttpBasic < Signer
        def sign(context)
          # TODO: does not handle realm or other properties
          identity_string = "#{context[:auth].identity.username}:#{context[:auth].identity.password}"
          encoded = Base64.strict_encode64(identity_string)
          context.http_request.headers['Authorization'] = "Basic #{encoded}"
        end

        def reset(request:, **_options)
          request.headers.delete('Authorization')
        end
      end
    end
  end
end
