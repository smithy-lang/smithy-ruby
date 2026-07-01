# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe PageEnumerator do
      let(:enumerator) do
        PageEnumerator.new do |y|
          y << 'page1'
          y << 'page2'
          y << 'page3'
        end
      end

      describe '#each' do
        it 'yields each value when a block is given' do
          results = []
          enumerator.each { |v| results << v } # rubocop:disable Style/MapIntoArray
          expect(results).to eq %w[page1 page2 page3]
        end

        it 'returns self when no block is given' do
          expect(enumerator.each).to be(enumerator)
        end
      end

      describe '#map' do
        it 'transforms each value' do
          expect(enumerator.map(&:upcase)).to eq %w[PAGE1 PAGE2 PAGE3]
        end
      end

      describe '#select' do
        it 'filters values' do
          expect(enumerator.select { |v| v.include?('2') }).to eq ['page2']
        end
      end

      describe '#filter' do
        it 'filters values (alias for select)' do
          expect(enumerator.filter { |v| v.include?('3') }).to eq ['page3']
        end
      end

      describe '#flat_map' do
        it 'maps and flattens values' do
          expect(enumerator.flat_map { |v| [v, v] }).to eq %w[page1 page1 page2 page2 page3 page3]
        end
      end

      describe '#reduce' do
        it 'accumulates values' do
          expect(enumerator.reduce('') { |acc, v| acc + v }).to eq 'page1page2page3'
        end

        it 'supports an initial value' do
          expect(enumerator.reduce([]) { |acc, v| acc + [v] }).to eq %w[page1 page2 page3]
        end
      end

      describe '#first' do
        it 'returns the first value with no argument' do
          expect(enumerator.first).to eq 'page1'
        end

        it 'returns the first n values with an argument' do
          expect(enumerator.first(2)).to eq %w[page1 page2]
        end
      end

      describe '#take' do
        it 'returns the first n values' do
          expect(enumerator.take(2)).to eq %w[page1 page2]
        end
      end

      describe '#lazy' do
        it 'returns a lazy enumerator' do
          lazy = enumerator.lazy
          expect(lazy).to be_a(Enumerator::Lazy)
          expect(lazy.take(1).to_a).to eq ['page1']
        end
      end

      describe 'blocked methods' do
        %i[count sort min max tally to_a sum zip].each do |method|
          it "does not respond to ##{method}" do
            expect(enumerator.respond_to?(method)).to be false
          end
        end
      end
    end
  end
end
