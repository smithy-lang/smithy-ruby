# frozen_string_literal: true

module Hearth
  module HTTP2
    describe Client do
      let(:debug_output) { true }
      let(:client_logger) { double }
      let(:logger) { double }
      let(:open_timeout) { 1 }
      let(:read_timeout) { 2 }
      let(:max_concurrent_streams) { 3 }
      let(:verify_peer) { false }
      let(:ca_file) { 'ca_file' }
      let(:ca_path) { 'ca_path' }
      let(:cert_store) { 'cert_store' }
      let(:enable_alpn) { false }
      let(:host_resolver) { double }

      let(:client_options) do
        {
          logger: client_logger,
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
        }
      end

      subject { Client.new(**client_options) }

      let(:http_method) { :get }
      let(:uri) { URI('http://example.com/some/path?query') }
      let(:fields) { HTTP::Fields.new }
      let(:body_data) { 'payload' }
      let(:request_body) { StringIO.new(body_data) }
      let(:keep_open) { true }

      let(:request) do
        Request.new(
          http_method: http_method,
          uri: uri,
          fields: fields,
          body: request_body,
          keep_open: keep_open
        )
      end
      let(:response) { Response.new }
      let(:pool) { double }
      let(:connection) { double }
      let(:stream) { double(nil?: false) }
      let(:callbacks) { {} }
      let(:response_headers) do
        { 'header1' => 'value1', 'header2' => 'value2' }
      end
      let(:response_data) { 'data' }

      before(:each) do
        allow(ConnectionPool).to receive(:for).and_return(pool)
        allow(pool).to receive(:connection_for).and_return(connection)
        allow(connection).to receive(:new_stream).and_return(stream)
        allow(pool).to receive(:offer)

        allow(stream).to receive(:on) do |name, &block|
          callbacks[name] = block
        end

        allow(stream).to receive(:headers)
        allow(stream).to receive(:data)
        allow(client_logger).to receive(:debug)
      end

      describe '#initialize' do
        it 'raises when given unknown keys' do
          expect do
            Client.new(unknown: 'foo')
          end.to raise_error(ArgumentError, /unknown/)
        end
      end

      describe '#transmit' do
        it 're-uses a connection from the connection pool' do
          expect(ConnectionPool).to receive(:for).and_return(pool)
          expect(pool).to receive(:connection_for)
            .with(uri).and_return(connection)
          expect(Hearth::HTTP2::Connection).not_to receive(:new)
          expect(pool).to receive(:offer).with(uri, connection)

          subject.transmit(request: request, response: response, logger: logger)
        end

        it 'creates a new connection when non are available' do
          expect(ConnectionPool).to receive(:for).and_return(pool)
          expect(pool).to receive(:connection_for)
            .with(uri).and_yield
          expect(Hearth::HTTP2::Connection).to receive(:new)
            .with(endpoint: uri, **client_options)
            .and_return(connection)
          expect(pool).to receive(:offer).with(uri, connection)

          subject.transmit(request: request, response: response, logger: logger)
        end

        it 'creates a new connection when new_stream is nil' do
          over_capacity_conn = double
          expect(ConnectionPool).to receive(:for).and_return(pool)
          expect(pool).to receive(:connection_for)
            .and_return(over_capacity_conn)
          expect(over_capacity_conn).to receive(:new_stream).and_return(nil)
          expect(pool).to receive(:offer).with(uri, over_capacity_conn)

          expect(Hearth::HTTP2::Connection).to receive(:new)
            .with(endpoint: uri, **client_options)
            .and_return(connection)
          expect(connection).to receive(:new_stream).and_return(stream)

          expect(pool).to receive(:offer).with(uri, connection)

          subject.transmit(request: request, response: response, logger: logger)
        end

        it 'closes the connection on error' do
          expect(stream).to receive(:headers).and_raise(SocketError)
          expect(connection).to receive(:finish)
          expect do
            subject.transmit(
              request: request, response: response, logger: logger
            )
          end.to raise_error(SocketError)
        end

        it 'adds h2 required headers' do
          expected_headers = {
            ':authority' => 'example.com',
            ':method' => :GET,
            ':path' => '/some/path?query',
            ':scheme' => 'http'
          }
          expect(stream).to receive(:headers)
            .with(expected_headers, end_stream: false)

          subject.transmit(request: request, response: response, logger: logger)
        end

        it 'transmits the body' do
          expect(stream).to receive(:data)
            .with(body_data, end_stream: !keep_open)

          subject.transmit(request: request, response: response, logger: logger)
        end

        it 'sets the stream on the response' do
          subject.transmit(request: request, response: response, logger: logger)
          expect(response.stream).to eq(stream)
        end

        context 'response.body is an EventStream::Decoder' do
          before(:each) do
            response.body = double
            allow(response.body).to receive(:is_a?)
              .with(EventStream::Decoder)
              .and_return(true)
          end

          it 'emits headers using the decoder' do
            subject.transmit(request: request, response: response,
                             logger: logger)

            expect(response.body).to receive(:emit_headers)
              .with(response_headers)
            callbacks[:headers].call(response_headers)
          end
        end

        it 'sets headers on response when received' do
          subject.transmit(request: request, response: response, logger: logger)

          callbacks[:headers].call(response_headers)
          expect(response.headers.to_h).to eq(response_headers)
        end

        it 'writes data to the response body when received' do
          subject.transmit(request: request, response: response, logger: logger)

          expect(response.body).to receive(:write).with(response_data)
          callbacks[:data].call(response_data)
        end

        it 'signals close on the response' do
          subject.transmit(request: request, response: response, logger: logger)

          callbacks[:close].call

          expect(response.sync_queue.pop).to eq('stream-closed')
        end
      end
    end
  end
end
