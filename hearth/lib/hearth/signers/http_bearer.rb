# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that signs requests using the HTTP Bearer scheme.
    class HTTPBearer < Signers::Base
      # rubocop:disable Lint/UnusedMethodArgument
      def sign(request:, identity:, properties:)
        # TODO: does not handle realm or other properties
        request.headers['Authorization'] = "Bearer #{identity.token}"
      end
      # rubocop:enable Lint/UnusedMethodArgument
    end
  end
end
