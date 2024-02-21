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
      let(:config1) { double }
      let(:config2) { double }

      subject do
        Endpoint.new(
          app,
          endpoint_provider: endpoint_provider,
          param_builder: param_builder,
          config1: config1,
          config2: config2
        )
      end

      describe '#call' do
        let(:request) { Hearth::HTTP::Request.new }
        let(:response) { double('response') }
        let(:logger) { Logger.new(IO::NULL) }
        let(:resolved_auth) { nil }
        let(:context) do
          Context.new(
            request: request,
            response: response,
            auth: resolved_auth,
            logger: logger
          )
        end
        let(:endpoint_auth_schemes) do
          [Endpoints::AuthScheme.new(scheme_id: 'auth1')]
        end
        let(:endpoint_uri) { 'https://example.com' }
        let(:headers) do
          { 'headers1' => 'value1', 'headers2' => 'value2' }
        end
        let(:resolved_endpoint) do
          Endpoints::Endpoint.new(
            uri: endpoint_uri,
            auth_schemes: endpoint_auth_schemes,
            headers: headers
          )
        end
        let(:params) { double }

        before(:each) do
          expect(param_builder).to receive(:build)
            .with({ config1: config1,
                    config2: config2 }, input, context).and_return(params)
          expect(endpoint_provider).to receive(:resolve_endpoint)
            .with(params).and_return(resolved_endpoint)

          expect(app).to receive(:call).with(input, context).ordered
        end

        it 'resolves the endpoint and modifies the request' do
          resp = subject.call(input, context)

          expect(request.uri).to eq(URI(endpoint_uri))
          expect(request.headers.to_h).to include(headers)
          expect(context.auth).to be_nil
          expect(resp).to be output
        end

        context 'serialized request uri with path and query' do
          let(:endpoint_uri) { 'https://example.com/path1/path2' }
          let(:request) do
            Hearth::HTTP::Request.new(uri: URI(
              'https://localhost/path3/path4?query1=1&query2=2'
            ))
          end

          it 'merges the resolved and serialized paths and query' do
            subject.call(input, context)

            merged_uri = 'https://example.com/path1/path2/path3/path4' \
                         '?query1=1&query2=2'
            expect(request.uri).to eq(URI(merged_uri))
          end
        end

        context 'resolved non-matching auth scheme' do
          let(:resolved_auth) do
            double(scheme_id: 'resolved', signer_properties: {})
          end

          let(:endpoint_auth_properties) do
            { value: 'override' }
          end

          let(:endpoint_auth_schemes) do
            [
              Endpoints::AuthScheme.new(
                scheme_id: 'endpoint',
                properties: endpoint_auth_properties
              )
            ]
          end

          it 'does not update resolved auth properties' do
            subject.call(input, context)

            expect(context.auth.signer_properties)
              .not_to include(endpoint_auth_properties)
          end
        end

        context 'resolved matching auth scheme' do
          let(:resolved_auth) do
            double(scheme_id: 'matching', signer_properties: {})
          end

          let(:endpoint_auth_properties) do
            { value: 'override' }
          end

          let(:endpoint_auth_schemes) do
            [
              Endpoints::AuthScheme.new(
                scheme_id: 'non-matching',
                properties: { other: 'non-matching' }
              ),
              Endpoints::AuthScheme.new(
                scheme_id: 'matching',
                properties: endpoint_auth_properties
              )
            ]
          end

          it 'does not update resolved auth properties' do
            subject.call(input, context)

            expect(context.auth.signer_properties)
              .to include(endpoint_auth_properties)
          end
        end
      end
    end
  end
end
