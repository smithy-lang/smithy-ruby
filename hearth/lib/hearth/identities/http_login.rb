# frozen_string_literal: true

module Hearth
  module Identities
    # Identity class for login authentication.
    class HTTPLogin < Identities::Base
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
