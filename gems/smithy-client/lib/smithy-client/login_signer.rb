# frozen_string_literal: true

module Smithy
  module Client
    # Signs requests with the Login identity.
    class LoginSigner
      def initialize(options = {})
        @scheme_id = options[:scheme_id]
      end

      def sign_request(context)
        raise NotImplementedError unless @scheme_id == 'smithy.api#httpBasicAuth'

        sign_with_basic(context.http_request, context.config.login_provider)
      end

      def presign_url(_context)
        raise NotImplementedError
      end

      private

      def sign_with_basic(http_request, provider)
        http_request.headers.delete('Authorization')
        identity = provider.identity
        encoded = Base64.strict_encode64("#{identity.username}:#{identity.password}")
        http_request.headers['Authorization'] = "Basic #{encoded}"
      end
    end
  end
end
