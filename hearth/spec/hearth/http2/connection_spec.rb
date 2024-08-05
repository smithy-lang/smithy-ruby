# frozen_string_literal: true

module Hearth
  module HTTP2
    describe Connection do
      let(:debug_output) { false }
      let(:logger) { nil }
      let(:open_timeout) { nil }
      let(:read_timeout) { nil }
      let(:max_concurrent_streams) { nil }
      let(:verify_peer) { false }
      let(:ca_file) { nil }
      let(:ca_path) { nil }
      let(:cert_store) { nil }
      let(:enable_alpn) { nil }
      let(:host_resolver) { nil }
      let(:endpoint) { URI('https://example.com') }
      let(:addr) { 'addr' }

      let(:socket) do
        double(
          setsockopt: nil, connect: nil,
          closed?: true, eof?: true, close: nil
        )
      end
      let(:sockaddr) { double }
      let(:thread) { double(kill: nil) }
      let(:h2_client) { double }
      let(:context) { {} } # used for temp storage

      subject do
        Connection.new(
          endpoint: endpoint,
          logger: logger,
          debug_output: debug_output,
          open_timeout: open_timeout,
          read_timeout: read_timeout,
          max_concurrent_streams: max_concurrent_streams,
          verify_peer: verify_peer,
          ca_file: ca_file,
          ca_path: ca_path,
          cert_store: cert_store,
          enable_alpn: enable_alpn,
          host_resolver: host_resolver
        )
      end

      before(:each) do
        allow(::Socket).to receive(:new).and_return(socket)
        allow(OpenSSL::SSL::SSLSocket).to receive(:new).and_return(socket)
        allow(socket).to receive(:connect_nonblock)
        allow(socket).to receive(:sync_close=)
        allow(socket).to receive(:hostname=)

        allow(Thread).to receive(:new) do |&block|
          context[:thread_block] = block
          thread
        end
        allow(thread).to receive(:report_on_exception=)
        allow(::Socket).to receive(:getaddrinfo).and_return(
          [[addr, addr, addr, addr]]
        )
        allow(::Socket).to receive(:sockaddr_in).and_return(sockaddr)

        allow(::HTTP2::Client).to receive(:new).and_return(h2_client)
        allow(h2_client).to receive(:on) do |name, &block|
          context[name] = block
        end
      end

      describe '#initialize' do
        it 'connects to the endpoint' do
          expect(::Socket).to receive(:getaddrinfo)
            .with('example.com', nil, ::Socket::AF_INET)
            .and_return([[addr, addr, addr, addr]])
          expect(socket).to receive(:connect_nonblock)
                              .with(sockaddr, exception: false)

          subject
        end

        context 'open_timeout' do
          let(:open_timeout) { 1 }

          it 'connects with the open_timeout' do
            expect(socket)
              .to receive(:connect_nonblock)
              .and_return(:wait_writable)

            expect(socket).to receive(:wait_writable)
              .with(open_timeout).and_return(true)

            # a second call
            expect(socket).to receive(:connect_nonblock)
            subject
          end

          it 'does not fail when waiting for socket that is already open' do
            expect(socket)
              .to receive(:connect_nonblock)
              .and_return(:wait_writable)

            expect(socket).to receive(:wait_writable)
              .with(open_timeout).and_return(true)
            # second call raises already connected
            expect(socket).to receive(:connect_nonblock)
              .and_raise(Errno::EISCONN)
            expect(subject.stale?).to be_falsey
          end

          it 'raises when open timeout fails' do
            expect(socket)
              .to receive(:connect_nonblock)
              .and_return(:wait_writable)

            expect(socket).to receive(:wait_writable).and_return(false)
            expect(socket).to receive(:close)
            expect do
              subject
            end.to raise_error(Hearth::NetworkingError)
          end
        end

        context 'http' do
          let(:endpoint) { URI('http://no-ssl.com') }

          it 'does not create an ssl socket' do
            expect(OpenSSL::SSL::SSLSocket).not_to receive(:new)

            subject
          end
        end

        context 'host_resolver' do
          let(:host_resolver) { double }
          let(:ipv6_addr) { double(address: 'ipv6') }
          let(:ipv4_addr) { double(address: 'ipv4') }

          it 'uses the ipv6 address when returned' do
            expect(host_resolver).to receive(:resolve_address)
              .with(nodename: endpoint.host)
              .and_return([ipv6_addr, ipv4_addr])
            expect(::Socket).to receive(:sockaddr_in)
              .with(endpoint.port, ipv6_addr.address)
              .and_return(sockaddr)
            subject
          end

          it 'uses the ipv4 address when no ipv6' do
            expect(host_resolver).to receive(:resolve_address)
              .with(nodename: endpoint.host)
              .and_return([nil, ipv4_addr])
            expect(::Socket).to receive(:sockaddr_in)
              .with(endpoint.port, ipv4_addr.address)
              .and_return(sockaddr)
            subject
          end
        end
      end
    end
  end
end
