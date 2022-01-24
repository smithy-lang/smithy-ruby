# frozen_string_literal: true

module Seahorse
  describe NumberHelper do
    describe '.serialize' do
      it 'converts infinity' do
        expect(subject.serialize(Float::INFINITY)).to eq 'Infinity'
      end

      it 'converts -infinity' do
        expect(subject.serialize(-Float::INFINITY)).to eq '-Infinity'
      end

      it 'converts NAN' do
        expect(subject.serialize(-Float::NAN)).to eq 'NaN'
      end

      it 'converts nil' do
        expect(subject.serialize(nil)).to be_nil
      end

      it 'converts numbers' do
        expect(subject.serialize(123.111)).to eq 123.111
      end
    end

    describe '.deserialize' do
      it 'converts infinity' do
        expect(subject.deserialize('Infinity')).to eq Float::INFINITY
      end

      it 'converts -infinity' do
        expect(subject.deserialize('-Infinity')).to eq(-Float::INFINITY)
      end

      it 'converts NAN' do
        expect(subject.deserialize('NaN')).to be Float::NAN
      end

      it 'converts nil' do
        expect(subject.deserialize(nil)).to be_nil
      end

      it 'converts numbers' do
        expect(subject.deserialize(123.111)).to eq 123.111
      end
    end
  end
end
