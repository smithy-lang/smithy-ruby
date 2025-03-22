# frozen_string_literal: true

module Smithy
  module Client
    module Identities
      # Identity class for HTTP Bearer token authentication.
      class HttpBearer < Identity
        def initialize(token:, **)
          @token = token
          super(**)
        end

        # @return [String, nil]
        attr_reader :token
      end
    end
  end
end
