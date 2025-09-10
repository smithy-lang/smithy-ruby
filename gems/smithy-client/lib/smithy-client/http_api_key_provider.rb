# frozen_string_literal: true

module Smithy
  module Client
    # Returns an HTTP API key identity
    class HttpApiKeyProvider
      include IdentityProvider

      # @param [String] key
      def initialize(key)
        @identity = Identities::ApiKey.new(key: key)
      end
    end
  end
end
