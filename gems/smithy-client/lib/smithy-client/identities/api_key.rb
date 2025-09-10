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

        # Removing the key from the default inspect string.
        # @api private
        def inspect
          super.gsub(/@key="(\\"|[^"])*"/, '@key=[FILTERED]')
        end
      end
    end
  end
end
