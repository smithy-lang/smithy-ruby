# frozen_string_literal: true

module Smithy
  module Client
    # Returns an HTTP login identity
    class HttpLoginProvider
      include IdentityProvider

      # @param [String] username
      # @param [String] password
      def initialize(username, password)
        @identity = Identities::HttpLogin.new(username: username, password: password)
      end
    end
  end
end
