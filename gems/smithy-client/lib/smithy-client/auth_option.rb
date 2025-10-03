# frozen_string_literal: true

module Smithy
  module Client
    # Contains information about candidate authentication schemes.
    class AuthOption
      # @param [Hash] options
      # @option options [String] :scheme_id The auth scheme ID.
      # @option options [Hash] :signer_properties
      #   Additional properties to pass to the signer.
      #   This is a hash of String keys to String values and is signer-specific.
      def initialize(options = {})
        @scheme_id = options[:scheme_id]
        @signer_properties = options[:signer_properties] || {}
      end

      # @return [String]
      attr_reader :scheme_id

      # @return [Hash]
      attr_reader :signer_properties
    end
  end
end
