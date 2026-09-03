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
  let(:request) do
    Smithy::Client::Http::Request.new(
      endpoint: endpoint, http_method: 'GET', body: nil
    )
  end

  it 'responds to #transmit' do
    expect(transport).to respond_to(:transmit)
  end

  it 'returns a stream conforming to the stream contract' do
    stub_request(:get, endpoint).to_return(status: 200, body: 'ok')
    stream = transport.transmit(request)
    expect(stream).to respond_to(:response_headers, :each_chunk, :abort)
  end

  it 'makes response headers available without consuming the body' do
    stub_request(:get, endpoint)
      .to_return(status: 201, headers: { 'X-Foo' => 'bar' }, body: 'body')
    stream = transport.transmit(request)
    status, headers = stream.response_headers
    expect(status).to eq(201)
    expect(headers['x-foo']).to eq('bar')
  end

  it 'delivers the body in order via #each_chunk' do
    stub_request(:get, endpoint).to_return(status: 200, body: 'hello-world')
    stream = transport.transmit(request)
    chunks = []
    stream.each_chunk { |c| chunks << c }
    expect(chunks.join).to eq('hello-world')
  end

  it 'raises ArgumentError for an invalid http method' do
    request.http_method = 'bogus'
    expect { transport.transmit(request) }.to raise_error(ArgumentError)
  end

  it 'raises NetworkingError on a networking failure' do
    stub_request(:get, endpoint).to_raise(EOFError)
    expect { transport.transmit(request) }
      .to raise_error(Smithy::Client::NetworkingError)
  end
end
