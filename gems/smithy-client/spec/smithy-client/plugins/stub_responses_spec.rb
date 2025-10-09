# frozen_string_literal: true

require 'bigdecimal'

require_relative '../../spec_helper'

module Smithy
  module Client
    module Plugins
      describe StubResponses do
        let(:sample_client) { ClientHelper.sample_client }
        let(:client_class) { sample_client.const_get(:Client) }
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

        it 'defaults the endpoint if :stub_responses is true' do
          expect(client.config.endpoint).to eq('http://stubbed-endpoint')
        end

        it 'does not default the endpoint if a custom endpoint is set' do
          client = client_class.new(stub_responses: true, endpoint: 'https://example.com')
          expect(client.config.endpoint).to eq('https://example.com')
        end

        it 'signals error for exceptions' do
          expect_any_instance_of(Http::Response).to receive(:signal_error)
          client.stub_responses(:operation, RuntimeError.new('error'))
          client.operation
        end

        it 'signals error for exception classes' do
          expect_any_instance_of(Http::Response).to receive(:signal_error)
          client.stub_responses(:operation, Timeout::Error)
          client.operation
        end

        it 'signals http for a service error' do
          expect_any_instance_of(Http::Response).to receive(:signal_headers)
          expect_any_instance_of(Http::Response).to receive(:signal_data)
          expect_any_instance_of(Http::Response).to receive(:signal_done)
          client.stub_responses(:operation, 'Error')
          client.operation
        end

        it 'signals http for a data stub' do
          expect_any_instance_of(Http::Response).to receive(:signal_headers)
          expect_any_instance_of(Http::Response).to receive(:signal_data)
          expect_any_instance_of(Http::Response).to receive(:signal_done)
          client.stub_responses(:operation, { string: 'stubbed-data' })
          client.operation
        end

        it 'tracks an api request for each stubbed response' do
          client.stub_responses(:operation, { string: 'stubbed-data' })
          response1 = client.operation
          response2 = client.operation
          expect(client.config.api_requests.size).to eq(2)
          expect(client.config.api_requests.first).to be(response1.context)
          expect(client.config.api_requests.last).to be(response2.context)
        end

        context 'response stubbing' do
          let(:now) { Time.now }
          let(:default_stub_data) do
            {
              big_decimal: BigDecimal(0),
              big_integer: 0,
              blob: String.new('blob'),
              boolean: false,
              byte: 0,
              double: 0.0,
              enum: 'enum',
              float: 0.0,
              int_enum: 0,
              integer: 0,
              list: [],
              long: 0,
              map: {},
              short: 0,
              streaming_blob: String.new('streamingBlob'),
              structure_list: [],
              structure_map: {},
              string: 'string',
              timestamp: now,
              union: { string: 'string' }
            }
          end

          before do
            allow(Time).to receive(:now).and_return(now)
            allow(Time).to receive(:at).and_return(now)
          end

          it 'returns the correct type' do
            client.stub_responses(:operation)
            response = client.operation
            expect(response.data).to be_a(sample_client::Types::OperationOutput)
          end

          it 'validates stubs at request time' do
            data = { not_a_member: 'foo' }
            client.stub_responses(:operation, data)
            expect { client.operation }
              .to raise_error(ArgumentError, /unexpected value at stub\[:not_a_member\]/)
          end

          it 'can stub default data' do
            client.stub_responses(:operation)
            response = client.operation
            expect(response.data.to_h).to include(default_stub_data)
            expect(response.data.structure.to_h).to include(default_stub_data)
          end

          it 'can stub procs' do
            client.stub_responses(:operation, ->(ctx) { { string: ctx.params[:string] } })
            response = client.operation(string: 'new string')
            expect(response.data.string).to eq('new string')
          end

          it 'can stub nested procs' do
            proc = ->(ctx2) { { string: ctx2.params[:string] } }
            client.stub_responses(:operation, ->(_ctx1) { proc })
            response = client.operation(string: 'new string')
            expect(response.data.string).to eq('new string')
          end

          it 'can stub exceptions' do
            error = StandardError.new('error')
            client.stub_responses(:operation, error)
            expect { client.operation }.to raise_error(error)
          end

          it 'can stub errors as a class' do
            client.stub_responses(:operation, Timeout::Error)
            expect { client.operation }.to raise_error(Timeout::Error)
          end

          it 'can stub modeled errors as strings' do
            client.stub_responses(:operation, 'Error')
            expect { client.operation }.to raise_error(sample_client::Errors::Error, 'stubbed-error-message')
          end

          it 'can stub http hashes' do
            headers = { 'smithy-protocol' => 'rpc-v2-cbor' }
            body = Smithy::Cbor.encode({ 'string' => 'value' })
            client.stub_responses(:operation, { status_code: 200, headers: headers, body: body })
            response = client.operation
            expect(response.context.http_response.status_code).to eq(200)
            expect(response.context.http_response.headers.to_h).to eq(headers)
            expect(response.context.http_response.body.string).to eq(body.force_encoding('UTF-8'))
          end

          it 'can stub data' do
            data = { string: 'new string' }
            client.stub_responses(:operation, data)
            response = client.operation
            expect(response.data.string).to eq('new string')
          end

          it 'does not set defaults when stubbed data is provided' do
            data = { string: 'new string' }
            client.stub_responses(:operation, data)
            response = client.operation
            expect(response.data).not_to include(default_stub_data.except(:string))
          end

          it 'can stub multiple responses' do
            client.stub_responses(:operation, { string: 'value-1' }, { string: 'value-2' })
            expect(client.operation.string).to eq('value-1')
            expect(client.operation.string).to eq('value-2')
          end
        end
      end
    end
  end
end
