# frozen_string_literal: true

module Hearth
  module Signers
    describe Base do
      let(:request) { HTTP::Request.new }
      let(:identity) { Identities::Anonymous.new }
      let(:properties) { {} }
      let(:message) { EventStream::Message.new }
      let(:encoder) { EventStream::Binary::MessageEncoder.new }

      it 'defines the interface' do
        expect do
          subject.sign(
            request: request,
            identity: identity,
            properties: properties
          )
        end.to raise_error(NotImplementedError)

        expect do
          subject.reset(request: request, properties: properties)
        end.to raise_error(NotImplementedError)

        expect do
          subject.sign_initial_event_stream_request(
            request: request,
            identity: identity,
            properties: properties
          )
        end.to raise_error(NotImplementedError)

        expect do
          subject.sign_event(
            message: message,
            prior_signature: '',
            identity: identity,
            properties: properties,
            event_type: :event,
            encoder: encoder
          )
        end.to raise_error(NotImplementedError)
      end
    end
  end
end
