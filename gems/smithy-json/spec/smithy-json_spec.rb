# frozen_string_literal: true

require_relative 'spec_helper'

module Smithy
  describe JSON do
    %i[oj json].each do |engine|
      describe("ENGINE: #{engine},") do
        before do
          subject.engine = engine
        rescue LoadError
          skip "Skipping #{engine} tests because it is not installed"
        end

        let(:raw_json) { '{"foo":"bar"}' }

        describe '.load' do
          it 'returns a hash with the JSON' do
            expect(subject.load(raw_json)).to eq('foo' => 'bar')
          end

          context 'not JSON' do
            # OJ gem raises EncodingError in this case
            # OJ can also raise JSON::ParserError if using Oj.mimic_JSON
            let(:raw_json) { '<ServiceUnavailableException/>' }

            it 'raises a ParseError' do
              expect { subject.load(raw_json) }.to raise_error(Smithy::JSON::ParseError)
            end
          end

          context 'invalid JSON' do
            let(:raw_json) { '{ "steve": }' }

            it 'raises a ParseError' do
              expect { subject.load(raw_json) }.to raise_error(Smithy::JSON::ParseError)
            end
          end
        end

        describe '.dump' do
          it 'returns a JSON string' do
            expect(subject.dump('foo' => 'bar')).to eq(raw_json)
          end

          it 'returns null for nil' do
            expect(subject.dump(nil)).to eq('null')
          end

          it 'returns empty string for an empty string' do
            expect(subject.dump('')).to eq('""')
          end
        end
      end
    end
  end
end
