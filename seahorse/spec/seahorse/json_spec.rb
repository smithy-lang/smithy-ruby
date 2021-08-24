# frozen_string_literal: true

module Seahorse
  describe JSON do
    subject { described_class }
    let(:hash) { { 'foo' => 'bar' } }

    describe '.load' do
      context 'valid json' do
        it 'loads the json' do
          expect(subject.load(hash.to_json)).to eq hash
        end
      end

      context 'invalid json' do
        it 'raises a ParseError' do
          value = 'not valid json'
          expect { subject.load(value) }.to raise_error(JSON::ParseError)
        end
      end
    end

    describe '.dump' do
      it 'dumps the values to JSON' do
        expect(subject.dump(hash)).to eq hash.to_json
      end
    end
  end
end
