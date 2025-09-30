# frozen_string_literal: true

module Smithy
  module Client
    # Contains information about configured authentication schemes.
    class AuthScheme
      def initialize(options = {})
        @scheme_id = options[:scheme_id]
        @identity_provider = options[:identity_provider]
        @signer = options[:signer]
      end

      # @return [String]
      attr_reader :scheme_id

      # @return [IdentityProvider]
      attr_reader :identity_provider

      # @return [Signer]
      attr_reader :signer
    end
  end
end
