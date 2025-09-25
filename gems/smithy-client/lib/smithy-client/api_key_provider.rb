# frozen_string_literal: true

module Smithy
  module Client
    # Provides an API key for authentication.
    class ApiKeyProvider
      include IdentityProvider

      # @param [Hash] options
      # @option options [String, nil] :key
      def initialize(options = {})
        @identity = ApiKey.new(key: options[:key])
      end
    end
  end
end
