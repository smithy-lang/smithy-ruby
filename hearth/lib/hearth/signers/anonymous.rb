# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that does not sign requests.
    class Anonymous
      def sign(request:, identity:, properties: {})
        # do nothing
      end
    end
  end
end
