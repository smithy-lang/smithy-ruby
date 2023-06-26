# frozen_string_literal: true

module Hearth
  module DNS
    # Address results from a DNS lookup in {HostResolver}.
    class HostAddress
      def initialize(address_type:, address:, hostname:)
        @address_type = address_type
        @address = address
        @hostname = hostname
      end

      # @return [Symbol]
      attr_reader :address_type

      # @return [String]
      attr_reader :address

      # @return [String]
      attr_reader :hostname
    end
  end
end
