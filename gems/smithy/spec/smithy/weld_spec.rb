# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  describe Weld do
    it 'includes Thor::Actions' do
      expect(Class.new(Smithy::Weld).ancestors).to include(Thor::Actions)
    end
  end
end
