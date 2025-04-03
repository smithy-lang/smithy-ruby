# frozen_string_literal: true

module Smithy
  module Client
    module Identities
      # Identity class for HTTP API Key authentication.
      class HttpApiKey < Identity
        def initialize(key:, **)
          @key = key
          super(**)
        end

        # @return [String, nil]
        attr_reader :key
      end
    end
  end
end
