# frozen_string_literal: true

module Hearth
  module Auth
    # Identity class for login authentication.
    class LoginIdentity < Identity
      def initialize(username:, password:, **kwargs)
        super(**kwargs)
        @username = username
        @password = password
      end

      # @return [String]
      attr_reader :username

      # @return [String]
      attr_reader :password
    end
  end
end
