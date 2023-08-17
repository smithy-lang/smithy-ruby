# frozen_string_literal: true

module Hearth
  module Identities
    describe HTTPLogin do
      let(:expiration) { Time.now + 3600 }
      let(:username) { 'username' }
      let(:password) { 'password' }

      subject do
        described_class.new(
          username: username,
          password: password,
          expiration: expiration
        )
      end

      it 'inherits from Base' do
        expect(subject).to be_a(Identities::Base)
      end

      it 'has an expiration' do
        expect(subject.expiration).to eq(expiration)
      end

      it 'has username and password' do
        expect(subject.username).to eq(username)
        expect(subject.password).to eq(password)
      end
    end
  end
end
