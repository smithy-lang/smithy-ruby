# frozen_string_literal: true

module Smithy
  module Client
    # This module provides basic accessors and methods for an
    # Identity Provider class which provides an Identity.
    module IdentityProvider
      # @return [Boolean]
      def set?
        !@identity.nil?
      end

      # @return [Identity]
      attr_reader :identity
    end
  end
end
