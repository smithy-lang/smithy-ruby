require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:config) { Config.build(stub_responses: true) }
    let(:client) { Client.new(config) }

    describe '#kitchen_sink' do
      it 'does a retry' do
        # this error is retryable
        error = Errors::ServerError.new(
          http_resp: Hearth::HTTP::Response.new,
          metadata: {}, error_code: 'error'
        )
        # first return error, then some data
        client.stub_responses(:kitchen_sink, [error, { string: "ok" }])

        expect(Kernel).to receive(:sleep).once
        expect_any_instance_of(Hearth::Middleware::Retry).to receive(:call).twice.and_call_original

        client.kitchen_sink
      end
    end
  end
end