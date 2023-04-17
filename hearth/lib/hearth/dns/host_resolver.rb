# frozen_string_literal: true

module Hearth
  module DNS
    # Resolve a host name to an address.
    # @api private
    class HostResolver
      def resolve_address(options = {})
        options = { service: 443, socktype: :SOCK_STREAM }.merge(options)
        addrinfo_list = addrinfo(options)
        ipv6 = ipv6_addr(addrinfo_list, options)
        ipv4 = ipv4_addr(addrinfo_list, options)
        [ipv6, ipv4].compact
      end

      private

      def addrinfo(options)
        Addrinfo.getaddrinfo(
          options[:nodename],
          options[:service],
          options[:family],
          options[:socktype],
          options[:protocol],
          options[:flags]
        )
      end

      def ipv4_addr(addrinfo_list, options)
        addr = addrinfo_list.find(&:ipv4?)
        return unless addr

        HostAddress.new(
          address_type: :A,
          address: addr.ip_address,
          hostname: options[:nodename],
          service: options[:service]
        )
      end

      def ipv6_addr(addrinfo_list, options)
        addr = addrinfo_list.find(&:ipv6?)
        return unless addr

        HostAddress.new(
          address_type: :AAAA,
          address: addr.ip_address,
          hostname: options[:nodename],
          service: options[:service]
        )
      end
    end
  end
end
