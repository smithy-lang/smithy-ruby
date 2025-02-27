# frozen_string_literal: true

require 'smithy-client/plugins/stub_responses'

module Smithy
  module Client
    module Plugins
      describe StubResponses do
        let(:client_class) do
          client_class = ClientHelper.sample_service.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new }

        it 'adds a :stub_responses option to config' do
          client = client_class.new(stub_responses: true)
          expect(client.config.stub_responses).to be(true)
        end

        it 'defaults :stub_responses to false' do
          client = client_class.new
          expect(client.config.stub_responses).to be(false)
        end

        it 'does not add the handler if :stub_responses is false' do
          client = client_class.new(stub_responses: false)
          expect(client.handlers).not_to include(StubResponses::Handler)
        end

        it 'adds the handler if :stub_responses is true' do
          client = client_class.new(stub_responses: true)
          expect(client.handlers).to include(StubResponses::Handler)
        end

        it 'pending'
      end
    end
  end
end
