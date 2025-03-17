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
          client_class.add_plugin(Protocol)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        it 'adds a :stub_responses option to config' do
          expect(client.config).to respond_to(:stub_responses)
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

        it 'defaults the endpoint provider if :stub_responses is true' do
          expect(client.config.endpoint_provider).to be_a(Stubbing::EndpointProvider)
        end

        it 'defaults the protocol if :stub_responses is true' do
          expect(client.config.protocol).to be_a(Stubbing::Protocol)
        end

        it 'allows for passed in endpoint providers' do
          endpoint_provider = double('endpoint-provider')
          client = client_class.new(stub_responses: true, endpoint_provider: endpoint_provider)
          expect(client.config.endpoint_provider).to be(endpoint_provider)
        end

        it 'allows for passed in protocols' do
          protocol = double('protocol')
          client = client_class.new(stub_responses: true, protocol: protocol)
          expect(client.config.protocol).to be(protocol)
        end

        it 'signals error for exceptions' do
          expect_any_instance_of(HTTP::Response).to receive(:signal_error)
          client.stub_responses(:operation, RuntimeError.new('error'))
          client.operation
        end

        it 'signals error for exception classes' do
          expect_any_instance_of(HTTP::Response).to receive(:signal_error)
          client.stub_responses(:operation, Timeout::Error)
          client.operation
        end

        it 'signals http for a service error' do
          expect_any_instance_of(HTTP::Response).to receive(:signal_headers)
          expect_any_instance_of(HTTP::Response).to receive(:signal_data)
          expect_any_instance_of(HTTP::Response).to receive(:signal_done)
          client.stub_responses(:operation, 'Error')
          client.operation
        end

        it 'signals http for a data stub' do
          expect_any_instance_of(HTTP::Response).to receive(:signal_headers)
          expect_any_instance_of(HTTP::Response).to receive(:signal_data)
          expect_any_instance_of(HTTP::Response).to receive(:signal_done)
          client.stub_responses(:operation, { string: 'stubbed-data' })
          client.operation
        end

        it 'tracks an api request for each stubbed response' do
          client.stub_responses(:operation, { string: 'stubbed-data' })
          output1 = client.operation
          output2 = client.operation
          expect(client.config.api_requests.size).to eq(2)
          expect(client.config.api_requests.first).to be(output1.context)
          expect(client.config.api_requests.last).to be(output2.context)
        end
      end
    end
  end
end
