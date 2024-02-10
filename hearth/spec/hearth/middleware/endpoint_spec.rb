# frozen_string_literal: true

module Hearth
  module Middleware
    describe Endpoint do
      let(:app) { double('app', call: output) }
      let(:struct) { Struct.new(:foo, keyword_init: true) }
      let(:input) { struct.new }
      let(:output) { double('output') }
      let(:endpoint_provider) { double }
      let(:param_builder) { double }
      let(:config) { double }

      subject do
        Endpoint.new(
          app,
          endpoint_provider: endpoint_provider,
          param_builder: param_builder,
          config: config
        )
      end

      describe '#call' do
        let(:request) { Hearth::HTTP::Request.new }
        let(:response) { double('response') }
        let(:logger) { Logger.new(IO::NULL) }
        let(:context) do
          Context.new(
            request: request,
            response: response,
            logger: logger
          )
        end
        let(:auth_scheme) do
          RulesEngine::AuthScheme.new(name: 'auth1')
        end
        let(:endpoint_uri) { 'https://example.com' }
        let(:headers) do
          { 'headers1' => 'value1', 'headers2' => 'value2' }
        end
        let(:resolved_endpoint) do
          RulesEngine::Endpoint.new(
            uri: endpoint_uri,
            auth_schemes: [auth_scheme],
            headers: headers
          )
        end
        let(:params) { double }

        it 'resolves the endpoint and modifies the request' do
          expect(param_builder).to receive(:build)
            .with(config, context).and_return(params)
          expect(endpoint_provider).to receive(:resolve_endpoint)
            .with(params).and_return(resolved_endpoint)

          expect(app).to receive(:call).with(input, context).ordered

          resp = subject.call(input, context)

          expect(request.uri).to eq(endpoint_uri)
          expect(request.headers.to_h).to include(headers)
          # TODO: Expect on Auth
          expect(resp).to be output
        end
      end
    end
  end
end
