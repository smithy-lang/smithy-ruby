# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Waiters' do
  ['generated client gem'].each do |context|
    context context do
      include_examples context, 'Waiters'

      it 'generates waiters' do
        assert true
      end
    end
  end
end