# frozen_string_literal: true

module Smithy
  describe Client do
    it 'has a version number' do
      expect(Smithy::Client::VERSION).not_to be nil
    end
  end
end
