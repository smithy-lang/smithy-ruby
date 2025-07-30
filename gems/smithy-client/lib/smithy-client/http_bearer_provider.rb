# frozen_string_literal: true

module Smithy
  module Client
    # Returns an HTTP Bearer identity
    class HttpBearerProvider
      include IdentityProvider

      # @param [String] token
      def initialize(token)
        @identity = Identities::HttpBearer.new(token: token)
      end
    end
  end
end
