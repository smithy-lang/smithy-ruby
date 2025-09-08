# frozen_string_literal: true

module Smithy
  module Client
    module Identities
      # Identity class for API Key authentication.
      class ApiKey < Identity
        def initialize(key:, **)
          @key = key
          super(**)
        end

        # @return [String, nil]
        attr_reader :key

        alias original_inspect inspect

        # Removing the key from the default inspect string.
        # @api private
        def inspect
          original_inspect.gsub(/@key="[^"]*"/, '@key=[FILTERED]')
        end
      end
    end
  end
end
