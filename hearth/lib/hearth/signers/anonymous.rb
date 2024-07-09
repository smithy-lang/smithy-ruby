# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that does not sign requests.
    class Anonymous < Signers::Base
      def sign(request:, identity:, properties:)
        # Do nothing.
      end

      def sign_event(prior_signature, _event_type, message, _encoder)
        [message, prior_signature]
      end

      def reset(request:, properties:)
        # Do nothing.
      end
    end
  end
end
