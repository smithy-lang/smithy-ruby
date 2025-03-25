# frozen_string_literal: true

module Smithy
  module Client
    # Returns an HTTP Bearer identity
    class HttpBearerProvider
      # @param [String] token
      def initialize(token)
        @identity = Identities::HttpBearer.new(token: token)
      end

      # @return [Identities::HttpBearer]
      def identity(_properties)
        @identity
      end
    end
  end
end
