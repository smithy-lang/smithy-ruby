# frozen_string_literal: true

module Hearth
  module DNS
    # Address results from a DNS lookup.
    # @api private
    class HostAddress
      def initialize(address_type:, address:, hostname:, service:)
        @address_type = address_type
        @address = address
        @hostname = hostname
        @service = service
      end

      # @return [Symbol]
      attr_reader :address_type

      # @return [String]
      attr_reader :address

      # @return [String]
      attr_reader :hostname

      # @return [Integer]
      attr_reader :service
    end
  end
end
