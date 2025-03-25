# frozen_string_literal: true

module Smithy
  module Client
    module Identities
      # Identity class for HTTP login authentication.
      class HttpLogin < Identity
        def initialize(username:, password:, **)
          @username = username
          @password = password
          super(**)
        end

        # @return [String]
        attr_reader :username

        # @return [String]
        attr_reader :password
      end
    end
  end
end
