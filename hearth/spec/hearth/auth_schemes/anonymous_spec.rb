# frozen_string_literal: true

module Hearth
  module AuthSchemes
    describe Anonymous do
      it 'inherits from Base' do
        expect(subject).to be_a(AuthSchemes::Base)
      end

      describe '#scheme_id' do
        it 'returns the scheme_id' do
          expect(subject.scheme_id).to eq('smithy.api#noAuth')
        end
      end

      describe '#signer' do
        it 'returns a signer' do
          expect(subject.signer).to be_a(Signers::Anonymous)
        end
      end

      describe '#identity_provider' do
        it 'returns a static identity resolver' do
          resolver = subject.identity_provider({})
          expect(resolver).to be_a(Hearth::IdentityProvider)
          identity = resolver.identity
          expect(identity).to be_a(Identities::Anonymous)
        end
      end
    end
  end
end
