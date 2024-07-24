# frozen_string_literal: true

module Hearth
  module DNS
    describe HostAddress do
      let(:address_type) { :A }
      let(:address) { '123.123.123.123' }
      let(:hostname) { 'example.com' }

      subject do
        HostAddress.new(
          address_type: address_type,
          address: address,
          hostname: hostname
        )
      end

      describe '#address_type' do
        it 'returns the address type' do
          expect(subject.address_type).to eq(address_type)
        end
      end

      describe '#address' do
        it 'returns the address' do
          expect(subject.address).to eq(address)
        end
      end

      describe '#hostname' do
        it 'returns the hostname' do
          expect(subject.hostname).to eq(hostname)
        end
      end
    end
  end
end
