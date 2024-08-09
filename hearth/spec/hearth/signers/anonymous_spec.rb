# frozen_string_literal: true

module Hearth
  module Signers
    describe Anonymous do
      let(:request) { HTTP::Request.new }
      let(:identity) { Identities::Anonymous.new }
      let(:properties) { {} }

      describe '#sign' do
        it 'does not modify the request' do
          expect do
            subject.sign(
              request: request,
              identity: identity,
              properties: properties
            )
          end.not_to(change { request })
        end
      end

      describe '#sign_event' do
        let(:message) { double }
        let(:prior_signature) { 'signature' }
        let(:encoder) { double }

        it 'does not modify the message' do
          signed_message, signature = subject.sign_event(
            message: message,
            prior_signature: prior_signature,
            event_type: :event,
            encoder: encoder,
            identity: identity,
            properties: properties
          )
          expect(signed_message).to be(message)
          expect(signature).to be(prior_signature)
        end
      end

      describe '#reset' do
        it 'does not modify the request' do
          expect do
            subject.reset(request: request, properties: properties)
          end.not_to(change { request })
        end
      end
    end
  end
end
