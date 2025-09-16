# frozen_string_literal: true

module Smithy
  module Client
    # Provides a Bearer token for authentication.
    class BearerTokenProvider
      include IdentityProvider

      # @param [Hash] options
      # @option options [String] :token
      def initialize(options = {})
        @identity = BearerToken.new(token: options[:token])
      end
    end
  end
end
