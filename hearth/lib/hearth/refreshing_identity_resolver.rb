# frozen_string_literal: true

module Hearth
  # Refreshing Identity resolver that uses a proc to resolve an Identity.
  # Automatically refreshes the identity if it is near expiration.
  class RefreshingIdentityResolver < IdentityResolver
    include RefreshingIdentity

    # @param [Hash] properties
    def refresh(properties = {})
      @identity = @proc.call(properties)
    end
  end
end
