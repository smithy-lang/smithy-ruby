# frozen_string_literal: true

module Hearth
  # Object that represents an auth scheme resolved by Auth middleware.
  class AuthScheme
    def initialize(scheme_id:)
      @scheme_id = scheme_id
    end

    # @return [String]
    attr_reader :scheme_id

    def identity_resolver(options = {})
      # todo
    end

    # @return [Signer]
    attr_accessor :signer
  end
end
