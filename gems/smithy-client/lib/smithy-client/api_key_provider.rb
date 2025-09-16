# frozen_string_literal: true

module Smithy
  module Client
    # Provides an API key for authentication.
    class ApiKeyProvider
      include IdentityProvider
      include RefreshingIdentityProvider

      # @param [Hash] options
      # @option options [String, nil] :key
      # @option options [Time, nil] :expiration
      def initialize(options = {})
        @key = options[:key]
        @expiration = options[:expiration]
        super
      end

      private

      def refresh
        @identity = ApiKey.new(key: @key)
      end
    end
  end
end
