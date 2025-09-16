# frozen_string_literal: true

module Smithy
  module Client
    # Provides a Bearer token for authentication.
    class BearerTokenProvider
      include IdentityProvider
      include RefreshingIdentityProvider

      # @param [Hash] options
      # @option options [String] :token
      # @option options [Time, nil] :expiration
      def initialize(options = {})
        @token = options[:token]
        @expiration = options[:expiration]
        super
      end

      private

      def refresh
        @identity = BearerToken.new(token: @token)
      end
    end
  end
end
