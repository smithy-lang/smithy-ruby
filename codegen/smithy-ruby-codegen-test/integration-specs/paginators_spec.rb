# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Paginators
    describe ListHighScores do
      let(:client) { SampleService::Client.new(stub_responses: true, endpoint: 'https://example.com') }
      let(:high_score_1) do
        SampleService::Types::HighScoreAttributes.new(id: '1', game: 'frogger', score: 69)
      end
      let(:high_score_2) do
        SampleService::Types::HighScoreAttributes.new(id: '2', game: 'dance dance revolution', score: 420)
      end
      let(:response_1) do
        SampleService::Types::ListHighScoresOutput.new(high_scores: [high_score_1], next_token: 'foo')
      end
      let(:response_2) do
        SampleService::Types::ListHighScoresOutput.new(high_scores: [high_score_2])
      end

      subject { SampleService::Paginators::ListHighScores.new(client, {}, {}) }

      before do
        expect(client).to receive(:list_high_scores).with({}, {}).and_return(response_1)
        expect(client).to receive(:list_high_scores).with({next_token: 'foo'}, {}).and_return(response_2)
      end

      describe '#pages' do
        it 'returns response pages' do
          pages = subject.pages
          expect(pages).to be_a(Enumerator)
          expect(pages.to_a).to eq([response_1, response_2])
        end
      end

      describe '#items' do
        it 'returns items from the response pages' do
          items = subject.items
          expect(items).to be_a(Enumerator)
          expect(items.to_a).to eq([high_score_1, high_score_2])
        end
      end
    end
  end
end
