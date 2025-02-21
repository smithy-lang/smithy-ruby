# frozen_string_literal: true

RSpec.shared_examples 'protocol plugin' do |context, opts|
  context do
    include_context context, 'ProtocolService', fixture: opts[:fixture]

    it 'is generated' do
      expect(ProtocolService::Client.plugins).to include(ProtocolService::Plugins::Protocol)
    end

    if opts[:protocol_set]
      it 'sets the default protocol' do
        client = ProtocolService::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be_a(FakeProtocol)
      end
    else
      it 'sets protocol config to nil' do
        client = ProtocolService::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be_nil
      end
    end

    it 'can override the default protocol config' do
      custom_protocol = Smithy::Client::Protocols::RPCv2.new(query_compatible: true)
      client = ProtocolService::Client.new(endpoint: 'https://example.com', protocol: custom_protocol)
      expect(client.config.protocol).to eq(custom_protocol)
    end
  end
end
