# frozen_string_literal: true

module Hearth
  module DNS
    # Resolve a host name to an address.
    # @api private
    class HostResolver
      def resolve_address(options = {})
        addrinfo_list = addrinfo(options)
        ipv6 = ipv6_addr(addrinfo_list, options) if use_ipv6?
        ipv4 = ipv4_addr(addrinfo_list, options)
        [ipv6, ipv4]
      end

      private

      def addrinfo(options)
        Addrinfo.getaddrinfo(
          options[:nodename],
          options[:service],
          options[:family],
          options[:socktype] || :SOCK_STREAM,
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

      def use_ipv6?
        begin
          list = Socket.ip_address_list
        rescue NotImplementedError
          return true
        end
        list.any? { |a| a.ipv6? && !a.ipv6_loopback? && !a.ipv6_linklocal? }
      end
    end
  end
end
