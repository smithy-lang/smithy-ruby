# frozen_string_literal: true

module Smithy
  module Client
    # Returns a Token identity
    class HttpBearerProvider
      include IdentityProvider

      # @param [String] token
      def initialize(token)
        @identity = Identities::Token.new(token: token)
      end
    end
  end
end
