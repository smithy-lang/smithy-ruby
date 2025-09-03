# frozen_string_literal: true

module Smithy
  module Client
    module Identities
      # Identity class for token authentication.
      class Token < Identity
        def initialize(token:, **)
          @token = token
          super(**)
        end

        # @return [String, nil]
        attr_reader :token

        # Removing the token from the default inspect string.
        # @api private
        def inspect
          "#<#{self.class.name} token=[FILTERED]>"
        end
      end
    end
  end
end
