# frozen_string_literal: true

module Smithy
  module Client
    # Basic Identity resolver that uses a proc to resolve an Identity.
    class IdentityProvider
      # @param [Proc] proc A proc that takes identity properties (Hash)
      #  and returns an Identity.
      def initialize(proc)
        @proc = proc
      end

      # @param [Hash] properties
      def identity(properties = {})
        @proc.call(properties)
      end
    end
  end
end
