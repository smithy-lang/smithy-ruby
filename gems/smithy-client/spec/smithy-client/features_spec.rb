# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Client
    describe Features do
      describe '#clear' do
        it 'clears features' do
          Thread.current[:smithy_ruby_features] = ['test']
          Features.clear
          expect(Features.list).to be_empty
        end
      end

      describe '#track' do
        before(:each) { Features.clear }

        it 'tracks and removes a feature' do
          proc = proc { expect(Features.list).to eq(%w[A]) }
          Features.track('A') { proc.call }
          expect(Features.list).to be_empty
        end

        it 'tracks and removes multiple features' do
          features = %w[A B C]
          proc = proc { expect(Features.list).to eq(features) }
          Features.track(*features) { proc.call }
          expect(Features.list).to be_empty
        end

        it 'tracks and removes features in stack order' do
          proc1 = proc do
            Features.track('C') do
              expect(Features.list).to eq(%w[A B C])
            end
            expect(Features.list).to eq(%w[A B])
          end
          proc2 = proc do
            Features.track('B') do
              expect(Features.list).to eq(%w[A B])
              proc1.call
            end
            expect(Features.list).to eq(%w[A])
          end
          Features.track('A') { proc2.call }
          expect(Features.list).to be_empty
        end

        it 'ensures that features are removed' do
          proc = proc do
            expect(Features.list).to eq(%w[A])
            raise StandardError
          end
          begin
            Features.track('A') { proc.call }
          rescue StandardError
            # ignore
          end
          expect(Features.list).to be_empty
        end

        it 'tracks features in multiple threads' do
          Features.track('A') do
            expect(Features.list).to eq(%w[A])
            Thread.new do
              expect(Features.list).to be_empty
              Features.clear
              Features.track('B') do
                expect(Features.list).to eq(%w[B])
              end
              expect(Features.list).to be_empty
            end.join
            expect(Features.list).to eq(%w[A])
          end
          expect(Features.list).to be_empty
        end
      end
    end
  end
end
