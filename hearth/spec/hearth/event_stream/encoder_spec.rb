# frozen_string_literal: true

module Hearth
  module EventStream
    describe Encoder do
      let(:message_encoder) { double }

      subject do
        Encoder.new(
          message_encoder: message_encoder
        )
      end

      describe '#rewind' do
        it 'responds to rewind' do
          expect(subject).to respond_to(:rewind)
        end
      end

      describe '#encode' do
        let(:signature1) { 'signature1' }
        let(:signature2) { 'signature2' }
        let(:event_type) { :event }
        let(:message) { double }
        let(:signed_message) { double }

        it 'signs and encodes the event' do
          subject.prior_signature = signature1
          sign_event = proc do |sig, event_type, message, message_encoder|
            expect(sig).to eq(signature1)
            expect(event_type).to eq(event_type)
            expect(message).to eq(message)
            expect(message_encoder).to eq(message_encoder)
            [signed_message, signature2]
          end
          expect(message_encoder).to receive(:encode).with(signed_message)
          subject.sign_event = sign_event

          subject.encode(event_type, message)
        end
      end
    end

    describe EncoderWithInitialMessage do
      let(:message_encoder) { double }
      let(:initial_event) { double }

      subject do
        EncoderWithInitialMessage.new(
          message_encoder: message_encoder,
          initial_event: initial_event
        )
      end

      describe '#read' do
        let(:signature1) { 'signature1' }
        let(:signature2) { 'signature2' }
        let(:event_type) { :event }
        let(:message) { double }
        let(:signed_message) { double }
        let(:encoded_payload) { 'encoded_payload' }

        it 'returns the signed, encoded initial event' do
          subject.prior_signature = signature1
          sign_event = proc do |sig, event_type, message, message_encoder|
            expect(sig).to eq(signature1)
            expect(event_type).to eq(event_type)
            expect(message).to eq(message)
            expect(message_encoder).to eq(message_encoder)
            [signed_message, signature2]
          end
          expect(message_encoder).to receive(:encode)
            .with(signed_message)
            .and_return(encoded_payload)
          subject.sign_event = sign_event

          expect(subject.read).to eq(encoded_payload)
        end
      end
    end
  end
end
