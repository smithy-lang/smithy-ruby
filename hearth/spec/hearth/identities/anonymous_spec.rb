# frozen_string_literal: true

module Hearth
  module Identities
    describe Anonymous do
      let(:expiration) { Time.now + 3600 }

      subject { described_class.new(expiration: expiration) }

      it 'inherits from Base' do
        expect(subject).to be_a(Identities::Base)
      end

      it 'has an expiration' do
        expect(subject.expiration).to eq(expiration)
      end
    end
  end
end
