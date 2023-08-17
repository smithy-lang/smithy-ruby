# frozen_string_literal: true

module Hearth
  module Identities
    describe HTTPApiKey do
      let(:expiration) { Time.now + 3600 }
      let(:key) { 'key' }

      subject do
        described_class.new(
          key: key,
          expiration: expiration
        )
      end

      it 'inherits from Base' do
        expect(subject).to be_a(Identities::Base)
      end

      it 'has an expiration' do
        expect(subject.expiration).to eq(expiration)
      end

      it 'has a key' do
        expect(subject.key).to eq(key)
      end
    end
  end
end
