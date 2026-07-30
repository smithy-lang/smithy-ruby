# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe RpcV2Cbor do
      subject(:protocol) { described_class.new }

      let(:client) do
        ClientHelper.sample_client.const_get(:Client).new(endpoint: 'https://example.com', stub_responses: true)
      end
      let(:operation) { client.config.service.operation(:operation) }
      let(:config) { client.config }

      def build_context(http_request: Http::Request.new, http_response: Http::Response.new, params: {})
        http_request.endpoint = 'https://example.com'
        HandlerContext.new(
          operation_name: :operation,
          operation: operation,
          client: client,
          params: params,
          config: config,
          http_request: http_request,
          http_response: http_response
        )
      end

      describe '#build_request' do
        it 'builds a valid RPC v2 CBOR request' do
          context = build_context(params: { string: 'hello' })
          protocol.build_request(context)
          service_name = config.service.name
          aggregate_failures do
            expect(context.http_request.http_method).to eq('POST')
            expect(context.http_request.headers['Smithy-Protocol']).to eq('rpc-v2-cbor')
            expect(context.http_request.headers['Content-Type']).to eq('application/cbor')
            expect(context.http_request.headers['Accept']).to eq('application/cbor')
            expect(context.http_request.endpoint.path)
              .to end_with("/service/#{service_name}/operation/#{operation.name}")
            expect(context.http_request.body.read).not_to be_empty
          end
        end
      end

      describe '#parse_data' do
        it 'parses the response body via the codec' do
          data = { string: 'hello' }
          body = Smithy::Cbor::Codec.new.build(operation.output, data)
          context = build_context(http_response: Http::Response.new(status_code: 200, body: body))
          result = protocol.parse_data(context)
          expect(result[:string]).to eq('hello')
        end
      end

      describe '#parse_error' do
        let(:request_headers) { { 'smithy-protocol' => 'rpc-v2-cbor' } }

        def response(status_code:, body: '', protocol_header: 'rpc-v2-cbor')
          headers = protocol_header ? { 'smithy-protocol' => protocol_header } : {}
          Http::Response.new(status_code: status_code, headers: headers, body: body)
        end

        it 'returns nil when there is no error to raise' do
          success = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 200)
          )
          # status 0 => a signaled transport error passes through untouched
          transport_error = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 0, protocol_header: nil)
          )
          aggregate_failures do
            expect(protocol.parse_error(success)).to be_nil
            expect(protocol.parse_error(transport_error)).to be_nil
          end
        end

        it 'returns an error when the protocol header does not match (even on 2xx)' do
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 200, protocol_header: 'not-cbor')
          )
          expect(protocol.parse_error(context)).to be_a(StandardError)
        end

        it 'returns an error when the response is missing the protocol header' do
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 200, protocol_header: nil)
          )
          expect(protocol.parse_error(context)).to be_a(StandardError)
        end

        it 'returns an HTTP status error for an error response with an empty body' do
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 500)
          )
          error = protocol.parse_error(context)
          expect(error.code).to eq('HTTP500Error')
        end

        it 'extracts the modeled error from the __type in the body' do
          body = Smithy::Cbor.encode('__type' => 'smithy.ruby.tests#Error', 'message' => 'boom')
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 400, body: body)
          )
          error = protocol.parse_error(context)
          aggregate_failures do
            expect(error.code).to eq('Error')
            expect(error.data.message).to eq('boom')
          end
        end

        it 'falls back to an HTTP status error when the body is not valid CBOR' do
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 400, body: 'not-cbor')
          )
          error = protocol.parse_error(context)
          expect(error.code).to eq('HTTP400Error')
        end
      end

      describe '#stub_data' do
        it 'builds a 200 CBOR response with protocol headers' do
          response = protocol.stub_data(config, operation, { string: 'hello' })
          body = response.body.read
          decoded = Smithy::Cbor::Codec.new.parse(operation.output, body)
          aggregate_failures do
            expect(response.status_code).to eq(200)
            expect(response.headers['Smithy-Protocol']).to eq('rpc-v2-cbor')
            expect(response.headers['Content-Type']).to eq('application/cbor')
            expect(body).not_to be_empty
            expect(decoded[:string]).to eq('hello')
          end
        end
      end

      describe '#stub_error' do
        it 'builds a 400 CBOR error response with protocol headers' do
          response = protocol.stub_error(config, 'Error')
          expect(response.status_code).to eq(400)
          expect(response.headers['Smithy-Protocol']).to eq('rpc-v2-cbor')
          decoded = Cbor.decode(response.body.read)
          expect(decoded['__type']).to eq('smithy.ruby.tests#Error')
        end
      end
    end
  end
end
