# frozen_string_literal: true

module Hearth
  module Auth
    module HTTP
      # Identity class for API Key authentication.
      class ApiKeyIdentity < Identity
        def initialize(key:, **kwargs)
          super(**kwargs)
          @key = key
        end

        # @return [String]
        attr_reader :key
      end
    end
  end
end
