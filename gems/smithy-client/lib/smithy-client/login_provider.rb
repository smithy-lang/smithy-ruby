# frozen_string_literal: true

module Smithy
  module Client
    # Provides a login credentials for authentication.
    class LoginProvider
      include IdentityProvider

      # @param [Hash] options
      # @option options [String, nil] :username
      # @option options [String. nil] :password
      def initialize(options = {})
        @identity = Login.new(username: options[:username], password: options[:password])
      end
    end
  end
end
