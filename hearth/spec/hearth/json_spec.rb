# frozen_string_literal: true

module Hearth
  describe JSON do
    subject { described_class }
    let(:hash) { { 'foo' => 'bar' } }

    describe '.parse' do
      context 'valid json' do
        it 'parses the json' do
          expect(subject.parse(hash.to_json)).to eq hash
        end
      end

      context 'invalid json' do
        it 'handles empty strings' do
          expect(subject.parse('')).to be_nil
        end

        it 'raises a ParseError' do
          value = 'not valid json'
          expect { subject.parse(value) }.to raise_error(JSON::ParseError)
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
