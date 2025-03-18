# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe IdentityProvider do
      let(:identity) { Identity.new }
      let(:properties) { { foo: 'bar' } }
      let(:proc) { ->(_properties) { identity } }

      subject { IdentityProvider.new(proc) }

      describe '#identity' do
        it 'returns the identity' do
          expect(subject.identity).to eq(identity)
        end

        it 'calls the proc with the properties' do
          expect(proc).to receive(:call).with(properties).and_call_original
          subject.identity(properties)
        end
      end
    end
  end
end
