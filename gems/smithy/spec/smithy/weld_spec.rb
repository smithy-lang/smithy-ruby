# frozen_string_literal: true

module Smithy
  describe Weld do
    it 'includes Thor::Actions' do
      expect(Class.new(Smithy::Weld).ancestors).to include(Thor::Actions)
    end
  end
end
