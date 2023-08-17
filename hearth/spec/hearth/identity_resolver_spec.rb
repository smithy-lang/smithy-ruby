# frozen_string_literal: true

module Hearth
  describe IdentityResolver do
    let(:identity) { double('identity') }
    let(:properties) { { foo: 'bar' } }
    let(:proc) { ->(_properties) { identity } }

    subject { IdentityResolver.new(proc) }

    describe '#identity' do
      it 'returns the identity' do
        expect(subject.identity).to eq(identity)
      end

      it 'calls the proc with the properties' do
        expect(proc).to receive(:call).with(properties)
        subject.identity(properties)
      end
    end
  end
end
