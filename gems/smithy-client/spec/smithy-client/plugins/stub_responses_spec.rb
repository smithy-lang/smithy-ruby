# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/stub_responses'

module Smithy
  module Client
    module Plugins
      describe StubResponses do
        let(:service) { ClientHelper.sample_service }
        let(:client_class) do
          client_class = service.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(service::Plugins::Endpoint)
          client_class.add_plugin(service::Plugins::Protocol)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:protocol) { Smithy::Client::Protocols::RPCv2.new }
        let(:client) { client_class.new(stub_responses: true, protocol: protocol) }

        it 'adds a :stub_responses option to config' do
          expect(client.config.stub_responses).to be(true)
        end

        it 'defaults :stub_responses to false' do
          client = client_class.new
          expect(client.config.stub_responses).to be(false)
        end

        it 'does not add the handlers if :stub_responses is false' do
          client = client_class.new
          expect(client.handlers).not_to include(StubResponses::StubHandler)
          expect(client.handlers).not_to include(StubResponses::APIRequestsHandler)
        end

        it 'adds the handler if :stub_responses is true' do
          expect(client.handlers).to include(StubResponses::StubHandler)
          expect(client.handlers).to include(StubResponses::APIRequestsHandler)
        end

        it 'defaults the endpoint to localhost if :stub_responses is true' do
          expect(client.config.endpoint).to eq('http://stubbed-endpoint')
        end

        it 'can apply an error stub' do
          client.stub_responses(:operation, 'Error')
          output = client.operation
          expect(output.error).to be_a(service::Errors::Error)
        end

        it 'can apply runtime error stubs' do
          error = NetworkingError.new(RuntimeError.new('error'))
          client.stub_responses(:operation, error)
          output = client.operation
          expect(output.error).to be(error)
        end

        it 'can apply an http stub' do
          headers = { 'header' => 'value' }
          body = Client::CBOR.encode({ 'string' => 'value' })
          client.stub_responses(:operation, { status_code: 200, headers: headers, body: body })
          output = client.operation
          expect(output.context.response.status_code).to eq(200)
          expect(output.context.response.headers.to_h).to eq(headers)
          expect(output.context.response.body.string).to eq(body.force_encoding('UTF-8'))
        end

        it 'can apply a data stub' do
          data = { string: 'new-string' }
          client.stub_responses(:operation, data)
          output = client.operation
          expect(output.string).to eq('new-string')
        end
      end
    end
  end
end
