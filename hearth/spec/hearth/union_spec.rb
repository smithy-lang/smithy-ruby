# frozen_string_literal: true

module Hearth
  class MyUnion < Hearth::Union
    class StringValue < MyUnion
      def to_h
        { string_value: super(__getobj__) }
      end
    end
  end

  describe Union do
    subject { MyUnion::StringValue.new('union') }

    it 'uses simple delegator and structure' do
      expect(subject).to be_a(SimpleDelegator)
      expect(subject).to be_a(Structure)
    end

    describe '#to_h' do
      it 'serializes the value to a hash' do
        expect(subject.to_h).to eq(string_value: 'union')
      end
    end
  end
end
