# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Welds: Protocols' do
  ['generated client gem', 'generated client from source code'].each do |context|
    before(:all) do
      Class.new(Smithy::Weld) do
        def for?(service)
          service.keys.first == 'smithy.ruby.tests#WeldProtocolService'
        end

        def protocols
          { 'rpcv2Cbor' => Smithy::Client::RPCv2CBOR::Protocol, 'other' => Class }
        end
      end
    end

    context 'no protocol' do
      include_context context, 'NoProtocol'

      it 'does not have a protocol config' do
        client = NoProtocol::Client.new
        expect(client.config.protocol).to be_nil
      end
    end

    context 'modeled protocol' do
      include_context context, 'Rpcv2Protocol'

      it 'defaults to the rpcv2Cbor protocol' do
        client = Rpcv2Protocol::Client.new
        expect(client.config.protocol).to be_a(Smithy::Client::RPCv2CBOR::Protocol)
      end
    end

    context 'welded protocol' do
      include_context context, 'WeldProtocol'

      it 'defaults to the first protocol' do
        client = WeldProtocol::Client.new
        expect(client.config.protocol).to be_a(Smithy::Client::RPCv2CBOR::Protocol)
      end

      it 'can be configured to use a supported protocol' do
        client = WeldProtocol::Client.new(protocol: 'other')
        expect(client.config.protocol).to be_a(Class)
      end
    end
  end
end
