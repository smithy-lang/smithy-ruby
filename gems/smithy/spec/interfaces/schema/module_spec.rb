# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Schema: Module' do
  ['generated schema gem', 'generated schema from source code'].each do |context|
    context context do
      include_examples 'gem module', context
      include_examples 'gem module documentation', context if context == 'generated schema gem'
    end
  end
end
