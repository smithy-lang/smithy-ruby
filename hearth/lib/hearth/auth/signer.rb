# frozen_string_literal: true

module Hearth
  module Auth
    # Signs requests.
    class Signer
      # Signs a {Request} using an {Identity}. Raises an exception if the
      # identity is not compatible with this signer.
      #
      # @param request [Request]
      # @param identity [Identity]
      # @param options [Hash]
      def sign(request:, identity:, options: {})
        # TODO
      end
    end
  end
end
