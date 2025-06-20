# frozen_string_literal: true

module Smithy
  module Client
    # Returns an HTTP API key identity
    class HttpApiKeyProvider
      # @param [String] key
      def initialize(key)
        @identity = Identities::HttpApiKey.new(key: key)
      end

      # @return [Identities::HttpApiKey]
      attr_reader :identity
    end
  end
end
