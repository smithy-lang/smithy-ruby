# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Schema: Module' do
  context 'single module' do
    ['generated schema gem', 'generated schema from source code'].each do |context|
      context context do
        include_examples 'gem module', context
      end
    end
  end
end
