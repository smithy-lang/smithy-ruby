# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe Transport do
        let(:sample_client) { ClientHelper.sample_client }
        let(:client_class) { sample_client.const_get(:Client) }
        let(:client) { client_class.new(stub_responses: true) }

        it 'adds the transport-agnostic options' do
          options = %i[
            connect_timeout
            read_timeout
            ssl_verify_peer
            ssl_ca_bundle
            ssl_ca_directory
            ssl_ca_store
            http_wire_trace
            http_proxy
          ]
          options.each do |option|
            expect(client.config).to respond_to(option)
          end
        end

        it 'resolves a default NetHTTP transport' do
          expect(client.config.transport).to be_a(Client::NetHTTP::Transport)
        end

        it 'uses a caller-supplied transport as-is' do
          custom = double('transport', transmit: nil)
          expect(client_class.new(transport: custom).config.transport).to be(custom)
        end

        it 'accepts any object satisfying the transport contract (duck typed)' do
          conforming = double('transport')
          Client::Transport::REQUIRED_METHODS.each { |m| allow(conforming).to receive(m) }
          expect(client_class.new(transport: conforming).config.transport).to be(conforming)
        end

        it 'raises when a caller-supplied transport does not satisfy the contract' do
          expect { client_class.new(transport: Object.new) }
            .to raise_error(ArgumentError, /does not implement the transport contract \(transmit\)/)
        end

        it 'forwards the transport-agnostic options to the default transport' do
          expect(Client::NetHTTP::Transport).to receive(:new)
            .with(hash_including(read_timeout: 42)).and_call_original
          client_class.new(read_timeout: 42)
        end

        it 'registers the send handler' do
          # Not stubbed: stubbing replaces the :send handler with the stub.
          expect(client_class.new.handlers).to include(Client::SendHandler)
        end
      end
    end
  end
end
