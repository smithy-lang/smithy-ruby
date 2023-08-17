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

      describe '#identity_resolver' do
        let(:identity_resolver) { double('identity_resolver') }

        it 'returns an identity resolver using identity_type' do
          identity_resolvers = { Identities::Anonymous => identity_resolver }
          resolver = subject.identity_resolver(identity_resolvers)
          expect(resolver).to eq(identity_resolver)
        end
      end
    end
  end
end
