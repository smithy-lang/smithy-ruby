# frozen_string_literal: true

module Hearth
  module Identities
    describe HTTPBearer do
      let(:expiration) { Time.now + 3600 }
      let(:token) { 'token' }

      subject do
        described_class.new(
          token: token,
          expiration: expiration
        )
      end

      it 'inherits from Base' do
        expect(subject).to be_a(Identities::Base)
      end

      it 'has an expiration' do
        expect(subject.expiration).to eq(expiration)
      end

      it 'has a token' do
        expect(subject.token).to eq(token)
      end
    end
  end
end
