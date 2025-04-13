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
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        it 'adds a :protocol option to config' do
          expect(client.config).to respond_to(:protocol)
        end

        it 'defaults :protocol to the modeled protocol' do
          client = client_class.new
          expect(client.config.protocol).to be_a(client_class.protocols.values.first)
        end

        it 'validates :protocol against available protocols when provided a string' do
          expect { client_class.new(protocol: 'unknown') }
            .to raise_error(ArgumentError, /Unknown protocol/)
        end

        it 'will use any provided protocol object' do
          protocol = double('protocol')
          client = client_class.new(protocol: protocol)
          expect(client.config.protocol).to be(protocol)
        end

        it 'will use the stubbing protocol if :stub_responses is true and no protocol is available' do
          expect(client_class).to receive(:protocols).and_return({})
          expect(client.config.protocol).to be_a(Stubbing::Protocol)
        end

        it 'adds the build and parse handlers' do
          expect(client.handlers).to include(Protocol::BuildHandler)
          expect(client.handlers).to include(Protocol::ParseHandler)
        end

        describe Protocol::BuildHandler do
          it 'calls the protocol build_request method' do
            client = client_class.new(stub_responses: true)
            expect(client.config.protocol).to receive(:build_request).and_call_original
            client.operation
          end
        end

        describe Protocol::ParseHandler do
          it 'does not call parse_error if output has an error' do
            client = client_class.new(stub_responses: true)
            client.stub_responses(:operation, StandardError.new)
            expect(client.config.protocol).not_to receive(:parse_error)
            client.operation
          end

          it 'calls parse_error if output does not have an error' do
            client = client_class.new(stub_responses: true)
            expect(client.config.protocol).to receive(:parse_error)
            client.operation
          end

          it 'does not call parse_data if an error was parsed' do
            client = client_class.new(stub_responses: true)
            client.stub_responses(:operation, sample_client::Errors::Error.new(nil, nil))
            expect(client.config.protocol).not_to receive(:parse_data)
            client.operation
          end

          it 'calls parse_data if no error was parsed' do
            client = client_class.new(stub_responses: true)
            expect(client.config.protocol).to receive(:parse_data)
            client.operation
          end
        end
      end
    end
  end
end
