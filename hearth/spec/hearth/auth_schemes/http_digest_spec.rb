# frozen_string_literal: true

module Hearth
  module AuthSchemes
    describe HTTPDigest do
      it 'inherits from Base' do
        expect(subject).to be_a(AuthSchemes::Base)
      end

      describe '#scheme_id' do
        it 'returns the scheme_id' do
          expect(subject.scheme_id).to eq('smithy.api#httpDigestAuth')
        end
      end

      describe '#signer' do
        it 'returns a signer' do
          expect(subject.signer).to be_a(Signers::HTTPDigest)
        end
      end

      describe '#identity_provider' do
        let(:identity_provider) { double('identity_provider') }

        it 'returns an identity resolver using identity_type' do
          identity_providers = { Identities::HTTPLogin => identity_provider }
          resolver = subject.identity_provider(identity_providers)
          expect(resolver).to eq(identity_provider)
        end
      end
    end
  end
end
