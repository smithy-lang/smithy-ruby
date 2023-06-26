# frozen_string_literal: true

module Hearth
  module DNS
    # Resolves a host name and service to an IP address. Can be used with
    # {Hearth::HTTP::Client} host_resolver option. This implementation uses
    # Addrinfo.getaddrinfo to resolve the host name.
    # @see https://ruby-doc.org/stdlib-3.0.2/libdoc/socket/rdoc/Addrinfo.html
    class HostResolver
      # @param [Integer] service (443)
      # @param [Integer] family (nil)
      # @param [Symbol] socktype (:SOCK_STREAM)
      # @param [Integer] protocol (nil)
      # @param [Integer] flags (nil)
      def initialize(service: 443, family: nil, socktype: :SOCK_STREAM,
                     protocol: nil, flags: nil)
        @service = service
        @family = family
        @socktype = socktype
        @protocol = protocol
        @flags = flags
      end

      # @return [Integer]
      attr_reader :service

      # @return [Integer]
      attr_reader :family

      # @return [Symbol]
      attr_reader :socktype

      # @return [Integer]
      attr_reader :protocol

      # @return [Integer]
      attr_reader :flags

      # @param [String] nodename
      # @param (see Hearth::DNS::HostResolver#initialize)
      def resolve_address(nodename:, **kwargs)
        options = kwargs.merge(nodename: nodename)
        addrinfo_list = addrinfo(options)
        ipv6 = ipv6_addr(addrinfo_list, options) if use_ipv6?
        ipv4 = ipv4_addr(addrinfo_list, options)
        [ipv6, ipv4]
      end

      private

      def addrinfo(options)
        Addrinfo.getaddrinfo(
          options[:nodename],
          options.fetch(:service, @service),
          options.fetch(:family, @family),
          options.fetch(:socktype, @socktype),
          options.fetch(:protocol, @protocol),
          options.fetch(:flags, @flags)
        )
      end

      def ipv4_addr(addrinfo_list, options)
        addr = addrinfo_list.find(&:ipv4?)
        return unless addr

        HostAddress.new(
          address_type: :A,
          address: addr.ip_address,
          hostname: options[:nodename]
        )
      end

      def ipv6_addr(addrinfo_list, options)
        addr = addrinfo_list.find(&:ipv6?)
        return unless addr

        HostAddress.new(
          address_type: :AAAA,
          address: addr.ip_address,
          hostname: options[:nodename]
        )
      end

      def use_ipv6?
        Socket.ip_address_list.any? do |a|
          a.ipv6? && !a.ipv6_loopback? && !a.ipv6_linklocal?
        end
      end
    end
  end
end
