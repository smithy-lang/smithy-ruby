# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe RpcV2Cbor do
      subject(:protocol) { described_class.new }

      let(:sample_client) { ClientHelper.sample_client }
      let(:client) { sample_client.const_get(:Client).new(endpoint: 'https://example.com', stub_responses: true) }
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
        it 'sets the POST method' do
          context = build_context
          protocol.build_request(context)
          expect(context.http_request.http_method).to eq('POST')
        end

        it 'sets the Smithy-Protocol header' do
          context = build_context
          protocol.build_request(context)
          expect(context.http_request.headers['Smithy-Protocol']).to eq('rpc-v2-cbor')
        end

        it 'sets the Content-Type and Accept headers' do
          context = build_context
          protocol.build_request(context)
          expect(context.http_request.headers['Content-Type']).to eq('application/cbor')
          expect(context.http_request.headers['Accept']).to eq('application/cbor')
        end

        it 'appends the rpc v2 service/operation url path' do
          context = build_context
          protocol.build_request(context)
          service_name = config.service.name
          expect(context.http_request.endpoint.path)
            .to end_with("/service/#{service_name}/operation/#{operation.name}")
        end

        it 'serializes the params into the body' do
          context = build_context(params: { string: 'hello' })
          protocol.build_request(context)
          expect(context.http_request.body.read).not_to be_empty
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

        it 'returns nil for a successful response' do
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 200)
          )
          expect(protocol.parse_error(context)).to be_nil
        end

        it 'returns nil for a response outside the HTTP status range (e.g. a signaled transport error)' do
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 0, protocol_header: nil)
          )
          expect(protocol.parse_error(context)).to be_nil
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
          expect(error).to be_a(StandardError)
        end

        it 'extracts the modeled error from the __type in the body' do
          body = Cbor.encode('__type' => 'smithy.ruby.tests#Error', 'message' => 'boom')
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 400, body: body)
          )
          error = protocol.parse_error(context)
          expect(error).to be_a(StandardError)
        end

        it 'falls back to an HTTP status error when the body is not valid CBOR' do
          context = build_context(
            http_request: Http::Request.new(headers: request_headers),
            http_response: response(status_code: 400, body: 'not-cbor')
          )
          error = protocol.parse_error(context)
          expect(error).to be_a(StandardError)
        end
      end

      describe '#stub_data' do
        it 'builds a 200 CBOR response with protocol headers' do
          response = protocol.stub_data(config, operation, { string: 'hello' })
          expect(response.status_code).to eq(200)
          expect(response.headers['Smithy-Protocol']).to eq('rpc-v2-cbor')
          expect(response.headers['Content-Type']).to eq('application/cbor')
          expect(response.body.read).not_to be_empty
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
