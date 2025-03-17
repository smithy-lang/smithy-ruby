# frozen_string_literal: true

module Smithy
  module Client
    module Identities
      # Identity class for bearer token authentication.
      class HTTPBearer < Identity
        def initialize(options = {})
          @token = options[:token]
          super(**options)
        end

        # @return [String, nil]
        attr_reader :token
      end
    end
  end
end
