# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module NetHTTP
      describe Stream do
        let(:pool) { ConnectionPool.for({}) }
        let(:endpoint) { 'https://example.com' }
        let(:http_method) { 'GET' }
        let(:body) { nil }
        let(:request) do
          Http::Request.new(endpoint: endpoint, http_method: http_method, body: body)
        end

        subject { described_class.new(pool, request) }

        describe '#send_request' do
          it 'returns self and reads status and headers' do
            stub_request(:get, endpoint)
              .to_return(status: 201, headers: { 'X-Foo' => 'bar' }, body: '')
            expect(subject.send_request).to be(subject)
            status, headers = subject.response_headers
            expect(status).to eq(201)
            expect(headers['x-foo']).to eq('bar')
          end

          it 'sends the request body' do
            @body = StringIO.new('request-body')
            stub = stub_request(:post, endpoint).with(body: 'request-body')
            described_class.new(pool, Http::Request.new(
                                        endpoint: endpoint, http_method: 'POST', body: @body
                                      )).send_request
            expect(stub).to have_been_requested
          end

          it 'raises ArgumentError for an invalid http verb (without networking)' do
            request.http_method = 'bogus'
            expect { subject.send_request }.to raise_error(ArgumentError, /not a valid http verb/)
          end

          it 'wraps networking errors in a NetworkingError' do
            stub_request(:get, endpoint).to_raise(EOFError)
            expect { subject.send_request }.to raise_error(Smithy::Client::NetworkingError)
          end
        end

        describe '#each_chunk' do
          it 'yields the response body chunks' do
            stub_request(:get, endpoint).to_return(body: 'hello-world')
            subject.send_request
            chunks = []
            subject.each_chunk { |c| chunks << c }
            expect(chunks.join).to eq('hello-world')
          end

          it 'yields nothing for an empty body' do
            stub_request(:get, endpoint).to_return(body: '')
            subject.send_request
            chunks = []
            subject.each_chunk { |c| chunks << c }
            expect(chunks).to be_empty
          end

          it 'is safe to call after the body has been consumed' do
            stub_request(:get, endpoint).to_return(body: 'data')
            subject.send_request
            subject.each_chunk { |_c| } # drain
            expect { |b| subject.each_chunk(&b) }.not_to yield_control
          end

          it 'raises a NetworkingError when the body is shorter than Content-Length' do
            stub_request(:get, endpoint)
              .to_return(status: 200, headers: { 'Content-Length' => '100' }, body: 'short')
            subject.send_request
            chunks = []
            expect { subject.each_chunk { |c| chunks << c } }
              .to raise_error(Smithy::Client::NetworkingError)
          end

          it 're-raises the consumer block error and aborts the stream' do
            stub_request(:get, endpoint).to_return(body: 'hello-world')
            subject.send_request
            expect { subject.each_chunk { |_c| raise 'consumer boom' } } # rubocop:disable Lint/UnreachableLoop
              .to raise_error(RuntimeError, 'consumer boom')
            # The stream was torn down; a subsequent drain yields nothing.
            expect { |b| subject.each_chunk(&b) }.not_to yield_control
          end
        end

        describe '#write / #close_write' do
          before do
            stub_request(:get, endpoint).to_return(body: '')
            subject.send_request
          end

          it '#write raises NotSupportedError' do
            expect { subject.write('data') }.to raise_error(Smithy::Client::NotSupportedError)
          end

          it '#close_write raises NotSupportedError' do
            expect { subject.close_write }.to raise_error(Smithy::Client::NotSupportedError)
          end
        end

        describe '#abort' do
          it 'does not raise and prevents further reads' do
            stub_request(:get, endpoint).to_return(body: 'data')
            subject.send_request
            expect { subject.abort }.not_to raise_error
            expect { |b| subject.each_chunk(&b) }.not_to yield_control
          end
        end
      end
    end
  end
end
