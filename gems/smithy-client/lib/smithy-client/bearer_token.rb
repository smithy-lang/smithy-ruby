# frozen_string_literal: true

module Smithy
  module Client
    # Identity class for Bearer token authentication.
    class BearerToken
      def initialize(options = {})
        @token = options[:token]
      end

      # @return [String, nil]
      attr_reader :token

      # @return [Boolean]
      def set?
        !!@token && !@token.empty?
      end

      # @api private
      def inspect
        super.gsub(/@token="(\\"|[^"])*"/, '@token=[FILTERED]')
      end
    end
  end
end
