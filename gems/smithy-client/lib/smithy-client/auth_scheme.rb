# frozen_string_literal: true

module Smithy
  module Client
    # Contains information about candidate authentication schemes.
    class AuthScheme
      def initialize(options = {})
        @identity_provider = options[:identity_provider]
        @scheme_id = options[:scheme_id]
        @signer = options[:signer]
      end

      # @return [IdentityProvider]
      attr_reader :identity_provider

      # @return [String]
      attr_reader :scheme_id

      # @return [Signer]
      attr_reader :signer
    end
  end
end
