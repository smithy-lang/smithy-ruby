# frozen_string_literal: true

module Hearth
  module DNS
    # Address results from a DNS lookup in {HostResolver}.
    class HostAddress
      # @param [Symbol] :address_type The type of address. For example,
      #  :A or :AAAA.
      # @param [String] :address The IP address.
      # @param [String] :hostname The hostname that was resolved.
      def initialize(address_type:, address:, hostname:)
        @address_type = address_type
        @address = address
        @hostname = hostname
      end

      # The type of address. For example, :A or :AAAA.
      # @return [Symbol]
      attr_accessor :address_type

      # The IP address.
      # @return [String]
      attr_accessor :address

      # The hostname that was resolved.
      # @return [String]
      attr_accessor :hostname
    end
  end
end
