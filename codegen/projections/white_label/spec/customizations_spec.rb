# frozen_string_literal: true

require_relative 'spec_helper'

module WhiteLabel
  describe Customization do
    describe '#customization?' do
      it 'exists and returns true' do
        expect(Customization.customization?).to eq(true)
      end
    end
  end
end
