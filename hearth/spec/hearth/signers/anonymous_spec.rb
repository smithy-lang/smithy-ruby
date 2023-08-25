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
