# frozen_string_literal: true

require 'seahorse/http'

module Seahorse
  describe HTTP do
    describe '.uri_escape' do
      it 'URI escapes a value' do
        escaped = Seahorse::HTTP.uri_escape('a b/c')
        expect(escaped).to eq 'a%20b%2Fc'
      end

      it 'does not escape ~' do
        escaped = Seahorse::HTTP.uri_escape('~')
        expect(escaped).to eq '~'
      end

      it 'escapes a space as %20 instead of +' do
        escaped = Seahorse::HTTP.uri_escape(' ')
        expect(escaped).to eq '%20'
      end
    end

    describe '.uri_escape_path' do
      it 'URI escapes an entire path' do
        escaped = Seahorse::HTTP.uri_escape_path('a b/c')
        expect(escaped).to eq 'a%20b/c'
      end
    end
  end
end
