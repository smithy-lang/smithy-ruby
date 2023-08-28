# frozen_string_literal: true

module Hearth
  module Signers
    describe HTTPDigest do
      let(:request) { HTTP::Request.new }
      let(:identity) do
        Identities::HTTPLogin.new(username: username, password: password)
      end
      let(:username) { 'username' }
      let(:password) { 'password' }
      let(:properties) { {} }

      describe '#sign' do
        it 'signs the request' do
          expect do
            subject.sign(
              request: request,
              identity: identity,
              properties: properties
            )
          end.to raise_error(NotImplementedError)
        end
      end

      describe '#reset' do
        it 'resets the request' do
          expect do
            subject.reset(request: request, properties: properties)
          end.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
