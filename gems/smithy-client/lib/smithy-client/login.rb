# frozen_string_literal: true

module Smithy
  module Client
    # Identity class for login authentication.
    class Login
      def initialize(options = {})
        @username = options[:username]
        @password = options[:password]
      end

      # @return [String]
      attr_reader :username

      # @return [String]
      attr_reader :password

      # @return [Boolean]
      def set?
        # username and password can be empty strings
        !@username.nil? && !@password.nil?
      end

      # @api private
      def inspect
        super.gsub(/@password="(\\"|[^"])*"/, '@password=[FILTERED]')
      end
    end
  end
end
