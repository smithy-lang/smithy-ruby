# frozen_string_literal: true

require_relative 'auth/anonymous_identity'
require_relative 'auth/api_key_identity'
require_relative 'auth/bearer_token_identity'
require_relative 'auth/identity'
require_relative 'auth/identity_resolver'
require_relative 'auth/login_identity'
require_relative 'auth/refreshing_identity'
require_relative 'auth/scheme'
require_relative 'auth/signer'

module Hearth
  # Contains all authentication related code.
  module Auth; end
end
