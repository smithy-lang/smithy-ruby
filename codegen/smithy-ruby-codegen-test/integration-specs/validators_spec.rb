# frozen_string_literal: true

require_relative 'spec_helper'

module SampleService
  module Validators
    describe GetHighScoreInput do
      it 'accepts a string' do
        GetHighScoreInput.validate!({id: 'string'}, context: 'input')
      end
    end
  end
end
