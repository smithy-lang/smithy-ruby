# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  describe Welds do
    let(:first) { Class.new(Weld) }
    let(:second) { Class.new(Weld) }
    let(:plan) { double('plan', quiet: true, destination_root: nil) }

    around do |example|
      original_welds = described_class.instance_variable_get(:@welds)
      described_class.instance_variable_set(:@welds, {})
      example.run
    ensure
      described_class.instance_variable_set(:@welds, original_welds)
    end

    before do
      first
      second
      allow(Weld).to receive(:subclasses).and_return([first, second], [second, first])
    end

    it 'applies welds in declaration order' do
      described_class.load!(plan)

      expect(described_class.for({}).map(&:class)).to eq([first, second])
    end

    it 'preserves precedence when loading another plan' do
      described_class.load!(plan)
      another_plan = double('another plan', quiet: true, destination_root: nil)
      described_class.load!(another_plan)

      welds = described_class.for({})
      expect(welds.map(&:class)).to eq([first, second])
      expect(welds.map { |weld| weld.instance_variable_get(:@plan) }).to eq([another_plan, another_plan])
    end
  end
end
