# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: RPCv2CBOR' do
  ['generated client gem', 'generated client from source code'].each do |context|
    before(:all) do
      Class.new(Smithy::Weld) do
        def for?(service)
          service.keys.first == 'smithy.ruby.tests#WeldProtocolService'
        end

        def plugins
          {
            Smithy::Client::Plugins::RPCv2CBOR => {
              require_path: 'smithy-client/plugins/rpc_v2_cbor'
            }
          }
        end
      end
    end

    context 'no protocol' do
      include_context context, 'NoProtocol'

      it 'does not have a protocol config' do
        client = NoProtocol::Client.new(endpoint: 'https://example.com')
        expect(client.config).to_not respond_to(:protocol)
      end
    end

    context 'registered protocol' do
      include_context context, 'WeldProtocol'

      it 'defaults to the protocol' do
        client = WeldProtocol::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be('smithy-rpc-v2-cbor')
      end
    end

    context 'default cbor protocol' do
      include_context context, 'Rpcv2Protocol'

      it 'defaults to the rpcv2Cbor protocol' do
        client = Rpcv2Protocol::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be('smithy-rpc-v2-cbor')
      end
    end
  end
end
