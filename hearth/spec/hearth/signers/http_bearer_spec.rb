# frozen_string_literal: true

module Hearth
  module Signers
    describe HTTPBearer do
      let(:request) { HTTP::Request.new }
      let(:identity) { Identities::HTTPBearer.new(token: token) }
      let(:token) { 'token' }
      let(:properties) { {} }

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
  end
end
