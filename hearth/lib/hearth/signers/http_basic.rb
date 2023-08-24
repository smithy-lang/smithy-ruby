# frozen_string_literal: true

require 'base64'

module Hearth
  module Signers
    # A signer that signs requests using the HTTP Basic Auth scheme.
    class HTTPBasic
      # rubocop:disable Lint/UnusedMethodArgument
      def sign(request:, identity:, properties:)
        # TODO: does not handle realm or other properties
        identity_string = "#{identity.username}:#{identity.password}"
        encoded = Base64.strict_encode64(identity_string)
        request.headers['Authorization'] = "Basic #{encoded}"
      end

      def reset(request:, properties:)
        request.headers.delete('Authorization')
      end
      # rubocop:enable Lint/UnusedMethodArgument
    end
  end
end
