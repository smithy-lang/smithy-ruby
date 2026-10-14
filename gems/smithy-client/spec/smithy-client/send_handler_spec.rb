# frozen_string_literal: true

require_relative '../spec_helper'

require 'smithy-client/plugins/transport'

module Smithy
  module Client
    describe SendHandler do
      let(:client_class) do
        klass = Class.new(Client::Base)
        klass.add_plugin(Plugins::Logging)
        klass.add_plugin(Plugins::Transport)
        klass.add_plugin(Plugins::RetryErrors)
        klass
      end

      let(:context) do
        client = client_class.new
        context = HandlerContext.new(config: client.config)
        context.http_request.endpoint = endpoint
        context
      end

      def endpoint
        @endpoint ||= 'https://example.com'
      end

      let(:http_request) { context.http_request }
      let(:make_request) { subject.call(context) }

      subject { described_class.new }

      describe '#call' do
        it 'returns a Response object' do
          stub_request(:any, endpoint)
          expect(make_request).to be_kind_of(Response)
        end

        it 'populates the #context of the returned response' do
          stub_request(:any, endpoint)
          expect(make_request.context).to be(context)
        end

        it 'does not store a stream on the context for a non-event-stream operation' do
          stub_request(:any, endpoint)
          make_request
          # transmit drives inline and returns nothing; there is no handle.
          expect(context[:stream]).to be_nil
        end

        describe 'request' do
          it 'makes a request against the given endpoint and method' do
            http_request.http_method = 'POST'
            stub = stub_request(:post, endpoint)
            make_request
            expect(stub).to have_been_requested
          end

          it 'sends the request body' do
            http_request.body = StringIO.new('request-body')
            stub = stub_request(:any, endpoint).with(body: 'request-body')
            make_request
            expect(stub).to have_been_requested
          end

          it 'signals an ArgumentError for an invalid http method' do
            http_request.http_method = 'abc'
            expect(make_request.error).to be_a(ArgumentError)
          end
        end

        describe 'response' do
          [
            [:on_headers, RuntimeError],
            [:on_data, RuntimeError],
            [:on_done, RuntimeError],
            [:on_headers, IOError]
          ].each do |event, error_class|
            it "preserves a #{error_class} from an #{event} listener" do
              stub_request(:any, endpoint).to_return(status: 200, body: 'data')
              error = error_class.new('listener failed')
              context.http_response.public_send(event) { raise error }
              expect(make_request.error).to be(error)
            end
          end

          it 'updates an SDK response created before a completion listener fails' do
            stub_request(:any, endpoint).to_return(status: 200)
            response = Response.new(context: context)
            error = RuntimeError.new('listener failed')
            context.http_response.on_done { raise error }
            make_request
            expect(response.error).to be(error)
          end

          it 'returns the body rewind failure as the SDK response error' do
            stub_request(:any, endpoint).to_return(status: 200, body: 'data')
            error = Errno::EIO.new('rewind failed')
            expect(context.http_response.body).to receive(:rewind).once.and_raise(error)
            response = Plugins::RetryErrors::Handler.new(subject).call(context)
            expect(response.error).to be(error)
            expect(context.retries).to eq(0)
          end

          it 'preserves an unexpected exception from a custom transport' do
            error = RuntimeError.new('transport bug')
            allow(context.config.transport).to receive(:transmit).and_raise(error)
            expect(make_request.error).to be(error)
          end

          [429, 503].each do |status|
            it "does not retry a listener failure after receiving status #{status}" do
              stub = stub_request(:any, endpoint).to_return(status: status, body: 'data')
              error = IOError.new('listener failed')
              context.http_response.on_data { raise error }
              response = Plugins::RetryErrors::Handler.new(subject).call(context)
              expect(response.error).to be(error)
              expect(stub).to have_been_requested.once
              expect(context.retries).to eq(0)
            end
          end

          it 'does not retry a NetworkingError raised inside a response callback' do
            stub = stub_request(:any, endpoint).to_return(status: 503, body: 'data')
            error = NetworkingError.new(IOError.new('nested operation failed'))
            context.http_response.on_data { raise error }
            response = Plugins::RetryErrors::Handler.new(subject).call(context)
            expect(response.error).to be(error)
            expect(Http::ErrorInspector.new(error, context.http_response).error_type).to eq('Unknown')
            expect(stub).to have_been_requested.once
          end

          it 'populates the status code' do
            stub_request(:any, endpoint).to_return(status: 200)
            expect(make_request.context.http_response.status_code).to eq(200)
          end

          it 'populates the headers' do
            stub_request(:any, endpoint).to_return(headers: { 'Content-Length' => '0' })
            expect(make_request.context.http_response.headers['Content-Length']).to eq('0')
          end

          it 'populates the response body' do
            stub_request(:any, endpoint).to_return(body: 'response-body')
            resp_body = make_request.context.http_response.body
            resp_body.rewind
            expect(resp_body.read).to eq('response-body')
          end

          it 'wraps networking errors with a NetworkingError' do
            stub_request(:any, endpoint).to_raise(EOFError)
            expect(make_request.error).to be_a(NetworkingError)
          end

          it 'wraps OpenSSL errors with a NetworkingError' do
            stub_request(:any, endpoint).to_raise(OpenSSL::SSL::SSLError)
            expect(make_request.error).to be_a(NetworkingError)
          end

          it 'signals NotSupportedError as-is (not wrapped into a retryable NetworkingError)' do
            # A single-mode transport raises NotSupportedError from #transmit.
            # NotSupportedError < StandardError, so it must be rescued ahead of
            # the networking-failure clause; otherwise it would be wrapped into a
            # transient NetworkingError and retried with backoff for an operation
            # that can never succeed.
            error = NotSupportedError.new('this transport does not serve request/response')
            allow(context.config.transport).to receive(:transmit).and_raise(error)
            expect(make_request.error).to be(error)
            expect(make_request.error).not_to be_a(NetworkingError)
          end

          it 'raises when content length and body length mismatch' do
            stub_request(:any, endpoint).to_return(body: 'foo', headers: { 'Content-Length' => 1 })
            expect(make_request.error).to be_a(NetworkingError)
          end

          it 'does not verify bytes for HEAD requests' do
            http_request.http_method = 'HEAD'
            stub_request(:head, endpoint).to_return(headers: { 'Content-Length' => '100' })
            expect(make_request.error).to be_nil
          end
        end

        describe 'event streams' do
          it 'stores the stream (via transmit_background) but does not resolve the response inline' do
            stub_request(:any, endpoint).to_return(status: 200, body: 'data')
            context[:event_stream] = true
            make_request
            # The handle is available for the event stream layer to pump.
            expect(context[:stream]).to be_a(NetHTTP::Stream)
            expect(context[:stream]).to respond_to(:abort)
            # The handler did not drive synchronously; clean up the background
            # exchange.
            context[:stream].abort
          end

          it 'records a background completion listener failure on the SDK response' do
            error = RuntimeError.new('background listener failed')
            context.http_response.on_done { raise error }
            stub_request(:any, endpoint).to_return(status: 200, body: 'data')
            context[:event_stream] = true
            thread = nil
            allow(context.config.transport).to receive(:transmit_background) do |request, sink|
              exchange = NetHTTP::Exchange.new(NetHTTP::ConnectionPool.for({}), request, sink)
              thread = exchange.drive_background
              NetHTTP::Stream.new(exchange)
            end
            response = make_request
            thread.value
            expect(response.error).to be(error)
          end
        end
      end
    end
  end
end
