# frozen_string_literal: true

module Hearth
  module Signers
    describe Base do
      let(:request) { HTTP::Request.new }
      let(:identity) { Identities::Anonymous.new }
      let(:properties) { {} }

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
      end
    end
  end
end
