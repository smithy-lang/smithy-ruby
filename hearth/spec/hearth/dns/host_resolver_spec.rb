# frozen_string_literal: true

module Hearth
  module DNS
    describe HostResolver do
      let(:nodename) { 'example.com' }
      let(:service) { 443 }
      let(:family) { :INET }
      let(:socktype) { :SOCK_STREAM }
      let(:protocol) { 0 }
      let(:flags) { Socket::AI_ALL | Socket::AI_V4MAPPED }

      let(:addrinfo_ipv4) do
        double(Addrinfo, ipv4?: true, ipv6?: false, ip_address: '127.0.0.1')
      end
      let(:addrinfo_ipv6) do
        double(Addrinfo, ipv4?: false, ipv6?: true, ip_address: '::1')
      end
      let(:addrinfo_list) { [addrinfo_ipv4, addrinfo_ipv6] }

      subject do
        HostResolver.new(
          service: service,
          family: family,
          socktype: socktype,
          protocol: protocol,
          flags: flags
        )
      end

      describe '#initialize' do
        it 'sets empty defaults' do
          host_resolver = HostResolver.new
          expect(host_resolver.service).to eq(443)
          expect(host_resolver.family).to be_nil
          expect(host_resolver.socktype).to eq(:SOCK_STREAM)
          expect(host_resolver.protocol).to be_nil
          expect(host_resolver.flags).to be_nil
        end
      end

      describe '#resolve_address' do
        it 'uses instance defaults' do
          expect(Addrinfo).to receive(:getaddrinfo).with(
            nodename,
            service,
            family,
            socktype,
            protocol,
            flags
          ).and_return(addrinfo_list)
          subject.resolve_address(nodename: nodename)
        end

        it 'uses passed in options' do
          service = 80
          family = :INET6
          socktype = :SOCK_DGRAM
          protocol = nil
          flags = nil

          expect(Addrinfo).to receive(:getaddrinfo).with(
            nodename,
            service,
            family,
            socktype,
            protocol,
            flags
          ).and_return(addrinfo_list)
          subject.resolve_address(
            nodename: nodename,
            service: service,
            family: family,
            socktype: socktype,
            protocol: protocol,
            flags: flags
          )
        end

        it 'returns host address objects' do
          expect(Addrinfo).to receive(:getaddrinfo).and_return(addrinfo_list)
          ipv6, ipv4 = subject.resolve_address(nodename: nodename)
          expect(ipv4).to be_a(Hearth::DNS::HostAddress)
        end

        context 'ipv6 is not available' do
          before do
            allow(subject).to receive(:use_ipv6?).and_return(false)
          end

          it 'returns host addresses' do
            expect(Addrinfo).to receive(:getaddrinfo).and_return(addrinfo_list)
            ipv6, ipv4 = subject.resolve_address(nodename: nodename)
            expect(ipv6).to be_nil
            expect(ipv4.address).to eq(addrinfo_ipv4.ip_address)
          end
        end

        context 'ipv6 is available' do
          before do
            allow(subject).to receive(:use_ipv6?).and_return(true)
          end

          it 'returns host addresses' do
            expect(Addrinfo).to receive(:getaddrinfo).and_return(addrinfo_list)
            ipv6, ipv4 = subject.resolve_address(nodename: nodename)
            expect(ipv6.address).to eq(addrinfo_ipv6.ip_address)
            expect(ipv4.address).to eq(addrinfo_ipv4.ip_address)
          end
        end
      end
    end
  end
end
