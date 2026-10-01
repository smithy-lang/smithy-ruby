# frozen_string_literal: true

# Shared compliance tests for the {Smithy::Client::Stream} control-handle
# contract - the handle returned by {Smithy::Client::Transport#transmit_background}
# for an event-stream operation. Any handle implementation should exercise these
# to validate conformance.
#
# Usage:
#
#   it_behaves_like 'a stream' do
#     # return a fresh control handle wired to the given sink
#     def build_handle(sink, body:, status: 200, headers: {})
#       ...
#     end
#   end
#
# Requires the including group to define a +build_handle(sink, ...)+ helper that
# returns a control handle wired to push into +sink+, and a
# +drive_handle(handle)+ helper that synchronously runs the handle's exchange to
# completion (so the +#abort+ examples can assert an OBSERVABLE effect: an
# aborted stream delivers no terminal into the sink, rather than merely not
# raising).
#
# A +Stream+ is an OUTBOUND + CONTROL handle only. Inbound response data flows
# into the sink, not back through the handle, so this contract covers +#abort+
# (output-only tier) and +#write+/+#close_write+ (bidirectional tier).
RSpec.shared_examples 'a stream' do
  let(:sink) { RecordingSink.new }

  describe '#write / #close_write (non-bidirectional / HTTP/1.1)' do
    it '#write raises NotSupportedError' do
      handle = build_handle(sink, body: '')
      expect { handle.write('data') }.to raise_error(Smithy::Client::NotSupportedError)
    end

    it '#close_write raises NotSupportedError' do
      handle = build_handle(sink, body: '')
      expect { handle.close_write }.to raise_error(Smithy::Client::NotSupportedError)
    end
  end

  describe '#abort' do
    it 'does not raise' do
      handle = build_handle(sink, body: 'data')
      expect { handle.abort }.not_to raise_error
    end

    it 'is idempotent' do
      handle = build_handle(sink, body: 'data')
      handle.abort
      expect { handle.abort }.not_to raise_error
    end

    it 'delivers no terminal into the sink once aborted' do
      # Observable effect (not just "doesn't raise"): a stream aborted before it
      # is driven delivers NOTHING to the sink - no headers, data, done, or
      # error. Gutting the abort would let the driven exchange push a terminal
      # here and fail this example.
      handle = build_handle(sink, body: 'data')
      handle.abort
      drive_handle(handle)
      expect(sink.terminal).to be_nil
      expect(sink.status).to be_nil
      expect(sink.chunks).to be_empty
    end
  end
end
