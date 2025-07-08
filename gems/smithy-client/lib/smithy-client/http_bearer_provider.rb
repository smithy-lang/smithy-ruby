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
      attr_reader :identity
    end
  end
end
