# frozen_string_literal: true

require_relative '../../spec_helper'

module Smithy
  module Client
    module NetHTTP
      describe Exchange do
        # Records the pushed response lifecycle for assertions.
        let(:sink) { RecordingSink.new }
        let(:pool) { ConnectionPool.for({}) }
        let(:endpoint) { 'https://example.com' }
        let(:http_method) { 'GET' }
        let(:body) { nil }
        let(:request) do
          Http::Request.new(endpoint: endpoint, http_method: http_method, body: body)
        end

        subject { described_class.new(pool, request, sink) }

        describe '#initialize' do
          it 'raises ArgumentError for an invalid http verb (without networking)' do
            request.http_method = 'bogus'
            expect { described_class.new(pool, request, sink) }
              .to raise_error(ArgumentError, /not a valid http verb/)
          end
        end

        describe '#drive' do
          it 'pushes headers then data then done for a successful response' do
            stub_request(:get, endpoint)
              .to_return(status: 201, headers: { 'X-Foo' => 'bar' }, body: 'hello-world')
            expect(subject.drive).to be(subject)
            expect(sink.status).to eq(201)
            expect(sink.headers_hash['x-foo']).to eq('bar')
            expect(sink.body).to eq('hello-world')
            expect(sink.terminal).to eq(:done)
          end

          it 'pushes headers and done with no data for an empty body' do
            stub_request(:get, endpoint).to_return(status: 200, body: '')
            subject.drive
            expect(sink.chunks).to be_empty
            expect(sink.terminal).to eq(:done)
          end

          it 'sends the request body' do
            @body = StringIO.new('request-body')
            stub = stub_request(:post, endpoint).with(body: 'request-body')
            post = Http::Request.new(endpoint: endpoint, http_method: 'POST', body: @body)
            described_class.new(pool, post, RecordingSink.new).drive
            expect(stub).to have_been_requested
          end

          it 'surfaces networking errors as sink.error(NetworkingError) (not raised)' do
            stub_request(:get, endpoint).to_raise(EOFError)
            expect { subject.drive }.not_to raise_error
            expect(sink.terminal).to eq(:error)
            expect(sink.error_value).to be_a(Smithy::Client::NetworkingError)
          end

          it 'surfaces a short Content-Length body as a NetworkingError terminal' do
            stub_request(:get, endpoint)
              .to_return(status: 200, headers: { 'Content-Length' => '100' }, body: 'short')
            subject.drive
            expect(sink.terminal).to eq(:error)
            expect(sink.error_value).to be_a(Smithy::Client::NetworkingError)
          end

          it 'wraps the underlying TruncatedBodyError as the NetworkingError cause' do
            # Truncation is delivered as a NetworkingError (so it retries like any
            # networking failure), but callers can distinguish it via
            # #original_error. Pin that so it stays a supported detection path.
            stub_request(:get, endpoint)
              .to_return(status: 200, headers: { 'Content-Length' => '100' }, body: 'short')
            subject.drive
            expect(sink.error_value.original_error).to be_a(described_class::TruncatedBodyError)
          end

          it 'does not verify bytes for HEAD requests' do
            request.http_method = 'HEAD'
            stub_request(:head, endpoint).to_return(headers: { 'Content-Length' => '100' })
            subject.drive
            expect(sink.terminal).to eq(:done)
          end
        end

        describe '#drive_background' do
          it 'drives the exchange on a background thread' do
            stub_request(:get, endpoint).to_return(status: 200, body: 'ok')
            thread = subject.drive_background
            expect(thread).to be_a(Thread)
            thread.join(5)
            expect(sink.status).to eq(200)
            expect(sink.body).to eq('ok')
            expect(sink.terminal).to eq(:done)
          end
        end

        describe '#abort' do
          it 'does not raise after the exchange has completed' do
            stub_request(:get, endpoint).to_return(body: 'data')
            subject.drive
            expect { subject.abort }.not_to raise_error
          end

          it 'is a no-op once the exchange has completed and the session is pooled' do
            # After drive completes the session has been returned to the pool and
            # the exchange relinquished ownership; a late cross-thread abort must
            # not reach through and finish the pooled session.
            stub_request(:get, endpoint).to_return(body: 'data')
            subject.drive
            expect(pool).not_to receive(:finish_session)
            expect { subject.abort }.not_to raise_error
          end

          it 'discards the session through the pool when aborting before completion' do
            expect(pool).to receive(:finish_session)
            subject.abort
          end

          it 'is idempotent' do
            expect(pool).to receive(:finish_session).once
            subject.abort
            expect { subject.abort }.not_to raise_error
          end
        end

        describe 'no sink delivery after abort' do
          # Records every sink call so we can assert what was (not) delivered.
          let(:recording_sink) do
            Class.new do
              def initialize = @calls = []

              attr_reader :calls

              def headers(status, _headers) = @calls << [:headers, status]
              def data(chunk)  = @calls << [:data, chunk]
              def done         = @calls << [:done]
              def error(err)   = @calls << [:error, err]
            end
          end

          it 'delivers nothing when the exchange is aborted before it is driven' do
            # abort() before drive() records @aborted; #deliver then suppresses
            # both headers and body, and #run emits no success terminal. This is
            # the deterministic core of the abort/no-deliver contract: #deliver
            # checks @aborted and calls the sink atomically under @mutex, so once
            # @aborted is observed nothing further is delivered.
            stub_request(:get, endpoint).to_return(status: 200, body: 'body-bytes')
            sink = recording_sink.new
            exchange = described_class.new(pool, request, sink)

            exchange.abort               # record the abort first
            exchange.drive               # drive; every deliver{} sees @aborted

            expect(sink.calls).to be_empty # no headers, data, done, or error
          end

          it 'does not re-pool the session when delivery stops on abort' do
            # When #deliver suppresses delivery (rather than the socket close
            # raising), perform_exchange can return normally; #run must still
            # discard the session instead of letting #session_for pool a socket
            # that abort already finished.
            stub_request(:get, endpoint).to_return(status: 200, body: 'body-bytes')
            exchange = described_class.new(pool, request, recording_sink.new)
            exchange.abort
            exchange.drive
            expect(pool.size).to eq(0) # nothing pooled
          end
        end
      end
    end
  end
end
