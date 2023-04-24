# frozen_string_literal: true

module Hearth
  module DNS
    context 'DNS resolution patch' do
      let(:host_resolver) { Hearth::DNS::HostResolver.new }
      let(:hostname) { 'example.com' }

      let(:ipv6_host_address) do
        Hearth::DNS::HostAddress.new(
          address: '::1',
          address_type: :AAAA,
          hostname: hostname
        )
      end
      let(:ipv4_host_address) do
        Hearth::DNS::HostAddress.new(
          address: '127.0.0.1',
          address_type: :A,
          hostname: hostname
        )
      end

      context 'IPSocket' do
        context 'configured resolver' do
          before do
            Thread.current[:net_http_hearth_dns_resolver] = host_resolver
          end

          it 'prefers ipv6' do
            expect(host_resolver).to receive(:resolve_address)
              .with(nodename: 'example.com')
              .and_return([ipv6_host_address, ipv4_host_address])
            addr = IPSocket.getaddress('example.com')
            expect(addr).to eq(ipv6_host_address.address)
          end

          it 'falls back to ipv4' do
            expect(host_resolver).to receive(:resolve_address)
              .with(nodename: 'example.com')
              .and_return([nil, ipv4_host_address])
            addr = IPSocket.getaddress('example.com')
            expect(addr).to eq(ipv4_host_address.address)
          end
        end

        context 'no configured resolver' do
          before do
            Thread.current[:net_http_hearth_dns_resolver] = nil
          end

          it 'uses stdlib if no resolver is set' do
            expect(IPSocket).to receive(:original_hearth_getaddress)
              .with(hostname) # aliased original method
            expect(host_resolver).not_to receive(:resolve_address)
            IPSocket.getaddress('example.com')
          end
        end
      end

      context 'TCPSocket' do
        let(:service) { 443 }
        let(:proxy_host) { 'proxy.example.com' }
        let(:proxy_addr) { '123.123.123.123' }
        let(:proxy_port) { 8080 }

        context 'configured resolver' do
          before do
            Thread.current[:net_http_hearth_dns_resolver] = host_resolver
          end

          it 'calls original with patched IPSocket' do
            address = ipv4_host_address.address
            expect(IPSocket).to receive(:getaddress)
              .with(hostname).and_return(address)
            expect_any_instance_of(TCPSocket)
              .to receive(:original_hearth_initialize).with(address, service)
            TCPSocket.new(hostname, service)
          end

          it 'calls original with patched IPSocket and proxy' do
            address = ipv4_host_address.address
            expect(IPSocket).to receive(:getaddress)
              .with(hostname).and_return(address)
            expect(IPSocket).to receive(:getaddress)
              .with(proxy_host).and_return(proxy_addr)
            expect_any_instance_of(TCPSocket)
              .to receive(:original_hearth_initialize)
              .with(address, service, proxy_addr, proxy_port)
            TCPSocket.new(hostname, service, proxy_host, proxy_port)
          end
        end

        context 'no configured resolver' do
          before do
            Thread.current[:net_http_hearth_dns_resolver] = nil
          end

          it 'uses stdlib if no resolver is set' do
            expect_any_instance_of(TCPSocket)
              .to receive(:original_hearth_initialize)
              .with(hostname, service, proxy_host, proxy_port)
            expect(IPSocket).to_not receive(:getaddress)
            TCPSocket.new(hostname, service, proxy_host, proxy_port)
          end
        end
      end
    end
  end
end