# frozen_string_literal: true

module Smithy
  module Client
    # This module provides basic accessors and methods for an
    # Identity Resolver class which resolves an Identity.
    module IdentityResolver
      # @return [Identity]
      attr_reader :identity

      # @return [Boolean]
      def set?
        !@identity.nil?
      end
    end
  end
end
