# frozen_string_literal: true

module Hearth
  module Signers
    # A signer that does not sign requests.
    # rubocop:disable Lint/UnusedMethodArgument
    class Anonymous < Signers::Base
      def sign(request:, identity:, properties:)
        # Do nothing.
      end

      def sign_initial_event_stream_request(request:, identity:, properties:)
        nil
      end

      # rubocop:disable Metrics/ParameterLists
      def sign_event(message:, prior_signature:,
                     identity:, properties:, event_type:, encoder:)
        [message, prior_signature]
      end
      # rubocop:enable Metrics/ParameterLists

      def reset(request:, properties:)
        # Do nothing.
      end
    end
    # rubocop:enable Lint/UnusedMethodArgument
  end
end
