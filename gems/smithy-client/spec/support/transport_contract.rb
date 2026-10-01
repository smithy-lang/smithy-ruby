# frozen_string_literal: true

# Shared compliance tests for the {Smithy::Client::Transport} contract. Any
# transport implementation should exercise these to validate conformance.
#
# Usage:
#
#   it_behaves_like 'a transport' do
#     let(:transport) { MyTransport.new }
#     let(:endpoint) { 'https://example.com' }
#   end
#
# Requires the including group to define:
# * +transport+ - the transport instance under test
# * +endpoint+  - a String endpoint the transport can reach (stubbed via WebMock)
RSpec.shared_examples 'a transport' do
  let(:sink) { RecordingSink.new }
  let(:request) do
    Smithy::Client::Http::Request.new(
      endpoint: endpoint, http_method: 'GET', body: nil
    )
  end

  it 'responds to #transmit' do
    expect(transport).to respond_to(:transmit)
  end

  it 'pushes the response lifecycle into the sink and returns nothing' do
    stub_request(:get, endpoint)
      .to_return(status: 201, headers: { 'X-Foo' => 'bar' }, body: 'hello-world')
    result = transport.transmit(request, sink)
    # transmit drives to completion synchronously and returns nothing.
    expect(result).to be_nil
    expect(sink.status).to eq(201)
    expect(sink.headers_hash['x-foo']).to eq('bar')
    expect(sink.body).to eq('hello-world')
    expect(sink.terminal).to eq(:done)
  end

  it 'raises ArgumentError for an invalid http method (at transmit, no network)' do
    request.http_method = 'bogus'
    expect { transport.transmit(request, sink) }.to raise_error(ArgumentError)
  end

  it 'surfaces a networking failure as a sink.error terminal (not raised)' do
    stub_request(:get, endpoint).to_raise(EOFError)
    expect { transport.transmit(request, sink) }.not_to raise_error
    expect(sink.terminal).to eq(:error)
    expect(sink.error_value).to be_a(Smithy::Client::NetworkingError)
  end

  describe '#transmit_background (event streams)' do
    it 'returns a Stream handle immediately' do
      stub_request(:get, endpoint).to_return(status: 200, body: 'ok')
      handle = transport.transmit_background(request, sink)
      expect(handle).to respond_to(:abort)
      # Let the background exchange complete so the thread is joined cleanly.
      sink.wait_for_terminal
      handle.abort
    end

    it 'drives the response into the sink on the background exchange' do
      stub_request(:get, endpoint)
        .to_return(status: 200, headers: { 'X-Foo' => 'bar' }, body: 'hello-world')
      handle = transport.transmit_background(request, sink)
      # The exchange runs concurrently; wait for it to terminate.
      sink.wait_for_terminal
      expect(sink.status).to eq(200)
      expect(sink.body).to eq('hello-world')
      expect(sink.terminal).to eq(:done)
      handle.abort
    end

    it 'raises ArgumentError for an invalid http method (before spawning)' do
      request.http_method = 'bogus'
      expect { transport.transmit_background(request, sink) }.to raise_error(ArgumentError)
    end
  end
end
