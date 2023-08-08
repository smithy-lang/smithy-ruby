# frozen_string_literal: true

module Hearth
  # Base class for all Identity classes.
  class Identity
    def initialize(expiration: nil)
      @expiration = expiration
    end

    # @return [Time, nil]
    attr_reader :expiration
  end
end

require_relative 'identity/anonymous_identity'
require_relative 'identity/http_api_key_identity'
require_relative 'identity/http_bearer_token_identity'
require_relative 'identity/http_login_identity'
