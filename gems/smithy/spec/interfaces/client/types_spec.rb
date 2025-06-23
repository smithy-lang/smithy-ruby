# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Client: Types', rbs_test: true do
  ['generated client gem', 'generated client from source code'].each do |context|
    next if ENV['SMITHY_RUBY_RBS_TEST'] && context != 'generated client gem'

    context context do
      include_examples 'types module', context
      include_examples 'types module documentation', context if context == 'generated client gem'
    end
  end
end
