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

        # A distinct subclass of NoOpProtocol (not NoOpProtocol itself) so the
        # "defaults to the first registered protocol" example proves resolution
        # against the registry, separate from the empty-registry fallback.
        let(:fake_protocol_class) { Class.new(Client::NoOpProtocol) }

        # Override the generated registry with a controlled double so the
        # plugin's resolution logic is tested in isolation from any real protocol.
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

        it 'adds the build, parse, and error handlers' do
          client = client_class.new(client_options)
          expect(client.handlers).to include(Protocol::BuildHandler)
          expect(client.handlers).to include(Protocol::ParseHandler)
          expect(client.handlers).to include(Protocol::ErrorHandler)
        end

        it 'adds the error handler at the :sign step (inside the retry loop)' do
          client = client_class.new(client_options)
          entry = client.handlers.entries.find { |e| e.handler_class == Protocol::ErrorHandler }
          expect(entry.step).to eq(:sign)
        end
      end

      describe Client::NoOpProtocol do
        subject(:protocol) { described_class.new }

        it 'returns nil from #build_request without raising' do
          expect(protocol.build_request(double('context'))).to be_nil
        end

        it 'returns nil from #parse_data without raising' do
          expect(protocol.parse_data(double('context'))).to be_nil
        end

        it 'returns nil from #parse_error without raising' do
          expect(protocol.parse_error(double('context'))).to be_nil
        end

        it 'returns an empty response from #stub_data' do
          response = protocol.stub_data(double('config'), double('operation'), {})
          expect(response).to be_a(Http::Response)
        end

        it 'returns an empty response from #stub_error' do
          response = protocol.stub_error(double('config'), 'ErrorCode')
          expect(response).to be_a(Http::Response)
        end
      end
    end
  end
end
