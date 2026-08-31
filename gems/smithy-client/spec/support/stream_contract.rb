# frozen_string_literal: true

# Shared compliance tests for the {Smithy::Client::Stream} contract. Any stream
# implementation should exercise these to validate conformance.
#
# Usage:
#
#   it_behaves_like 'a stream' do
#     # return a fresh, already-transmitted stream for the given body
#     def build_stream(body:, status: 200, headers: {})
#       ...
#     end
#   end
#
# Requires the including group to define a +build_stream+ helper that returns a
# stream whose request has already been transmitted (response headers ready).
RSpec.shared_examples 'a stream' do
  it 'exposes response status and headers' do
    stream = build_stream(body: '', status: 201, headers: { 'X-Foo' => 'bar' })
    status, headers = stream.response_headers
    expect(status).to eq(201)
    expect(headers['x-foo']).to eq('bar')
  end

  it 'yields body chunks in order' do
    stream = build_stream(body: 'hello-world')
    chunks = []
    stream.each_chunk { |c| chunks << c }
    expect(chunks.join).to eq('hello-world')
  end

  it 'yields nothing for an empty body' do
    expect { |b| build_stream(body: '').each_chunk(&b) }.not_to yield_control
  end

  it 'is safe to iterate again after the body is consumed' do
    stream = build_stream(body: 'data')
    stream.each_chunk { |_c| nil }
    expect { |b| stream.each_chunk(&b) }.not_to yield_control
  end

  describe '#abort' do
    it 'does not raise and stops further reads' do
      stream = build_stream(body: 'data')
      expect { stream.abort }.not_to raise_error
      expect { |b| stream.each_chunk(&b) }.not_to yield_control
    end

    it 'is idempotent' do
      stream = build_stream(body: 'data')
      stream.abort
      expect { stream.abort }.not_to raise_error
    end
  end
end
