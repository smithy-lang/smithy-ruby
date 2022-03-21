# frozen_string_literal: true

module Hearth
  describe Union do
    subject { MyUnion::StringValue.new('union') }

    it 'uses simple delegator and structure' do
      expect(subject).to be_a(SimpleDelegator)
      expect(subject).to be_a(Structure)
    end
  end
end
