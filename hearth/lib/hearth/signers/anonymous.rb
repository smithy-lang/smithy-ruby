# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that does not sign requests.
    class Anonymous < Signers::Base
      def sign(request:, identity:, properties:)
        # Do nothing.
      end

      def sign_initial_event_stream_request(request:, identity:, properties:)
        nil
      end

      def sign_event(message:, prior_signature:,
          identity:, properties:, event_type:, encoder:)
        [message, prior_signature]
      end

      def reset(request:, properties:)
        # Do nothing.
      end
    end
  end
end
