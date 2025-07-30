# frozen_string_literal: true

module Smithy
  module Client
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