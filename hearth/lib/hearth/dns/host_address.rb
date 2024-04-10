# frozen_string_literal: true

module Hearth
  module DNS
    # Address results from a DNS lookup in {HostResolver}.
    # @!method initialize(*args)
    #   @option args [Symbol] :address_type The type of address. For example,
    #    :A or :AAAA.
    #   @option args [String] :address The IP address.
    #   @option args [String] :hostname The hostname that was resolved.
    # @!attribute address_type
    #   The type of address. For example, :A or :AAAA.
    #   @return [Symbol]
    # @!attribute address
    #   The IP address.
    #   @return [String]
    # @!attribute hostname
    #   The hostname that was resolved.
    #   @return [String]
    HostAddress = Struct.new(
      :address_type,
      :address,
      :hostname,
      keyword_init: true
    )
  end
end
