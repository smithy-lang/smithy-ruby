# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Validators
    describe GetHighScoreInput do
      let(:id) { 'string'}
      let(:input) { Types::GetHighScoreInput.new(id: id) }

      it 'accepts a string' do
        GetHighScoreInput.validate!(input, context: 'input')
      end

      context 'id is not a string' do
        let(:id) { 1 }

        it 'raises an ArgumentError with the context' do
          expect {
            GetHighScoreInput.validate!(input, context: 'input')
          }.to raise_error(ArgumentError, 'Expected input[:id] to be in [String], got Integer.')
        end
      end
    end

    describe UpdateHighScoreInput do
      let(:id) { 'string' }
      let(:high_score) { nil }
      let(:input) { Types::UpdateHighScoreInput.new(id: id, high_score: high_score) }

      context ':high_score not set' do
        it 'does not validate :high_score' do
          expect(HighScoreParams).not_to receive(:validate!)
          UpdateHighScoreInput.validate!(input, context: 'input')
        end
      end

      context ':high_score set' do
        let(:high_score) { Types::HighScoreParams.new }
        it 'validates :high_score' do
          expect(HighScoreParams).to receive(:validate!)
          UpdateHighScoreInput.validate!(input, context: 'input')
        end
      end
    end
  end
end
