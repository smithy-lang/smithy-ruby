# frozen_string_literal: true

module Hearth
  # Object that represents an auth option, returned by Auth Resolvers.
  class AuthOption
    def initialize(scheme_id:, identity_properties: {}, signer_properties: {})
      @scheme_id = scheme_id
      @identity_properties = identity_properties
      @signer_properties = signer_properties
    end

    # @return [String]
    attr_reader :scheme_id

    # @return [Hash]
    attr_reader :identity_properties

    # @return [Hash]
    attr_reader :signer_properties
  end
end
