# frozen_string_literal: true

module Smithy
  module Client
    # This module provides basic accessors and methods for an Identity provider.
    module IdentityProvider
      # @return [Identity]
      attr_reader :identity

      # @return [Time, nil]
      attr_reader :expiration

      # @return [Boolean]
      def set?
        !!identity && identity.set?
      end
    end
  end
end
