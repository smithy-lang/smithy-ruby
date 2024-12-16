# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      describe Endpoint do
        let(:client_class) do
          api = API.new
          api.add_operation(:operation_name, Operation.new)
          client_class = Class.new(Client::Base)
          client_class.api = api
          client_class.clear_plugins
          client_class.add_plugin(Endpoint)
          client_class.add_plugin(DummySendPlugin)
          client_class
        end

        it 'adds an #endpoint option to config' do
          client = client_class.new(endpoint: 'https://example.com')
          expect(client.config.endpoint.to_s).to eq('https://example.com')
        end

        it 'raises if the endpoint is not set' do
          expect do
            client_class.new
          end.to raise_error(ArgumentError, 'missing required option `:endpoint`')
        end

        it 'raises if the endpoint is not a URI::HTTP or URI::HTTPS' do
          expect do
            client_class.new(endpoint: 'foo')
          end.to raise_error(ArgumentError, 'expected `:endpoint` to be a HTTP or HTTPS endpoint')
        end

        it 'populates the request endpoint' # do
        # client = client_class.new(endpoint: 'https://example.com')
        # resp = client.build_input(:operation_name).send_request
        # expect(resp.context.http_request.endpoint).to eq(URI.parse('https://example.com/'))
        # end
      end
    end
  end
end
