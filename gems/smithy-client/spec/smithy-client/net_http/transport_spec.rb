# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/transport'

module Smithy
  module Client
    module NetHTTP
      describe Transport do
        let(:endpoint) { 'https://example.com' }

        subject { described_class.new }

        it_behaves_like 'a transport' do
          let(:transport) { described_class.new }
        end

        # NOTE: transmit / transmit_background behavior (push into sink, return
        # value, invalid-verb ArgumentError, networking-failure terminal, handle
        # returned for the background path) is covered by the shared 'a transport'
        # compliance examples above. The specs below cover only what is specific
        # to this transport: event_queue, default wiring, and option mapping.

        describe '#event_queue' do
          it 'returns a fresh SizedQueue with the bridge capacity' do
            q1 = subject.event_queue
            q2 = subject.event_queue
            expect(q1).to be_a(SizedQueue)
            expect(q1.max).to eq(64)
            # Fresh per call - the event stream layer gets its own bridge queue.
            expect(q1).not_to be(q2)
          end
        end

        describe 'default wiring' do
          let(:client_class) do
            klass = Class.new(Client::Base)
            klass.add_plugin(Plugins::Logging)
            klass.add_plugin(Plugins::Transport)
            klass
          end

          it 'is the default :transport for a client configured with the Transport plugin' do
            expect(client_class.new.config.transport).to be_a(described_class)
          end
        end

        describe 'option mapping' do
          it 'maps transport-agnostic options onto Net::HTTP pool options' do
            expect(ConnectionPool).to receive(:for).with(
              hash_including(
                http_open_timeout: 5,
                http_read_timeout: 10,
                http_verify_mode: OpenSSL::SSL::VERIFY_NONE,
                http_ca_file: '/bundle.pem',
                http_ca_path: '/certs',
                http_cert_store: :a_store,
                http_proxy: 'http://proxy:8080',
                http_debug_output: true
              )
            )
            described_class.new(
              connect_timeout: 5,
              read_timeout: 10,
              ssl_verify_peer: false,
              ssl_ca_bundle: '/bundle.pem',
              ssl_ca_directory: '/certs',
              ssl_ca_store: :a_store,
              http_proxy: 'http://proxy:8080',
              http_wire_trace: true
            )
          end

          it 'maps ssl_verify_peer true (default) to VERIFY_PEER' do
            expect(ConnectionPool).to receive(:for).with(
              hash_including(http_verify_mode: OpenSSL::SSL::VERIFY_PEER)
            )
            described_class.new
          end

          it 'passes Net::HTTP-specific options through' do
            expect(ConnectionPool).to receive(:for).with(
              hash_including(
                http_continue_timeout: 1,
                http_keep_alive_timeout: 30,
                http_write_timeout: 7,
                http_ssl_timeout: 3,
                http_cert: :a_cert,
                http_key: :a_key
              )
            )
            described_class.new(
              continue_timeout: 1,
              keep_alive_timeout: 30,
              write_timeout: 7,
              ssl_timeout: 3,
              cert: :a_cert,
              key: :a_key
            )
          end
        end
      end
    end
  end
end
