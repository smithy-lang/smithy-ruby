# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module NetHTTP
      describe Stream do
        let(:sink) { RecordingSink.new }
        let(:pool) { ConnectionPool.for({}) }
        let(:endpoint) { 'https://example.com' }
        let(:request) do
          Http::Request.new(endpoint: endpoint, http_method: 'GET', body: nil)
        end
        let(:exchange) { Exchange.new(pool, request, sink) }

        subject { described_class.new(exchange) }

        it_behaves_like 'a stream' do
          def build_handle(sink, body:, status: 200, headers: {})
            stub_request(:get, 'https://example.com')
              .to_return(status: status, headers: headers, body: body)
            pool = ConnectionPool.for({})
            request = Http::Request.new(endpoint: 'https://example.com', http_method: 'GET', body: nil)
            Smithy::Client::NetHTTP::Stream.new(Exchange.new(pool, request, sink))
          end
        end

        describe 'Stream contract conformance' do
          it 'answers the output-only event-stream method tier' do
            expect(subject).to respond_to(*Client::Stream::REQUIRED_FOR_OUTPUT_EVENT_STREAM_OPS)
          end

          it 'answers the bidirectional event-stream method tier' do
            expect(subject).to respond_to(*Client::Stream::REQUIRED_FOR_BIDI_EVENT_STREAM_OPS)
          end
        end

        describe '#abort' do
          it 'delegates to the exchange' do
            expect(exchange).to receive(:abort).with(nil)
            subject.abort
          end

          it 'forwards an error argument to the exchange' do
            error = StandardError.new('boom')
            expect(exchange).to receive(:abort).with(error)
            subject.abort(error)
          end

          it 'does not raise' do
            expect { subject.abort }.not_to raise_error
          end
        end

        describe '#write / #close_write' do
          it '#write raises NotSupportedError (HTTP/1.1 is not bidirectional)' do
            expect { subject.write('data') }.to raise_error(Smithy::Client::NotSupportedError)
          end

          it '#close_write raises NotSupportedError (HTTP/1.1 is not bidirectional)' do
            expect { subject.close_write }.to raise_error(Smithy::Client::NotSupportedError)
          end
        end
      end
    end
  end
end
