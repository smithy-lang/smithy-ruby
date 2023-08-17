# frozen_string_literal: true

module Hearth
  describe AuthOption do
    let(:scheme_id) { 'scheme_id' }
    let(:identity_properties) { { 'identity' => 'properties' } }
    let(:signer_properties) { { 'signer' => 'properties' } }

    subject do
      AuthOption.new(
        scheme_id: scheme_id,
        identity_properties: identity_properties,
        signer_properties: signer_properties
      )
    end

    describe '#scheme_id' do
      it 'returns the scheme_id' do
        expect(subject.scheme_id).to eq(scheme_id)
      end
    end

    describe '#identity_properties' do
      it 'returns the identity_properties' do
        expect(subject.identity_properties).to eq(identity_properties)
      end
    end

    describe '#signer_properties' do
      it 'returns the signer_properties' do
        expect(subject.signer_properties).to eq(signer_properties)
      end
    end
  end
end
