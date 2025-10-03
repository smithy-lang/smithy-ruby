# frozen_string_literal: true

module Smithy
  module Client
    # Signs requests with the Login identity.
    class LoginSigner
      # @param [Hash] options
      # @option options [Symbol] :type
      #  The type of login authentication. Valid values are: :http_basic.
      def initialize(options = {})
        @type = options[:type]
      end

      def sign_request(context)
        raise NotImplementedError unless @type == :http_basic

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
