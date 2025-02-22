# frozen_string_literal: true

RSpec.shared_examples 'protocol plugin' do |context|
  context do
    before(:all) do
      # Define Weld classes (scoped to this block only)
      Class.new(Smithy::Weld) do
        def for?(service)
          service.keys.first == 'smithy.ruby.tests#OneProtocol'
        end

        def protocols
          { 'smithy.ruby.tests#fakeProtocol' => 'FakeProtocol' }
        end
      end
    end

    context 'no protocols' do
      include_context context, 'NoProtocol'

      it 'defaults protocol config to nil' do
        client = NoProtocol::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be_nil
      end
    end

    context 'one protocol' do
      include_context context, 'OneProtocol'

      it 'defaults to the protocol' do
        fake_protocol = Class.new
        stub_const('FakeProtocol', fake_protocol)
        client = OneProtocol::Client.new(endpoint: 'https://example.com')
        expect(client.config.protocol).to be_a(fake_protocol)
      end
    end
  end
end
