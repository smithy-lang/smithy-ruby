# frozen_string_literal: true

module Hearth
  # Basic Identity resolver that uses a proc to resolve an Identity.
  class IdentityProvider
    # @param [Proc] proc A proc that takes identity properties (Hash)
    #   and returns a {Hearth::Identities::Base}.
    def initialize(proc)
      @proc = proc
    end

    # @param [Hash] properties
    def identity(properties = {})
      @proc.call(properties)
    end
  end
end
