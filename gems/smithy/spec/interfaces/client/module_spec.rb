# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Module' do
  ['generated client gem', 'generated client from source code'].each do |context|
    context context do
      include_examples 'gem module', context
      include_examples 'gem module documentation', context if context == 'generated client gem'
    end
  end
end
