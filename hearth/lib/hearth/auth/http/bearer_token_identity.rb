# frozen_string_literal: true

module Hearth
  module Auth
    module HTTP
      # Identity class for bearer token authentication.
      class BearerTokenIdentity < Identity
        def initialize(token:, **kwargs)
          super(**kwargs)
          @token = token
        end

        # @return [String]
        attr_reader :token
      end
    end
  end
end
