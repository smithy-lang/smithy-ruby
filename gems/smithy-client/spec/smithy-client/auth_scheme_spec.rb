# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe AuthScheme do
      let(:scheme_id) { 'scheme_id' }
      let(:signer) { Signer.new }
      let(:identity_type) { Identity }
      let(:identity_provider_class) do
        Class.new do
          def identity(_properties)
            Identity.new
          end
        end
      end

      subject do
        AuthScheme.new(
          scheme_id: scheme_id,
          signer: signer,
          identity_type: identity_type
        )
      end

      describe '#scheme_id' do
        it 'returns the scheme_id' do
          expect(subject.scheme_id).to eq(scheme_id)
        end
      end

      describe '#identity_provider' do
        it 'returns the identity_provider using the identity type' do
          expect(subject.identity_provider({})).to be_nil
          identity_provider = identity_provider_class.new
          expect(subject.identity_provider({ identity_type => identity_provider })).to eq(identity_provider)
        end
      end

      describe '#signer' do
        it 'returns the signer' do
          expect(subject.signer).to eq(signer)
        end
      end
    end
  end
end
