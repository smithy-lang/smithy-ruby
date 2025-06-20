# frozen_string_literal: true

module Smithy
  module Client
    # Returns an HTTP login identity
    class HttpLoginProvider
      # @param [String] username
      # @param [String] password
      def initialize(username, password)
        @identity = Identities::HttpLogin.new(username: username, password: password)
      end

      # @return [Identities::HttpLogin]
      def identity
        @identity
      end
    end
  end
end
