# frozen_string_literal: true

module Hearth
  module Signers
    describe HTTPBasic do
      let(:request) { HTTP::Request.new }
      let(:identity) do
        Identities::HTTPLogin.new(username: username, password: password)
      end
      let(:username) { 'username' }
      let(:password) { 'password' }
      let(:properties) { {} }

      describe '#sign' do
        it 'signs the request' do
          expect(request.headers['authorization']).to be_nil
          subject.sign(
            request: request,
            identity: identity,
            properties: properties
          )
          encoded = Base64.strict_encode64("#{username}:#{password}")
          expect(request.headers['authorization']).to eq("Basic #{encoded}")
        end
      end

      describe '#reset' do
        it 'resets the request' do
          encoded = Base64.strict_encode64("#{username}:#{password}")
          request.headers['authorization'] = "Basic #{encoded}"
          subject.reset(request: request, properties: properties)
          expect(request.headers['authorization']).to be_nil
        end
      end
    end
  end
end
