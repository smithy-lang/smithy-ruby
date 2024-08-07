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
          closed?: false, eof?: true, close: nil
        )
      end
      let(:sockaddr) { double }
      let(:thread) { double(kill: nil) }
      let(:h2_client) { double }
      let(:callbacks) { {} } # used for temp storage
      let(:frame) { 'frame_data' }

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
          callbacks[:thread_block] = block
          thread
        end
        allow(thread).to receive(:report_on_exception=)
        allow(::Socket).to receive(:getaddrinfo).and_return(
          [[addr, addr, addr, addr]]
        )
        allow(::Socket).to receive(:sockaddr_in).and_return(sockaddr)

        allow(::HTTP2::Client).to receive(:new).and_return(h2_client)
        allow(h2_client).to receive(:on) do |name, &block|
          callbacks[name] = block
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

        it 'raises when trying to write h2 data to closed' do
          subject

          allow(socket).to receive(:closed?).and_return(true)
          expect do
            callbacks[:frame].call('frame')
          end.to raise_error(Hearth::HTTP2::ConnectionClosedError)
        end

        it 'prints h2 stream data to the socket' do
          subject

          expect(socket).to receive(:print).with(frame)
          expect(socket).to receive(:flush)
          callbacks[:frame].call(frame)
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

        context 'verify_peer: false' do
          let(:verify_peer) { false }

          it 'does not verify peer' do
            expect(OpenSSL::SSL::SSLSocket).to receive(:new) do |_tcp, tls|
              expect(tls.verify_mode).to eq(OpenSSL::SSL::VERIFY_NONE)
              socket
            end

            subject
          end
        end

        context 'verify_peer' do
          let(:verify_peer) { true }

          it 'verifies peer' do
            expect(OpenSSL::SSL::SSLSocket).to receive(:new) do |_, tls|
              expect(tls.verify_mode).to eq(OpenSSL::SSL::VERIFY_PEER)
              socket
            end

            subject
          end

          it 'configures default certs' do
            allow(File).to receive(:exist?).and_return(true)
            allow(Dir).to receive(:exist?).and_return(true)

            expect(OpenSSL::SSL::SSLSocket).to receive(:new) do |_, tls|
              expect(tls.ca_file).to eq(OpenSSL::X509::DEFAULT_CERT_FILE)
              expect(tls.ca_path).to eq(OpenSSL::X509::DEFAULT_CERT_DIR)
              socket
            end

            subject
          end

          context 'certs/ca configured' do
            let(:ca_file) { 'ca_file' }
            let(:ca_path) { 'ca_path' }
            let(:cert_store) { double }

            it 'configures certs' do
              expect(OpenSSL::SSL::SSLSocket).to receive(:new) do |_, tls|
                expect(tls.ca_file).to eq(ca_file)
                expect(tls.ca_path).to eq(ca_path)
                expect(tls.cert_store).to eq(cert_store)
                socket
              end

              subject
            end
          end
        end

        context 'debug_output' do
          let(:debug_output) { true }
          let(:logger) { double }

          it 'logs connections and frame data' do
            expect(logger).to receive(:debug)
              .with('opening connection to example.com:443')
            expect(logger).to receive(:debug)
              .with('starting TLS for example.com:443')
            subject

            expect(logger).to receive(:debug)
              .with('-> frame: "frame_data"')
            callbacks[:frame_sent].call(frame)

            expect(logger).to receive(:debug)
              .with('<- frame: "frame_data"')
            callbacks[:frame_received].call(frame)
          end
        end
      end

      describe '#socket_read_loop' do
        it 'closes the socket after eof' do
          subject
          expect(socket).to receive(:eof?).and_return(true)
          expect(subject).to receive(:close)
          callbacks[:thread_block].call
        end

        it 'writes data to the h2_client' do
          subject
          expect(socket).to receive(:eof?).and_return(false, true)
          expect(socket).to receive(:read_nonblock).and_return(frame)
          expect(h2_client).to receive(:<<).with(frame)
          expect(subject).to receive(:close)
          callbacks[:thread_block].call
        end

        context 'read_timeout' do
          let(:read_timeout) { 1 }

          it 'waits to read' do
            expect(socket).to receive(:eof?).and_return(false, true)
            expect(socket).to receive(:read_nonblock)
              .and_return(:wait_readable)
            expect(socket).to receive(:wait_readable).with(read_timeout)
                                                     .and_return(true)
            expect(socket).to receive(:read_nonblock).and_return(frame)
            expect(h2_client).to receive(:<<).with(frame)
            expect(subject).to receive(:close)
            callbacks[:thread_block].call
          end

          it 'raises after timeout' do
            expect(socket).to receive(:eof?).and_return(false)
            expect(socket).to receive(:read_nonblock)
              .and_return(:wait_readable)
            expect(socket).to receive(:wait_readable).with(read_timeout)
                                                     .and_return(false)
            expect(subject).to receive(:close).at_least(:once)
            expect do
              callbacks[:thread_block].call
            end.to raise_error(NetworkingError)
          end
        end
      end

      describe '#new_stream' do
        let(:max_concurrent_streams) { 1 }
        let(:stream) { double(id: 1) }
        it 'returns nil when stale' do
          subject.instance_variable_set(:@healthy, false)
          expect(subject.new_stream).to be_nil
        end

        it 'creates and returns a stream' do
          expect(h2_client).to receive(:new_stream).and_return(stream)
          expect(subject.new_stream).to eq(stream)
        end

        it 'returns nil when streams > max configured streams' do
          expect(h2_client).to receive(:new_stream).and_return(stream)
          subject.new_stream

          # try to create a second stream
          expect(subject.new_stream).to be_nil
        end

        it 'returns nil when server exceeds stream limit' do
          expect(h2_client).to receive(:new_stream)
            .and_raise(::HTTP2::Error::StreamLimitExceeded)
          expect(subject.new_stream).to be_nil
        end
      end

      describe '#close_stream' do
        let(:stream) { double(id: 1) }

        it 'closes the stream' do
          allow(h2_client).to receive(:new_stream).and_return(stream)
          subject.new_stream

          expect(stream).to receive(:close)
          subject.close_stream(stream)
        end
      end

      describe '#close' do
        let(:stream) { double(id: 1, state: :open) }

        it 'closes streams and the socket' do
          allow(h2_client).to receive(:new_stream).and_return(stream)
          subject.new_stream

          expect(stream).to receive(:close)
          expect(thread).to receive(:kill)
          expect(socket).to receive(:close)

          subject.close

          expect(subject.stale?).to be_truthy
        end
      end
    end
  end
end
