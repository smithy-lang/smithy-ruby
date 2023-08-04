# frozen_string_literal: true

require_relative 'auth/anonymous_identity'
require_relative 'auth/http'
require_relative 'auth/identity'
require_relative 'auth/identity_resolver'
require_relative 'auth/refreshing_identity_resolver'

module Hearth
  # Contains all authentication related code.
  module Auth; end
end
