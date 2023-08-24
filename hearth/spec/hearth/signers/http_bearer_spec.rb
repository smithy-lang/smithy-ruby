# frozen_string_literal: true

module Hearth
  module Signers
    describe HTTPBearer do
      let(:request) { HTTP::Request.new }
      let(:identity) { Identities::HTTPBearer.new(token: token) }
      let(:token) { 'token' }
      let(:properties) { {} }

      describe '#sign' do
        it 'signs the request' do
          expect(request.headers['authorization']).to be_nil
          subject.sign(
            request: request,
            identity: identity,
            properties: properties
          )
          expect(request.headers['authorization']).to eq("Bearer #{token}")
        end
      end

      describe '#reset' do
        it 'resets the request' do
          request.headers['authorization'] = "Bearer #{token}"
          subject.reset(request: request, properties: properties)
          expect(request.headers['authorization']).to be_nil
        end
      end
    end
  end
end
