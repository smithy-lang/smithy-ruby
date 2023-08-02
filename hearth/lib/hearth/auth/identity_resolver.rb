# frozen_string_literal: true

module Hearth
  module Auth
    # Basic Identity resolver that uses a proc to resolve an Identity.
    class IdentityResolver
      include RefreshingIdentity

      # @param [Proc] proc A proc that takes identity properties (Hash)
      #   and returns an identity (Identity).
      def initialize(proc)
        @proc = proc
      end

      # @param [Hash] properties
      def refresh(properties)
        @identity = @proc.call(properties)
      end
    end
  end
end
