# frozen_string_literal: true

module Smithy
  module Client
    # Signs requests with the BearerToken identity.
    class BearerTokenSigner
      def sign_request(context)
        context.http_request.headers.delete('Authorization')
        provider = context.config.bearer_token_provider
        context.http_request.headers['Authorization'] = "Bearer #{provider.identity.token}"
      end

      def presign_url(*args)
        raise NotImplementedError
      end
    end
  end
end
