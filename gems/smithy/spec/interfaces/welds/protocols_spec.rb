# frozen_string_literal: true

describe 'Welds: Protocols' do
  ['generated client gem', 'generated client from source code'].each do |context|
    before(:all) do
      Class.new(Smithy::Weld) do
        def for?(service)
          service.keys.first == 'smithy.ruby.tests#WeldProtocolService'
        end

        def protocols
          { 'smithy.ruby.tests#weldProtocol' => 'FakeProtocol' }
        end
      end
    end

    context 'no protocol' do
      include_context context, 'NoProtocol'

      it 'defaults protocol config to nil' do
        client = NoProtocol::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be_nil
      end
    end

    context 'registered protocol' do
      include_context context, 'WeldProtocol'

      it 'defaults to the protocol' do
        fake_protocol = Class.new
        stub_const('FakeProtocol', fake_protocol)
        client = WeldProtocol::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be_a(fake_protocol)
      end
    end

    context 'default cbor protocol' do
      include_context context, 'Rpcv2Protocol'

      it 'defaults to the rpcv2Cbor protocol' do
        client = Rpcv2Protocol::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be_a(Smithy::Client::Protocols::RPCv2)
      end
    end
  end
end
