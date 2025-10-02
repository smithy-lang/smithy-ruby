# frozen_string_literal: true

module Smithy
  module Client
    # Contains information about candidate authentication schemes.
    class AuthOption
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
