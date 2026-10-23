# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  describe Weld do
    it 'includes Thor::Actions' do
      expect(Class.new(Smithy::Weld).ancestors).to include(Thor::Actions)
    end

    describe '.ordered_subclasses' do
      it 'preserves declaration order regardless of subclass enumeration order' do
        first = Class.new(described_class)
        second = Class.new(described_class)
        third = Class.new(described_class)
        allow(described_class).to receive(:subclasses).and_return([third, first, second])

        expect(described_class.ordered_subclasses).to eq([first, second, third])
      end

      it 'includes direct subclasses without including their descendants' do
        parent = Class.new(described_class)
        child = Class.new(parent)

        expect(described_class.ordered_subclasses).to include(parent)
        expect(described_class.ordered_subclasses).not_to include(child)
      end
    end
  end
end
