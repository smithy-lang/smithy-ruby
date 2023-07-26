# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Client do
    let(:config) { Config.new(stub_responses: true) }
    let(:client) { Client.new(config) }

    describe '#kitchen_sink' do
      it 'does a retry' do
        client.stub_responses(
          :kitchen_sink,
          { error: { class: Errors::ServerError } },
          { data: { string: 'ok' } }
        )

        expect_any_instance_of(Hearth::Retry::Standard)
          .to receive(:acquire_initial_retry_token).and_call_original
        expect_any_instance_of(Hearth::Retry::Standard)
          .to receive(:refresh_retry_token).and_call_original
        expect_any_instance_of(Hearth::Retry::Standard)
          .to receive(:record_success).and_call_original
        expect(Kernel).to receive(:sleep).once

        client.kitchen_sink
      end
    end
  end
end
