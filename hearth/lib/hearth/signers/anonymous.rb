# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that does not sign requests.
    class Anonymous < Signers::Base
      def sign(request:, identity:, properties:)
        # Do nothing.
      end
    end
  end
end
