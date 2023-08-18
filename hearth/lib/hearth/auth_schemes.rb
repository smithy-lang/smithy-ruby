# frozen_string_literal: true

module Hearth
  module AuthSchemes
    # Base class for all AuthScheme classes.
    class Base
      def initialize(scheme_id:, signer:, identity_type:)
        @scheme_id = scheme_id
        @signer = signer
        @identity_type = identity_type
      end

      # @return [String]
      attr_reader :scheme_id

      # @return [IdentityResolver, nil]
      def identity_resolver(identity_resolvers = {})
        identity_resolvers[@identity_type]
      end

      # @return [Signers::Base]
      attr_reader :signer
    end
  end
end

require_relative 'auth_schemes/anonymous'
require_relative 'auth_schemes/http_api_key'
require_relative 'auth_schemes/http_basic'
require_relative 'auth_schemes/http_bearer'
require_relative 'auth_schemes/http_digest'
