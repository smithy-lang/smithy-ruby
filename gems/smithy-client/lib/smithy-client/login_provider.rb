# frozen_string_literal: true

module Smithy
  module Client
    # Provides a login credentials for authentication.
    class LoginProvider
      include IdentityProvider
      include RefreshingIdentityProvider

      # @param [Hash] options
      # @option options [String, nil] :username
      # @option options [String. nil] :password
      # @option options [Time, nil] :expiration
      def initialize(options = {})
        @username = options[:username]
        @password = options[:password]
        @expiration = options[:expiration]
        super
      end

      private

      def refresh
        @identity = Login.new(username: @username, password: @password)
      end
    end
  end
end
