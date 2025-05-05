# frozen_string_literal: true

require_relative '../../spec_helper'

require 'smithy-client/plugins/host_prefix'

module Smithy
  module Client
    module Plugins
      describe HostPrefix do
        let(:shapes) { ClientHelper.sample_shapes }
        let(:sample_client) { ClientHelper.sample_client(shapes: shapes) }

        let(:client_class) do
          client_class = sample_client.const_get(:Client)
          client_class.clear_plugins
          client_class.add_plugin(sample_client::Plugins::Endpoint)
          client_class.add_plugin(HostPrefix)
          client_class.add_plugin(Protocol)
          client_class.add_plugin(StubResponses)
          client_class
        end

        let(:client) { client_class.new(stub_responses: true) }

        it 'adds a :disable_host_prefix_injection option to config' do
          expect(client.config).to respond_to(:disable_host_prefix_injection)
        end

        it 'adds the handler if :disable_host_prefix_injection is false' do
          expect(client.handlers).to include(HostPrefix::Handler)
        end

        it 'does not add the handler if :disable_host_prefix_injection is true' do
          client = client_class.new(disable_host_prefix_injection: true)
          expect(client.handlers).not_to include(HostPrefix::Handler)
        end

        it 'validates :disable_host_prefix_injection option as a boolean' do
          client_class.new(disable_host_prefix_injection: true)
          client_class.new(disable_host_prefix_injection: false)
          expect { client_class.new(disable_host_prefix_injection: 'foo') }
            .to raise_error(ArgumentError, ':disable_host_prefix_injection must be either `true` or `false`')
        end

        it 'allows :disable_host_prefix_injection to be set via ENV' do
          ENV['DISABLE_HOST_PREFIX_INJECTION'] = 'true'
          client = client_class.new
          expect(client.config.disable_host_prefix_injection).to be(true)
        end

        context 'host prefixing' do
          before do
            shapes['smithy.ruby.tests#Structure']['members']['string'] = {
              'target' => 'smithy.api#String',
              'traits' => { 'smithy.api#hostLabel' => {} }
            }
          end

          it 'applies the host prefix to the endpoint' do
            shapes['smithy.ruby.tests#Operation']['traits'] = {
              'smithy.api#endpoint' => { 'hostPrefix' => 'bar.' }
            }
            client.config.endpoint = 'https://example.com'
            output = client.operation(string: 'foo')
            expect(output.context.request.endpoint.host).to eq('bar.example.com')
          end

          it 'applies the host prefix with a label to the endpoint' do
            shapes['smithy.ruby.tests#Operation']['traits'] = {
              'smithy.api#endpoint' => { 'hostPrefix' => '{string}.bar.' }
            }
            client.config.endpoint = 'https://example.com'
            output = client.operation(string: 'foo')
            expect(output.context.request.endpoint.host).to eq('foo.bar.example.com')
          end

          it 'raises when the label is not a valid host label' do
            shapes['smithy.ruby.tests#Operation']['traits'] = {
              'smithy.api#endpoint' => { 'hostPrefix' => '{invalid}.bar.' }
            }
            client.config.endpoint = 'https://example.com'
            expect { client.operation(string: 'foo') }
              .to raise_error(ArgumentError, 'invalid is not a valid host label')
          end

          it 'raises when the label value is nil or empty' do
            shapes['smithy.ruby.tests#Operation']['traits'] = {
              'smithy.api#endpoint' => { 'hostPrefix' => '{string}.bar.' }
            }
            client.config.endpoint = 'https://example.com'
            expect { client.operation(string: nil) }
              .to raise_error(ArgumentError, 'params[:string] must not be nil or blank')
            expect { client.operation(string: '') }
              .to raise_error(ArgumentError, 'params[:string] must not be nil or blank')
          end
        end
      end
    end
  end
end
