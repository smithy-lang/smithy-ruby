# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Stubs
    describe GetHighScore do
      let(:id) { 'string'}
      let(:client) { SampleService::Client.new(stub_responses: true, endpoint: 'https://example.com')}

      it 'returns a default' do
        resp = client.get_high_score(id: id)
        high_score = resp.data.high_score
        expect(high_score.id).to eq('string')
        expect(high_score.game).to eq('string')
        expect(high_score.score).to eq(1)
        expect(high_score.created_at).to be_a(Time)
      end
    end
  end
end
