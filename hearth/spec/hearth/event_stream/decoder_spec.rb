# frozen_string_literal: true

module Hearth
  module EventStream
    describe Decoder do
      let(:message_decoder) { double }
      let(:event_handler) { double }

      subject do
        Decoder.new(
          message_decoder: message_decoder,
          event_handler: event_handler
        )
      end

      describe '#emit_headers' do
        let(:headers) { {} }
        it 'calls the  event_handler' do
          expect(event_handler).to receive(:emit_headers).with(headers)
          subject.emit_headers(headers)
        end
      end

      describe '#write' do
        let(:chunk) { 'chunk' }
        let(:message1) { Message.new }
        let(:message2) { Message.new }
        it 'decodes and emits messages until empty' do
          expect(message_decoder).to receive(:decode)
            .with(chunk).and_return([message1, false])
          expect(message_decoder).to receive(:decode)
            .with(nil).and_return([message2, true])
          expect(event_handler).to receive(:emit).with(message1)
          expect(event_handler).to receive(:emit).with(message2)

          subject.write(chunk)
        end
      end
    end
  end
end
