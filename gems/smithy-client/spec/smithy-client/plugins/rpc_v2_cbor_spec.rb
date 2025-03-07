# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/rpc_v2_cbor'

module Smithy
  module Client
    module Plugins
      describe RPCv2CBOR do
        let(:client_class) do
          client_class = ClientHelper.sample_service.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(RPCv2CBOR)
          client_class
        end

        let(:client) { client_class.new }

        it 'adds a :protocol option to config' do
          expect(client.config).to respond_to(:protocol)
        end

        it 'defaults :protocol to smithy-rpc-v2-cbor' do
          expect(client.config.protocol).to eq('smithy-rpc-v2-cbor')
        end

        it 'does not add the handlers and stubber if :protocol is not smithy-rpc-v2-cbor' do
          client = client_class.new(protocol: 'some-other-protocol')
          expect(client.handlers).not_to include(RPCv2CBOR::BuildHandler)
          expect(client.handlers).not_to include(RPCv2CBOR::ParseHandler)
          expect(client.config.stubber).not_to eq(RPCv2CBOR::Stubber)
        end

        it 'adds the handler and stubber if :protocol is smithy-rpc-v2-cbor' do
          expect(client.handlers).to include(RPCv2CBOR::BuildHandler)
          expect(client.handlers).to include(RPCv2CBOR::ParseHandler)
          expect(client.config.stubber).to eq(RPCv2CBOR::Stubber)
        end

        context 'multi protocol' do
          let(:some_other_protocol) do
            Class.new(Plugin) do
              option(:protocol, 'some-other-protocol')
            end
          end

          before { client_class.add_plugin(some_other_protocol) }

          it 'allows other added protocol plugins to take default precedence' do
            expect(client.config.protocol).to eq('some-other-protocol')
          end

          it 'can still be configured to use smithy-rpc-v2-cbor' do
            client = client_class.new(protocol: 'smithy-rpc-v2-cbor')
            expect(client.handlers).to include(RPCv2CBOR::BuildHandler)
            expect(client.handlers).to include(RPCv2CBOR::ParseHandler)
            expect(client.config.stubber).to eq(RPCv2CBOR::Stubber)
          end
        end
      end
    end
  end
end
