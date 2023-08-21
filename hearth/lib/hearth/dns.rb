# frozen_string_literal: true

require 'socket'

require_relative 'dns/host_address'
require_relative 'dns/host_resolver'

# These patches are based on resolv-replace
# https://github.com/ruby/ruby/blob/master/lib/resolv-replace.rb
# We cannot require resolv-replace because it would change DNS resolution
# globally. When opening an HTTP request, we will set a thread local variable
# to enable custom DNS resolution, and then disable it after the request is
# complete. When the thread local variable is not set, we will use the default
# Ruby DNS resolution, which may be Resolv or the system resolver.

# Patch IPSocket
# @api private
class << IPSocket
  alias original_hearth_getaddress getaddress

  def getaddress(host)
    unless (resolver = Thread.current[:net_http_hearth_dns_resolver])
      return original_hearth_getaddress(host)
    end

    ipv6, ipv4 = resolver.resolve_address(nodename: host)
    return ipv6.address if ipv6

    ipv4.address
  end
end

# Patch TCPSocket
# @api private
class TCPSocket < IPSocket
  alias original_hearth_initialize initialize

  # rubocop:disable Lint/MissingSuper
  def initialize(host, serv, *rest)
    if Thread.current[:net_http_hearth_dns_resolver]
      rest[0] = IPSocket.getaddress(rest[0]) if rest[0]
      original_hearth_initialize(IPSocket.getaddress(host), serv, *rest)
    else
      original_hearth_initialize(host, serv, *rest)
    end
  end
  # rubocop:enable Lint/MissingSuper
end
