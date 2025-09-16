# frozen_string_literal: true

module Smithy
  module Client
    # Identity class for API Key authentication.
    class ApiKey
      def initialize(options = {})
        @key = options[:key]
      end

      # @return [String, nil]
      attr_reader :key

      # @return [Boolean]
      def set?
        @key && !@key.empty?
      end

      # @api private
      def inspect
        super.gsub(/@key="(\\"|[^"])*"/, '@key=[FILTERED]')
      end
    end
  end
end
