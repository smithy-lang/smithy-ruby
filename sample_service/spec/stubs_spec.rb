# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Stubs
    describe GetHighScore do
      let(:id) { 'string'}
      let(:client) { SampleService::Client.new(stub_responses: true, endpoint: 'https://example.com')}

      it 'returns a default' do
        resp = client.get_high_score(id: id)
        high_score = resp.high_score
        expect(high_score.id).to eq('id')
        expect(high_score.game).to eq('game')
        expect(high_score.score).to eq(1)
        expect(high_score.created_at).to be_a(Time)
      end

      it 'returns the stubbed values' do
        t = Time.now.utc
        client.stub_responses(:get_high_score, {high_score: {id: '1', game: 'pong', score: 42, created_at: Time.now}})
        resp = client.get_high_score(id: id)
        high_score = resp.high_score
        expect(high_score.id).to eq('1')
        expect(high_score.game).to eq('pong')
        expect(high_score.score).to eq(42)
        expect(high_score.created_at.to_i).to eq(t.to_i)
      end

      it 'stubs an empty body when given nil' do
        client.stub_responses(:get_high_score, {high_score: nil})
        resp = client.get_high_score(id: id)
        high_score = resp.high_score
        expect(high_score.id).to be_nil
        expect(high_score.game).to be_nil
        expect(high_score.score).to be_nil
        expect(high_score.created_at).to be_nil
      end
    end

    describe ListHighScores do
      let(:id) { 'string'}
      let(:client) { SampleService::Client.new(stub_responses: true, endpoint: 'https://example.com')}

      it 'returns a default' do
        resp = client.list_high_scores
        expect(resp.next_token).to eq("next_token")
        expect(resp.high_scores.size).to eq(1)

        high_score = resp.high_scores.first
        expect(high_score.id).to eq('id')
        expect(high_score.game).to eq('game')
        expect(high_score.score).to eq(1)
        expect(high_score.created_at).to be_a(Time)
      end

      it 'returns the stubbed values' do
        t = Time.now.utc
        client.stub_responses(:list_high_scores, {high_scores: [{id: '1', game: 'pong', score: 42, created_at: Time.now}]})
        resp = client.list_high_scores
        expect(resp.next_token).to be_nil
        expect(resp.high_scores.size).to eq(1)

        high_score = resp.high_scores.first
        expect(high_score.id).to eq('1')
        expect(high_score.game).to eq('pong')
        expect(high_score.score).to eq(42)
        expect(high_score.created_at.to_i).to eq(t.to_i)
      end
    end
  end
end
