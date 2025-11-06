# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe Features do
      it 'tracks and removes a feature' do
        Features.track('A') { expect(Features.tracked).to eq(%w[A]) }
        expect(Features.tracked).to be_empty
      end

      it 'tracks and removes multiple features' do
        features = %w[A B C]
        Features.track(*features) { expect(Features.tracked).to eq(features) }
        expect(Features.tracked).to be_empty
      end

      it 'tracks and removes features in stack order' do
        Features.track('A') do
          expect(Features.tracked).to eq(%w[A])
          Features.track('B') do
            expect(Features.tracked).to eq(%w[A B])
            Features.track('C') do
              expect(Features.tracked).to eq(%w[A B C])
            end
            expect(Features.tracked).to eq(%w[A B])
          end
          expect(Features.tracked).to eq(%w[A])
        end
        expect(Features.tracked).to be_empty
      end

      it 'ensures that features are removed' do
        begin
          Features.track('A') do
            expect(Features.tracked).to eq(%w[A])
            raise StandardError
          end
        rescue StandardError
          # ignore
        end
        expect(Features.tracked).to be_empty
      end

      it 'tracks features in multiple threads' do
        Features.track('A') do
          expect(Features.tracked).to eq(%w[A])
          Thread.new do
            expect(Features.tracked).to be_empty
            Features.track('B') do
              expect(Features.tracked).to eq(%w[B])
            end
            expect(Features.tracked).to be_empty
          end.join
          expect(Features.tracked).to eq(%w[A])
        end
        expect(Features.tracked).to be_empty
      end

      it 'does not track duplicate features' do
        Features.track('A', 'B') do
          expect(Features.tracked).to eq(%w[A B])
          Features.track('A') do
            expect(Features.tracked).to eq(%w[A B])
          end
          expect(Features.tracked).to eq(%w[A B])
        end
        expect(Features.tracked).to be_empty
      end
    end
  end
end
