# frozen_string_literal: true

module Hearth
  module Identities
    # Identity class for API Key authentication.
    class HTTPApiKey < Identities::Base
      def initialize(key:, **kwargs)
        super(**kwargs)
        @key = key
      end

      # @return [String]
      attr_reader :key
    end
  end
end
