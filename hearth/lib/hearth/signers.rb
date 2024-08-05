# frozen_string_literal: true

module Hearth
  # Namespace for all Signer classes.
  module Signers
    # Base class for all Signer classes.
    class Base
      def sign(request:, identity:, properties:)
        raise NotImplementedError
      end

      # rubocop:disable Metrics/ParameterLists
      def sign_event(message:, prior_signature:,
                     identity:, properties:, event_type:, encoder:)
        raise NotImplementedError
      end
      # rubocop:enable Metrics/ParameterLists

      def reset(request:, properties:)
        raise NotImplementedError
      end
    end
  end
end

require_relative 'signers/anonymous'
require_relative 'signers/http_api_key'
require_relative 'signers/http_basic'
require_relative 'signers/http_bearer'
require_relative 'signers/http_digest'
