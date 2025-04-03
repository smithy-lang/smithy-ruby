# frozen_string_literal: true

module Smithy
  module Client
    # Base class for all AuthScheme classes.
    class AuthScheme
      def initialize(scheme_id:, signer:, identity_type:)
        @scheme_id = scheme_id
        @signer = signer
        @identity_type = identity_type
      end

      # @return [String]
      attr_reader :scheme_id

      # @return [IdentityProvider, nil]
      def identity_provider(identity_provider = {})
        identity_provider[@identity_type]
      end

      # @return [Signer]
      attr_reader :signer
    end
  end
end
