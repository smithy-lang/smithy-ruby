# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe Identity do
      let(:expiration) { Time.now }

      subject { Identity.new(expiration: expiration) }

      describe '#expiration' do
        it 'returns the expiration' do
          expect(subject.expiration).to eq(expiration)
        end
      end
    end
  end
end
