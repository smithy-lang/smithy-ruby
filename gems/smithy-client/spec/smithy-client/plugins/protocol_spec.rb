# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/protocol'

module Smithy
  module Client
    module Plugins
      describe Protocol do
        let(:sample_client) { ClientHelper.sample_client }
        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(Protocol)
          client_class
        end
        let(:client_options) { { endpoint: 'https://example.com' } }

        let(:fake_protocol_class) do
          Class.new(Client::Protocol) do
            def build_request(_context); end
            def parse_data(_response); end
            def parse_error(_response); end
          end
        end

        # TODO: remove this test-only registry once the `protocols` weld is impl
        before do
          protocols = { rpc_v2_cbor: fake_protocol_class }
          client_class.define_singleton_method(:protocols) { protocols }
        end

        it 'adds a :protocol option to config' do
          client = client_class.new(client_options)
          expect(client.config).to respond_to(:protocol)
        end

        context 'when :protocol is not provided (default)' do
          it 'defaults to an instance of the first registered protocol' do
            client = client_class.new(client_options)
            expect(client.config.protocol).to be_a(fake_protocol_class)
          end

          it 'falls back to NoOpProtocol when no protocol is registered' do
            client_class.define_singleton_method(:protocols) { {} }
            client = client_class.new(client_options)
            expect(client.config.protocol).to be_a(Client::NoOpProtocol)
          end
        end

        context 'when :protocol is a Symbol' do
          it 'resolves to an instance of the named protocol' do
            client = client_class.new(client_options.merge(protocol: :rpc_v2_cbor))
            expect(client.config.protocol).to be_a(fake_protocol_class)
          end

          it 'raises an ArgumentError for an unknown protocol' do
            expect { client_class.new(client_options.merge(protocol: :nope)) }
              .to raise_error(ArgumentError, /Unknown protocol: nope/)
          end
        end

        context 'when :protocol is a custom object' do
          it 'uses the provided object as-is' do
            custom = fake_protocol_class.new
            client = client_class.new(client_options.merge(protocol: custom))
            expect(client.config.protocol).to be(custom)
          end
        end

        it 'adds the build and parse handlers' do
          client = client_class.new(client_options)
          expect(client.handlers).to include(Protocol::BuildHandler)
          expect(client.handlers).to include(Protocol::ParseHandler)
        end
      end

      describe 'Custom Protocol' do
        subject(:protocol) { described_class.new }

        it 'raises NotImplementedError for #build_request' do
          expect { protocol.build_request(double('context')) }
            .to raise_error(NotImplementedError)
        end

        it 'raises NotImplementedError for #parse_data' do
          expect { protocol.parse_data(double('response')) }
            .to raise_error(NotImplementedError)
        end

        it 'raises NotImplementedError for #parse_error' do
          expect { protocol.parse_error(double('response')) }
            .to raise_error(NotImplementedError)
        end
      end

      describe 'NoOp Protocol' do
        subject(:protocol) { described_class.new }

        it 'is a Protocol' do
          expect(protocol).to be_a(Client::Protocol)
        end

        it 'returns nil from #build_request without raising' do
          expect(protocol.build_request(double('context'))).to be_nil
        end

        it 'returns nil from #parse_data without raising' do
          expect(protocol.parse_data(double('response'))).to be_nil
        end

        it 'returns nil from #parse_error without raising' do
          expect(protocol.parse_error(double('response'))).to be_nil
        end
      end
    end
  end
end
